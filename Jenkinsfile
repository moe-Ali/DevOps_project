pipeline {
  agent any

  environment {
    AWS_DEFAULT_REGION= "us-east-1"
    GIT_URL= "github.com/moe-Ali/DevOps_project.git"
    GIT_EMAIL = "mohamd1234505@outlook.com"
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
    stage('Configure App Deployment') {
      steps {
        withCredentials([usernamePassword(credentialsId: "githublogin", usernameVariable: 'GIT_USER', passwordVariable: 'GIT_PASSWORD')]) {
          sh """
          export BUILD_NUMBER=\$(cat ../push_number.txt)
          [ -e "k8s/app/deployment.yaml" ] && rm -f "k8s/app/deployment.yaml"
          cp k8s/deployment_jenkins.yaml k8s/app/deployment.yaml.tmp
          cat k8s/app/deployment.yaml.tmp | envsubst > k8s/app/deployment.yaml
          rm -f k8s/app/deployment.yaml.tmp
          git config --global user.email ${GIT_EMAIL}
          git config --global user.name ${GIT_USER}
          git add .
          git commit -m "Edited by Jenkins pipeline ${BUILD_NUMBER}"
          git push https://${GIT_USER}:${GIT_PASSWORD}@${GIT_URL}
          """
        }
      }
    }
    stage('Install ArgoCD Prometheusand Gerafana') {
        steps {
            sh """
            chmod +x script.sh
            bash script.sh
            """
        }
    }
}
}