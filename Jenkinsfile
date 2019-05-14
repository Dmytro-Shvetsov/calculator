node("ubuntu-slave-1")
{
    stage("Cloning git")
    {
        git credentialsId: '27dba3c9-93b1-4619-8c7f-dc10969057ca', url: 'https://github.com/Dmytro-Shvetsov/calculator'
    }
    
    withCredentials([usernamePassword(credentialsId: 'f2901bd9-cb29-4417-9980-df75e729021d', usernameVariable: 'SLAVE_USER', passwordVariable: 'SLAVE_PASSWORD')])
    {
        stage("Build")
        {
            sh "echo ${SLAVE_PASSWORD} | sudo -S docker build -t calc-demo:${BUILD_NUMBER} ${WORKSPACE}"
        }
        stage("Unit-testing")
        {
            sh "echo ${SLAVE_PASSWORD} | sudo -S docker run -d --name test -p 3000:3000 calc-demo:${BUILD_NUMBER}"
            try 
            {
                sh "echo ${PASSWORD} | sudo -S docker exec -it test npm test"
            }catch(error)
            {
                sh "Unit tests have not passed. ${error}"
            }
            sh "echo ${SLAVE_PASSWORD} | sudo -S docker stop test"
        }
        stage("Publish")
        {
            sh "echo ${SLAVE_PASSWORD} | sudo -S docker commit test ${env.DOCKERHUB_IMAGE}"
            sh "echo ${SLAVE_PASSWORD} | sudo -S docker rm test"
            withCredentials([usernamePassword(credentialsId: 'DockerHub', usernameVariable: 'DOCKERHUB_USER', passwordVariable: 'DOCKERHUB_PASSWD')])
            {
                sh "echo ${SLAVE_PASSWORD} | sudo -S docker login -u ${DOCKERHUB_USER} -p ${DOCKERHUB_PASSWD}"
                sh "echo ${SLAVE_PASSWORD} | sudo -S docker push 'dymokk/calculator':latest"
            }
        }
    }
}
