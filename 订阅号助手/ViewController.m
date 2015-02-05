//
//  ViewController.m
//  订阅号助手
//
//  Created by 龚莎 on 15/1/14.
//  Copyright (c) 2015年 GSClock. All rights reserved.
//

#import "ViewController.h"
#import "SWRevealViewController.h"
#import "DYArticle.h"

#import "DYArticle.h"
#import "DYIURLParser.h"
#import "DYSongTableViewCell.h"
#import "DYPlayer.h"

#define INPUT_WEBPATH_SAVE      0
#define INPUT_WEBPATh_CANCEL    1

@interface ViewController ()
@end

@implementation ViewController
{
    DYIURLParser* parser;
    DYPlayer* player;
    UITableView* tv;
    DYSongTableViewCell* playingCell;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Change button color
    _sidebarButton.tintColor = [UIColor colorWithWhite:0.1f alpha:0.9f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    parser = [DYIURLParser defaultInstance];
    player = [DYPlayer defaultInstance];
    
    self.songs = [NSMutableArray array];
    self->playingCell = nil;
    [self loadSongs];
}

- (void)loadSongs
{
#if 0
    /* 20150202 zl Test DYSongTableViewCell start */
    DYArticle *article = [[DYArticle alloc] init];
    //article.isReaded = FALSE;
    //article.identifier = 0;
    article.title = @"宝宝去哪儿了";
    article.addToFavor = @1;
    /* 20150202 zl Test DYSongTableViewCell end */
#endif
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return 1;
    if (tv == nil) {
        tv = tableView;
    }
    return [self.songs count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
#if 1
    DYSongTableViewCell *cell = [DYSongTableViewCell initWithDYArticle:self.songs[indexPath.row] delegate:self tableView:tableView];
#endif
    
#if 0
    DYSongTableViewCell *cell = [DYSongTableViewCell initWithDYArticle:nil delegate:self tableView:tableView];
#endif
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self.songs removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
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
//    [alertView setOnButtonTouchUpInside:^(CustomIOS7AlertView *alertView, int buttonIndex) {
//        NSLog(@"Block: Button at position %d is clicked on alertView %d.", buttonIndex, (int)[alertView tag]);
//        //[alertView close];
//    }];
    
    [alertView setUseMotionEffects:true];
    
    // And launch the dialog
    [alertView show];
}

- (void)customIOS7dialogButtonTouchUpInside: (CustomIOS7AlertView *)alertView clickedButtonAtIndex: (NSInteger)buttonIndex
{
//    NSLog(@"Delegate: Button at position %d is clicked on alertView %d.", (int)buttonIndex, (int)[alertView tag]);
    UITextView* textView  = ((UITextView *)alertView.containerView.subviews[1]);
    if(!textView.hasText)
        return;

    switch (buttonIndex) {
        case INPUT_WEBPATH_SAVE:
            [self onSaveBittonClick:textView.text];
            break;
        case INPUT_WEBPATh_CANCEL:
            break;
        default:
            NSLog(@"customIOS7dialogButtonTouchUpInside: Unknown button index %d.", (int)buttonIndex);
            break;
    }
    [alertView close];
}

-(void) onSaveBittonClick:(NSString *) url{
    DYArticle* da = [DYArticle initWithUpdateSelector:^(DYArticle * result) {
        if (result.IsSuccess) {
            [self.songs addObject:result];
            [tv reloadData];
        }
    }];
    da.url = url;
    [parser Parse:da];
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

- (void) cell:(DYSongTableViewCell*)cell didFavorOrNot:(BOOL)bFavor {
    
}

- (void) cellDidPlaySong:(DYSongTableViewCell *)cell {
    if (nil != cell) {
        [playingCell stopSong];
    }
    playingCell = cell;
    
    /// TODO:Need Play API
    DYArticle * a = [self getArticalByIdentify:playingCell.identifier];
    if(a != nil)
    {
        [player setCurrentData:a.arrcontent];
        [player play];
    }
}

-(DYArticle*)getArticalByIdentify:(long)indentifier{
    DYArticle* result = nil;
    if(self.songs != nil){
      NSInteger index =  [self.songs indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
            if (((DYArticle *)obj).identifier == indentifier) {
                *stop = YES;
                return YES;
            }
            return NO;
        }];
        result = self.songs[index];
    }
    return  result;
}

- (void) cellDidStopSong:(DYSongTableViewCell *)cell {
    playingCell = nil;
    
    /// TODO:Need Play API
}

@end
