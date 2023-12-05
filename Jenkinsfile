pipeline {
    agent any

environment {
        AWS_REGION = "us-east-1"
    }
    
    parameters {
        booleanParam(defaultValue: false, description: 'Run terraform destroy?', name: 'Destroy')
    }

    stages {
        stage('Init') {
            steps {
                script{
                    sh 'terraform init'
                }
            }
        }

        stage('Plan') {
            when {
                expression { params.runDestroy == false }
            }
            stages{
                stage{
                    steps {
                        script{
                            withAWS(region: AWS_REGION, credentials: 'AWS_KEYS') {
                            sh 'terraform plan'
                   }
                }
            }
        }

                stage('Apply') {
                    steps {
                        script{
                        withAWS(region: AWS_REGION, credentials: 'AWS_KEYS') {
                        sh 'terraform apply -auto-approve'
                        }
                    }
                }
            }

                stage('Print Workspace Directory') {
                    steps {
                        script {
                        echo "Workspace Directory: ${workspace}"
                    }
                }
            }
        }
    }
    stage('Terraform Destroy'){
        when {
                expression { params.Destroy == true }
            }
        steps{
            script{
                 withAWS(region: AWS_REGION, credentials: 'AWS') {
                        sh 'terraform destroy -auto-approve'
                    }
                }
            }
        }
    }
}