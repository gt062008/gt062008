file=$1
aws s3 cp ${file} s3://cup-wmp-ecomm-files/cloudformation/${file} --grants read=uri=http://acs.amazonaws.com/groups/global/AuthenticatedUsers
