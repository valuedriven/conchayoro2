pipeline {
	
  agent any
  		
  environment {
    Settings = "--settings ${env.PROJECT_FILE_SETTINGS}"
    SonarHost = "${env.QUALITY_REPO_PROTOCOL}${env.QUALITY_REPO_HOST}:${env.QUALITY_REPO_PORT}"
    RepoHost = "${env.PROJECT_REPO_HOST}/${env.PROJECT_REPO_USER}/${env.PROJECT_REPO_NAME}.git"
	  NexusServer = "${env.ARTIFACT_REPO_PROTOCOL}${env.ARTIFACT_REPO_HOST}:${env.ARTIFACT_REPO_PORT}"
	  EmailRecipients = "${env.MAIL_RECIPIENTS}"         
    ProjectRepoCredentials = "${env.PROJECT_REPO_CREDENTIALS_ID}"
    ImageRepoCredentials = "${env.IMAGE_REPO_CREDENTIALS_ID}"
    imageDB = null
    imageServer = null
    imageClient = null
    AppServerHost = null
    AppServerPort = null

  }

  options {
    buildDiscarder(logRotator(numToKeepStr: '10')) 
    disableConcurrentBuilds() 
    disableResume()
    timeout(time: 1, unit: 'DAYS')
	  durabilityHint('PERFORMANCE_OPTIMIZED')   
  }

  stages {

    stage("Commit") {
       steps {         
         runStepsCommitStage()
       }                   
    }
            
    stage("Aceitação") {
       steps {		   			   
 	       runStepsAceitacaoStage()
       }
    }

    stage("Homolocação") {
       steps {
 	       runStepsHomolocacaoStage()
       }
    }
	 
    stage("Produção") {
      steps {
         runStepsProducaoStage()
      }
    }

  } 
  
  post {
	  always {
		deleteDir()
	  }
		
	  success {
		  echo "Pipeline concluído com sucesso"
	  }
		
	  unstable {
		  echo "Pipeline apresenta instabilidade"
	  }
		
	  failure {
		  echo "Erro na execução do pipeline"
	  }
	  changed {
		  echo "O pipeline teve a execução atual diferente da última"
	  }
	}

} //end pipeline

void runStepsCommitStage() {
	
  withCredentials([usernamePassword(credentialsId: ProjectRepoCredentials, passwordVariable: 'PROJECT_REPO_PASSWORD', usernameVariable: 'PROJECT_REPO_USER')]) {
    sh "git config --global credential.username ${PROJECT_REPO_USER}"			 
    sh "git config --global credential.helper '!echo password=${PROJECT_REPO_PASSWORD}; echo'"										
  }
			
  script {
    if (env.MULTI_BRANCH_PIPELINE == "True") {
      selecionarBranch()
    }
    else 
      {env.BRANCH_SELECIONADA = 'master'}
   }
     					 
  def tagName  				
  script {
    if (env.BRANCH_SELECIONADA == 'master') {
	    sh "git checkout -b $PROJECT_NAME-R-$VERSION_NUMBER-$BUILD_NUMBER"
	    tagName = "$VERSION_NUMBER-$BUILD_NUMBER"
	  }
	  else {
	    sh 'git checkout "$BRANCH_SELECIONADA"'
	    Branch = "${env.BRANCH_SELECIONADA}"
	    Projeto = "${env.PROJECT_NAME}"
	    NumeroBuild = "${env.BUILD_NUMBER}"
	    tagName = Branch.substring(Projeto.length()+2,Branch.length())+"-fix-"+NumeroBuild
	  }
  }

  sh "echo 'configurando nexus para npm'"

  sh "npm config set registry ${NexusServer}/repository/npm-proxy/"
					   
  sh "npm version $VERSION_NUMBER-$BUILD_NUMBER --prefix server"
  sh "npm install --prefix server"

  sh "npm version $VERSION_NUMBER-$BUILD_NUMBER --prefix client"    
  sh "npm install --prefix client"
  sh "npm run build --prefix client"
  
  script {
	    if (env.QUALITY_REPO_ENABLED == 'True')	{
        sh "sonar-scanner -Dsonar.host.url=${SonarHost}"
     }
	 }  
  
  sh "git commit -a -m 'Nova release candidata'"
  sh "git tag -a ${tagName} --force -m 'Nova versão'"
    
  if (env.PUSH_BRANCH_TO_REPO == 'True')	{
    sh "git push https://${PROJECT_REPO_USER}@${RepoHost} --follow-tags"
  }

  imageDB = "${env.IMAGE_REPO_USER}/${env.PROJECT_NAME}:${tagName}-db"      
  imageServer = "${env.IMAGE_REPO_USER}/${env.PROJECT_NAME}:${tagName}-server"
  imageClient = "${env.IMAGE_REPO_USER}/${env.PROJECT_NAME}:${tagName}-client"

  def dockerCommand = "docker build -t "+imagemDB+" db"
  sh dockerCommand

  dockerCommand = "docker build -t "+imagemServer+" server"
  sh dockerCommand

  dockerCommand = "docker build -t "+imagemClient+" client"
  sh dockerCommand
    
  imageRepository = "${env.IMAGE_REPO_PROTOCOL}${env.IMAGE_REPO_HOST}"

  if (env.PUSH_IMAGE_TO_REPO == 'True')	{
    withCredentials([usernamePassword(credentialsId: ImageRepoCredentials, passwordVariable: 'ImageRepoPassword', usernameVariable: 'ImageRepoUser')]) {
	
        sh "docker login -u ${ImageRepoUser} -p ${ImageRepoPassword}"
        dockerCommand = "docker push "+imagemDB
        sh dockerCommand
	      dockerCommand = "docker push "+imagemServer
        sh dockerCommand
        dockerCommand = "docker push "+imagemClient
        sh dockerCommand
    }
  }
  
  script {
	  if (env.APP_SERVER_DEV_ENABLED == 'True') {
      println("Implantando no ambiente de desenvolvimento...")
      realizarDeploy("development")
      println("Implantação no ambiente de desenvolvimento concluída...")
	  }
  }
  	
}

