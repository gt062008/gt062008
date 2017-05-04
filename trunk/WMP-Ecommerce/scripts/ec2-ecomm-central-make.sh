Environment=$1
Account=$2
Stack="ecomm-ec2-$Environment"

if test $# -lt 1
then
   echo "Please enter the correct number of paramters"
   exit 1
fi

## Account should be --profile cambridge for cambridge account updates
## Account should be blank for cup-infrastructure account updates
if test "$Account" = "cambridge"
then
   Account="--profile $Account"
fi
if test "$Account" != ""
then
   echo "Account should be blank or cambridge"
   exit 1
fi

aws cloudformation create-stack --stack-name $Stack --template-url https://s3-eu-west-1.amazonaws.com/cup-wmp-ecomm-files/cloudformation/EC2-Ecomm-Central.template "$Account" --parameters file:///root/svn/AWS/CloudFormation/trunk/WMP-Ecommerce/cfg/ec2-ecomm-central-make.cfg <<EOD
##aws cloudformation create-stack --stack-name $Stack --template-body file:///root/svn/AWS/CloudFormation/trunk/WMP-Ecommerce/EC2-Ecomm-Central.template "$Account" --parameters file:///root/svn/AWS/CloudFormation/trunk/WMP-Ecommerce/cfg/ec2-ecomm-central-make.cfg <<EOD
{
"StackId" : "arn:aws:cloudformation:eu-west-1:123456789012:stack/myteststack/330b0120-1771-11e4-af37-50ba1b98bea7"
}
EOD
