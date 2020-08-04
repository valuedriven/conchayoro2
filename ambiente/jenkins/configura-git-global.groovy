import jenkins.model.*

def inst = Jenkins.getInstance()

def desc = inst.getDescriptor("hudson.plugins.git.GitSCM")

desc.setGlobalConfigName(System.getenv('PROJECT_REPO_USER'))
desc.setGlobalConfigEmail(System.getenv('PROJECT_REPO_EMAIL'))

desc.save()


