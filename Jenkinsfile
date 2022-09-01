def fnSteps = evaluate readTrusted("jenkinsfiles/steps.groovy")

pipeline{
    agent any
    parameters {
        choice(
            name: 'STACK',
            choices:['DEPLOY','DESTROY'],
            description: 'Opciones de deploy/destroy del Stack'
        )
    }

    stages{
        stage('Set Config') {
            steps {
                script {
                    config = fnSteps.configs()
                }
            }
        }

        stage('Build Images') {
            steps {
                script {
                    fnSteps.build_images(config)
                }
            }
        }

        stage('Execute test for app') {
            when { expression { return params.STACK == 'DEPLOY' }}
            steps {
                script {
                    fnSteps.execute_test_app(config)
                }
            }
        }


        stage('Push images to ECR') {
            when { expression { return params.STACK == 'DEPLOY' }}
            steps {
                script {
                    fnSteps.push_images_to_ecr(config)
                }
            }
        }

        stage('Destroy images from ECR') {
            when { expression { return params.STACK == 'DESTROY' }}
            steps {
                script {
                    fnSteps.destroy_images_from_ecr(config)
                }
            }
        }

        stage('Deploy app, database and proxy'){
            when { expression { return params.STACK == 'DEPLOY' }}
            steps {
                script {
                    fnSteps.stack_deploy(config)
                }
            }
        }

        stage('Destroy Stack') {
            when { expression { return params.STACK == 'DESTROY' }}
            steps {
                script {
                    fnSteps.stack_destroy(config)
                }
            }
        }

    }

    post {
        always {
            echo 'Execution finished.'
            cleanWs()
        }
    }
}

