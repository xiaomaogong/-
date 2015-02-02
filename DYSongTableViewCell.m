//
//  DYSongTableViewCell.m
//  订阅号助手
//
//  Created by 龚莎 on 2/1/15.
//  Copyright (c) 2015 GSClock. All rights reserved.
//

#import "DYSongTableViewCell.h"
#import "DYArticle.h"

@interface RedCircleView() {
}
@end

@implementation RedCircleView
    
- (void)drawRect:(CGRect)rect {
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(contextRef, 5.0);
    CGContextSetRGBFillColor(contextRef, 255.0, 0.0, 0.0, 1.0);
    CGContextSetRGBStrokeColor(contextRef, 255.0, 255.0, 255.0, 1.0);
    CGContextFillEllipseInRect(contextRef, rect);
    CGContextStrokeEllipseInRect(contextRef, rect);
}

@end


@interface ClearCircleView() {
}
@end

@implementation ClearCircleView

- (void)drawRect:(CGRect)rect {
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(contextRef, 5.0);// Set the border width
    CGContextSetRGBFillColor(contextRef, 255.0, 255.0, 255.0, 1.0);
    CGContextSetRGBStrokeColor(contextRef, 255.0, 255.0, 255.0, 1.0);
    CGContextFillEllipseInRect(contextRef, rect);
    CGContextStrokeEllipseInRect(contextRef, rect);
}

@end

@interface DYSongTableViewCell()
{
    id<DYSongTableViewCellDelegate> delegate;
}
@end

@implementation DYSongTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)setRedDot {
    CGRect positionFrame = CGRectMake(10,10,10,10);
    RedCircleView * circleView = [[RedCircleView alloc] initWithFrame:positionFrame];
    [self.contentView addSubview:circleView];
    self.isReaded = FALSE;
}

- (void)unsetRedDot {
    CGRect positionFrame = CGRectMake(10,10,10,10);
    ClearCircleView * circleView = [[ClearCircleView alloc] initWithFrame:positionFrame];
    [self.contentView addSubview:circleView];
    self.isReaded = TRUE;
}

- (void)setPlayStatus:(BOOL)playStatus {
    self.songPlayIcon.hidden = playStatus;
    self.songPlayIcon.tag = playStatus;
}

- (void)setFavorStatus:(BOOL)favorStatus {
    self.favorButton.tag = favorStatus;
    
    if (TRUE == favorStatus) {
        UIImageView *strechTest = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"like_heart.png"]];
        [strechTest setContentStretch:CGRectMake(0.5f, 0.5f, 0.f, 0.f)];
        CGRect frame = strechTest.frame;
        frame.size.width -= 30;
        frame.size.height -= 20;
        strechTest.frame = frame;
        
        //把imageView放入button中，并设置为back
        UIButton *button1 = self.favorButton;
        button1.frame = frame;
        button1.center = CGPointMake(10, 10);
        [button1 addSubview:strechTest];
        [button1 bringSubviewToFront:strechTest];
        //[button1 sendSubviewToBack:strechTest];
        //[button1 setBackgroundColor:[UIColor clearColor]];
    } else {
        UIImageView *strechTest = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"unlike_heart.png"]];
        [strechTest setContentStretch:CGRectMake(0.5f, 0.5f, 0.f, 0.f)];
        CGRect frame = strechTest.frame;
        frame.size.width -= 30;
        frame.size.height -= 20;
        strechTest.frame = frame;
        
        //把imageView放入button中，并设置为back
        UIButton *button1 = self.favorButton;
        button1.frame = frame;
        button1.center = CGPointMake(10, 10);
        [button1 addSubview:strechTest];
        [button1 bringSubviewToFront:strechTest];
        //[button1 sendSubviewToBack:strechTest];
        //[button1 setBackgroundColor:[UIColor clearColor]];
    }
}

- (void)changeFavorStatus {
    [self setFavorStatus:!self.favorButton.tag];
}

- (void)awakeFromNib {
    // Initialization code
}


- (IBAction)favorSong:(id)sender {
    [self changeFavorStatus];
    [self->delegate cell:self didFavorOrNot:self.favorButton.tag];
}

- (IBAction)playSong:(id)sender {
    [self setPlayStatus:TRUE];
    [self unsetRedDot];
    [self->delegate cellDidPlaySong:self];
}

+(instancetype) initWithDYArticle: (DYArticle*) article delegate:(id<DYSongTableViewCellDelegate>) delegate tableView:(UITableView*)tableView {
    static NSString *CellIdentifier = @"songCell";
    DYSongTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[DYSongTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell->delegate = delegate;
    
#if 0
    cell.identifier = article.identifier;
    [cell.songTitle setTitle:article.title forState:UIControlStateNormal];
    [cell setPlayStatus:false];
    [cell setFavorStatus:article.addToFavor > 0 ? TRUE : FALSE];
    if (FALSE == article.isReaded) {
        [cell setRedDot];
    } else {
        [cell unsetRedDot];
    }
#endif
    cell.identifier = 0;
    [cell.songTitle setTitle:@"123" forState:UIControlStateNormal];
    [cell setPlayStatus:FALSE];
    [cell setFavorStatus:TRUE];
    if (FALSE == FALSE) {
        [cell setRedDot];
    } else {
        [cell unsetRedDot];
    }

    return cell;
}

@end
