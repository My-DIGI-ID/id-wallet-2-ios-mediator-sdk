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

### To Do's
- Find a better way for `mobileSecret`
- Maybe parameterize `@type` instead of `Constants`
- Rework/Remove `Networking` as it might be over-engineered because it's basically only used for the `discover` and this might be also the only use for it
