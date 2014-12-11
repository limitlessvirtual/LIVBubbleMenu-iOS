//
//  ViewController.m
//  LIVBubbleMenu
//
//  Created by Leon van Dyk on 2014/10/22.
//  Copyright (c) 2014 Limitless Virtual. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _images = [NSArray arrayWithObjects:
                      [UIImage imageNamed:@"angry"],
                      [UIImage imageNamed:@"confused"],
                      [UIImage imageNamed:@"cool"],
                      [UIImage imageNamed:@"grin"],
                      [UIImage imageNamed:@"happy"],
                      [UIImage imageNamed:@"neutral"],
                      [UIImage imageNamed:@"sad"],
                      [UIImage imageNamed:@"shocked"],
                      [UIImage imageNamed:@"smile"],
                      [UIImage imageNamed:@"tongue"],
                      [UIImage imageNamed:@"wink"],
                      [UIImage imageNamed:@"wondering"],
                      nil];    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)moodButtonTapped {
    _bubbleMenu = [[LIVBubbleMenu alloc] initWithPoint:self.moodButton.center radius:150 menuItems:_images inView:self.view];
    _bubbleMenu.delegate = self;
    _bubbleMenu.easyButtons = NO;
    [_bubbleMenu show];
}

- (IBAction)partialButtonTapped:(id)sender {
    NSRange range;
    range.location = 0;
    range.length = 4;
    _bubbleMenu = [[LIVBubbleMenu alloc] initWithPoint:self.partialButton.center radius:150 menuItems:[_images subarrayWithRange:range] inView:self.view];
    _bubbleMenu.delegate = self;
    _bubbleMenu.easyButtons = NO;
    _bubbleMenu.bubbleStartAngle = 0.0f;
    _bubbleMenu.bubbleTotalAngle = 180.0f;
    [_bubbleMenu show];
}

#pragma mark - Delegates

-(void)livBubbleMenu:(LIVBubbleMenu *)bubbleMenu tappedBubbleWithIndex:(NSUInteger)index {
    NSLog(@"User has selected bubble index: %tu", index);
}

-(void)livBubbleMenuDidHide:(LIVBubbleMenu *)bubbleMenu {
    NSLog(@"LIVBubbleMenu has been hidden");
}

@end
