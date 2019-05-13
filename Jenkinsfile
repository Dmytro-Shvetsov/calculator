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
    withCredentials([string(credentialsId: "1fdea051-9c8f-4ade-9bcf-b83183c78640", variable: "USER_PASSWD")])
    {
        stage("Build")
        {
            sh "docker build -t calc-demo:${BUILD_NUMBER} ${WORKSPACE}"
        }
        stage("Unit-testing")
        {
            sh "echo ${USER_PASSWD} | sudo -S docker run --rm -d --name test -p 3000:3000 calc-demo:${BUILD_NUMBER}"
            sh "echo ${USER_PASSWD} | sudo -S docker exec -it test npm test"
            sh "echo ${USER_PASSWD} | sudo -S docker ps -aq | xargs docker rm || true"
        }
        stage("Publish")
        {
            sh "echo ${USER_PASSWD} | sudo -S docker commit calc-demo:${BUILD_NUMBER} ${DOCKERHUB_IMAGE}"
            withRegistry([credentialsId: "DockerHub"])
            {
                sh "echo ${USER_PASSWD} | sudo -S docker push ${DOCKERHUB_IMAGE}:latest"
            }
        }
    }
}
