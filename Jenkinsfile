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
                    docker build -t --network=host mlflow-image .
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
