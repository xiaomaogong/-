//
//  ViewController.h
//  订阅号助手
//
//  Created by 龚莎 on 15/1/14.
//  Copyright (c) 2015年 GSClock. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "View/CustomIOS7AlertView.h"

@interface ViewController : UIViewController<CustomIOS7AlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *songTableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

- (IBAction)addASong:(id)sender;

- (IBAction)outputFavirateSongs:(id)sender;

- (IBAction)locatePositionOfSong:(id)sender;

- (IBAction)playSong:(id)sender;

- (IBAction)playPreviousSong:(id)sender;

- (IBAction)playNextSong:(id)sender;

@end

