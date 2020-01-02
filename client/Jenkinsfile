node {
    //config
    def to = emailextrecipients([
        [$class: 'CulpritsRecipientProvider'],
        [$class: 'DevelopersRecipientProvider'],
        [$class: 'RequesterRecipientProvider']
    ])
    def commit_id
    //job
    try{
    
    stage('Preparation') {
        checkout scm
        sh "git rev-parse --short HEAD > .git/commit-id"
        commit_id = readFile('.git/commit-id').trim()
    }
    //stage('failing-test') {
    //    println('Now test stage will fail!')
    //    sh 'exit 1'
    // }
    stage('test') {
        nodejs(nodeJSInstallationName: 'nodejs') {
            sh 'npm install --only=dev'
            sh 'npm test'
        }
    }
    } catch(e) {
    // mark build as failed
    currentBuild.result = "FAILURE";
    // set variables
    def subject = "${env.JOB_NAME} - Build #${env.BUILD_NUMBER} ${currentBuild.result}"
    def content = '${JELLY_SCRIPT,template="html"}'

    // send slack notification
    slackSend (baseUrl: "https://hooks.slack.com/services/", color: '#FF0000', message: "FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")

    // send email
    if(to != null && !to.isEmpty()) {
        emailext(body: content, mimeType: 'text/html',
        replyTo: '$DEFAULT_REPLYTO', subject: subject,
        to: to, attachLog: true )
    }

    // mark current build as failure and throw the error
    throw e;
    }
    stage('docker build/push') {
        docker.withRegistry('https://registry.hub.docker.com', 'dockerhub') {
            def app = docker.build("pawelfraczyk/bgshop:${commit_id}", '.').push()
        }
    }
    
}