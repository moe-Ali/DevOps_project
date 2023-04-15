pipeline {
  agent any

  environment {
    AWS_DEFAULT_REGION= "us-east-1"
  }
  stages {
    stage('SETUP Kubectl'){
        steps {
            withCredentials([usernamePassword(credentialsId: "aws", usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                sh """
                aws s3 ls
                """
            }
        }
    }
    // stage('Deploy APP') {
    //   steps {
    //     sh """
    //     export BUILD_NUMBER=\$(cat ../push_number.txt)
    //     mv dev/deployment.yaml dev/deployment.yaml.tmp
    //     cat dev/deployment.yaml.tmp | envsubst > dev/deployment.yaml
    //     rm -f dev/deployment.yaml.tmp
    //     [ -d /tmp/dev ] && rm -r /tmp/dev
    //     mv ./dev  /tmp/
    //     """
    //   }
    // }
    // stage('Install Prometheusand Gerafana') {
    //     steps {
    //         sh """

    //         """
    //     }
    // }
}
}