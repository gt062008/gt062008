KeyName=$1
IamRole=$2
Environment=$3
Account=$4
Stack="ecomm-db-$Environment"

if test $# -lt 3
then
   echo "Please enter the correct number of paramters"
   exit 1
fi

## Account should be --profile cambridge for cambridge account updates
## Account should be blank for cup-infrastructure account updates
#if test "$Account" = "cambridge"
#then
#   Account='--profile cambridge'
#else
#   echo "Account should be blank or cambridge"
#   exit 1
#fi

aws cloudformation create-stack --stack-name $Stack $Account --template-url https://s3-eu-west-1.amazonaws.com/cup-wmp-ecomm-files/cloudformation/DB-Ecomm.template --parameters file:///root/svn/AWS/CloudFormation/trunk/WMP-Ecommerce/cfg/db-ecomm-make.cfg <<EOD
##aws cloudformation create-stack --stack-name $Stack $Account --template-body file:///root/svn/AWS/CloudFormation/trunk/WMP-Ecommerce/DB-Ecomm.template --parameters file:///root/svn/AWS/CloudFormation/trunk/WMP-Ecommerce/cfg/db-ecomm-make.cfg <<EOD
{
"StackId" : "arn:aws:cloudformation:eu-west-1:123456789012:stack/myteststack/330b0120-1771-11e4-af37-50ba1b98bea8"
}
EOD
if [ $? -ne 0 ]
then
  exit $?
fi

## Wait until stack has completed it's build
while true
do
   if aws cloudformation describe-stacks --output text $Account | grep "$Stack" | head -1 | grep CREATE_COMPLETE >/dev/null
   then
      break
   else
      sleep 10
   fi
done

## Build the parameter file for the next script ec2-ecomm-central to use

. $PWD/`dirname $0`/functions.sh

VPC=`aws ec2 describe-vpcs --filter 'Name=tag:Name,Values="Ecommerce VPC"' --query 'Vpcs[*].{Id:VpcId}' --output text $Account`
PrivA=`aws ec2 describe-subnets --filter 'Name=tag:Name,Values="Ecommerce App Subnet AZ A (Private)"' --query 'Subnets[*].{Id:SubnetId}' --output text $Account`
CentralSG=`aws ec2 describe-security-groups --filters 'Name=tag:Name,Values="Ecommerce KK Central Server SG"' --query 'SecurityGroups[*].{Id:GroupId}' --output text $Account`
CentralELBSG=`aws ec2 describe-security-groups --filters 'Name=tag:Name,Values="Ecommerce KK Central Server Load Balancer SG"' --query 'SecurityGroups[*].{Id:GroupId}' --output text $Account`

. ./functions.sh
( CFHeader
CFParameter KeyName $KeyName
CFParameter KKCentralServerSecurityGroup $CentralSG
CFParameter KKCentralLBSecurityGroup $CentralELBSG
CFParameter IamRole $IamRole
CFParameter Environment $Environment
CFLastParameter PrivateSubnetA $PrivA
CFFooter ) >/root/svn/AWS/CloudFormation/trunk/WMP-Ecommerce/cfg/ec2-ecomm-central-make.cfg

