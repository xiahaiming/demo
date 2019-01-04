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
				stage("===============================2") {
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
				stage("===================================3") {
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
				stage("===================================4") {
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
								echo "step4 go build failure"
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

		stage("package") {
			steps {
				echo "TODO"
				echo "pack into docker"
			}
			post {
				always {
					echo "finish stage package"
				}
			}
		}

		stage("deploy") {
			steps {
				echo "TODO: "
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
