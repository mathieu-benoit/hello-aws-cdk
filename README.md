# hello-cdk

This app has been created following this [AWS doc](https://docs.aws.amazon.com/cdk/v2/guide/getting_started.html), here is the summary of the commands to achieve this:
```bash
npm install -g aws-cdk
cdk version

mkdir hello-cdk && cd hello-cdk
cdk init app --language typescript

npm run build

cat <<EOF > lib/hello-cdk-stack.ts
import * as cdk from 'aws-cdk-lib';
import { aws_s3 as s3 } from 'aws-cdk-lib';

export class HelloCdkStack extends cdk.Stack {
  constructor(scope: cdk.App, id: string, props?: cdk.StackProps) {
    super(scope, id, props);

    new s3.Bucket(this, 'MyFirstBucket', {
      versioned: true,
      removalPolicy: cdk.RemovalPolicy.DESTROY,
      autoDeleteObjects: true
    });
  }
}
EOF
```
We also edited the [lib/hello-cdk-stack.ts](/hello-cdk/lib/hello-cdk-stack.ts) file in order to provision an S3 bucket.

## Deployment via AWS CDK

```bash
aws configure

cdk bootstrap # aws://ACCOUNT-NUMBER/REGION

cdk synth --json --version-reporting false --path-metadata false

cdk deploy
```

## Deployment via Terraform

After generating the CloudFormation template as the output of the AWS CDK, we could use the [`aws_cloudformation_stack` Terraform resource](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack): 
```bash
export AWS_ACCESS_KEY_ID="anaccesskey"
export AWS_SECRET_ACCESS_KEY="asecretkey"
export AWS_REGION="us-west-2"

cdk synth --json --version-reporting false --path-metadata false

cd terraform
terraform init
terraform plan
terraform apply # not working yet, see details below.
```

FIXME: Getting an error with `terraform apply`:
```
aws_cloudformation_stack.hello-cdk-stack: Creating...
╷
│ Error: creating CloudFormation Stack (hello-cdk-stack): ValidationError: Unable to fetch parameters [/cdk-bootstrap/hnb659fds/version] from parameter store for this account.
│       status code: 400, request id: 7589d079-1c02-433f-a921-9c9a796626d4
│ 
│   with aws_cloudformation_stack.hello-cdk-stack,
│   on hello-cdk-stack.tf line 1, in resource "aws_cloudformation_stack" "hello-cdk-stack":
│    1: resource "aws_cloudformation_stack" "hello-cdk-stack" {
```