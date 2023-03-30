# View Programming Guide for iOS

[Link](https://developer.apple.com/library/content/documentation/WindowsViews/Conceptual/ViewPG_iPhoneOS/Introduction/Introduction.html#//apple_ref/doc/uid/TP40009503-CH1-SW2)

## About Windows and Views
**Windows**:
Windows do not have any visible content themselves but provide a basic container for your application’s views.

**Views**:
Views define a portion of a window that you want to fill with some content.
### At a Glance
Every application has **at least** one window and one view for presenting its content. 
UIKit and other system frameworks provide **predefined** views that you can use to present your content.
These **views** range from simple buttons and text labels to more complex views such as table views, picker views, and scroll views. 
In places where the predefined views do not provide what you need, you can also define **custom** views and manage the drawing and event handling yourself.


#### Views Manage Your Application’s Visual Content
_Views are responsible for :_

* drawing content
*  handling multitouch events
* managing the layout of any subviews

_Drawing involves:_

* Core Graphics
* OpenGL ES
* UIKit

#### Windows Coordinate the Display of Your Views
A window is an **instance** of the UIWindow class and handles the overall presentation of your application’s user interface.

#### Animations Provide the User with Visible Feedback for Interface Changes
The system defines **standard** animations for presenting modal views and transitioning between different groups of views.
However, many **attributes** of a view can also be animated directly.
And if you work directly with the view’s underlying Core Animation layer object, you can perform many **other** animations as well.
#### The Role of Interface Builder
Interface Builder is an application that you use to **graphically** construct and configure your application’s windows and views. 
   
## View and Window Architecture
UIKit and other system frameworks provide a number of views that you can use as-is with little or **no modification**. You can also define **custom** views for places where you need to present content differently than the standard views allow.

### View Architecture Fundamentals
Most of the things you might want to do visually are done with **view objects**—instances of the UIView class.

The UIView class does most of the work in managing these **relationships** between views, but you can also customize the default behavior as needed.

Views work in **conjunction** with Core Animation layers to handle the rendering and animating of a view’s content.

Every view in UIKit is **backed by** a layer object (usually an instance of the CALayer class), which manages the backing store for the view and handles view-related animations.

The use of Core Animation layer objects has important implications for **performance**. 

#### View Hierarchies and Subview Management
In addition to providing its own content, a view can act as a **container** for other views. 

Visually, the content of a subview **obscures** all or part of the content of its parent view. 

Changing the size of a parent view has a **ripple** effect that can cause the size and position of any subviews to change too.

The arrangement of views in a view hierarchy also determines how your application **responds to events**.

However, if the view does not handle a particular touch event, it can **pass** the event object along to its superview.

If no object handles the event, it eventually reaches the application object, which generally **discards** it.

#### The View Drawing Cycle
The UIView class uses an **on-demand** drawing model for presenting content. 

_Process:_
When a view first **appears** on the screen, the system **asks** it to draw its content. The system captures a **snapshot** of this content and uses that snapshot as the view’s visual representation. If you **never change** the view’s content, the view’s drawing code may **never be called again**. The snapshot image is **reused** for most operations involving the view. If you **do change** the content, you notify the system that the view has changed. The view then repeats the process of drawing the view and capturing a snapshot of the **new results**.

_Update:_
When the contents of your view change, you do not redraw those changes **directly**.
Instead, you **invalidate** the view using either the setNeedsDisplay or setNeedsDisplayInRect: method.

_When the time comes to render your view’s content:_
the **actual** drawing process varies depending on the view and its configuration.

**System views**:
typically implement private drawing methods to render their content
**For custom UIView subclasses**:you typically override the drawRect: method of your view and use that method to draw your view’s content.   
> override func draw(_ rect: CGRect){}


#### Content Modes
 the value in the contentMode property determines whether the bitmap should be **scaled to fit** the new bounds or simply pinned to one corner or edge of the view.
 
 ![](https://lh3.googleusercontent.com/-5Xl9sxiZsQk/WqgC4yIm18I/AAAAAAAAPVA/D3W-rmPH5-odUxKPe7MMKQwRV07MGznywCHMYCw/I/15206347532540.jpg)

#### Stretchable Views
![](https://lh3.googleusercontent.com/-bcGR5mgtuFc/WqgC5evRELI/AAAAAAAAPVE/-iQOCtQwxfEpdzh3cJybo-3v7r68KkldQCHMYCw/I/15206355050273.jpg)

#### Built-In Animation Support
One of the benefits of having a layer object **behind** every view is that you can animate many view-related changes easily.

Many **properties** of the UIView class are **animatable**—that is, semiautomatic support exists for animating from one value to another.

_Among the properties you can animate on a UIView object are the following:_

* **frame**—Use this to animate position and size changes for the view.
* **bounds**—Use this to animate changes to the size of the view.
* **center**—Use this to animate the position of the view.
* **transform**—Use this to rotate or scale the view.
* **alpha**—Use this to change the transparency of the view.
* **backgroundColor**—Use this to change the background color of the view.
* **contentStretch**—Use this to change how the view’s contents stretch.

One place where animations are very important is when **transitioning** from one set of views to another. 
However, you can also **create transitions** between two sets of views using animations instead of a view controller.

In addition to the animations you create using UIKit classes, you can **also** create animations using Core Animation layers.

### View Geometry and Coordinate Systems

_The default coordinate system in UIKit:_
**Top-left corner** and has axes that extend down and to the right from the origin point. 

_Note:_
Core Graphics and OpenGL ES use a coordinate system whose origin lies in the **lower-left corner** of the view or window and whose y-axis points upward relative to the screen.

_Coordinate values are represented:_
using floating-point numbers, which allow for precise layout and positioning of content regardless of the underlying screen resolution. 

#### The Relationship of the Frame, Bounds, and Center Properties

The _frame_ property :
contains the frame rectangle, which specifies the size and location of the view in its **superview’s coordinate system**.

The _bounds_ property:
contains the bounds rectangle, which specifies the size of the view (and its content origin) in the view’s own **local coordinate system**.

The _center_ property
contains the known center point of the view in the **superview’s coordinate system**.

You use the center and frame properties primarily for **manipulating** the geometry of the current view.The value in the center property is always **valid**.

You use the bounds property primarily during **drawing**. Anything you draw **inside** this rectangle is part of the view’s visible content.


#### Coordinate System Transformations

To modify your entire view, modify the affine **transform** in the transform property of your view.
To modify specific pieces of content in your view’s drawRect: method, modify the affine transform associated with the active graphics context.

#### Points Versus Pixels
One point does not necessarily correspond to one pixel on the screen.

#### The Runtime Interaction Model for Views![](https://lh3.googleusercontent.com/-ZVU_1082ANQ/WqgC5pPSCGI/AAAAAAAAPVI/GNW36vMVg90ge9A-QKZvSOe3hJVF6uZ4wCHMYCw/I/15208837752325.jpg)

In the preceding set of steps, the primary integration points for your own **custom** views are:

1.The event-handling methods:

    touchesBegan:withEvent:
    touchesMoved:withEvent:
    touchesEnded:withEvent:
    touchesCancelled:withEvent:

2.The layoutSubviews method

3.The drawRect: method


### Tips for Using Views Effectively
 It is your responsibility to ensure that the performance of your views is good enough
#### Views Do Not Always Have a Corresponding View Controller

There is **rarely** a one-to-one relationship between individual views and view controllers in your application. 


The job of a view controller is to **manage a view hierarchy**, which often consists of more than one view used to implement some self-contained feature. 


It is important to consider the **role** that view controllers will play. 

View controllers provide a lot of important behaviors, such as:
1.coordinating the presentation of views on the screen
2.coordinating the removal of those views from the screen
3.releasing memory in response to low-memory warnings
4.rotating views in response to interface orientation changes. 

#### Minimize Custom Drawing

#### Take Advantage of Content Modes
you should avoid using the **UIViewContentModeRedraw** content mode if you can

#### Declare Views as Opaque Whenever Possible

#### Adjust Your View’s Drawing Behavior When Scrolling
Adjust Your View’s Drawing Behavior When Scrolling

#### Do Not Customize Controls by Embedding Subviews
Although it is technically possible to add subviews to the standard system controls—objects that inherit from **UIControl** — you should **never** customize them in this way. 




## Windows

A window object has several responsibilities:

It contains your application’s **visible content**.
It plays a key role in the **delivery of touch events** to your views and **other** application objects.
It works with your application’s view controllers to **facilitate orientation changes**.

In iOS, windows do not have title bars, close boxes, or any other visual adornments.

A window is always just **a blank container** for one or more views.


### Tasks That Involve Windows
For many applications, the **only** time the application interacts with its window is when it creates the window at **startup**. 

However, you can use your application’s window object to perform a few application-related tasks:

Use the window object to convert points and rectangles to or from the window’s local coordinate system.
Use window notifications to track window-related changes.

### Creating and Configuring a Window
You should always create your application’s main window at launch time regardless of whether your application is being launched into the foreground or background

#### Creating Windows in Interface Builder
Every new Xcode application project includes a main nib file (usually with the name MainWindow.xib or some variant thereof) that includes the application’s main window.
(Main.storyboard)

#### Creating a Window Programmatically
self.window is assumed to be a declared property of your application delegate that is configured to retain the window object.

#### Adding Content to Your Window
 If the root view of your window is provided by **a container view controller** (such as a tab bar controller, navigation controller, or split-view controller), you do not need to set the initial size of the view yourself. The container view controller automatically sizes its view appropriately based on whether the status bar is visible.

#### Changing the Window Level
Each UIWindow object has a configurable windowLevel property 


### Monitoring Window Changes
...
### Displaying Content on an External Display
...


## Views

***Responsibilities:***

_Layout and subview management_

* A view defines its own default resizing behaviors in relation to its parent view.
* A view can manage a list of subviews.
* A view can override the size and position of its subviews as needed.
* A view can convert points in its coordinate system to the coordinate systems of other views or the window.

_Drawing and animation_

* A view draws content in its rectangular area.
Some view properties can be animated to new values.

_Event handling_

* A view can receive touch events.
* A view participates in the responder chain.

### Creating and Configuring View Objects
#### Creating View Objects Using Interface Builder
You usually create nib files in order to **store an entire view hierarchy** for one of your application’s view controllers.


#### Creating View Objects Programmatically
The **default initialization** method for views is the initWithFrame: method.

After you create a view, you must **add** it to a window (or to another view in a window) before it can become visible. 


#### Setting the Properties of a View
![Screen Shot 2018-03-12 at 3.27.41 P](https://lh3.googleusercontent.com/-toYcabCbINQ/WqgC5kzy1RI/AAAAAAAAPVM/YV0JKKf4fDwvJ2mN0IeCpqCw5ZL4TsBBACHMYCw/I/Screen%2BShot%2B2018-03-12%2Bat%2B3.27.41%2BPM.png)

#### Tagging Views for Future Identification
You can use tags to uniquely identify views inside your view hierarchy and to perform searches for those views at runtime.

### Creating and Managing a View Hierarchy
![](https://lh3.googleusercontent.com/-jCOyTeM-NHE/WqgC52rlyYI/AAAAAAAAPVQ/ggOzgMPKNlYiXlp_NvOijGqs_h0JtENogCHMYCw/I/15208865830432.jpg)
#### Adding and Removing Subviews
When using _Interface Builder_:
you save your resulting view hierarchy in a nib file, which you load at runtime as the corresponding views are needed.

_Programmatically_:

* addSubview: 
* insertSubview:
* bringSubviewToFront:
* sendSubviewToBack:
* exchangeSubviewAtIndex:withSubviewAtIndex: 
* removeFromSuperview 

One **place** where you might **add subviews** to a view hierarchy is in the loadView or viewDidLoad methods of a view controller. 

If you are building your views **programmatically**, you put your view creation code in the **loadView** method of your view controller. 

You could include additional view **configuration** code in the viewDidLoad method.


#### Hiding Views
Events targeted at the first responder are still delivered to the hidden view.

#### Locating Views in a View Hierarchy
**Storing references** to relevant views is the most common approach to locating views and makes accessing those views very convenient.

#### Translating, Scaling, and Rotating Views
For more information about creating and using affine transforms, see Transforms in Quartz 2D Programming Guide.

#### Converting Coordinates in the View Hierarchy
need to convert coordinate values from one frame of reference to another.


### Adjusting the Size and Position of Views at Runtime
The UIView class supports both the **automatic** and **manual** layout of views in a view hierarchy. 


#### Being Prepared for Layout Changes

**Layout changes** can occur whenever any of the following events happens in a view:

The size of a view’s _bounds rectangle changes_.
An interface _orientation_ change occurs, which usually triggers a change in the root view’s bounds rectangle.
The set of Core Animation _sublayers associated_ with the view’s layer changes and requires layout.
Your application forces layout to occur by calling the _setNeedsLayout_ or _layoutIfNeeded_ method of a view.
Your application forces layout by calling the setNeedsLayout method of the view’s _underlying_ layer object.

#### Handling Layout Changes Automatically Using Autoresizing Rules
When you change the **size** of a view, the **position** and size of any embedded subviews usually needs to change to account for the new size of their parent.

The **autoresizesSubviews** property of the superview determines whether the subviews resize at all.
 If this property is set to **YES**, the view uses the **autoresizingMask** property of each subview to determine how to size and position that subview.
![Screen Shot 2018-03-13 at 10.51.32 A](https://lh3.googleusercontent.com/-CBG3ZC5YU8o/WqgC6N7EoQI/AAAAAAAAPVU/xntUwULyNdEoKkXxXa52vWvQNCV3DNVQACHMYCw/I/Screen%2BShot%2B2018-03-13%2Bat%2B10.51.32%2BAM.png)
![](https://lh3.googleusercontent.com/-v5CmZ7whuwo/WqgC6JOA_rI/AAAAAAAAPVY/6Yf8vZi5KVkE83Rtk2Xxr4VbU3yQKbxtACHMYCw/I/15209563103514.jpg)
The easiest way to configure autoresizing rules is using the Autosizing controls in the Size inspector of **Interface Builder**.

#### Tweaking the Layout of Your Views Manually
Whenever the size of a view changes, UIKit applies the autoresizing behaviors of that view’s subviews and then calls the **layoutSubviews** method of the view to let it make manual changes. 

You can _implement the layoutSubviews_ method in custom views when the autoresizing behaviors by themselves _do not yield the results you want_. Your implementation of this method can do any of the following:

**Adjust** the size and position of any immediate subviews.
**Add or remove** subviews or Core Animation layers.
Force a subview to be **redrawn** by calling its setNeedsDisplay or setNeedsDisplayInRect: method.

When writing your layout code, be sure to **test** your code in the following ways:

**Change the orientation** of your views to make sure the layout looks correct in all supported interface orientations.
Make sure your code responds appropriately to changes in **the height of the status bar**. When a phone call is active, the status bar height increases in size, and when the user ends the call, the status bar decreases in size.

### Modifying Views at Runtime
As applications receive input from the user, they adjust their user interface _in response to that input_.
There are several places and ways in which you perform these kinds of actions:

![Screen Shot 2018-03-13 at 10.56.41 A](https://lh3.googleusercontent.com/-_EQFHc_SS5U/WqgC6ZwoAgI/AAAAAAAAPVc/xM3bXj5eOKk4sFFYTEoiTXBCdIfF9sEvQCHMYCw/I/Screen%2BShot%2B2018-03-13%2Bat%2B10.56.41%2BAM.png)

**View controllers are a common place to initiate changes to your views.** 
Because a view controller manages the view hierarchy associated with the content being displayed, it is ultimately responsible for everything that happens to those views.

**Animation blocks** are another common place to initiate view-related changes.

### Interacting with Core Animation Layers
Each view object has a **dedicated Core Animation layer** that manages the presentation and animation of the view’s content on the screen.

#### Changing the Layer Class Associated with a View

The type of layer associated with a view **cannot be changed** after the view is created. 
Therefore, each view **uses the layerClass class method to specify** the class of its layer object.
#### Embedding Layer Objects in a View
If you prefer to work primarily with **layer objects** instead of views, you can **incorporate custom layer** objects into your view hierarchy as needed.
CALayer*viewLayer = self.view.layer;[viewLayer addSublayer:myLayer];

### Defining a Custom View
#### Checklist for Implementing a Custom View
The job of a custom view is to **present content** and **manage interactions** with that content. 


The following _checklist_ includes the more important methods you can override (and behaviors you can provide) when implementing a custom view:

* [ ] ***Define the appropriate initialization methods for your view:***

    * For views you plan to create **programmatically**, override the initWithFrame: method or define a custom initialization method.
    
    * For views you plan to **load from nib files**, override the initWithCoder: method. Use this method to initialize your view and put it into a known state.

* [ ] ***Implement a dealloc method to handle the cleanup of any custom data.***

* [ ] ***To handle any custom drawing, override the drawRect: method and do your drawing there.***

* [ ] ***Set the autoresizingMask property of the view to define its autoresizing behavior.***

* [ ] ***If your view class manages one or more integral subviews, do the following:***

    * Create those subviews during your view’s initialization sequence.
    * Set the autoresizingMask property of each subview at creation time.
    * If your subviews require custom layout, override the layoutSubviews method and implement your layout code there.


* [ ] ***To handle touch-based events, do the following:***

    * Attach any suitable gesture recognizers to the view by using the addGestureRecognizer: method.
    * For situations where you want to process the touches yourself, override the
     * touchesBegan:withEvent:, 
     * touchesMoved:withEvent:, 
     * touchesEnded:withEvent:,
     * touchesCancelled:withEvent: methods. 
    
    >  (Remember that you should always override the touchesCancelled:withEvent: method, regardless of which other touch-related methods you override.)
    

* [ ] ***If you want the printed version of your view to look different from the onscreen version, implement the drawRect:forViewPrintFormatter: method.*** 

    * For detailed information about how to support printing in your views, see Drawing and Printing Guide for iOS.


In addition to overriding methods, remember that there is a lot you can do with the view’s existing properties and methods.


#### Initializing Your Custom View

***Creating instances of your view programmatically in your code.***

Every new view object you define should include a custom initWithFrame: initializer method.

* This method calls  the inherited implementation of the method first **super.init(frame: frame)**
 and then initializes the instance variables and state information of the class before returning the initialized object. 

* Calling the inherited implementation is traditionally performed first so that if there is a problem, you **can abort your own initialization code** and return nil.


***Load instances of your custom view class from a nib file***

You should be aware that in iOS, the nib-loading code does **not use** the initWithFrame: method to instantiate new view objects. Instead, it uses the **initWithCoder**: method that is part of the NSCoding protocol.

#### Implementing Your Drawing Code
For views that need to do **custom drawing**, you need to override the **drawRect:** method and do your drawing there.


The implementation of your drawRect: method should **do exactly one thing**: draw your content.

This method is **not the place** to be updating your application’s data structures or performing any tasks not related to drawing. 

And if your drawRect: method might be **called frequently**, you should do everything you can to optimize your drawing code and draw as little as possible each time the method is called.

Before calling your view’s drawRect: method, UIKit configures the basic drawing environment for your view. Specifically, it creates a **graphics context and adjusts the coordinate system and clipping region** to match the coordinate system and visible bounds of your view.


The current **graphics context** is _valid only for the duration of one call to your view’s drawRect: method._ UIKit might create a different graphics context for each subsequent call to this method, so you should not try to cache the object and use it later.


***Improve drawing performance:***

* If you know that your view’s drawing code always covers the entire surface of the view with ***opaque content***, you can improve system performance by setting the opaque property of your view to ***YES***.

* Especially during scrolling, is to set the clearsContextBeforeDrawing property of your view to NO. When this property is set to YES, UIKIt automatically fills the area to be updated by your drawRect: method with transparent black before calling your method



### Responding to Events
View objects are responder objects—**instances of the UIResponder class**—and are therefore capable of receiving touch events.

In addition to **handling touch events directly**, views can also use **gesture recognizers** to detect taps, swipes, pinches, and other types of common touch-related gestures.

### Cleaning Up After Your View
...
## Animations
Animations provide **fluid visual transitions** between different states of your user interface.

In iOS, animations are used extensively to 

* reposition views
* change their size
* remove them from view hierarchies, and hide them. 

### What Can Be Animated?
Both **UIKit** and **Core Animation** provide support for animations, but the level of support provided by each technology varies.

_In UIKit_, animations are performed using UIView objects. Views support a basic set of animations that cover many common tasks.
![Screen Shot 2018-03-13 at 11.46.09 A](https://lh3.googleusercontent.com/-DUKJUXnNSws/WqgC6S15_qI/AAAAAAAAPVg/XW1-yv96twEIYAbQdaU30a1cu1NkjXdawCHMYCw/I/Screen%2BShot%2B2018-03-13%2Bat%2B11.46.09%2BAM.png)

_Core Animation_
In places where you want to perform more sophisticated animations, or animations not supported by the UIView class, you can use **Core Animation and the view’s underlying layer** to create the animation. Because view and layer objects are intricately linked together, changes to a view’s layer affect the view itself. 

***Using Core Animation, you can animate the following types of changes for your view’s layer:***

* The size and position of the layer
* The center point used when performing transformations
* Transformations to the layer or its sublayers in 3D space
* The addition or removal of a layer from the layer hierarchy
* The layer’s Z-order relative to other sibling layers
* The layer’s shadow
* The layer’s border (including whether the layer’s corners are rounded)
* The portion of the layer that stretches during resizing operations
* The layer’s opacity
* The clipping behavior for sublayers that lie outside the layer’s bounds
* The current contents of the layer
* The rasterization behavior of the layer

***Layer not associated with this view (view.layer)***
If your view hosts custom layer objects—that is, layer objects without an associated view—you must use Core Animation to animate any changes to them.

### Animating Property Changes in a View
In order to animate changes to a property of the UIView class, you must wrap those changes inside **an animation block**. 

#### Starting Animations Using the Block-Based Methods

This method lets you customize the following animation parameters:

* The delay to use before starting the animation
* The type of timing curve to use during the animation
* The number of times the animation should repeat
* Whether the animation should reverse itself automatically when it reaches the end
* Whether touch events are delivered to views while the animations are in progress
* Whether the animation should interrupt any in-progress animations or wait until those are complete before starting

#### Starting Animations Using the Begin/Commit Methods

#### Implementing Animations That Reverse Themselve

### Creating Animated Transitions Between Views

View transitions help you hide sudden changes associated with adding, removing, hiding, or showing views in your view hierarchy. You use view transitions to implement the following types of changes:

* Change the visible subviews of an existing view. 

    You typically choose this option when you want to make relatively small changes to an existing view.

* Replace one view in your view hierarchy with a different view. 

    You typically choose this option when you want to replace a view hierarchy that spans all or most of the screen.

#### Changing the Subviews of a View
#### Replacing a View with a Different View

### Linking Multiple Animations Together

### Animating View and Layer Changes Together

