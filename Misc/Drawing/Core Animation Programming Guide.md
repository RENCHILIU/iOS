# Core Animation Programming Guide
[link](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/CoreAnimation_guide/Introduction/Introduction.html#//apple_ref/doc/uid/TP40004514)

## About Core Animation

Core Animation is a graphics rendering and animation infrastructure available on both iOS and OS X that you use to animate the views and other visual elements of your app.

With Core Animation, most of the work required to draw each frame of an animation is **done** for you. All you have to do is configure a few animation **parameters** (such as the start and end points) and tell Core Animation to **start**.

    UIKit/AppKit
    Core Animation
    Metal/Core Graphics
    Graphics Hardware
    
### At a Glance

##### The Layer-Based Drawing Model
With view-based drawing, changes to the view itself often result in a call to the view’s **drawRect:** method to redraw content using the new parameters. But drawing in this way is expensive because it is done using the CPU on the main thread. Core Animation avoids this expense by whenever possible by manipulating the cached bitmap in hardware to achieve the same or similar effects.

##### Layer-Based Animations


