environment=$1
Repos=$2
case ${environment} in
  dev) 
	echo "dev customization"
	sed '1,$s/ec2-user/wmpecommdev/' </etc/sudoers.d/ec2-user >/etc/sudoers.d/wmpecommdev
        sed '1,$s/cuprepo/'$Repos'/g' </etc/yum.repos.d/cup.repo >/tmp/cup.repo
        /bin/mv /tmp/cup.repo /etc/yum.repos.d/cup.repo
        /usr/bin/yum clean all
        /usr/bin/yum check-update

       ;;
  test-deploy) 
	echo "test-deploy customization"
        /usr/sbin/groupadd -g 508 releaseadmin
        /usr/sbin/useradd -u 501 -g 508 -c "Release Deployment user" releaseadmin
	sed '1,$s/ec2-user/releaseadmin/' </etc/sudoers.d/ec2-user >/etc/sudoers.d/releasedmin
        sed '1,$s/cuprepo/'$Repos'/g' </etc/yum.repos.d/cup.repo >/tmp/cup.repo
        /bin/mv /tmp/cup.repo /etc/yum.repos.d/cup.repo
        /usr/bin/yum clean all
        /usr/bin/yum check-update
       ;;
  uat) 
	echo "uat customization"
        sed '1,$s/cuprepo/'$Repos'/g' </etc/yum.repos.d/cup.repo >/tmp/cup.repo
        /bin/mv /tmp/cup.repo /etc/yum.repos.d/cup.repo
        /usr/bin/yum clean all
        /usr/bin/yum check-update
       ;;
esac
