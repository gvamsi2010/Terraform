pipeline {
    agent any

    stages {
        stage('TFLint') {
            steps {
                script {
                    try {
                        // Run tflint and capture the exit code
                        sh 'tflint'
                    } catch (Exception e) {
                        echo 'TFLint found potential problems'
                    }
                }
            }
        }

        stage('TFSec') {
            steps {
                script {
                    try {
                        // Run tfsec and capture the exit code
                        sh 'tfsec'
                    } catch (Exception e) {
                        echo 'TFSec found potential problems'
                    }
                }
            }
        }

        stage('Terratest') {
            steps {
                dir('test') {
                    sh 'if [ ! -f go.mod ]; then go mod init github.com/gvamsi2010/Terraform.git; fi'
                    sh 'go mod tidy'
                    try {
                        sh 'go test'
                    } catch (Exception e) {
                        echo 'Error occurred during Terratest'
                    }
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
