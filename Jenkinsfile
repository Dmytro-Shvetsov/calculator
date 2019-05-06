env.DOCKERHUB_USERNAME = "dymokk"
env.DOCKERHUB_PROJECT_NAME = "calculator"
env.DOCKERHUB_PROJECT_PATH = DOCKERHUB_USERNAME + "/" + DOCKERHUB_PROJECT_NAME
node("stage")
{
    //checkout scm
    stage("Unit-testing")
    {
        sh "docker run --rm -d --name test -p 3000:3000 ${DOCKERHUB_PROJECT_PATH}"
    
        sh "docker exec -it ${DOCKERHUB_PROJECT_PATH} npm test"
        sh "docker ps -aq | xargs docker rm || true"
    }
    stage("Build")
    {
        sh "docker build -t ${DOCKERHUB_PROJECT_PATH}:${BUILD_NUMBER}"
    }
    stage("Publish")
    {
        withDockerRegistry([credentialsId: "DockerHub"])
        sh "docker push ${DOCKERHUB_PROJECT_PATH}:${BUILD_NUMBER}"
    }
}