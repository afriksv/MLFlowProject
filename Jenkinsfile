pipeline {
    agent any
    stages
       {
        stage('Checkout-git') 
            {
            steps{
                git poll: true, url:'https://github.com/afriksv/MLFlowProject.git'
                }
            }
        stage('Build-mlflow-container') 
            {
            steps{
                sh '''
                    docker build --network=host -t mlflow-image .
                '''
                }
            }
        stage('Delete-mlflow-container') 
            {
            steps{
                sh '''
                    docker rmi mlflow-image
                '''
                }
            }
      }
}