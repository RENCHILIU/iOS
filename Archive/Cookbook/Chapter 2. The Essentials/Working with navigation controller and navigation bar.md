# Working with navigation controller and navigation bar


##### Push and pop


Also, to pop view controllers, we have three functions that we can use:

* The **popViewControllerAnimated function:** This will pop the top view controller and update the UI to the preceding one
* The **popToRootViewControllerAnimated function:** This will pop all view controllers in the stack, but the root view controller
    * back to *TOP*
* The **popToViewController:animated function:** This will pop all view controllers in the stack not up to the root but up to a given reference to the view controller to pop to it
    * back to *Specify*
    

##### Hiding navigation bar
* You can at any time hide or show the navigation bar based on any logic you have in your app by calling:
     
        self.navigationController?.setNavigationBarHidden(true, animated: true) 

* UINavigationController has another awesome property called **hidesBarsOnSwipe** when you set it to true. 

        self.navigationController?.hidesBarsOnSwipe = true 
    
The navigation bar will be hidden automatically when you **swipe up a table view or a scroll view**.    

 
##### Navigation bar color

Open the **AppDelegate.swift** file, and add these lines of code:

    UINavigationBar.appearance().tintColor = UIColor.blackColor() 
    UINavigationBar.appearance().barTintColor = UIColor.cyanColor() 
    


