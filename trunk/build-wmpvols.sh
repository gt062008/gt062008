#!/bin/bash
## Script to create the application volumes needed for a dev test WMP server by cloning the most recent snapshots
## Logic brorrowed from envlauncher python script Copyright Ian Webb Software International

#mysql volume
snap_mysql=`aws ec2 describe-snapshots --filter Name=volume-id,Values=vol-03877556 --profile cambridge | sort -k 7 | tail -1 | awk '{print $6}'`
mysql_vol=`aws ec2 create-volume --snapshot-id $snap_mysql --availability-zone eu-west-1a --volume-type gp2 --profile cambridge | awk '{print $8}'`
echo Created MySQL volume $mysql_vol

##solr volume
snap_solr=`aws ec2 describe-snapshots --filter Name=volume-id,Values=vol-2146790d --profile cambridge | sort -k 7 | tail -1 | awk '{print $6}'`
solr_vol=`aws ec2 create-volume --snapshot-id $snap_solr --availability-zone eu-west-1a --volume-type gp2 --profile cambridge | awk '{print $8}'`
echo Created SOLR volume $solr_vol

##mongo volume
snap_mongo=`aws ec2 describe-snapshots --filter Name=volume-id,Values=vol-33fefb1e --profile cambridge | sort -k 7 | tail -1 | awk '{print $6}'`
mongo_vol=`aws ec2 create-volume --snapshot-id $snap_mongo --availability-zone eu-west-1a --volume-type gp2 --profile cambridge | awk '{print $8}'`
echo Created Mongo volume $mongo_vol

##files volume
snap_files=`aws ec2 describe-snapshots --filter Name=volume-id,Values=vol-03877556 --profile cambridge | sort -k 7 | tail -1 | awk '{print $6}'`
files_vol=`aws ec2 create-volume --snapshot-id $snap_files --availability-zone eu-west-1a --volume-type gp2 --profile cambridge | awk '{print $8}'`
echo Created GlusterFS files volume $files_vol

##logs volume
snap_logs=`aws ec2 describe-snapshots --filter Name=volume-id,Values=vol-3c2a5cfe --profile cambridge | sort -k 7 | tail -1 | awk '{print $6}'`
logs_vol=`aws ec2 create-volume --snapshot-id $snap_logs --availability-zone eu-west-1a --volume-type gp2 --profile cambridge | awk '{print $8}'`
echo Created MySQL logs volume $logs_vol
