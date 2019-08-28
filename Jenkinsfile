node {
    def commit_id
    stage('Preparation') {
        checkout scm
        sh "git rev-parse --short HEAD > .git/commit-id"
        commit_id = readFile('.git/commit-id').trim()
    }
    stage('test') {
        nodejs(nodeJSInstallationName: 'nodejs') {
            sh 'yarn install'
            sh 'yarn test'
        }
    }
    stage('docker build/push') {
        docker.withRegistry('https://index.docker.io.v1/', 'dockerhub') {
            def app = docker.build("pawelfraczyk/bgshop:${commit_id}", '.').push()
        }
    }
}