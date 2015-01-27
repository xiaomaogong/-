//
//  ViewController.m
//  订阅号助手
//
//  Created by 龚莎 on 15/1/14.
//  Copyright (c) 2015年 GSClock. All rights reserved.
//

#import "ViewController.h"

#define INPUT_WEBPATH_SAVE      0
#define INPUT_WEBPATh_CANCEL    1

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (IBAction)addASong:(id)sender {
}

- (IBAction)outputFavirateSongs:(id)sender {
}

- (IBAction)locatePositionOfSong:(id)sender {
}

- (IBAction)playSong:(id)sender {
}

- (IBAction)playPreviousSong:(id)sender {
}

- (IBAction)playNextSong:(id)sender {
}

- (IBAction)lauchDialog:(id)sender {
    // Here we need to pass a full frame
    CustomIOS7AlertView *alertView = [[CustomIOS7AlertView alloc] init];
    
    // Add some custom content to the alert view
    [alertView setContainerView:[self createDemoView]];
    
    // Modify the parameters
    [alertView setButtonTitles:[NSMutableArray arrayWithObjects:@"Save", @"Cancel", nil]];
    [alertView setDelegate:self];
    
    // You may use a Block, rather than a delegate.
    [alertView setOnButtonTouchUpInside:^(CustomIOS7AlertView *alertView, int buttonIndex) {
        NSLog(@"Block: Button at position %d is clicked on alertView %d.", buttonIndex, (int)[alertView tag]);
        //[alertView close];
    }];
    
    [alertView setUseMotionEffects:true];
    
    // And launch the dialog
    [alertView show];
}

- (void)customIOS7dialogButtonTouchUpInside: (CustomIOS7AlertView *)alertView clickedButtonAtIndex: (NSInteger)buttonIndex
{
    NSLog(@"Delegate: Button at position %d is clicked on alertView %d.", (int)buttonIndex, (int)[alertView tag]);
    switch (buttonIndex) {
        case INPUT_WEBPATH_SAVE:
            break;
        case INPUT_WEBPATh_CANCEL:
            break;
        default:
            NSLog(@"customIOS7dialogButtonTouchUpInside: Unknown button index %d.", (int)buttonIndex);
            break;
    }
    [alertView close];
}

- (UIView *)createDemoView
{
    UIView *demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 290, 200)];
    
    NSInteger titleHeight = 40;
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 270, titleHeight)];
    [title setText:@"输入WEB地址"];
    [title setBackgroundColor:[UIColor lightGrayColor]];
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 10+titleHeight, 270, 180)];
    [demoView addSubview:title];
    [demoView addSubview:textView];
    
    return demoView;
}

@end
