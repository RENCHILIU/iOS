# Working with gestures like swipe, pan, rotation, and tap

* **UITapGestureRecognizer**: This is a gesture recognizer that detects taps on UIViews with any number of taps, for example, detecting double taps on UIView

* **UIPinchGestureRecognizer**: This is a gesture recognizer that detects pinching (zooming) a view with two fingers, similar to zooming pictures in Photos app


* **UIPanGestureRecognizer**: This is a gesture recognizer that detects dragging UIViews


* **UISwipeGestureRecognizer**: This is a gesture recognizer that detects swiping up, down, left, or right


* **UIRotationGestureRecognizer**: This is a gesture recognizer that detects rotating a view with two fingers


* **UILongPressGestureRecognizer**: This is a gesture recognizer that detects long press on UIView to do a specific action






The most helpful function in the gesture recognizer is **locationInView()**, which returns a CGPoint of the gesture location relative to a given view. We used it in the pan gesture to move the view while dragging. You can use it with the tap gesture also to do specific action at the tapped location.

