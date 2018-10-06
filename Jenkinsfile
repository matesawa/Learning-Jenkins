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
                sshagent(credentials: ['dupa']) {
                    sh 'git config --local user.email "mateusz.sawa@gmail.com"'
                    sh 'git config --local user.name "mateusz"'
                    sh 'git checkout master'
                    sh './pipeline.sh version'
                    sh 'git add .'
                    sh 'git commit -m version-change'
                    sh 'git push origin master'
                }
            }
        }
    }
}