void runStepsAceitacaoStage() {
	
  script {
	  if (env.APP_SERVER_TEST_ENABLED == 'True') {
      println("Implantando no ambiente de testes...")
      realizarDeploy("dev", "ambiente/.env-dev", imagemServer,imagemClient, imagemDB)
      println("Implantação no ambiente de testes concluída...")
      sh "mvn failsafe:integration-test ${Settings}"
	  }
  }
	  	
}

void runStepsHomolocacaoStage() {
	
  script {
	  if (env.APP_SERVER_HOM_ENABLED == 'True') {
      println("Implantando no ambiente de homologação...")
      realizarDeploy("dev", "ambiente/.env-dev", imagemServer,imagemClient, imagemDB)
      println("Implantação no ambiente de homologação concluída...")
	  } 
    input ( message: 'Autoriza promoção da build para produção?', ok: 'Autorizado', submitter: 'admin' )
  }
	
	
}

void runStepsProducaoStage() {
	
  script {
	  if (env.APP_SERVER_PROD_ENABLED == 'True') {
      println("Implantando no ambiente de produção...")
	    realizarDeploy("dev", "ambiente/.env-development", imagemServer,imagemClient, imagemDB)
      println("Implantação no ambiente de produção concluída...")
	  }
  }

}

String carregarVariavelAmbiente(String parametro, String arquivo) {

  runCmd = "cat "+arquivo+" | grep "+parametro+" | awk -F \'=\' \'{print \$2}\'"
	valorParametro = sh (    
		script: runCmd, returnStdout: true
	)
  valorParametro = valorParametro.replaceAll("[^\\.A-Za-z0-9-_]", "");
	return valorParametro
			 
}

void selecionarBranch() {
	
	sh 'git branch -r | awk \'{print $1}\' ORS=\'\\n\' >branches.txt'	
	sh '''cut -d '/' -f 2 branches.txt > branch.txt'''	 
	branches = readFile "branch.txt"

	def didTimeout = false
	try {
	  timeout(time: 15, unit: 'SECONDS', activity: false) {
		env.BRANCH_SELECIONADA = input (
		   id: 'SelecaoBranchParaPipeline', message: 'Escolha a branch para execução do pipeline', 
		   parameters: [choice(name: 'BRANCH_NAME', choices: "${branches}", description: 'Branches disponíveis')]
		   )
	  }
	} catch( org.jenkinsci.plugins.workflow.steps.FlowInterruptedException e ) {
		env.BRANCH_SELECIONADA = "master"		
	}
	
}

// void realizarDeploy(String ambiente, String arquivoAmbiente, String imagemServer, String imagemClient, String imagemDB) {  
void realizarDeploy(String ambiente) {
  envFileServer = "ambiente/.env-"+ambiente+"-server"
  envFileClient = "ambiente/.env-"+ambiente+"-client"
  ServerHost = carregarVariavelAmbiente("SERVER_HOST", envFileServer)
  ServerPort = carregarVariavelAmbiente("SERVER_PORT", envFileServer)
  ServerContainerPort = carregarVariavelAmbiente("SERVER_CONTAINER_PORT", envFileServer)
  DBHost = carregarVariavelAmbiente("DB_HOST", envFileServer)
  DBPort = carregarVariavelAmbiente("DB_PORT", envFileServer)
  DBContainerPort = carregarVariavelAmbiente("DB_CONTAINER_PORT", envFileServer)
  ClientHost = carregarVariavelAmbiente("VUE_APP_HOST", envFileClient)
  ClientPort = carregarVariavelAmbiente("VUE_APP_PORT", envFileClient)
  ClientContainerPort = carregarVariavelAmbiente("CLIENT_CONTAINER_PORT", envFileClient)
  
  sh "terraform init ambiente/terraform/$ambiente"
  sh "terraform plan -var envFileServer=$envFileServer -var envFileClient=$envFileClient -var ServerHost=$ServerHost -var ServerPort=$ServerPort -var ServerContainerPort=$ServerContainerPort -var ClientHost=$ClientHost -var ClientPort=$ClientPort -var ClientContainerPort=$ClientContainerPort -var DBHost=$DBHost -var DBPort=$DBPort -var DBContainerPort=$DBContainerPort -var imageServer=$imageServer -var imageClient=$imageClient -var imageDB=$imageDB ambiente/terraform/$ambiente"
  sh "terraform apply -auto-approve -var envFileServer=$envFileServer -var envFileClient=$envFileClient -var ServerHost=$ServerHost -var ServerPort=$ServerPort -var ServerContainerPort=$ServerContainerPort -var ClientHost=$ClientHost -var ClientPort=$ClientPort -var ClientContainerPort=$ClientContainerPort -var DBHost=$DBHost -var DBPort=$DBPort -var DBContainerPort=$DBContainerPort -var imageServer=$imageServer -var imageClient=$imageClient -var imageDB=$imageDB ambiente/terraform/$ambiente"
}