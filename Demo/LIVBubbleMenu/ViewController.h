//
//  ViewController.h
//  LIVBubbleMenu
//
//  Created by Leon van Dyk on 2014/10/22.
//  Copyright (c) 2014 Limitless Virtual. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LIVBubbleMenu.h"

@interface ViewController : UIViewController <LIVBubbleButtonDelegate>

@property LIVBubbleMenu* bubbleMenu;
@property NSArray* images;
@property (strong, nonatomic) IBOutlet UIButton *moodButton;
@property (weak, nonatomic) IBOutlet UIButton *partialButton;
- (IBAction)moodButtonTapped;
- (IBAction)partialButtonTapped:(id)sender;


@end

