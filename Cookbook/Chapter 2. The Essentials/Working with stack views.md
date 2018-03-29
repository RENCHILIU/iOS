# Working with stack views

UIStackView is one of the coolest features introduced in iOS 9.0 for developers. It was a hassle to **arrange groups** of views horizontally or vertically.


From Attribute Inspector, we set some settings to the stack view, which will highlight the most important ones, such as the following:

* Axis: You choose whether you want the stack to layout your subview vertically or horizontally. For example, in horizontal layout, you will note that the first item leading edge will be pinned to the stack's leading edge, and the last item trailing edge will be pinned to the stack's trailing edge. In vertical layout, the layout will be arranged based on top and bottom edges.

* Alignment: This option indicates how the stack view will align your subview relative to the stack view. For example, when you set it to Center when the Axis is vertical, stack view will calculate the size of each item and center it horizontally. However, when you set it to Leading, all items will be aligned along with the stack view's leading. In our example, we set it to Fill, which means the stack view will stretch the arranged views to match the stack view.


* Distribution: The option defines the size of the arranged views. For example, when you set it to Fill Equally, the stack view will lay them out, so all arranged views share the same size.


* Spacing: This defines the spacing between the arranged views.

