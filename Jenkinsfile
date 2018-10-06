pipeline {
    agent any

    stages{
        stage("checkout"){
            scm checkout
        }

        stage("introduction"){
            script{
                println "Hello!"
            }
        }
    }
}