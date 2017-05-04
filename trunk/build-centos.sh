Stack="Centos7-Build"
Account="--profile cambridge --region ap-southeast-1"

aws cloudformation create-stack --stack-name $Stack $Account --template-url https://s3-eu-west-1.amazonaws.com/cup-wmp-ecomm-files/cloudformation/Centos7-Builder.template --parameters file:///root/svn/AWS/CloudFormation/trunk/centos7.cfg <<EOD
{
"StackId" : "arn:aws:cloudformation:eu-west-1:123456789012:stack/myteststack/330b0120-1771-11e4-af37-50ba1b98bea8"
}
EOD

