# hello-cdk

This app has been created following this [AWS doc](https://docs.aws.amazon.com/cdk/v2/guide/getting_started.html), here is the summary of the command to achieve this:
```
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