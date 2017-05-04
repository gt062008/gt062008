Source=/app/konakart/webapps/konakartadmin/WEB-INF/classes/konakartadmin.properties
/bin/cp $Source ${Source}.bak
MySQLDBEndPoint=$1
KKPassword=$2
/bin/cat $Source | /bin/sed '1,$s/^konakart.modules.payment=Authorizenet BarclaycardSmartPayHosted BarclaycardSmartPayApi Bluepay Caledon Chronopay Cod CommideaVanguard CyberSource CyberSourceHOP Elink Eway_au GlobalCollect MoneyBookers Netpayintl PayflowPro Payjunction Paypal Usaepay Worldpay WorldPayXMLRedirect Yourpay$/konakart.modules.payment=Authorizenet BarclaycardSmartPayHosted BarclaycardSmartPayApi Bluepay Caledon Chronopay Cod CommideaVanguard CyberSource CyberSourceHOP Elink Eway_au GlobalCollect MoneyBookers Netpayintl PayflowPro Payjunction Paypal Usaepay Worldpay WorldPayXMLRedirect Yourpay Greenzone Vista/' >/root/ka1
/bin/cp /root/ka1 $Source
/bin/cat $Source | /bin/sed '1,$s/^konakart.modules.shipping=DigitalDownload Fedex Flat Free FreeProduct Item PickUpInStore Table Ups Usps Uspsint Zones$/konakart.modules.shipping=DigitalDownload Fedex Flat Free FreeProduct Item PickUpInStore Table Ups Usps Uspsint Zones Vista/' >/root/ka2
/bin/cp /root/ka2 $Source

/bin/cat $Source | /bin/sed '1,$s/^konakart.modules.ordertotal=BuyXGetYFree GiftCertificate ProductDiscount RewardPoints RedeemPoints ShippingDiscount Shipping SubTotal Tax TaxCloud Thomson Total TotalDiscount FreeProduct PaymentCharge$/konakart.modules.ordertotal=BuyXGetYFree GiftCertificate ProductDiscount RewardPoints RedeemPoints ShippingDiscount Shipping SubTotal Tax TaxCloud Thomson Total TotalDiscount FreeProduct PaymentCharge VistaTotal VistaNowTotal VistaSubTotal VistaSoonSubTotal VistaAvailableSubTotal VistaShipping VistaTax VistaProductDiscount/' >/root/ka3
/bin/cp /root/ka3 $Source
/bin/cat $Source | /bin/sed '1,$s/^konakart.modules.others=Ldap USPSAddrVal$/konakart.modules.others=Ldap USPSAddrVal MongoDb/' >/root/ka4
/bin/cp /root/ka4 $Source
/bin/cat $Source | /bin/sed '1,$s/^konakart.password.expiryDays *= 90$/password.expiryDays                   = 360/' >/root/ka5
/bin/cp /root/ka5 $Source
/bin/cat $Source | /bin/sed '1,$s/#torque.dsfactory.store2/torque.dsfactory.store2/' >/root/ka6
/bin/cp /root/ka6 $Source
/bin/cat $Source | /bin/sed '1,$s/#torque.database.store2/torque.database.store2/' >/root/ka6b
/bin/cp /root/ka6b $Source

/bin/sed "s#torque.dsfactory.store2.connection.url      = jdbc:mysql://localhost:3306/dbname#torque.dsfactory.store2.connection.url      = jdbc:mysql://$MySQLDBEndPoint:3306/konakart#gi" $Source >/root/ka7
/bin/cp /root/ka7 $Source
/bin/cat $Source | /bin/sed '1,$s/torque.dsfactory.store2.connection.user     = root/torque.dsfactory.store2.connection.user     = konakart/' >/root/ka8
/bin/cp /root/ka8 $Source
/bin/sed "s/torque.dsfactory.store2.connection.password =/torque.dsfactory.store2.connection.password = $KKPassword/gi" $Source >/root/ka9
/bin/cp /root/ka9 $Source
/bin/cat $Source | /bin/sed '1,$s/konakart.rmi.categoriesShared = false/konakart.rmi.categoriesShared = true/' >/root/ka10
/bin/cp /root/ka10 $Source
