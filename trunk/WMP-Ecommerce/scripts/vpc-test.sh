Stack=vpc-test

KeyName=${1:er-management-test}
IamRole=${2}

aws cloudformation create-stack --stack-name $Stack --template-body file:///root/svn/AWS/CloudFormation/trunk/large-vpc-build.template "$Account" --parameters ParameterKey=KeyName,ParameterValue=$KeyName <<EOD
{
"StackId" : "arn:aws:cloudformation:eu-west-1:123456789012:stack/myteststack/330b0120-1771-11e4-af37-50ba1b98bea6"
}
EOD

