environment
    {
        DOCKERHUB_USERNAME = "dymokk"
        DOCKERHUB_PROJECT_NAME = "calculator"
        DOCKERHUB_IMAGE = DOCKERHUB_USERNAME + "/" + DOCKERHUB_PROJECT_NAME
    }
node("ubuntu-slave-1")
{
    stage("Cloning git")
    {
        git credentialsId: '6a470481-5272-42b2-98ae-5ede2528bc13', url: 'https://github.com/Dmytro-Shvetsov/calculator'
    }
    stage("Build")
    {
        sh "docker build -t calc-demo:${BUILD_NUMBER} ${WORKSPACE}/calculator
    }
    stage("Unit-testing")
    {
        sh "docker run --rm -d --name test -p 3000:3000 calc-demo:${BUILD_NUMBER}"
        sh "docker exec -it test npm test"
        sh "docker ps -aq | xargs docker rm || true"
    }
    stage("Publish")
    {
        sh "docker commit calc-demo:${BUILD_NUMBER} ${DOCKERHUB_IMAGE}"
        withRegistry([credentialsId: "DockerHub"])
        sh "docker push ${DOCKERHUB_IMAGE}:latest"
    }
}
