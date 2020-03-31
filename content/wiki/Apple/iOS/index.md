---
date: 2019-06-01
title: iOS
description: ""
tags: [swift, iOS]

---


iOS
===

## Swift

[Swift](swift)

## Stopping the responder chain

https://medium.com/@nguyenminhphuc/how-to-pass-ui-events-through-views-in-ios-c1be9ab1626b

## Make old Xcode work with newer SDK

- This happens when you have Xcode 10.1, then Apple releases iOS 12.2 and that is not supported by Xcode 10.1, you need 10.2 but that means updating the whole OS.

```bash
ln -s /Applications/Xcode-10.2.app/Contents/Developer/Platforms/iPhoneOS.platform/DeviceSupport/12.2\ \(16E226\) /Applications/Xcode-10.1.app/Contents/Developer/Platforms/iPhoneOS.platform/DeviceSupport
```

## Dark mode

- [How to turn Dark Mode on in the Simulator](https://technikales.com/how-to-turn-on-dark-mode-in-ios-13-simulator/)
- [Apple's Dark Mode docs](https://developer.apple.com/documentation/appkit/supporting_dark_mode_in_your_interface/choosing_a_specific_interface_style_for_your_ios_app)
- Opt out of Dark Mode [SO](https://stackoverflow.com/a/56546554/225503)

```
<key>UIUserInterfaceStyle</key>
<string>Light</string>
```


## App Store Connect

### Testflight Open link beta

> Up until now, developers would have to manually invite testers using their email address. 
> ...
> With the new TestFlight Public Link feature, however, developers can create a unique URL to share with people.

https://9to5mac.com/2018/06/07/testflight-public-link-wwdc/

## Check if a framework is loading other frameworks

`otool -l libswiftMetal.dylib`