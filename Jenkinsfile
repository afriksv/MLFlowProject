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
                    cd docker-compose
                    docker-compose down
                    cd ..
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
                steps{
                    sh '''
                      export COMPOSE_INTERACTIVE_NO_CLI=1
                      docker exec -it docker-compose_mlflow_1 /bin/bash
                      /*docker start docker-compose_mlflow_1
                      docker attach docker-compose_mlflow_1*/
                      ls
                      /* cd mlflow
                      mlflow run exmaples/sklearn_elasticnet_diabetes/linux*/
                      exit
                      
                    '''
                    }
                }
      }
  }
