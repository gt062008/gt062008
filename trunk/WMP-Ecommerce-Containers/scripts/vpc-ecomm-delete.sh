Stack=ecomm-vpc
Account=$1

## Account should be --profile cambridge for cambridge account updates
## Account should be blank for cup-infrastructure account updates
if test "$Account" == "cambridge"
then
   Account="--profile $Account"
fi
if test "$Account" != ""
then
   echo "Account should be blank or cambridge"
   exit 1
fi

aws cloudformation delete-stack --stack-name $Stack "$Account"

