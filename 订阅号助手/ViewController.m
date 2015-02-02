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

#define INPUT_WEBPATH_SAVE      0
#define INPUT_WEBPATh_CANCEL    1

@interface ViewController ()

@end

@implementation ViewController
{
    DYIURLParser* parser;
    UITableView* tv;
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
    
    self.songs = [NSMutableArray array];
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
    if (tv == nil) {
        tv = tableView;
    }
    return [self.songs count];
//    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
#if 0
    DYSongTableViewCell *cell = [DYSongTableViewCell initWithDYArticle:self.songs[indexPath.row] delegate:self];
#endif
    DYSongTableViewCell *cell = [DYSongTableViewCell initWithDYArticle:[self.songs objectAtIndex:indexPath.item] delegate:self tableView:tableView];
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
    UITextView* tv  = ((UITextView *)alertView.containerView.subviews[1]);
    if(!tv.hasText)
        return;

    switch (buttonIndex) {
        case INPUT_WEBPATH_SAVE:
            [self onSaveBittonClick:tv.text];
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
        //Update UI logic here when data is back
//        [[[UIAlertView new] initWithTitle:result.IsSuccess ? @"成功结果": @"失败结果" message:result.arrcontent[0] delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil] show];
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
    
}

@end
