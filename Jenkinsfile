pipeline {
    agent {dockerfile true}
    environment {
        appName = 'Sunflower'
    }
    stages {
        stage("Initialise") {
            steps {
                echo "Branch to build is: ${env.BRANCH_NAME}"
                echo "Change branch is: ${env.CHANGE_BRANCH}"
                echo "Target branch is: ${env.CHANGE_TARGET}"
                echo "Build number: ${env.BUILD_NUMBER}"

                script {

                    env.BUILD_TYPE = 'Release'
                    if (env.BRANCH_NAME == 'main' || env.CHANGE_TARGET == 'main') { //main = develop
                        env.BUILD_FLAVOUR = 'Development'
                        env.BUILD_TYPE = 'Debug'
                    } else if (env.BRANCH_NAME == 'master' || env.CHANGE_TARGET == 'master') {
                        env.BUILD_FLAVOUR = 'Release'
                    } else {
                        //do staging type
                        env.BUILD_FLAVOUR = 'Staging'
                    }
                }
                echo "Flavour is: ${env.BUILD_FLAVOUR}"
                echo "Build type: ${env.BUILD_TYPE}"
            }
        }
        stage("Test") {
            steps {


                echo 'Testing'
//                sh './gradlew testProductionReleaseUnitTest'
            }
        }
        stage("Build") {
            steps {
                echo 'Building apk'
                sh "./gradlew clean assemble${BUILD_FLAVOUR}${BuildType}"

                echo "Successful build ${currentBuild.fullDisplayName}"
                echo "Url:  ${currentBuild.absoluteUrl}"
                echo "Workspace: ${env.WORKSPACE}"
                echo "DIR: ${currentBuild.fullProjectName}"
            }
        }
//        stage("Quality Control") {
//            steps {
//                sh './gradlew testProductionReleaseUnitTestCoverage'
//            }
//        }
        stage("Deploy") {
            environment {
                location = "${env.WORKSPACE}/app/build/outputs/*.apk"
                apkLocation = "${env.WORKSPACE}/app/build/outputs/apk/production/release/app-production-release-unsigned.apk"
                newApk = "${env.WORKSPACE}/app/build/outputs/Sunflower-${BUILD_FLAVOUR}-${BUILD_NUMBER}.apk"
            }
            steps {
                echo 'Deploy apk'
                echo location
                echo apkLocation
                echo newApk

                script {

                    obj = "${env.WORKSPACE}/app/build/outputs/*.apk"
                    echo '----'
                    echo obj
                    echo '----'

                    if (fileExists(apkLocation)) {
                        writeFile(file: newApk, encoding: "UTF-8", text: readFile(file: apkLocation, encoding: "UTF-8"))
                        echo 'Successfully renamed file'
                    }
                }
            }
        }
        stage("Post Actions") {
            steps {
                echo 'Do after build things'
            }
        }
    }
}