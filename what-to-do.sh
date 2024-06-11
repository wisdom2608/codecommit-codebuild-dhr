A)- Navigate to AWS CodeBuild:
  . Go to the AWS Management Console.
  . Open the CodeBuild service.

B)- Create a Build Project:
  i)- Click "Create build project".
  ii)- Project Configuration:
      . Project name: 'docker-build-project'.
      . Description: A brief description of the project.

  iii)- Source:
      . Source provider: AWS CodeCommit.
      . Repository: Select your CodeCommit repository.
      . Branch: Specify the branch you want to build from (e.g., 'main').

    iv)- Environment:
      . Managed image: AWS Linux 2.
      . Runtime: Standard.
      . Image: aws/codebuild/standard:5.0.
      . Service role: Create a new role or use an existing one.

    v)- Buildspec:
      . Use the buildspec file in the source code.
    
    vii)- Logs:
       . Enable CloudWatch logs.
       . Click "Create build project".

Step 4: Set Up AWS CodePipeline

A)- Navigate to AWS CodePipeline:
       . Go to the AWS Management Console.
       . Open the CodePipeline service.

B)- Create a Pipeline:
       . Click "Create pipeline".

C)- Pipeline Settings:
       . Pipeline name: docker-build-pipeline.
       . Role: Create a new role or use an existing one.

D)- Source:
       . Source provider: AWS CodeCommit.
       . Repository name: Select your CodeCommit repository.
       . Branch: Select the branch to build from (e.g., main).

E)- Build:
       . Build provider: AWS CodeBuild.
       . Project name: Select the CodeBuild project you created earlier.

F)- Deploy:
       . Skip the deploy stage since we are only building and pushing the Docker image.
       . Click "Create pipeline".

G)- Start the Pipeline:
       . After creating the pipeline, it will start automatically.
       . You can view the progress in the pipeline overview.

Step 5: Configure Docker Hub Credentials in AWS Secrets Manager
Store Docker Hub Credentials:

A)- Navigate to AWS Secrets Manager.
       . Click "Store a new secret".
       . Choose "Other type of secret".
       . Add the following key-value pairs:
         - DOCKERHUB_USERNAME: your Docker Hub username.
         - DOCKERHUB_PASSWORD: your Docker Hub password.
       . Name the secret (e.g., dockerhub-creds).

B)- Update CodeBuild Project to Use Secrets:
   i)- Edit your CodeBuild project.
   ii)- Under "Environment variables", add:
       . Name: DOCKERHUB_USERNAME.
       . Value: Use the AWS Secrets Manager reference (e.g., secretsmanager:arn:aws:secretsmanager:<region>:<account-id>:secret:dockerhub-creds:DOCKERHUB_USERNAME).

    iii)- Add another environment variable:
       . Name: DOCKERHUB_PASSWORD.
       . Value: Use the AWS Secrets Manager reference (e.g., secretsmanager:arn:aws:secretsmanager:<region>:<account-id>:secret:dockerhub-creds:DOCKERHUB_PASSWORD).

Conclusion
By following these steps, you'll set up a CI/CD pipeline that builds and pushes Docker images to Docker Hub from an AWS CodeCommit repository. AWS CodeBuild handles the build and push process, while AWS CodePipeline automates the workflow.

This setup allows you to automate the deployment of Docker images, making your development and release process more efficient and reliable.
