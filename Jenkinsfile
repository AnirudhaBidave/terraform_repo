pipeline {
    agent any

    environment {
        AWS_REGION = 'us-east-1'
    }

    parameters {
        booleanParam(defaultValue: false, description: 'Run terraform destroy?', name: 'Destroy')
    }

    stages {
        stage('Init') {
            steps {
                script {
                    sh 'terraform init'
                }
            }
        }

        stage('Create Infrastructure') {
            when {
                expression { params.Destroy == false }
            }
            stages {
                stage('Plan/Apply') {
                    steps {
                        script {
                            withAWS(region: AWS_REGION, credentials: 'AWS_KEY') {
                                sh 'terraform plan'
                                sh 'terraform apply -auto-approve'
                            }
                        }
                    }
                }
                stage('Get private key') {
                    steps {
                        script {
                            sh "sudo chmod 400 /var/lib/jenkins/workspace/terraform_pipeline/private_key.pem"
                            sh "sudo cp /var/lib/jenkins/workspace/terraform_pipeline/private_key.pem /home/sigmoid/"
                        }
                    }
                } 
            }
        }
        stage('Terraform Destroy') {
            when {
                expression { params.Destroy == true }
            }
            steps {
                script {
                    withAWS(region: AWS_REGION, credentials: 'AWS_KEy') {
                        sh 'terraform destroy -auto-approve'
                    }
                }
            }
        }
    }
}
