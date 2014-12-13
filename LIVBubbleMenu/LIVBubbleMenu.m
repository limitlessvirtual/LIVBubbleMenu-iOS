//
//  LIVBubbleMenu.m
//  LIVBubbleMenu
//
//  Created by Leon van Dyk on 2014/10/22.
//  Copyright (c) 2014 Limitless Virtual. All rights reserved.
//

#import "LIVBubbleMenu.h"
#import <pop/POP.h>

@implementation LIVBubbleMenu {
    NSMutableArray* bubbleButtons;
}

- (id)initCenteredInWindowWithRadius:(int)radiusValue menuItems:(NSArray *)menuItems
{
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];

    return [self initWithPoint:CGPointMake((CGFloat) (window.frame.size.width * 0.5), (CGFloat) (window.frame.size.height * 0.5)) radius:radiusValue menuItems:menuItems inView:window];
}

- (id)initWithPoint:(CGPoint)point radius:(int)radiusValue menuItems:(NSArray *)menuItems inView:(UIView *)view
{
    self = [super initWithFrame:CGRectMake(point.x - radiusValue, point.y - radiusValue, 2 * radiusValue, 2 * radiusValue)];

    if (self) {
        _menuItemImages = menuItems;
        _menuRadius = radiusValue;
        _bubbleRadius = 40;
        _bubbleAlpha = 0.97f;
        _bubbleShowDelayTime = 0.15f;
        _bubbleHideDelayTime = 0.15f;
        _bubbleSpringSpeed = 3.0f;
        _bubbleSpringBounciness = 20.0f;
        _bubblePopInDuration = 1.0f;
        _bubblePopOutDuration = 1.0f;
        _bubbleStartAngle = 0.0f;
        _bubbleTotalAngle = 360.0f;
        _easyButtons = YES;
        _parentView = view;
        _hasBackground = YES;
        _backgroundColor = [UIColor blackColor];
        _backgroundAlpha = 0.2;
        _backgroundFadeDuration = 1.2f;
    }
    return self;
}

-(void)show
{
    if(!_isAnimating)
    {
        _isAnimating = YES;

        [_parentView addSubview:self];


        if (_hasBackground) {

            // Create background
            _backgroundView = [[UIView alloc] initWithFrame:_parentView.bounds];
            _backgroundView.backgroundColor = _backgroundColor;
            _backgroundView.alpha = 0;

            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundTapped:)];
            [_backgroundView addGestureRecognizer:tapGesture];
            [_parentView insertSubview:_backgroundView belowSubview:self];

            // Animate the background in
            POPBasicAnimation *fadeInAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
            fadeInAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            fadeInAnimation.toValue = @(_backgroundAlpha);
            fadeInAnimation.duration = _backgroundFadeDuration;
            [_backgroundView pop_addAnimation:fadeInAnimation forKey:@"fadeIn"];

        }

        //If there are no menu items, dont continue
        if([_menuItemImages count] == 0) return;

        bubbleButtons = [[NSMutableArray alloc] init];
        //Create bubble buttons from each menu item image
        for (int i = 0; i < _menuItemImages.count; i++)
        {
            UIButton* button = [self createButtonWithImage:_menuItemImages[i]];
            [self addSubview:button];
            [bubbleButtons addObject:button];
        }


        // there may be a better way to do this
        float bubbleDistanceFromPivot = _menuRadius - _bubbleRadius;
        // degrees between each bubble
        // if we want them to fit within, don't subtract 1
        // if we don't, subtract 1 to force spacing angle to account for extra distance
        // if doing 360, we want them to fit within
        // otherwise, we probably want them on the edges
        // actually, if _bubbleTotalAngle % 360, make them fit within, else edge them
        float bubbleSpacingAngle;
        if (((int)_bubbleTotalAngle % 360) == 0) {
            bubbleSpacingAngle = _bubbleTotalAngle / ((float)[_menuItemImages count]);
        } else {
            bubbleSpacingAngle = _bubbleTotalAngle / ((float)[_menuItemImages count] - 1);
        }

        // @TODO(Shrugs) note: this is independent of direction
        // to make it directional, loop from count -> 0 instead of 0 -> count

        //Array to store each menu item destination coordinate
        NSMutableArray *coordinates = [NSMutableArray array];
        for (int i = 0; i < bubbleButtons.count; ++i)
        {
            UIButton *bubble = bubbleButtons[i];
            bubble.tag = i;

            float angle = _bubbleStartAngle + i * bubbleSpacingAngle;

            float x = (float) (cos(angle * M_PI / 180) * bubbleDistanceFromPivot + _menuRadius);
            float y = (float) (sin(angle * M_PI / 180) * bubbleDistanceFromPivot + _menuRadius);

            [coordinates addObject:[NSValue valueWithCGPoint:CGPointMake(x, y) ]];

            bubble.transform = CGAffineTransformMakeScale(0.001, 0.001);
            bubble.center = CGPointMake(_menuRadius, _menuRadius);
        }

        int i = 0;
        for (NSValue *coordinate in coordinates)
        {
            UIButton *bubble = bubbleButtons[i];
            float delayTime = (float) (i * _bubbleShowDelayTime);

            [self showBubbleWithAnimation:[coordinate CGPointValue] button:bubble delay:delayTime];
            ++i;
        }
    }
}

