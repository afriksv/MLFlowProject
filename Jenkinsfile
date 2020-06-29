pipeline {
    agent any
    
    stages
       {
        stages('Checkout-git') 
            {
            steps{
                git poll: true, url:'https://github.com/afriksv/MLFlowProject.git'
                }
            }
        }
        stages('Build-mlflow-container') 
            {
            steps{
                sh '''
                    docker build --network=host -t mlflow-image .
                '''
                }
            }
        }
        stages('Delete-mlflow-container') 
            {
            steps{
                sh '''
                    docker rmi mlflow-image
                '''
                }
            }
        }

}