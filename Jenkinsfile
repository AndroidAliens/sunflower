pipeline {
    agent {dockerfile true}
    environment {
        appName = 'Android-Work-Manager'
    }
    stages {
        stage("Test") {
            steps {
                echo "Branch to build is: ${env.BRANCH_NAME}"
                echo "Change branch is: ${env.CHANGE_BRANCH}"
                echo "Target branch is: ${env.CHANGE_TARGET}"
                echo "Build number: ${env.BUILD_NUMBER}"

                echo 'Testing'
//                sh './gradlew testProductionReleaseUnitTest'
            }
        }
        stage("Build") {
            steps {
                echo 'Building apk'
                sh './gradlew clean assembleProductionRelease'

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
            steps {
                echo 'Deploy apk'
                def apkLocation = "${env.WORKSPACE}/app/build/outputs/app-production-release-unsigned.apk"

                def newApk = "${env.WORKSPACE}/app/build/outputs/Sunflower-production-${env.BUILD_NUMBER}.apk"

                if (fileExists(apkLocation)) {
                    writeFile(file: newApk, encoding: "UTF-8", text: readFile(file: apkLocation, encoding: "UTF-8"))
                    echo 'Successfully renamed file'
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