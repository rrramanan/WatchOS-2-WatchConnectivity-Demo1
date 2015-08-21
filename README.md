# WatchOS-2-WatchConnectivity-Demo1
Using Watch Connectivity Framework sending multiple message to same view controller's "didReceiveMessage" in iOS


Sample demo using AddressBook Framework. Show your iPhone contacts in watch app with the help of iOS parent app. 
Select the user in watch app to request a phone call in iOS parent app. (Call function is not included just alert view).

Important: Run parent iOS app first, then allow permission to read your contatcs. Once permission granted for iOS parent 
app, watch app will receive contatcs via "replyhandelr" and list it through table. 

Multiple times "sendMessage" is sent from watch app to parent iOS app (same) view controller's "didReceiveMessage" and
performs the operation.


![alt tag](https://github.com/rrramanan/WatchOS-2-WatchConnectivity-Demo1/blob/master/screenref.png)
