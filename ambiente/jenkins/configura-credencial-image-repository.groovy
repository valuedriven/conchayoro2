import jenkins.model.*
import com.cloudbees.plugins.credentials.*
import com.cloudbees.plugins.credentials.common.*
import com.cloudbees.plugins.credentials.domains.*
import com.cloudbees.plugins.credentials.impl.*
import com.cloudbees.jenkins.plugins.sshcredentials.impl.*
import hudson.plugins.sshslaves.*;

domain = Domain.global()
store = Jenkins.instance.getExtensionList('com.cloudbees.plugins.credentials.SystemCredentialsProvider')[0].getStore()

usernameAndPassword = new UsernamePasswordCredentialsImpl(
  CredentialsScope.GLOBAL,
  System.getenv('IMAGE_REPO_CREDENTIALS_ID'),
  "Credenciais para acesso ao DockerHub",
  System.getenv('IMAGE_REPO_USER'),
  System.getenv('IMAGE_REPO_PASSWORD')
)

store.addCredentials(domain, usernameAndPassword)

