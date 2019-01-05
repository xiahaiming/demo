pipeline {
	agent { 
		kubernetes {
			label "jenkins-agent" 
			defaultContainer 'golang'
			customWorkspace "/home/jenkins/workspace/go/src/demo"
		}
	}

	environment {
		GOPATH="/go:/home/jenkins/workspace/go"
		PATH="$PATH:$WORKSPACE/bin:/usr/local/go/bin"
	}

	stages {
		stage("build") {
			parallel {
				stage("===========1") {
					steps {
						script {
							def response
							try {
								timeout(time: 20, unit: 'SECONDS') {
									response = input message: "continue to fucker ?", ok: 'yes'
								}
							}
							catch(err) {
								response = 'yes'
							}

							try {
								sh '''
									go build main.go
								'''
							}
							catch(err) {
								echo err
							}
						}
					}
				}
				stage("===============================2") {
					steps {
						echo "haha"
					}
				}
			}

			post {
				always {
					echo "finish stage build"
				}
			}
		}

		stage("analysis") {
			steps {
				echo "TODO"
				sh '''
					go vet
				'''
			}
			post {
				always {
					echo "finish stage analysis"
				}
			}
		}

		stage("unit test") {
			steps {
				sh 'go test'
			}
			post {
				always {
					echo "finish stage package"
				}
			}
		}

		stage("intergetion test") {
			steps {
				echo "TODO: "
			}
			post {
				always {
					echo "finish stage deploy"
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
