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

	triggers {
		githubPullRequest {
			admin('user_1')
			admins(['user_2', 'user_3'])
			userWhitelist('you@you.com')
			userWhitelist(['me@me.com', 'they@they.com'])
			orgWhitelist('my_github_org')
			orgWhitelist(['your_github_org', 'another_org'])
			cron('H/5 * * * *')
			triggerPhrase('OK to test')
			onlyTriggerPhrase()
			useGitHubHooks()
			permitAll()
			autoCloseFailedPullRequests()
			allowMembersOfWhitelistedOrgsAsAdmin()
			extensions {
				commitStatus {
					context('deploy to staging site')
					triggeredStatus('starting deployment to staging site...')
					startedStatus('deploying to staging site...')
					statusUrl('http://mystatussite.com/prs')
					completedStatus('SUCCESS', 'All is well')
					completedStatus('FAILURE', 'Something went wrong. Investigate!')
					completedStatus('PENDING', 'still in progress...')
					completedStatus('ERROR', 'Something went really wrong. Investigate!')
				}
			}
		}
	}

	stages {
		stage("build") {
			parallel {
				stage("===========1") {
					steps {
						script {
							echo "motherfucker"
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
							job('example') {
							}
						}
					}
				}
			}

			post {
				always {
					echo "finish stage build"
					step([$class: "GitHubCommitStatusSetter", reposSource: [$class: "ManuallyEnteredRepositorySource", url: "https://github.com/my-org/my-repo"], contextSource: [$class: "ManuallyEnteredCommitContextSource", context: "ci/jenkins/build-status"], errorHandlers: [[$class: "ChangingBuildStatusErrorHandler", result: "UNSTABLE"]], statusResultSource: [ $class: "ConditionalStatusResultSource", results: [[$class: "AnyBuildResult", message: message, state: state]] ] ]);
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
