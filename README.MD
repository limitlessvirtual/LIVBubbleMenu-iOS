#LIVBubbleMenu


An animated bubble menu using the pop animation library (https://github.com/facebook/pop). The menu is fully customizable in terms of radius, number of items, animation speed, bounciness, background, alpha ect.

<img src="http://i.imgur.com/qLZf7a8.gif?1">
<img src="http://i.imgur.com/p0HduNB.gif?1">
<img src="http://i.imgur.com/LPZpFhp.gif">

##Setup

You can either:

1. Copy the the **LIVBubbleMenu** directly into your Project
2. Include the following cocoa pod (preferred):

```
pod 'LIVBubbleMenu'
```

##Usage

Import the required header file:

```objective-c
#import "<LIVBubbleMenu/LIVBubbleMenu.h">
```

Create the LIVBubbleMenu with an array of images and set certain properties:

```objective-c

//Array of UIImages for each bubble
NSArray* images = [NSArray arrayWithObjects:
                     	[UIImage imageNamed:@"angry"],
                        [UIImage imageNamed:@"confused"],
                        [UIImage imageNamed:@"cool"],
                        [UIImage imageNamed:@"grin"],
                        [UIImage imageNamed:@"happy"],
                        [UIImage imageNamed:@"neutral"],
                        [UIImage imageNamed:@"sad"],
                        nil]; 

//Create the components
LIVBubbleMenu *bubbleMenu = [[LIVBubbleMenu alloc] initCenteredInWindowWithRadius:150 menuItems:images];

//Set optional properties
bubbleMenu.bubbleRadius = 80;
bubbleMenu.bubbleSpringBounciness = 30.0f;

//Show the menu
[bubbleMenu show];

```

The following delegates are available:

```objective-c

//User selected a bubble
-(void)livBubbleMenu:(LIVBubbleMenu *)bubbleMenu tappedBubbleWithIndex:(NSUInteger)index {
    NSLog(@"User has selected bubble index: %tu", index);
}

//The bubble menu has been hidden
-(void)livBubbleMenuDidHide:(LIVBubbleMenu *)bubbleMenu {
    NSLog(@"LIVBubbleMenu has been hidden");    
}

```

##Requirements

`ARC`, `iOS 7.1+`, `Xcode 5+`

##Upcoming Features

* Bubble hide animation starting at tapped bubble index
* Different types of animations
* More properties to custmize
* Have an idea? Pop an email to info@limitlessvirtual.com