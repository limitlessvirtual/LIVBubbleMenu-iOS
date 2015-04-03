#LIVBubbleMenu


An animated bubble menu using the pop animation library (https://github.com/facebook/pop). The menu is fully customizable in terms of radius, number of items, animation speed, bounciness, background, alpha ect.

<img src="http://i.imgur.com/qLZf7a8.gif?1" width="200px;">
<img src="http://i.imgur.com/p0HduNB.gif?1" width="200px;">
<img src="http://i.imgur.com/LPZpFhp.gif" width="200px;">

**Note**: An <a href="https://github.com/limitlessvirtual/LIVBubbleMenu-Android">Android Version</a> is also available (coming soon).

##Setup

You can either:

1. Copy the the **LIVBubbleMenu** directly into your Project
2. Include the following cocoapod (preferred):

```
pod 'LIVBubbleMenu'
```

##Usage

Import the required header file:

```objective-c
#import <LIVBubbleMenu/LIVBubbleMenu.h>

//or without pod

#import "LIVBubbleMenu.h"
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

//Create the component centered in window
LIVBubbleMenu *bubbleMenu = [[LIVBubbleMenu alloc] initCenteredInWindowWithRadius:150 menuItems:images];

//Set optional properties
bubbleMenu.bubbleRadius = 80;
bubbleMenu.bubbleSpringBounciness = 30.0f;

//Show the menu
[bubbleMenu show];

```

###Initialisation

There are two ways to create the bubble menu:

**At a certain point in a view:**

```objective-c
[[LIVBubbleMenu alloc] initWithPoint:CGPointMake(100,100) radius:150 menuItems:array inView:self.view];
```
**Centered in the window:**

```objective-c
LIVBubbleMenu *bubbleMenu = [[LIVBubbleMenu alloc] initCenteredInWindowWithRadius:150 menuItems:images];
```

###Delegates

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

##Customizable Properties

| Property               | Type     | Description                                                            | Default Value |
|------------------------|----------|------------------------------------------------------------------------|---------------|
| menuItemImages         | NSArray* | UIImages for each bubble menu item.                                    | -             |
| menuRadius             | int      | The overall radius of the bubble menu.                                 | -             |
| isAnimating            | BOOL     | Flag whether the animation is currently hiding or showing              | -             |
| parentView             | UIView*  | The parent view that the bubble menu gets added to.                    | -             |
| bubbleRadius           | float    | Radius of each bubble item                                             | 40.0f         |
| bubbleAlpha            | float    | Float of each bubble item                                              | 0.97f         |
| bubbleShowDelayTime    | float    | The delay between each bubble item popping in                          | 0.15f         |
| bubbleHideDelayTime    | float    | The delay between each bubble item popping out                         | 0.15f         |
| bubbleSpringBounciness | float    | Spring bounciness of the bubble item popping in                        | 20.0f         |
| bubbleSpringSpeed      | float    | The spring speed of the bubble when popping in (default is 3.0f)       | 3.0f          |
| bubblePopInDuration    | float    | The amount of seconds it takes for a bubble to reach its show position | 1.0f          |
| bubblePopOutDuration   | float    | The amount of seconds it takes for a bubble to reach its hide position | 1.0f          |
| bubbleStartAngle       | float    | Initial angle to start bubbles                                         | 0.0f          |
| bubbleTotalAngle       | float    | Total available degrees in the bubble menu                             | 360.0f        |
| easyButtons            | BOOL     | Simple vx complex button styling (set NO if buttons have alpha channel)| YES           |
| hasBackground          | BOOL     | Toggles whether the menu has a background that fades in                | YES           |
| backgroundColor        | UIColor* | The color of the background                                            | Black         |
| backgroundAlpha        | float    | The alpha of the background (0.2 by default)                           | 0.2f          |
| backgroundFadeDuration | float    | The amount of seconds it takes for the background to fade in/out       | 1.2f          |

##Requirements

`ARC`, `iOS 7.1+`, `Xcode 5+`

##Upcoming Features

* ~~Bubble hide animation starting at tapped bubble index~~ Done (v1.1.0)
* Different types of animations
* More properties to customize
* Have an idea? Pop an email to info@limitlessvirtual.com

##Credits
The component is originally based on the awesome <a href="https://github.com/mixdesign/AAShareBubbles">AAShareBubbles</a> by <a href="https://github.com/mixdesign">Almas Adilbek</a>.

Emoticons in the demo are by <a href="https://dribbble.com/shots/891540-Emoticons?list=users&offset=1">Keyamoon</a>

Thanks to the following developers who have contributed:

* Brendan Kirchner (waterskier2007)
* Matt Condon (Shrugs)


