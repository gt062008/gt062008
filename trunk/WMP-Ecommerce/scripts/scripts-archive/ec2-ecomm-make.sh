##aws cloudformation create-stack --stack-name ecomm-ec2 --template-body file:///root/svn/CloudFormation/WMP-Ecommerce/WMP-Ecomm-EC2 --parameters ParameterKey=KeyName,ParameterValue=er-management-test ParameterKey=VPC,ParameterValue=vpc-d0b378b5 ParameterKey=PrivateSubnetA,ParameterValue=subnet-5739bd32 ParameterKey=PrivateSubnetB,ParameterValue=subnet-b2f25ec5 ParameterKey=AdminSecurityGroup,ParameterValue=sg-337ce856 <<EOD
aws cloudformation create-stack --stack-name ecomm-ec2 --template-body file:///root/svn/CloudFormation/WMP-Ecommerce/WMP-Ecomm-EC2 --parameters file:///root/svn/CloudFormation/WMP-Ecommerce/cfg/ec2-ecomm-make.cfg <<EOD
{
"StackId" : "arn:aws:cloudformation:eu-west-1:123456789012:stack/myteststack/330b0120-1771-11e4-af37-50ba1b98bea7"
}
EOD
