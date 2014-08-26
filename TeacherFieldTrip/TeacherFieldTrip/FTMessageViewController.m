//
//  FTMessageViewController.m
//  TeacherFieldTrip
//
//  Created by Morgan Collino on 16/11/2013.
//  Copyright (c) 2013 Morgan Collino. All rights reserved.
//

#import "FTMessageViewController.h"
#import "FTStudent.h"
#import "FTMessage.h"

#import "UIButton+JSMessagesView.h"
#import "JSAvatarImageFactory.h"


@interface FTMessageViewController ()

@end

@implementation FTMessageViewController

@synthesize student, avatars, messages, subtitles;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = student.studentID;
    self.delegate = self;
    self.dataSource = self;
    
    self.title = @"Messages";
    
    self.messageInputView.textView.placeHolder = @"Message";
    
    self.messages = [[NSMutableArray alloc] init];
    self.subtitles = [[NSMutableArray alloc] init];
        
    self.tabBarController.tabBar.hidden = YES;
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messages.count;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    self.tabBarController.tabBar.hidden = YES;
}


#pragma mark - Messages view delegate: REQUIRED

- (void)didSendText:(NSString *)text
{
    FTMessage *a = [[FTMessage alloc] initWithDictionary: @{@"fromMe": @1, @"msg": text}];

    [self.messages addObject: a];
    [self.timestamps addObject:[NSDate date]];
    
    [self finishSend];
    [self scrollToBottomAnimated:YES];
    // SEND TO MOURRRAD
}

- (JSBubbleMessageType)messageTypeForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FTMessage *m = [messages objectAtIndex: indexPath.row];
    return (!m.fromMe) ? JSBubbleMessageTypeIncoming : JSBubbleMessageTypeOutgoing;
}

- (UIImageView *)bubbleImageViewWithType:(JSBubbleMessageType)type
                       forRowAtIndexPath:(NSIndexPath *)indexPath
{
    FTMessage *m = [messages objectAtIndex: indexPath.row];

    if(!m.fromMe) {
        return [JSBubbleImageViewFactory bubbleImageViewForType:type
                                                          style:JSBubbleImageViewStyleClassicSquareBlue];
    }
    
    return [JSBubbleImageViewFactory bubbleImageViewForType:type style:JSBubbleImageViewStyleClassicSquareGray];
}

- (JSMessagesViewTimestampPolicy)timestampPolicy
{
    return JSMessagesViewTimestampPolicyEveryThree;
}

- (JSMessagesViewAvatarPolicy)avatarPolicy
{
    return JSMessagesViewAvatarPolicyAll;
}

- (JSMessagesViewSubtitlePolicy)subtitlePolicy
{
    return JSMessagesViewSubtitlePolicyAll;
}

#pragma mark - Messages view delegate: OPTIONAL

//  *** Implement to customize cell further
//
//  - (void)configureCell:(JSBubbleMessageCell *)cell atIndexPath:(NSIndexPath *)indexPath
//  {
//      [cell.bubbleView setFont:[UIFont boldSystemFontOfSize:9.0]];
//      [cell.bubbleView setTextColor:[UIColor whiteColor]];
//  }

//  *** Required if using `JSMessagesViewTimestampPolicyCustom`
//
//  - (BOOL)hasTimestampForRowAtIndexPath:(NSIndexPath *)indexPath
//

//  *** Implement to use a custom send button
//
//  The button's frame is set automatically for you
//
- (UIButton *)sendButtonForInputView
{
    return [UIButton js_defaultSendButton_iOS6];
}

//  *** Implement to prevent auto-scrolling when message is added
//
- (BOOL)shouldPreventScrollToBottomWhileUserScrolling
{
    return YES;
}

#pragma mark - Messages view data source: REQUIRED

- (NSString *)textForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FTMessage *m = [messages objectAtIndex: indexPath.row];
    return m.msg;
}

- (NSDate *)timestampForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FTMessage *m = [messages objectAtIndex: indexPath.row];
    return m.date;
}

- (UIImageView *)avatarImageViewForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"mario.png"]];
}

- (NSString *)subtitleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"";
}


@end
