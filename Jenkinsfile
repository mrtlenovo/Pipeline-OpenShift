pipeline {
    agent any

    environment {
        OCP_SERVER = 'https://api.ocptest.demo.local:6443'
        OCP_TOKEN = credentials('ocp-external-token')  // Using the token credential
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/mrtlenovo/Pipeline-OpenShift.git'
            }
        }

        stage('Login to OpenShift') {
            steps {
                sh """
                oc login ${OCP_SERVER} --token=${OCP_TOKEN} --insecure-skip-tls-verify
                oc project cicd-prod
                """
            }
        }

        stage('Build and Deploy') {
            steps {
                sh """
                oc new-build --binary --name=my-app -l app=my-app || true
                oc start-build my-app --from-dir=. --follow
                oc apply -f deployment.yaml
                """
            }
        }
    }
}

