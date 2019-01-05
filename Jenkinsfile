pipeline {
	agent { 
		kubernetes {
			label "jenkins-agent-docker" 
			defaultContainer 'docker'
			customWorkspace "/home/jenkins/workspace/go/src/demo"
		}
	}

	stages {
		stage("deployment") {
			steps {
				echo "TODO: "
				sh 'docker version'
				sh 'docker build .'
				sh 'docker images'
			}

			post {
				always {
					echo "finish stage deploy"
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
