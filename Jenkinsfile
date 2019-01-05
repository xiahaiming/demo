pipeline {
	agent none

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

		stage("deployment") {
			agent { 
				kubernetes {
					label "jenkins-agent-docker" 
					defaultContainer 'docker'
					customWorkspace "/home/jenkins/workspace/go/src/demo"
				}
			}

			steps {
				sh '''
					docker version
					docker build -t togo-feeds-server .
					docker images
				'''

			}

			post {
				always {
					echo "finish stage deploy"
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
			echo "finished"	
		}

		failure {
			echo "failure"	
		}

		success {
			echo "success"	
		}
	}
}
