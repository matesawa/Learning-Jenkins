pipeline {
    agent any

    options{
        skipDefaultCheckout()
    }

    stages{
        stage("checkout"){
            steps{
                script{
                    println "Stage: checkout"
                }
                checkout scm
            }
        }

        stage("introduction"){
            steps{
                script{
                    println "Stage: introduction"
                    println "Hello!"
                }
            }
        }
        
        stage("dockerize"){
            steps{
                script{
                    println "Stage: dockerize"
                    sh('./pipeline.sh dockerize')
                }
            }
        }

        stage("app-run"){
            steps{
                script{
                    println "Stage: app-run"
                    sh('./pipeline.sh run')
                }
            }
        }

        stage("changelog"){
            steps{
                script{
                    println "Stage: changelog"
                    
                }
            }
        }

        stage("version"){
            steps{
                script{
                    println "Stage: version"
                }
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