environment
    {
        DOCKERHUB_USERNAME = "dymokk"
        DOCKERHUB_PROJECT_NAME = "calculator"
        DOCKERHUB_PROJECT_PATH = DOCKERHUB_USERNAME + "/" + DOCKERHUB_PROJECT_NAME
    }
node("ubuntu-slave-1")
{
    stages
    {
        stage("Cloning git")
        {
            git credentialsId: '6a470481-5272-42b2-98ae-5ede2528bc13', url: 'https://github.com/Dmytro-Shvetsov/calculator'
        }
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
            withRegistry([credentialsId: "DockerHub"])
            sh "docker push ${DOCKERHUB_PROJECT_PATH}:${BUILD_NUMBER}"
        }
    }
}
