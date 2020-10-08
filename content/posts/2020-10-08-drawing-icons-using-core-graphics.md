---
layout: post
title: Drawing icons using Core Graphics

description: How to use Core Graphics to draw fancy icons
tags: [swift, coregraphics]
date: 2020-10-08
---

# Drawing icons using Core Graphics

Sometimes you need to add an icon to your iOS app, The designer sends you that plain, simple icon. It can be a bitmap-based icon, like a PNG. Problem with those is they get blurry if zoomed in too much. So we can use a vector-based icon, like a Font Icon or a PDF. These are vector based, contains the instructions to draw the icon, not the icon itself. This way you can stretch the icon as much as you want, and you'll never see "big pixels" in your app.

But what happens when you have a screen capture of your icon, but can't get any of these options? Well, this means it's time to dust-off your Core Graphics Skills and draw the icon by yourself. Won't even mention the _horrible_ alternative of taking a screenshot and cutting the icon. Don't do it. I've done it and it's, indeed, _horrible_.

Instead of telling you what [Core Graphics](https://developer.apple.com/documentation/coregraphics) is and how it works, we'll write code to solve a problem, so you can experiment and learn by doing. This is my preferred way of learning a new framework / library / language: try things, read a bit, try more stuff, read more seriously, watch videos, `GOTO 1`.

## The Notebook Icon

The icon we'll try to recreate is this one:

![Icon of a Notebook with a darker spine, title and subtitle](/img/notebook-icon.png)

Represents a notebook with a background color that can change, a darker same color spine and a couple lines to represent the Notebook title.

## Create a new Playground

We'll do all our coding inside a Playground. So we can get instant feedback. In the end, it will look like this:

![Screen capture showing a Playground running the example with a Notebook icon](/img/notebook-icon-playground.png)

But for now let's create a Playground called `Icons`. It will just have one Playground page. Remove everything inside that page and just add:

```swift
import UIKit
import PlaygroundSupport
```

We'll use the first import to draw Views and use Core Graphics (it's included by `UIKit`). `PlaygroundSupport` will help us show nice previews of our work inside the Playground.

## Planning our work

Looking at that notebook icon we can see it's composed of 4 rectangles:
- a big rectangle that forms the Notebook itself
- a spine rectangle
- and a couple rectangles that seems like text written as title and subtitle

So we'll do exactly that, starting with a view that will be the main notebook icon

## The Notebook Icon View

We'll start with this:

```swift
import UIKit
import PlaygroundSupport

public class NotebookIcon: UIView {
}

var icon1 = NotebookIcon(frame: CGRect(x: 0, y: 0, width: 100, height: 100))

PlaygroundPage.current.liveView = icon1
```

Putting this in the Playground, we get a white square painted in the preview. What's happening here?

- we define our NotebookIconView class. Will be a subclass of UIView, so can be [easily added](https://developer.apple.com/documentation/uikit/uiview/1622616-addsubview) to any other UIView in our program.

```swift
public class NotebookIconView: UIView {
}
```

- then, we create an instance of this class, passing in a CGRect. This is just a rectangle with the dimensions of the `NotebookView` we want to create.

```swift
var icon1 = NotebookIconView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
```

- finally, we tell the Playground to show us the NotebookIconView:

```swift
PlaygroundPage.current.liveView = icon1
```

The view appears White because that's the default background color of the Playground Support View, and `icon2` own backgroundColor is `nil`, meaning transparent color.

## A builder for the icon

We want to pass more information while we create our icon. We need to pass in a `CGRect` to set the size and a colour. And we'll have to adjust the corner radius (to make this rectangle corner's rounded). We'll use a static factory method:

```swift
public class NotebookIconView: UIView {
    
    public static func build(withColor color: UIColor, usingFrame frame: CGRect) -> NotebookIconView {
        
        // create the icon
        let icon = NotebookIconView()

        // set background color
        icon.backgroundColor = color

        // all subview inside this view are confined to the bounds of this Notebook
        icon.clipsToBounds = true

        // we want rounded corners
        icon.layer.cornerRadius = 15

        // set frame of the icon to argument passed
        icon.frame = frame

        // we've finished the tuning, return it
        return icon
    }
}
```

