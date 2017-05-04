Environment=$1
Account=$2
Stack="ecomm-db-$Environment"

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


aws cloudformation delete-stack --stack-name $Stack "$Account"
