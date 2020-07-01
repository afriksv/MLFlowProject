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
                    docker-compose down
                    docker rmi mlflow_tutorial
                    docker build --network=host -t mlflow_tutorial .
                    docker images
                '''
                }
            }
        stage('Docker-compose') 
            {
              steps{
                    sh '''
                      cd docker-compose
                      docker-compose up -d
                    '''
                   } 
            }
        stage('Run experiment') 
                {
                agent { docker { image 'docker-compose_mlflow_1' } }
                steps{
                    sh '''
                      sleep 10
                      mlflow run mlflow/examples/sklearn_elasticnet_wine
                    '''
                    }
                }
      }
  }