Now we can create another icon and show it in the preview:

```swift
var icon2 = NotebookIconView.build(withColor: .brown, usingFrame: CGRect(x: 0, y: 0, width: 100, height: 100))

PlaygroundPage.current.liveView = icon2
```

Progress! We now have a view with desired background color and round corners!

![First step, showing just a brown rectangle with rounded corners](/img/notebook-icon-1.png)

## Notebook Spine

Up until now we've created a view, changed its color and round corners. Now it's time to draw _inside_ that view. To do that we'll overwrite [`UIView:draw(_ rect: CGRect)`](https://developer.apple.com/documentation/uikit/uiview).

Also, we'll add some constants to get correct proportions of all rectangles. If we set the spine's width to, say 40 points, it will look great with a Notebook icon 200x200 points in size, but too small for a 2000x2000 icon. So it's better to use a proportional factor.

Let's add this code inside `NotebookIconView`, just after our `build` method:

```swift
    // Constants
    private static let spacePercentage: CGFloat = 0.75
    private let spineWidthPercentage: CGFloat = 0.175
    private let titleLeftSpcToSpinePercent: CGFloat = 0.05
    private let titleWidthPercentage: CGFloat = 0.6
    private let titleHeightPercentage: CGFloat = 0.05
    private let titleTopPaddingPercentage: CGFloat = 0.2
    private let subtitleTopPaddingPercent: CGFloat = 0.3

    // Method that draws inside our view
    override public func draw(_ rect: CGRect) {
        
        // Do we have access to a CoreGraphics context?
        // This is the canvas we'll use to draw
        guard let context = UIGraphicsGetCurrentContext() else { return }

        // as we'll refer a lot to this views dimensions, we store them in short-named constants
        let x = self.bounds.origin.x
        let y = self.bounds.origin.y
        let width = self.bounds.width
        let height = self.bounds.height

        // Notebook spine width
        let spineWidth = self.bounds.width * spineWidthPercentage
        
        // set the fill color for the context. This will be used for any fill until we change it. We set it at 25% transparency        
        context.setFillColor(UIColor.black.withAlphaComponent(0.25).cgColor)
                
        // fill a rectangle that covers left side of the notebook view with the background color
        context.fill(CGRect(x: x, y: y, width: spineWidth, height: height))
    }
```

![Second step, showing Notebook with a Spine](/img/notebook-icon-2.png)

Thanks to the `clipToBounds` property, although we're drawing a regular rectangle, it get's clipped and we just see the external rounded corners of our main view, but we can see it's a regular rectangle after all just by looking at then internal corners of that rectangle. If you want to really see that rectangle, change this line to:

```
    context.fill(CGRect(x: x + 20, y: y, width: spineWidth, height: height))
```

## Finishing touches

Now we need to add the two "Title lines". Again, two more rectangles. Let's add this to our `draw` method:

```swift
    // Title
    let titleLeftSpace = width * titleLeftSpcToSpinePercent
    let titleWidth = width * titleWidthPercentage
    let titleRect = CGRect(x: spineWidth + titleLeftSpace,
                           y: height * titleTopPaddingPercentage,
                           width: titleWidth,
                           height: height * titleHeightPercentage)
    drawCGRoundedRect(titleRect,
                      usingColor: UIColor.white.withAlphaComponent(0.70),
                      withCornerRadius: 5)
    
    // Subtitle
    let subtitleWidth = width * 0.4
    let subtitleRect = CGRect(x: spineWidth + titleLeftSpace,
                              y: height * subtitleTopPaddingPercent,
                              width: subtitleWidth,
                              height: height * titleHeightPercentage)
    drawCGRoundedRect(subtitleRect,
                      usingColor: UIColor.white.withAlphaComponent(0.70),
                      withCornerRadius: 5)
```

Also, we're using this small function to draw rounded rectangles easily:

