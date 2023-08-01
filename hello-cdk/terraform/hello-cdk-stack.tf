resource "aws_cloudformation_stack" "hello-cdk-stack" {
  name = "hello-cdk-stack"
  //template_url = "https://raw.githubusercontent.com/mathieu-benoit/hello-aws-cdk/main/hello-cdk/cdk.out/manifest.json"
  template_body = file("${path.module}/../cdk.out/HelloCdkStack.template.json")
}