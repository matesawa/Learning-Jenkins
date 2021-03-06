@Library("Learning-Jenkins") _

def author

def printAuthor(author){    
    return author
}

pipeline {
    agent any

    options{
        skipDefaultCheckout()
        buildDiscarder(logRotator(numToKeepStr: '5'))
        disableConcurrentBuilds()
        skipStagesAfterUnstable()
    }

    triggers{
        pollSCM('* * * * *')
    }

    // parameters{
    //     string(name: 'build_version', defaultValue: '', description: 'Type application version to build. Ex: 0.39.')
    // }

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
                deleteDir()
                script{
                     println "Stage: checkout"
                }
                
                //checkout scm

                checkout([
                    $class              : "GitSCM",
                    branches            : [[name: "origin/master"]],
                    userRemoteConfigs   : [[url: 'https://github.com/matesawa/Learning-Jenkins.git']]])

                script{ 
                    author = sh(script: 'git log -n1 --format="%an"', returnStdout: true).trim().toLowerCase()
                    println "Author is: ${printAuthor(author)}"
                    printIntroduction.init 'First jenkins pipeline'
                }
            }
        }

        stage("stages running in parallel") {
            failFast true

            when {
                expression { return author!='ms-build-jenkins' }
            }

            parallel{
                stage("build"){
                    environment {
                        BUILD_CONDITION = 'UNSTABLE'
                    }

                    steps{
                        script{
                            def randomNumber = Math.random();
                            def randomBoolean = randomNumber < 0.1
                            def currentBuildState = currentBuild.result == null ? 'unknown' : currentBuild.result;

                            if (randomBoolean){
                                println "Build is ${BUILD_CONDITION}. Numer was ${randomNumber}."
                                currentBuild.result = '${BUILD_CONDITION}'
                            } else {
                                println "Build is unstable: ${randomBoolean}, number was: ${randomNumber}."
                                println "Build actual state: ${currentBuildState}"
                            }
                        }
                    }
                }

                stage("introduction"){
                    steps{
                        script{
                            println "Stage: introduction"
                            println "Hello!" /*+ "You selected version ${params.build_version} to build."*/
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
            when {
                expression { return author!='ms-build-jenkins' }
            }
            
            steps{
                script{
                    println "Stage: app-run"
                    sh('./pipeline.sh run')
                }
            }
        }

        stage("changelog"){
            when {
                expression { return author!='ms-build-jenkins' }
            }

            steps{
                script{
                    println "Stage: changelog"
                }
            }
        }

        stage("version"){
            when {
                expression { return author!='ms-build-jenkins' }
            }

            steps{
                script{
                    println "Stage: version"
                }
                withCredentials([usernamePassword(credentialsId: 'ms-build-jenkins', passwordVariable: 'GIT_PASSWORD', usernameVariable: 'GIT_USERNAME')]) {
                    sh "git config user.email ms-build-jenkins@gmail.com"
                    sh "git config user.name ms-build-jenkins"

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