```swift
func drawCGRoundedRect(_ rect: CGRect, usingColor color: UIColor, withCornerRadius cornerRadius: CGFloat) {
    
    let path = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
    color.setFill()
    path.fill()
}
```

Here we use a _path_, which is a closed sequence of points. Remembers those drawings you can do just joining points with lines? A path is just that. We define a path using a rectangle, set a `cornerRadius` so the borders are rounded and fill the area inside that path with a color.

This is our final result. You can make taller, wider, etc. Experiment with it!

![](/img/final.png)


## Improvements

We are using a fixed corner radius (15), that can look good if you're using a small icon, but not so great with a bigger one. If you like this article and say Hello in twitter, we'll add that and also create a new icon for different file types, with text, color, etc. Something like: 

![](/img/file-icon.png)

## Complete code

Just copy this code inside a playground and start experimenting. It's the best way to learn something!

```swift
import UIKit
import PlaygroundSupport

func drawCGRoundedRect(_ rect: CGRect, usingColor color: UIColor, withCornerRadius cornerRadius: CGFloat) {
    
    let path = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
    color.setFill()
    path.fill()
}

public class NotebookIconView: UIView {
    
    public static func build(withColor color: UIColor, usingFrame frame: CGRect) -> NotebookIconView {
        
        // create the icon
        let icon = NotebookIconView()

        // set background color
        icon.backgroundColor = color

        // all subview inside this view are confined to the bounds of this Notebook
        icon.clipsToBounds = true

        // we want rounded corners
        icon.layer.cornerRadius = 15

        // set frame of the icon to argument passed
        icon.frame = frame

        // we've finished the tuning, return it
        return icon
    }
    
    // Constants
    private static let spacePercentage: CGFloat = 0.75
    private let spineWidthPercentage: CGFloat = 0.175
    private let titleLeftSpcToSpinePercent: CGFloat = 0.05
    private let titleWidthPercentage: CGFloat = 0.6
    private let titleHeightPercentage: CGFloat = 0.05
    private let titleTopPaddingPercentage: CGFloat = 0.2
    private let subtitleTopPaddingPercent: CGFloat = 0.3

    // Method that draws inside our view
    override public func draw(_ rect: CGRect) {
        
        // Do we have access to a CoreGraphics context?
        // This is the canvas we'll use to draw
        guard let context = UIGraphicsGetCurrentContext() else { return }

        // as we'll refer a lot to this views dimensions, we store them in short-named constants
        let x = self.bounds.origin.x
        let y = self.bounds.origin.y
        let width = self.bounds.width
        let height = self.bounds.height

        // Notebook spine width
        let spineWidth = self.bounds.width * spineWidthPercentage
        
        // set the fill color for the context. This will be used for any fill until we change it. We set it at 25% transparency
        context.setFillColor(UIColor.black.withAlphaComponent(0.25).cgColor)
                
        // fill a rectangle that covers left side of the notebook view with the background color
        context.fill(CGRect(x: x, y: y, width: spineWidth, height: height))
        
        // Title
        let titleLeftSpace = width * titleLeftSpcToSpinePercent
        let titleWidth = width * titleWidthPercentage
        let titleRect = CGRect(x: spineWidth + titleLeftSpace,
                               y: height * titleTopPaddingPercentage,
                               width: titleWidth,
                               height: height * titleHeightPercentage)
        drawCGRoundedRect(titleRect,
                          usingColor: UIColor.white.withAlphaComponent(0.70),
                          withCornerRadius: 5)
        
        // Subtitle
        let subtitleWidth = width * 0.4
        let subtitleRect = CGRect(x: spineWidth + titleLeftSpace,
                                  y: height * subtitleTopPaddingPercent,
                                  width: subtitleWidth,
                                  height: height * titleHeightPercentage)
        drawCGRoundedRect(subtitleRect,
                          usingColor: UIColor.white.withAlphaComponent(0.70),
                          withCornerRadius: 5)
    }
}



var icon = NotebookIconView.build(withColor: .brown, usingFrame: CGRect(x: 0, y: 0, width: 100, height: 100))

PlaygroundPage.current.liveView = icon
```