//
//  LIVBubbleMenu.h
//  LIVBubbleMenu
//
//  Created by Leon van Dyk on 2014/10/22.
//  Copyright (c) 2014 Limitless Virtual. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LIVBubbleButtonDelegate;


@interface LIVBubbleMenu : UIView

//Delegate
@property (nonatomic, assign) id<LIVBubbleButtonDelegate> delegate;


//General
@property (nonatomic, assign) NSArray *menuItemImages; //The menu items images
@property (nonatomic, assign) int menuRadius; // Radius from center of menu to each menu item
@property (nonatomic, assign) BOOL isAnimating; // Flag to track if the menu items are currently animating
@property (nonatomic, weak) UIView *parentView; // The parent view this view was added to


// Bubble
@property (nonatomic, assign) int bubbleRadius; // Radius of each menu item
@property (nonatomic, assign) float bubbleAlpha; // Alpha of each bubble (0.97 by default)
@property (nonatomic, assign) float bubbleShowDelayTime; // The delay between each bubble item popping in
@property (nonatomic, assign) float bubbleHideDelayTime; // The delay between each bubble item popping out
@property (nonatomic, assign) float bubbleSpringBounciness; // Spring bounciness of the buble when popping in (default is 20.0f)
@property (nonatomic, assign) float bubbleSpringSpeed; // The spring speed of the bubble when popping in (default is 3.0f)
@property (nonatomic, assign) float bubblePopInDuration; // The amount of seconds it takes for a bubble to reach its show position (default is 1.0f)
@property (nonatomic, assign) float bubblePopOutDuration; // The amount of seconds it takes for a bubble to reach its hide position  (default is 1.0f)
@property (nonatomic, assign) float bubbleStartAngle; // Initial angle to start bubbles (default is 0.0f)
@property (nonatomic, assign) float bubbleTotalAngle; // Total available degrees in the bubble menu (default is 360)
@property (nonatomic, assign) BOOL easyButtons; // simple or complex button styling (set NO if buttons have alpha channel) (default is YES);

// Background
@property (nonatomic) UIView *backgroundView;
@property (nonatomic, assign) BOOL hasBackground; // Toggles whether the menu has a background that fades in (On by default)
@property (nonatomic, assign) UIColor *backgroundColor; // The color of the background (Black by default)
@property (nonatomic, assign) float backgroundAlpha; // The alpha of the background (0.2 by default)
@property int backgroundFadeDuration; // The amount of seconds it takes for the background to fade in/out (1.2 by default


-(id)initWithPoint:(CGPoint)point radius:(int)radiusValue menuItems:(NSArray*)menuItems inView:(UIView *)view; //Initialize the component at a certain point with a certain radius

-(id)initCenteredInWindowWithRadius:(int)radiusValue menuItems:(NSArray*)menuItems; // Initialize the component in a UIWindow instance

-(void)show; // Show the menu
-(void)hide; // Hide the menu
-(void)hideFromIndex:(NSInteger)index; // Hide the menu starting from a specific bubble

@end

@protocol LIVBubbleButtonDelegate<NSObject>

@optional

// On buttons pressed
-(void)livBubbleMenu:(LIVBubbleMenu *)bubbleMenu tappedBubbleWithIndex:(NSUInteger)index;

// On bubbles hide
-(void)livBubbleMenuDidHide:(LIVBubbleMenu *)bubbleMenu;
@end


