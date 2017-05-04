Stack=ecomm-nested

KeyName=${1:er-management-test}
DBPassword=${2}
IamRole=${3}
Env=${4}
Account=${5}

if test $# -lt 4
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

aws cloudformation create-stack --stack-name $Stack --template-url https://s3-eu-west-1.amazonaws.com/cup-wmp-ecomm-files/cloudformation/Ecommerce.template "$Account" --parameters ParameterKey=KeyName,ParameterValue=$KeyName ParameterKey=IamRole,ParameterValue=$IamRole ParameterKey=DBPassword,ParameterValue=$DBPassword ParameterKey=Environment,ParameterValue=$Env ParameterKey=WMPNatIp,ParameterValue=54.229.3.162/32 <<EOD
{
"StackId" : "arn:aws:cloudformation:eu-west-1:123456789012:stack/myteststack/330b0120-1771-11e4-af37-50ba1b98bea6"
}
EOD
