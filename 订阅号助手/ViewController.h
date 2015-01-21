//
//  ViewController.h
//  订阅号助手
//
//  Created by 龚莎 on 15/1/14.
//  Copyright (c) 2015年 GSClock. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *songTableView;

- (IBAction)addASong:(id)sender;

- (IBAction)outputFavirateSongs:(id)sender;

- (IBAction)locatePositionOfSong:(id)sender;

- (IBAction)playSong:(id)sender;

- (IBAction)playPreviousSong:(id)sender;

- (IBAction)playNextSong:(id)sender;

@end

