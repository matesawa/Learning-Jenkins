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
    }
}