pipeline {
  agent any

  environment {
    AWS_DEFAULT_REGION= "us-east-1"
  }
  stages {
    // stage('SETUP Kubectl'){
    //     steps {
    //         withCredentials([usernamePassword(credentialsId: "awslogin", usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
    //             sh """
    //             aws eks update-kubeconfig --region us-east-1 --name DevOps_project-cluster
    //             """
    //         }
    //     }
    // }
    // stage('Configure App Deployment') {
    //   steps {
    //     sh """
    //     export BUILD_NUMBER=\$(cat ../push_number.txt)
    //     mv k8s/app/deployment.yaml k8s/app/deployment.yaml.tmp
    //     cat k8s/app/deployment.yaml.tmp | envsubst > k8s/app/deployment.yaml
    //     rm -f k8s/app/deployment.yaml.tmp
    //     [ -d /tmp/k8s ] && rm -r /tmp/k8s
    //     mv ./k8s  /tmp/
    //     """
    //   }
    // }
    stage('Install ArgoCD Prometheusand Gerafana') {
        steps {
            sh """
            if [ "$K8S_READY" -ne 1 ]; then
            export K8S_READY=1
            echo yes
            fi
            """
        }
    }
}
}