# Mediator

This framework uses the Aries Apple SDK to communicate with a mediator service via DIDComm for

- connecting 
- creating an inbox
- getting inbox items
- delete inbox items
- adding a route
- adding the device info

### How To
To use the mediator service you first have to successfully 
1. connect
after that you have to go for the 
2. Device Check
where you can than create the inbox with the device validation objecct  
3. createInbox(with: validation)
and than add the device info to the ledger as well
4. addDeviceInfo
