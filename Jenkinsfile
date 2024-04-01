pipeline {
    agent any

    stages {
        stage('TFLint') {
            steps {
                script {
                    // Run tflint and capture the exit code
                    def tflintExitCode = sh(returnStatus: true, script: 'tflint')

                    // Check if tflint command failed (exit code not 0)
                    if (tflintExitCode != 0) {
                        echo 'TFLint found potential problems'
                        // Do not mark the build as failed
                    }
                }
            }
        }

        stage('TFSec') {
            steps {
                script {
                    // Run tfsec and capture the exit code
                    def tfsecExitCode = sh(returnStatus: true, script: 'tfsec')

                    // Check if tfsec command failed (exit code not 0)
                    if (tfsecExitCode != 0) {
                        echo 'TFSec found potential problems'
                        // Do not mark the build as failed
                    }
                }
            }
        }

        stage('Terratest') {
            steps {
                dir('test') {
                    sh 'if [ ! -f go.mod ]; then go mod init github.com/palakbhawsar98/Terraform-CI-CD-Pipeline; fi'
                    sh 'go mod tidy'
                    sh 'go test'
                    // You can add similar error handling logic here if required
                }
            }
        }

        /*stage('Terraform workflow') {
            steps {
                sh 'terraform init'
                sh 'terraform plan -out=tfplan'
                sh 'terraform apply -auto-approve tfplan'
                // You can add similar error handling logic here if required
            }
        }*/
    }

    post {
        always {
            // Perform cleanup or any necessary actions regardless of stage results
            echo 'Pipeline completed'
        }
    }
}
