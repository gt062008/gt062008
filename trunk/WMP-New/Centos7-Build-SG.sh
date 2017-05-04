#!/bin/sh -x
## Script to build two Security Groups for a WMP environment - one for the WMP App Server and the other for the associated Elastic Load Balancer to use.
## These security groups need to be provided as parameters to the Centos7-WMP.template template when it is called so the security groups are associated with the
## ELB and EC2 instance created.
## This script should be run in advance of the Centos7-WMP.template cloud formation template.

GroupNameAdmin=sg-97978efb
GroupNameElb=wmp-${1:-test}-elb
GroupNameElb=`aws ec2 create-security-group --group-name ${GroupNameElb} --description "WMP ELB SG ${GroupNameElb}" --profile cambridge --vpc-id vpc-ff8f7e97 2>/dev/null`
aws ec2 authorize-security-group-ingress --group-id ${GroupNameElb} --profile cambridge --protocol tcp --port 80 --cidr 103.23.193.2/32 
aws ec2 authorize-security-group-ingress --group-id ${GroupNameElb} --profile cambridge --protocol tcp --port 80 --cidr 121.97.34.10/32 
aws ec2 authorize-security-group-ingress --group-id ${GroupNameElb} --profile cambridge --protocol tcp --port 80 --cidr 121.97.40.34/32 
aws ec2 authorize-security-group-ingress --group-id ${GroupNameElb} --profile cambridge --protocol tcp --port 80 --cidr 122.55.14.126/32 
aws ec2 authorize-security-group-ingress --group-id ${GroupNameElb} --profile cambridge --protocol tcp --port 80 --cidr 131.111.154.0/24
aws ec2 authorize-security-group-ingress --group-id ${GroupNameElb} --profile cambridge --protocol tcp --port 80 --cidr 131.111.159.0/24
aws ec2 authorize-security-group-ingress --group-id ${GroupNameElb} --profile cambridge --protocol tcp --port 80 --cidr 192.153.213.50/32

AppGroupName=wmp-${1:-test}-app
AppGroupName=`aws ec2 create-security-group --group-name ${AppGroupName} --description "WMP App Server SG ${AppGroupName}" --profile cambridge --vpc-id vpc-ff8f7e97 2>/dev/null`
aws ec2 authorize-security-group-ingress --group-id ${AppGroupName} --profile cambridge --protocol tcp --port 80 --source-group ${GroupNameElb}
aws ec2 authorize-security-group-ingress --group-id ${AppGroupName} --profile cambridge --protocol tcp --port 22 --source-group ${GroupNameAdmin}
