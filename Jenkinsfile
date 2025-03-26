pipeline {
    agent any

    environment {
        OCP_SERVER = 'https://api.ocptest.demo.local:6443'
        OCP_TOKEN = credentials('ocp-external-token')  // Using the token credential
        MAIL_RECIPIENTS = 'developer@example.com'  // Developer's Outlook email
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

    post {
        success {
            emailext(
                to: "${MAIL_RECIPIENTS}",
                subject: "Jenkins Build SUCCESSFUL: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                body: """
                Good news! The Jenkins pipeline for your project completed successfully.

                Project: ${env.JOB_NAME}
                Build Number: ${env.BUILD_NUMBER}
                Result: SUCCESS

                You can view the build details at: ${env.BUILD_URL}

                Regards,
                Jenkins CI/CD Team
                """
            )
        }

        failure {
            emailext(
                to: "${MAIL_RECIPIENTS}",
                subject: "Jenkins Build FAILED: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                body: """
                Oops! The Jenkins pipeline for your project has failed.

                Project: ${env.JOB_NAME}
                Build Number: ${env.BUILD_NUMBER}
                Result: FAILURE

                You can view the build logs and details at: ${env.BUILD_URL}

                Please check the pipeline and logs to identify the cause of the failure.

                Regards,
                Jenkins CI/CD Team
                """
            )
        }
    }
}
