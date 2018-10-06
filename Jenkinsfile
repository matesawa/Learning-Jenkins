pipeline {
    agent any

    stages{
        stage("checkout"){
            steps{
                scm checkout
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