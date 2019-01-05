pipeline {
	agent none

	stages {
		stage("build") {
			parallel {
				agent {
					kubernetes {
						label "jenkins-agent"
						defaultContainer 'golang'
						customWorkspace "/home/jenkins/workspace/go/src/demo"
					}
				}
				stage("build") {
					steps {
						script {
							try {
								sh '''
									go build main.go
								'''
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
				stage("====build===========2") {
					steps {
						script {
							try {
								sh '''
									go build main.go
								'''
							}
							catch(err) {
								echo err
							}
							finally {
								echo "step3 go build failure"
							}
						}
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
			agent {
				kubernetes {
					label "jenkins-agent"
					defaultContainer 'golang'
					customWorkspace "/home/jenkins/workspace/go/src/demo"
				}
			}

			steps {
				echo "TODO"
				sh '''
					go env
					git status
				'''
			}
			post {
				always {
					echo "finish stage analysis"
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
