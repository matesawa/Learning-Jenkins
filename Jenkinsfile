pipeline {
    agent any

    options{
        skipDefaultCheckout()
    }

    stages{
        stage("checkout"){
            steps{
                checkout scm
            }
        }

        stage("introduction"){
            steps{
                script{
                    println "Hello!"
                }
            }
        }

        stage("version"){
            steps{
                withCredentials([usernamePassword(credentialsId: 'c96bd7d2-a99f-41bd-b529-2c5b314e647b', passwordVariable: 'GIT_PASSWORD', usernameVariable: 'GIT_USERNAME')]) {
                    sh('git checkout master')
                    sh('./pipeline.sh version')
                    sh('git add .')
                    sh('git commit -m version')
                    sh('git push https://${GIT_USERNAME}:${GIT_PASSWORD}@github.com/matesawa/Learning-Jenkins master')
                }
            }
        }
    }
}