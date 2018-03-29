# Notification Programming Topics
[link](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/Notifications/Introduction/introNotifications.html#//apple_ref/doc/uid/10000043-SW1)


## Notifications
A notification **encapsulates information about an event**, 

such as:

* A window gaining focus or a network connection closing.

* Objects that need to know about an event (for example, a file that needs to know when its window is about to be closed) register with the notification center that it wants to be notified when that event happens. 

When the event does happen, a notification is _posted to the notification center_, which immediately **broadcasts** the notification to _all registered objects_. 

Optionally, a notification is **queued** in a notification queue, which posts notifications to a notification center after it delays specified notifications and coalesces notifications that are similar according to some specified criteria you specify.


### Notifications and Their Rationale
The **standard way** to pass information between objects is message _passing—one object invokes the method of another object_. 
However, message passing **requires** that the object sending the message **know who the receiver is** and what messages it responds to.

At times, this **tight coupling of two objects** is **undesirable**—most notably because it would join together two otherwise independent subsystems.

For these cases, a **broadcast model** is introduced: An object posts a notification, which is dispatched to the appropriate observers through an NSNotificationCenter object, or simply notification center.


### Notification and Delegation
Using the notification system is similar to using delegation but has **these differences**:

* Any number of objects may receive the notification, not just the delegate object. This precludes returning a value.
* An object may receive any message you like from the notification center, not just the predefined delegate methods.
* The object posting the notification does not even have to know the observer exists.


## Notification Centers

_A notification center manages the sending and receiving of notifications._

***WorkFlow:***

* It notifies all observers of notifications meeting **specific criteria**. 
* The notification information is **encapsulated** in NSNotification objects. 
* Client objects **register themselves** with the notification center as observers of specific notifications posted by other objects. 
* When an event occurs, an object **posts** an appropriate notification to the notification center. 
* The notification center **dispatches** a message to each registered observer, passing the notification as the sole argument. 
* It is possible for the posting object and the observing object to be the **same**.



Cocoa includes two types of notification centers:

* The **NSNotificationCenter** class manages notifications within a single process.
* The **NSDistributedNotificationCenter** class manages notifications across multiple processes on a single computer.


### NSNotificationCenter
Each process has a **default notification center** that you access with the NSNotificationCenter +defaultCenter class method. 

    class var `default`: NotificationCenter

This notification center handles notifications within a single process.

**Synchronously:**
A notification center delivers notifications to observers **synchronously**. 
In other words, when posting a notification, control does not return to the poster _until all observers have received and processed the notification._ 
To send notifications **asynchronously** use a notification queue, which is described in Notification Queues.

### NSDistributedNotificationCenter
Each process has a default distributed notification center that you access with the NSDistributedNotificationCenter +defaultCenter class method. 

This distributed notification center handles notifications that can be sent between processes on a single machine. For communication between processes on different machines, use distributed objects (see Distributed Objects Programming Topics).

Posting a distributed notification is an **expensive operation**. The notification gets sent to a systemwide server that then distributes it to all the processes that have objects registered for distributed notifications. 


## Notification Queues

NSNotificationQueue objects, or simply, **notification queues**, act as buffers for notification centers (instances of NSNotificationCenter). 
The NSNotificationQueue class contributes two important features to the Foundation Kit’s notification mechanism: 

* the **coalescing**[ˌkoʊəˈles] of notifications
* **asynchronous** [eɪˈsɪŋkrənəs]posting.



### Notification Queue Basics

Using the NSNotificationCenter’s postNotification: method and its variants, you can post a notification to a notification center.

    func post(name aName: NSNotification.Name, object anObject: Any?)
    
However, the invocation of the method is **synchronous**: before the posting object can resume its thread of execution, **it must wait** until the notification center **dispatches** the notification to all observers and returns.

***FIFO***:
A notification queue, on the other hand, maintains notifications (instances of NSNotification) generally in a First In First Out ***(FIFO)*** order. 
   
### Posting Notifications Asynchronously
With NSNotificationQueue’s **enqueueNotification**:postingStyle: and enqueueNotification:postingStyle:coalesceMask:forModes: methods, you can post a notification asynchronously to the current thread by putting it in a queue. 

Posting to a notification queue can occur in one of three different styles: **NSPostASAP**, **NSPostWhenIdle**, and **NSPostNow**. These styles are described in the following sections.


### Coalescing Notifications
    
In some situations, you may want to post a notification if a given event occurs at least once, but _you want to post no more than one notification_ even if the event occurs multiple times. 

***more post, one react***
For example, in an application that receives data in discrete packets, upon receipt of a packet you may wish to post a notification to signify that the data needs to be processed. _If multiple packets arrive within a given time period, however, you do not want to post multiple notifications._ 
Moreover, the object that posts these notifications may not have any way of knowing whether more packets are coming or not, whether the posting method is called in a loop or not.



***Bad Solution:***
In some situations it may be possible to simply set a **Boolean flag** (whether an instance variable of an object or a global variable) to denote that an event has occurred and to suppress posting of further notifications until the flag is cleared.

**Drawback**
If this is not possible, however, in this situation you cannot **directly use** NSNotificationCenter since its behavior is synchronous—notifications are posted before returning, thus there is **no opportunity for "ignoring” duplicate notifications**; moreover, an NSNotificationCenter instance **has no way of** knowing whether more notifications are coming or not.

***->Right Solution:***
Rather than posting a notification to a notification center, therefore, you can add the notification to an **NSNotificationQueue** instance specifying an appropriate option for coalescing. 

You indicate the criteria for similarity by specifying one or more of the following constants in the third argument of the **enqueueNotification:postingStyle:coalesceMask:forModes:** method:

* NSNotificationNoCoalescing	
    * Do not coalesce notifications in the queue.
* NSNotificationCoalescingOnName
    * Coalesce notifications with the same name.
* NSNotificationCoalescingOnSender
    * Coalesce notifications with the same object.

-

        // MyNotificationName defined globally
        NSString *MyNotificationName = @"MyNotification";
         
        id object = <#The object associated with the notification#>;
        NSNotification *myNotification =
                [NSNotification notificationWithName:MyNotificationName object:object]
        [[NSNotificationQueue defaultQueue]
                enqueueNotification:myNotification
                postingStyle:NSPostWhenIdle
                coalesceMask:NSNotificationCoalescingOnName
                forModes:nil];
-

All notifications named MyNotificationName are coalesced into a single notification.

## Registering for a Notification

### Registering for Local Notifications
You register **an object** to receive a notification by invoking the notification center method addObserver:selector:name:object:, specifying 

* the **observer**
* the **message**the notification center should send to the observer
* the **name** of the notification it wants to receive
* and about which **object**. 


-
    - (void)addObserver:(id)observer 
               selector:(SEL)aSelector 
                   name:(NSNotificationName)aName 
                 object:(id)anObject;

_

    selector:-> func doSomething(sender: Any, forEvent event: UIEvent)
    
    
***You don’t need to specify both the name and the object.***

**Object & Name:**

* If you specify only an **object**, the observer will receive all notifications containing that object. 
* If you specify only a **notification name**, the observer will receive that notification every time it’s posted, regardless of the object associated with it.
    
It is possible for an observer to register to **receive more than one message for the same notification**. In such a case, the observer will receive all messages it is registered to receive for the notification, but the order in which it receives them cannot be determined.

you can remove the observer from the notification center’s list of observers with the methods **removeObserver**: or removeObserver:name:object:.
 
### Registering for Distributed Notifications





### Unregistering an Observer
Before an object that is observing notifications is deallocated, it must tell the notification center to stop sending it notifications.

Otherwise, the next notification gets sent to a nonexistent object and the program **crashes**.

 

## Posting a Notification
### Posting Local Notifications

**Create**
You can create a notification object with **notificationWithName**:object: or notificationWithName:object:userInfo:. 
**Post**
You then post the notification object to a notification center using the **postNotification**: instance method. 

**NSNotification objects are immutable**, so once created, they cannot be modified.

_However, you normally don’t create your own notifications directly._ 
The methods **postNotificationName**:object: and **postNotificationName**:object:userInfo: of the NSNotificationCenter class allow you to conveniently post a notification without creating it first.

### Posting Distributed Notifications

## Delivering Notifications To Particular Threads

_Regular notification_ centers deliver notifications on the thread in which the **notification was posted**.

_Distributed notification_ centers deliver notifications on the main thread.

***Get notification in Thread A. but execute in Thread B***
At times, you may require notifications to be delivered on a particular thread that is determined by you instead of the notification center. For example, if an object running in a background thread is listening for notifications from the user interface, such as a window closing, you would like to receive the notifications in the background thread instead of the main thread. In these cases, you must capture the notifications as they are delivered on the default thread and redirect them to the appropriate thread.

One way to redirect notifications is to **use a custom notification queue** (not an NSNotificationQueue object) to hold any notifications that are received on incorrect threads and then process them on the correct thread.


