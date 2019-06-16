iOS
===

## Swift

[Swift](swift.md)

## Stopping the responder chain

https://medium.com/@nguyenminhphuc/how-to-pass-ui-events-through-views-in-ios-c1be9ab1626b

## Make old Xcode work with newer SDK

- This happens when you have Xcode 10.1, then Apple releases iOS 12.2 and that is not supported by Xcode 10.1, you need 10.2 but that means updating the whole OS.

```bash
ln -s /Applications/Xcode-10.2.app/Contents/Developer/Platforms/iPhoneOS.platform/DeviceSupport/12.2\ \(16E226\) /Applications/Xcode-10.1.app/Contents/Developer/Platforms/iPhoneOS.platform/DeviceSupport
```

## App Store Connect

### Testflight Open link beta

> Up until now, developers would have to manually invite testers using their email address. 
> ...
> With the new TestFlight Public Link feature, however, developers can create a unique URL to share with people.

https://9to5mac.com/2018/06/07/testflight-public-link-wwdc/

## Check if a framework is loading other frameworks

`otool -l libswiftMetal.dylib`