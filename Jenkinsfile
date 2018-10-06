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
                sshagent(credentials: ['c96bd7d2-a99f-41bd-b529-2c5b314e647b']) {
                    sh 'git config --local user.email "mateusz.sawa@gmail.com"'
                    sh 'git config --local user.name "mateusz"'
                    sh './pipeline.sh version'
                    sh 'git add .'
                    sh 'git commit -m "version bump"'
                    sh 'git push origin master'
                }
            }
        }
    }
}