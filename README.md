To see the functionality of the app please watch this YT video: https://youtu.be/Wk3vtXJgr-I

Currently I'm working on the CI/CD with CircleCi and AWS CodeDeploy which is working. It contains very first version of AWS infrastructure provided via terraform which it will be upgraded within the time.

CircleCi - building history: https://circleci.com/gh/pawelfraczyk/react-shop


TODO in upcoming week (05.01 - 12.01.2020)
- DONE - make ssm agent working to get credentials from AWS SM Parameter Store
- create dynamoDB table via terraform
- connect backend (api service) with dynamodDB using SDK
- create production env in Dockerfiles
