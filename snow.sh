#!/bin/bash
echo "Welcome to Application Snow-White"
#create network interfaces

echo "Admin Password"
read -s adpass``
ip=$(ip route get 8.8.8.8| grep src| sed 's/.*src \(.*\)$/\1/g')
echo "This is your ip address $ip"
echo "" > ./ipfile
echo "[[local|localrc]]" > ./local.conf
echo "ADMIN_PASSWORD=$adpass" >> ./local.conf
echo "DATABASE_PASSWORD=$adpass" >> ./local.conf
echo "RABBIT_PASSWORD=$adpass" >> ./local.conf
echo "SERVICE_PASSWORD=$adpass" >> ./local.conf
echo "HOST_IP=$ip" >> ./local.conf
cat tmp.conf >> ./local.conf
#sudo bash net.sh
#sudo echo"stack ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
./stack.sh
echo "How many node you want to join in this cloud"
read numnode
for i in {1..$numnode}
do
        echo "IP node:"
        read ipnode
        echo "$ipnode" >> ./ipfile
        python3 send.py $ipnode $ip $adpass
        python3 server.py $ip
        echo "$ipnode now join your private cloud"
done

while true
do
 echo "Other feature:morenode,shutdown"
 read cmd
 if [ "$cmd" = "morenode" ]
 then
   echo "IP node:"
   read ipnode
   echo "$ipnode" >> ./ipfile
   python3 send.py $ipnode $ip $adpass
   python3 server.py $ip
   echo "$ipnode now join your private cloud"
 fi
 if [ "$cmd" = "shutdown" ]
 then
   tmp=$(cat ipfile)
   for word in $tmp
   do
     python3 send.py $ipnode $ip shutdown
   done
   ./unstack.sh
   ./clean.sh
   break
 fi
done