-(void)hide
{
    if(!self.isAnimating)
    {
        self.isAnimating = YES;

        int i = 0;

        for (UIButton *bubbleButton in bubbleButtons)
        {
            float delayTime = (float) (i * _bubbleHideDelayTime);

            [self hideBubbleWithAnimation:bubbleButton delay:delayTime];

            ++i;
        }
    }
}

-(void)hideFromIndex:(NSInteger)index
{
    if(!self.isAnimating)
    {
        self.isAnimating = YES;
        
        NSInteger count = bubbleButtons.count;
        
        for (int i = 0; i < count; i++)
        {
            NSInteger bubbleToHide = (i+index) % count;
            
            UIButton *bubbleButton = bubbleButtons[bubbleToHide];
            
            float delayTime = (float) (i * _bubbleHideDelayTime);
            
            [self hideBubbleWithAnimation:bubbleButton delay:delayTime];
            
        }
    }
}

-(void)showBubbleWithAnimation:(CGPoint)coordinate button:(UIButton*)bubble delay:(float)delay
{

    //Create the animations needed
    POPSpringAnimation *scaleInAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    scaleInAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(0.0f, 0.0f)];
    scaleInAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(1.0f, 1.0f)];
    scaleInAnimation.springBounciness = _bubbleSpringBounciness;
    scaleInAnimation.springSpeed = _bubbleSpringSpeed;
    scaleInAnimation.beginTime = CACurrentMediaTime() + delay;

    POPBasicAnimation *positionInAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
    positionInAnimation.toValue = [NSValue valueWithCGPoint:coordinate];
    positionInAnimation.duration = _bubblePopInDuration;
    positionInAnimation.beginTime = CACurrentMediaTime() + delay;

    //Set the completion blocks
    positionInAnimation.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        //Check if its the last button to animate
        if(bubble.tag == bubbleButtons.count - 1)
           _isAnimating = NO;

    };

    //Add the animations (start them)
    [bubble pop_addAnimation:scaleInAnimation forKey:@"scaleIn"];
    [bubble pop_addAnimation:positionInAnimation forKey:@"position"];
}


