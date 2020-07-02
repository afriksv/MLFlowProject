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
                      docker exec --tty docker-compose_mlflow_1 /bin/bash -c "ls && mlflow run mlflow/examples/sklearn_elasticnet_diabetes/linux --no-conda" 
                      docker exec --tty docker-compose_mlflow_1 /bin/bash -c "ls ../home/aiops-user/artifact_root/0/edb6344e714d40389afc704f5f0ba2b8/artifacts/model"
                    '''
                    }
                }
      }
  }
