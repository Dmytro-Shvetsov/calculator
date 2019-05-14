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
        git credentialsId: '27dba3c9-93b1-4619-8c7f-dc10969057ca', url: 'https://github.com/Dmytro-Shvetsov/calculator'
    }
    
    withCredentials([usernamePassword(credentialsId: 'f2901bd9-cb29-4417-9980-df75e729021d', usernameVariable: 'USER', passwordVariable: 'PASSWORD')])
    {
        stage("Build")
        {
            sh "echo ${PASSWORD} | sudo -S docker build -t calc-demo:${BUILD_NUMBER} ${WORKSPACE}"
        }
        stage("Unit-testing")
        {
            sh "echo ${PASSWORD} | sudo -S docker run --rm -d --name test -p 3000:3000 calc-demo:${BUILD_NUMBER}"
            try 
            {
                //sh "echo ${PASSWORD} | sudo -S docker exec -it test npm test"
            }catch(error)
            {
                sh "Unit tests have not passed. ${error}"
            }
            sh "echo ${PASSWORD} | sudo -S docker stop test"
        }
        stage("Publish")
        {
            sh "echo ${PASSWORD} | sudo -S docker commit test ${env.DOCKERHUB_IMAGE}"
            withDockerRegistry([credentialsId: "DockerHub"])
            {
                sh "echo ${PASSWORD} | sudo -S docker push ${env.DOCKERHUB_IMAGE}:latest"
            }
        }
    }
}
