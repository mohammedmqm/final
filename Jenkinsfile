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
                    // Using withCredentials to securely handle Docker Hub login
                    withCredentials([usernamePassword(credentialsId: 'docker-hub', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        // Docker login securely
                        sh """
                            echo ${DOCKER_PASS} | docker login -u ${DOCKER_USER} --password-stdin
                        """

                        // Build the Docker image
                        def image = docker.build(REPOSITORY_TAG)

                        // Push the image to Docker Hub
                        image.push()
                    }
                }
            }
        }

        stage('Deploy to Cluster') {
            steps {
                script {
                    // Deploy the image to your Kubernetes cluster, replace REPOSITORY_TAG in the YAML file
                    sh """
                        sed 's|REPOSITORY_TAG|${REPOSITORY_TAG}|g' deployment.yaml | kubectl apply -f -
                    """
                }
            }
        }
    }
}

