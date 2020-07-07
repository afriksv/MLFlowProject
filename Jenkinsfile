pipeline {
    agent any
    stages
       {
        stage('Stop Old Build') 
           {
            steps {
                milestone label: '', ordinal:  Integer.parseInt(env.BUILD_ID) - 1
                milestone label: '', ordinal:  Integer.parseInt(env.BUILD_ID)
            }
        }
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
                      docker exec --tty docker-compose_mlflow_1 /bin/bash -c "ls && mlflow run MLFlowProject/mlflow-master/examples/sklearn_elasticnet_diabetes/linux --no-conda" 
                      docker exec --tty docker-compose_mlflow_1 /bin/bash -c "mlflow models serve -m ../home/aiops-user/artifact_root/0/*/artifacts/model --no-conda -h 0.0.0.0 -p 5000"
                    '''
                    }
                }
      }
    environment {
        EMAIL_TO = 'maria.rod05.r@gmail.com'
    }
    post {
        failure {
            emailext body: 'Check console output at $BUILD_URL to view the results. \n\n ${CHANGES} \n\n -------------------------------------------------- \n${BUILD_LOG, maxLines=100, escapeHtml=false}', 
                    to: "${EMAIL_TO}", 
                    subject: 'Build failed in Jenkins: $PROJECT_NAME - #$BUILD_NUMBER'
        }
        unstable {
            emailext body: 'Check console output at $BUILD_URL to view the results. \n\n ${CHANGES} \n\n -------------------------------------------------- \n${BUILD_LOG, maxLines=100, escapeHtml=false}', 
                    to: "${EMAIL_TO}", 
                    subject: 'Unstable build in Jenkins: $PROJECT_NAME - #$BUILD_NUMBER'
        }
        changed {
            emailext body: 'Check console output at $BUILD_URL to view the results.', 
                    to: "${EMAIL_TO}", 
                    subject: 'Jenkins build is back to normal: $PROJECT_NAME - #$BUILD_NUMBER'
        }
    }
  }
