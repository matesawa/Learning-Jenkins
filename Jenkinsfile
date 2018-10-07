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
        
        stage("dockerize"){
            steps{
                script{
                    sh('./pipeline.sh dockerize')
                }
            }
        }

        stage("app-run"){
            steps{
                script{
                    sh('./pipeline.sh run')
                }
            }
        }

        stage("version"){
            steps{
                withCredentials([usernamePassword(credentialsId: 'github', passwordVariable: 'GIT_PASSWORD', usernameVariable: 'GIT_USERNAME')]) {
                    sh "git config user.email mateusz.sawa@gmail.com"
                    sh "git config user.name matesawa"

                    sh('./pipeline.sh version')
                    sh('git push https://${GIT_USERNAME}:${GIT_PASSWORD}@github.com/matesawa/Learning-Jenkins.git master')
                }
            }
        }
    }
}