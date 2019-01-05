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
