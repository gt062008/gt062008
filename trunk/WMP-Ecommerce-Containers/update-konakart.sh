Source=/app/konakart/webapps/konakart/WEB-INF/classes/konakart.properties
MySQLDBEndPoint=$1
KKPassword=$2
/bin/cat $Source | /bin/sed '1,$s/.torque.dsfactory.store2/torque.dsfactory.store2/' >/root/k0
/bin/cp /root/k0 $Source 
/bin/cat $Source | /bin/sed '1,$s/.torque.database.store2/torque.database.store2/' >/root/k1
/bin/cp /root/k1 $Source 
/bin/cat $Source | /bin/sed '1,$s/#konakart.databases.used/konakart.databases.used/' >/root/k2 
/bin/cp /root/k2 $Source
/bin/sed "s#torque.dsfactory.store2.connection.url      = jdbc:mysql://localhost:3306/dbname#torque.dsfactory.store2.connection.url      = jdbc:mysql://${MySQLDBEndPoint}:3306/konakart#gi" $Source >/root/k3
/bin/cp /root/k3 $Source
/bin/cat $Source | /bin/sed '1,$s!torque.dsfactory.store2.connection.user.*$!torque.dsfactory.store2.connection.user     = konakart!' >/root/k4
/bin/cp /root/k4 $Source
/bin/sed "s/torque.dsfactory.store2.connection.password =.*/torque.dsfactory.store2.connection.password = $KKPassword/gi" $Source >/root/k5
/bin/cp /root/k5 $Source
/bin/cat $Source | /bin/sed '1,$s/konakart.ws.categoriesShared = false/konakart.ws.categoriesShared = true/' >/root/k6
/bin/cp /root/k6 $Source
/bin/cat $Source | /bin/sed '1,$s/konakart.modules.shipping=DigitalDownload Fedex Flat Free FreeProduct Item PickUpInStore Table Ups Usps Uspsint Zones/konakart.modules.shipping=VistaShipping/' >/root/k7
/bin/cp /root/k7 $Source
