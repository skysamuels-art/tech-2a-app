pipeline {
  agent any
  environment {
    AWS_REGION = 'us-west-1'
    ACCOUNT_ID = '060255765406'
    REPO       = 'hello-world'
    CLUSTER    = 'tc2-eks'
    REGISTRY   = "${ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"
    IMAGE_TAG  = "${env.BUILD_NUMBER}"
  }
  stages {
    stage('Build image') {
      steps { sh 'docker build --platform linux/amd64 -t $REGISTRY/$REPO:$IMAGE_TAG .' }
    }
    stage('Push to ECR') {
      steps {
        sh '''
          aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $REGISTRY
          docker push $REGISTRY/$REPO:$IMAGE_TAG
        '''
      }
    }
    stage('Deploy with Helm') {
      steps {
        sh '''
          aws eks update-kubeconfig --name $CLUSTER --region $AWS_REGION
          helm upgrade --install hello-world k8s \
            --set image.repository=$REGISTRY/$REPO \
            --set image.tag=$IMAGE_TAG
          kubectl rollout status deployment/hello-world --timeout=180s
        '''
      }
    }
  }
}