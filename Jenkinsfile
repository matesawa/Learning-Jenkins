pipeline {
    agent any

    options{
        skipDefaultCheckout()
        buildDiscarder(logRotator(numToKeepStr: '5'))
    }

    stages{

        // stage("message") {
        //     input { 
        //         message "Please give introduction message:"
        //         ok "OK"
        //         submitter "dummyuser,admin"
        //         submitterParameter "whoIsSubmitter"
        //         parameters {
        //             string(name: 'title', defaultValue: 'Some title', description: 'Specify introduction message.')
        //             booleanParam(name: 'skipChangelog', defaultValue: false, description: 'skip changelog' )
        //         }
        //     }

        //     steps {
        //         echo "Introduction title is: ${title}"
        //         echo "Skip changelog: ${skipChangelog}"
        //     }
        // }
        
        stage("checkout"){
            steps{
                script{
                    println "Stage: checkout"
                }
                checkout scm
            }
        }

        stage("stages running in parallel") {
            failFast true

            parallel{
                stage("build"){
                    environment {
                        CONDITION = 'UNSTABLE'
                    }

                    steps{
                        script{
                            def randomBoolean = Math.random() < 0.1
                            def currentBuildState = currentBuild.result == null ? 'unknown' : currentBuild.result;
                            
                            if (randomBoolean){
                                println "Build is ${CONDITION}"
                                currentBuild.result = '${CONDITION}'
                            } else {
                                println "Build is unstable: ${randomBoolean}"
                                println "Build actual state: ${currentBuildState}"
                            }
                        }
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

    post{
        //run on success pipeline
        success{
            echo "post-> success is called"
        }
        //run on failed pipeline
        failure{
            echo "post-> failure is called"
        }
        //run always
        always{
            echo "post-> always is called"
        }
        //run when previous build had different result
        changed{
            echo "post-> changed is called"
        }
        //run when unstable pipeline
        unstable{
            echo "post-> unstable is called "
        }
        //run when previous build failed and current is success
        fixed{
            echo "post-> fixed is called"
        }
        //run when previous build was success and current failed
        regression{
            echo "post-> regression is called"
        }
        //run when build was aborted by user
        aborted{
            echo "post-> aborted is called"
        }
        //run regardless of pipeline result, executed last
        cleanup{
            echo "post-> cleanup is called"
        }
    }
}