-(void)hideBubbleWithAnimation:(UIButton *)bubble delay:(float)delay
{

    //Create the animations needed
    POPBasicAnimation *scaleOutAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    scaleOutAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(1.0f, 1.0f)];
    scaleOutAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(0.001f, 0.001f)];
    scaleOutAnimation.beginTime = CACurrentMediaTime() + delay;

    POPBasicAnimation *positionOutAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
    positionOutAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(_menuRadius, _menuRadius)];
    positionOutAnimation.duration = _bubblePopOutDuration;
    positionOutAnimation.beginTime = CACurrentMediaTime() + delay;


    POPBasicAnimation *bubbleFadeOutAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    bubbleFadeOutAnimation.toValue = @(0.0);
    bubbleFadeOutAnimation.duration = 0.45f;
    bubbleFadeOutAnimation.beginTime = CACurrentMediaTime() + delay;

    POPBasicAnimation *backgroundFadeOutAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    backgroundFadeOutAnimation.toValue = @(0.0);
    backgroundFadeOutAnimation.duration = _backgroundFadeDuration;



    //Set the completion blocks
    scaleOutAnimation.completionBlock = ^(POPAnimation *anim, BOOL finished) {

        if (bubble.tag == (bubbleButtons.count - 1))
        {
            if (_hasBackground)
            {
                [_backgroundView pop_addAnimation:backgroundFadeOutAnimation forKey:@"fadeOut"];
            }
            else
            {
                self.isAnimating = NO;
                self.hidden = YES;

                if([self.delegate respondsToSelector:@selector(livBubbleMenuDidHide:)]) {
                    [self.delegate livBubbleMenuDidHide:self];
                }

                [self removeFromSuperview];
            }
        }

        [bubble removeFromSuperview];
    };

    backgroundFadeOutAnimation.completionBlock = ^(POPAnimation *anim, BOOL finished) {

        self.isAnimating = NO;
        self.hidden = YES;

        [_backgroundView removeFromSuperview];

        if([self.delegate respondsToSelector:@selector(livBubbleMenuDidHide:)]) {
            [self.delegate livBubbleMenuDidHide:self];
        }

        [self removeFromSuperview];
    };


    //Add the animations (start them)
    [bubble pop_addAnimation:positionOutAnimation forKey:@"positionOut"];
    [bubble pop_addAnimation:scaleOutAnimation forKey:@"scaleOut"];
    [bubble pop_addAnimation:bubbleFadeOutAnimation forKey:@"fadeOut"];
}


#pragma mark Actions

-(void)buttonWasTapped:(UIButton *)button {
    
    [self hideFromIndex:[bubbleButtons indexOfObject:button]];
    
    if([self.delegate respondsToSelector:@selector(livBubbleMenu:tappedBubbleWithIndex:)]) {
        [self.delegate livBubbleMenu:self tappedBubbleWithIndex:button.tag];
    }
}


#pragma mark Utility

-(void)backgroundTapped:(UITapGestureRecognizer *)tapGesture
{
    [self hide];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // hides self if user touches anywhere but the buttons within the self UIView
    [self hide];
}

-(UIButton*)createButtonWithImage:(UIImage *)image
{
    //Create a new button with the specified image
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(buttonWasTapped:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 2 * _bubbleRadius, 2 * _bubbleRadius);

    if (_easyButtons) {
        [button setImage:image forState:UIControlStateNormal];
    } else {
        // Circle background
        UIView *circle = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2 * _bubbleRadius, 2 * _bubbleRadius)];
        circle.backgroundColor = [UIColor blackColor];
        circle.layer.cornerRadius = _bubbleRadius;
        circle.layer.masksToBounds = YES;
        circle.opaque = NO;
        circle.alpha = _bubbleAlpha;

        // Circle icon
        UIImageView *icon = [[UIImageView alloc] initWithImage:image];
        CGRect f = icon.frame;
        f.origin.x = (CGFloat) ((circle.frame.size.width - f.size.width) * 0.5);
        f.origin.y = (CGFloat) ((circle.frame.size.height - f.size.height) * 0.5);
        icon.frame = f;
        [circle addSubview:icon];

        [button setBackgroundImage:[self imageWithView:circle] forState:UIControlStateNormal];
    }

    return button;
}

-(UIImage *)imageWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}


@end
