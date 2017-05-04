Stack=ecomm-vpc-build

KeyName=${1:er-management-test}
WMPNatIp=${2}
DBPass=${3}
IamRole=${4}
Env=${5}
Account=${6}

if test $# -lt 5
then
   echo "Please provide the right number of parameters."
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

aws cloudformation create-stack --stack-name $Stack --template-url https://s3-eu-west-1.amazonaws.com/cup-wmp-ecomm-files/cloudformation/VPC-Ecomm.template "$Account" --parameters ParameterKey=KeyName,ParameterValue=$KeyName ParameterKey=IamRole,ParameterValue=$IamRole <<EOD
##aws cloudformation create-stack --stack-name $Stack --template-body file:///root/svn/AWS/CloudFormation/trunk/WMP-Ecommerce/VPC-Ecomm.template "$Account" --parameters ParameterKey=KeyName,ParameterValue=$KeyName ParameterKey=IamRole,ParameterValue=$IamRole <<EOD
{
"StackId" : "arn:aws:cloudformation:eu-west-1:123456789012:stack/myteststack/330b0120-1771-11e4-af37-50ba1b98bea6"
}
EOD

## Wait until stack has completed it's build
while true 
do
   if aws cloudformation describe-stacks --output text "$Account" | grep "$Stack" | head -1 | grep CREATE_COMPLETE >/dev/null
   then
      break
   else
      sleep 10
   fi
done
   
## Build the parameter file for the next script db-ecomm to use

. $PWD/`dirname $0`/functions.sh

VPC=`aws ec2 describe-vpcs --filter 'Name=tag:Name,Values="Ecommerce VPC"' --query 'Vpcs[*].{Id:VpcId}' --output text $Account`
PrivA=`aws ec2 describe-subnets --filter 'Name=tag:Name,Values="Ecommerce App Subnet AZ A (Private)"' --query 'Subnets[*].{Id:SubnetId}' --output text $Account`
DBA=`aws ec2 describe-subnets --filter 'Name=tag:Name,Values="Ecommerce DB Subnet AZ A (Private)"' --query 'Subnets[*].{Id:SubnetId}' --output text $Account`
DBB=`aws ec2 describe-subnets --filter 'Name=tag:Name,Values="Ecommerce DB Subnet AZ B (Private)"' --query 'Subnets[*].{Id:SubnetId}' --output text $Account`
AdminSG=`aws ec2 describe-security-groups --filters 'Name=tag:Name,Values="Ecommerce Admin Server SG"' --query 'SecurityGroups[*].{Id:GroupId}' --output text $Account`

# Shouldn't this functions.sh line be here:
. ./functions.sh 
( CFHeader
CFParameter VPC $VPC
CFParameter WMPNatIp $WMPNatIp
CFParameter PrivateSubnetA $PrivA
CFParameter IamRole $IamRole
CFParameter AdminSecurityGroup $AdminSG
CFParameter DBSubnetA $DBA
CFParameter DBSubnetB $DBB
CFParameter KeyName $KeyName
CFParameter DBPassword $DBPass
CFLastParameter Environment $Env
CFFooter ) >/root/svn/AWS/CloudFormation/trunk/WMP-Ecommerce/cfg/db-ecomm-make.cfg
