pipeline {
    agent any

    environment {
        SERVICE_NAME       = "nginx"
        ORGANIZATION_NAME  = "mohammedmqm"
        DOCKERHUB_USERNAME = "mohammedmqm"
        REPOSITORY_TAG     = "${DOCKERHUB_USERNAME}/${ORGANIZATION_NAME}-${SERVICE_NAME}:${BUILD_ID}"
    }

    stages {
        stage('Build and Push Image') {
            steps {
                script {
                    docker.withRegistry('', 'docker-hub') {
                        def image = docker.build(REPOSITORY_TAG)
                        image.push()
                    }
                }
            }
        }

        stage('Deploy to Cluster') {
            steps {
                sh """
                    sed 's|REPOSITORY_TAG|${REPOSITORY_TAG}|g' deployment.yaml | kubectl apply -f -
                """
            }
        }
    }
}

