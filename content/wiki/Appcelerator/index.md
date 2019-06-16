---
date: 2019-06-01
title: Appc
description: ""
tags: [coffeescript, appcelerator]

---

Appcelerator
============

## Create a quick example project

- create Mobile Alloy project
- put all code in `alloy.js`, creating a window and showing it
- remove the controller `.xml` file from `views`
- leave an empty `controllers/index.js`


## WebView in Android with content that scrolls

Key is `Titanium.UI.Android.OVER_SCROLL_ALWAYS`

```CoffeeScript
var win = Titanium.UI.createWindow({  
    backgroundColor:'#fff'
});
var Webheight=Ti.Platform.displayCaps.platformHeight;
var webview = Ti.UI.createWebView({
			top : 10,
			height : "100%",
			overScrollMode: Titanium.UI.Android.OVER_SCROLL_ALWAYS,
			url : 'https://blog.freniche.com'	
		});
win.add(webview);
		
win.open();
```

## User Defaults

http://docs.appcelerator.com/platform/latest/#!/api/Titanium.App.Properties-method-setBool

```CoffeeScript
# Save

Ti.App.Properties.setBool(enableNotificationKey, switchView.value)

# Read

Ti.App.Properties.getBool(enableNotificationKey, true)
```

## Detecting orientation

- detect orientation changes

```CoffeeScript
Ti.Gesture.addEventListener 'orientationchange', ( newOrientation ) =>
    @currentOrientation = newOrientation
    console.log "orientationchange fired #{ JSON.stringify( @rootView , null, 4) } "
```

This prints:

```CoffeeScript
orientationchange fired {
    "horizontalWrap": true,
    "visible": true,
    "touchEnabled": true,
    "left": 0,
    "id": "rootView",
    "right": 0,
    "bottom": 0,
    "top": 20
}
```

Checking for Portrait / Landscape

```CoffeeScript
 	if @currentOrientation["orientation"] == Titanium.UI.PORTRAIT || @currentOrientation"orientation"] == Titanium.UI.UPSIDE_PORTRAIT
 		console.log "portrait"

 	if @currentOrientation["orientation"] == Titanium.UI.LANDSCAPE_LEFT || @currentOrientation"orientation"] == Titanium.UI.LANDSCAPE_RIGHT
 		console.log "landscape"
```

## CoffeeScript

### Return tuple from function

https://stackoverflow.com/questions/2917175/return-multiple-values-in-javascript

```CoffeeScript
[x, y] = (function(){ return [3, 4]; })();
x; // 3
y; // 4
```

- returning an array

```CoffeeScript
var newCodes = function() {
    var dCodes = fg.codecsCodes.rs;
    var dCodes2 = fg.codecsCodes2.rs;
    return [dCodes, dCodes2];
};
```

- returning an object literal

```CoffeeScript
var newCodes = function() {
    var dCodes = fg.codecsCodes.rs;
    var dCodes2 = fg.codecsCodes2.rs;
    return {
        dCodes: dCodes,
        dCodes2: dCodes2
    };
};
```

### Try / catch

```
try 
	 # code
catch 
	{}
```