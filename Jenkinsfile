#!groovy
pipeline {
	agent none

	environment {
		COMPLETED_MSG = "==> Build done!"
	}

	parameters {
		string(defaultValue: '', description: '', name : 'BRANCH_NAME')
		choice (choices: 'DEBUG\nCANARY\nTEST', description: '', name : 'BUILD_CONFIG')
	}

	stages {
		stage("build") {
			agent {
				kubernetes {
					label "jenkins-agent"
					defaultContainer 'golang'
					customWorkspace "/home/jenkins/workspace/go/src/demo"
				}
			}
			steps {
				echo "${env.PATH}"
				echo "${PATH}"
				sh "printenv"
				script {
					try {
						echo "build"
						cmdOutput = echo sh (script:"go build main.go", returnStdout:true).trim()
						echo "${cmdOutput}"

						echo "analysis"
						cmdOutput = echo sh (script:"go vet .", returnStdout:true).trim()
						echo "${cmdOutput}"

						echo "unit test"
						cmdOutput = echo sh (script:"go test .", returnStdout:true).trim()
						echo "${cmdOutput}"

						echo "commitID is:"
						echo "${GIT_COMMIT}"

					}
					catch(err) {
						echo err
					}
					finally {
						echo "step1 go build failure"
					}
				}
				
			}
		}
		stage("select") {
			steps {
				script {
					try {
						timeout(time:4, unit: "MINUTES") {
							env.BUILD_TYPE = input message: 'build type ?', parameters: 
								[choice (choices: 'DEBUG\nCANARY\nONLINE', description: '', name : 'BUILD_TYPE')]
						}
					}
					catch(err) {
						env.BUILD_TYPE = "DEBUG"
					}
				}
			}
		}

		stage("deployment") {
			when {
				allOf {
					environment name: "BUILD_TYPE", value: "CANARY"
					environment name: "ghprbSourceBranch", value: "master"
				}
			}

			agent { 
				kubernetes {
					label "jenkins-agent-docker" 
					defaultContainer 'docker'
					customWorkspace "/home/jenkins/workspace/go/src/demo"
				}
			}

			steps {
				sh '''
					printenv
					echo "Kicking off canary build\n"
					docker version
					docker build -t togo-feeds-server .
					docker tag togo-feeds-server:latest 492666533052.dkr.ecr.ap-south-1.amazonaws.com/togo.feeds_server:git${GIT_COMMIT}
					docker images
				'''
			}

			post {
				always {
					sh "echo $COMPLETED_MSG"
				}
			}
		}
		
		stage("deployment for canary") {
			agent {
				kubernetes {
					label "jenkins-agent"
					defaultContainer 'golang'
					customWorkspace "/home/jenkins/workspace/go/src/demo"
				}
			}

			steps {
				echo "TODO"
			}
			post {
				always {
					echo "finish stage analysis"
				}
			}
		}

	}
	
	post {
		always {
			echo "$COMPLETED_MSG"	
		}

		failure {
			echo "failure"	
		}

		success {
			echo "success"	
		}
	}
}
