
pipeline {
    agent {
        node {label 'python'}
    }
    environment {
        APPLICATION_NAME = 'python-nginx'
        GIT_REPO="http://github.com/ruddra/openshift-python-nginx.git"
        GIT_BRANCH="master"
        STAGE_TAG = "promoteToQA"
        DEV_PROJECT = "dev"
        STAGE_PROJECT = "stage"
        TEMPLATE_NAME = "python-nginx"
        ARTIFACT_FOLDER = "target"
        PORT = 8081;
    }
  stages {
    
  }
}
