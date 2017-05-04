
## A bunch of nice functions to automate common AWS Administration tasks
## First three functions here are used to build a AWS CLI Parameter file which can be used when
## running the AWS CLI to build environments using CloudFormation
## The functions Create_R53 and Delete_R53 create Route 53 CNAME records in the AWS 'cambridge' account

function CFHeader () {
   echo "["
   }
function CFFooter () { 
   echo "]"
   }

function CFParameter () {
   Key=$1
   Value=$2
   echo "   {"
   echo "      \"ParameterKey\" : \"$Key\","
   echo "      \"ParameterValue\" : \"$Value\""
   echo "   },"
   }

function CFLastParameter () {
   Key=$1
   Value=$2
   echo "   {"
   echo "      \"ParameterKey\" : \"$Key\","
   echo "      \"ParameterValue\" : \"$Value\""
   echo "   }"
   }

function Create_R53 () {
   Target=$1
   Alias=$2
   HostZoneId=${3:-ZWEBITPF5WUTE}
   TmpFile=/tmp/r53.$$

   echo "{" >$TmpFile
   echo "  \"Comment\": \"Automatically created R53 record\"," >>$TmpFile
   echo "  \"Changes\": ["                   >>$TmpFile
   echo "    {"                              >>$TmpFile
   echo "      \"Action\": \"CREATE\","      >>$TmpFile
   echo "      \"ResourceRecordSet\": {"     >>$TmpFile
   echo "        \"Name\": \"$Alias\","      >>$TmpFile
   echo "        \"Type\": \"CNAME\","       >>$TmpFile
   echo "        \"TTL\": 300,"              >>$TmpFile
   echo "        \"ResourceRecords\": ["     >>$TmpFile
   echo "          {"                        >>$TmpFile
   echo "            \"Value\": \"$Target\"" >>$TmpFile
   echo "          }"                        >>$TmpFile
   echo "       ]"                           >>$TmpFile
   echo "     }"                             >>$TmpFile
   echo "   }"                               >>$TmpFile
   echo " ]"                                 >>$TmpFile
   echo "}"                                  >>$TmpFile

   aws route53 change-resource-record-sets --hosted-zone-id $HostZoneId --change-batch file:///$TmpFile --profile cambridge
   ##rm -f "$TmpFile"

}

function Delete_R53 () {
   Target=$1
   Alias=$2
   HostZoneId=${3:-ZWEBITPF5WUTE}
   TmpFile=/tmp/r53.$$

   echo "{" >$TmpFile
   echo "  \"Comment\": \"Automatically created R53 record\"," >>$TmpFile
   echo "  \"Changes\": ["                   >>$TmpFile
   echo "    {"                              >>$TmpFile
   echo "      \"Action\": \"DELETE\","      >>$TmpFile
   echo "      \"ResourceRecordSet\": {"     >>$TmpFile
   echo "        \"Name\": \"$Alias\","      >>$TmpFile
   echo "        \"Type\": \"CNAME\","       >>$TmpFile
   echo "        \"TTL\": 300,"              >>$TmpFile
   echo "        \"ResourceRecords\": ["     >>$TmpFile
   echo "          {"                        >>$TmpFile
   echo "            \"Value\": \"$Target\"" >>$TmpFile
   echo "          }"                        >>$TmpFile
   echo "       ]"                           >>$TmpFile
   echo "     }"                             >>$TmpFile
   echo "   }"                               >>$TmpFile
   echo " ]"                                 >>$TmpFile
   echo "}"                                  >>$TmpFile

   aws route53 change-resource-record-sets --hosted-zone-id $HostZoneId --change-batch file:///$TmpFile --profile cambridge
   ##rm -f "$TmpFile"

}
