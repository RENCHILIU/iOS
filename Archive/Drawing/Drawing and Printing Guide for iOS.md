# Drawing and Printing Guide for iOS
[link](https://developer.apple.com/library/content/documentation/2DDrawing/Conceptual/DrawingPrintingiOS/BezierPaths/BezierPaths.html)

 

##### drawRect:
UIKit creates a **graphics context** for rendering to the display. This graphics context contains the information the drawing system needs to perform drawing commands, including attributes such as fill and stroke color, the font, the clipping area, and line width. You can also create and draw into custom graphics context for bitmap images and PDF content.

UIKit has a **default coordinate system** where the origin of drawing is at the top-left of a view; positive values extend downward and to the right of that origin. You can change the size, orientation, and position of the default coordinate system relative to the underlying view or window by modifying the current transformation matrix, which maps a view’s coordinate space to the device screen.
In iOS, the **logical coordinate space**, which measures distances in points, is not equal to the device coordinate space, which measures in pixels. For greater precision, points are expressed in floating-point values.

##### iOS provides two primary paths for creating high-quality graphics :

    1.OpenGL
    2.native rendering using Quartz, Core Animation, and UIKit
    
    

### The UIKit Graphics System
When a view is first shown or when a portion of the view needs to be redrawn, iOS asks the view to draw its content by calling the view’s drawRect: method.

There are several actions that can trigger a view update:

   1. Moving or removing another view that was partially obscuring your view
   2. Making a previously hidden view visible again by setting its hidden property to NO
   3. Scrolling a view off of the screen and then back onto the screen
   4. Explicitly calling the setNeedsDisplay or setNeedsDisplayInRect: method of your view


##### Custom view
For custom views, you must override the drawRect: method and perform all your drawing inside it. Inside your drawRect: method, use the native drawing technologies to draw shapes, text, images, gradients, or any other visual content you want. The first time your view becomes visible, iOS passes a rectangle to the view’s drawRect: method that contains your **view’s entire visible area**. During subsequent calls, the rectangle includes only the portion of the view that actually needs to be redrawn. For maximum performance, you should redraw only affected content.

If you want to change the contents of the view, however, you must tell your view to redraw its contents. To do this, call the **setNeedsDisplay** or **setNeedsDisplayInRect:** method to trigger an update.

Do not call your view’s drawRect: method yourself. 

##### ### Coordinate Systems and Drawing in iOS
In iOS, all drawing occurs in a graphics context

This initial drawing coordinate system is known as the **default coordinate system**, and is a 1:1 mapping onto the view’s underlying coordinate system.

### Points Versus Pixels
Native drawing technologies, such as Core Graphics, take the current scale factor into account for you.

Thus, any content you draw in your drawRect: method is scaled appropriately for the underlying device’s screen.

Because of this automatic mapping, when writing drawing code, pixels usually don’t matter. 

##### Obtaining Graphics Contexts
Most of the time, graphics contexts are configured for you. Each view object automatically creates a graphics context so that your code can start drawing immediately as soon as your custom drawRect: method is called.

##### Drawing to the Screen
    If you use Core Graphics functions to draw to a view, either in the drawRect: method or elsewhere, you’ll need a graphics context for drawing


### Drawing with Quartz and UIKit
Quartz is the general name for the native drawing technology in iOS.

This framework provides data types and functions for manipulating the following:

    Graphics contexts
    Paths
    Images and bitmaps
    Transparency layers
    Colors, pattern colors, and color spaces
    Gradients and shadings
    Fonts
    PDF content
    
UIKit builds on the basic features of Quartz by providing a focused set of classes for graphics-related operations.
UIKit builds on the basic features of Quartz by providing a focused set of classes for graphics-related operations.

UIKit support includes the following classes and functions:

    UIImage, which implements an immutable class for displaying images
    UIColor, which provides basic support for device colors
    UIFont, which provides font information for classes that need it
    UIScreen, which provides basic information about the screen
    UIBezierPath, which enables your app to draw lines, arcs, ovals, and other shapes.
    Functions for generating a JPEG or PNG representation of a UIImage object
    Functions for drawing to a bitmap graphics context
    Functions for generating PDF data by drawing to a PDF graphics context
    Functions for drawing rectangles and clipping the drawing area
    Functions for changing and getting the current graphics context
    

##### Creating and Drawing Paths
When drawing a path, you must have a current context set. This context can be a custom view’s context (in drawRect:), a bitmap context, or a PDF context.

## Drawing Shapes Using Bézier Paths

### Bézier Path Basics
The processes for building and using a path object are separate. Building the path is the first process and involves the following steps:

1. Create the path **object**.
2. Set any relevant drawing **attributes** of your UIBezierPath object, such as the lineWidth or lineJoinStyle properties for stroked paths or the usesEvenOddFillRule property for filled paths. These drawing attributes apply to the entire path.
3. Set the **starting point** of the initial segment using the moveToPoint: method.
4. Add line and curve **segments** to define a subpath.
5. Optionally, close the subpath by calling **closePath**, which draws a straight line segment from the end of the last segment to the beginning of the first.
6. Optionally, **repeat** the steps 3, 4, and 5 to define additional subpaths.

