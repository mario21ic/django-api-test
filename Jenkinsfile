pipeline {

  agent any

  options {
    timestamps()
    timeout(time: 1, unit: 'HOURS')
  }

  environment {
    ARTIFACTOR = "ci.zip"
    SLACK_MESSAGE = "Job '${env.JOB_NAME}' Build ${env.BUILD_NUMBER} URL ${env.BUILD_URL}"
  }

  stages {
    stage ('Repository') {
      steps {
        checkout scm
      }
    }

    stage ('Tests') {
      steps {
        sh "docker-compose -f docker-compose.test.yml up"
      }
    }

    stage ('Build') {
      steps {
        sh "./scripts/build_artifact ${ARTIFACTOR}"
      }
    }

    stage ('Deploy') {
      steps {
          sh "echo Deploy"
        }
      }
    }
  }

  post {
    always {
      archiveArtifacts artifacts: "${ARTIFACTOR}", onlyIfSuccessful: true
      sh "rm -f ${ARTIFACTOR}"
      echo "Job has finished"
    }
    success {
      slackSendMessage "good"
    }
    failure {
      slackSendMessage "danger"
    }
    unstable {
      slackSendMessage "warning"
    }
  }
}

def slackSendMessage(String color){
  slackSend channel: "${params.SLACK_CHANNEL}", 
            color: color, 
            failOnError: true, 
            message: "$SLACK_MESSAGE"
}
