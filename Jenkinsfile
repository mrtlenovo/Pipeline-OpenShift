pipeline {
    agent any

    environment {
        OCP_TOKEN = credentials('ocp-token')  // Use the token credential added earlier
        OCP_SERVER = 'https://api.ocptest.demo.local:6443'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git 'https://gitlab.com/your-repo.git'
            }
        }

        stage('Build and Push Image') {
            steps {
                sh """
                oc login ${OCP_SERVER} --token=${OCP_TOKEN} --insecure-skip-tls-verify
                oc project cicd-test
                oc new-build --binary --name=my-app -l app=my-app
                oc start-build my-app --from-dir=. --follow
                """
            }
        }

        stage('Deploy to OpenShift') {
            steps {
                sh """
                oc apply -f deployment.yaml
                """
            }
        }

        stage('Run Smoke Tests') {
            steps {
                sh """
                oc run smoke-test --image=my-app --command -- ./run-smoke-tests.sh
                """
            }
        }
    }
}
