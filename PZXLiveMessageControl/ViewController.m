//
//  ViewController.m
//  PZXLiveMessageControl
//
//  Created by quark123321 on 2020/7/3.
//  Copyright © 2020 pengzuxin. All rights reserved.
//

#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#import "ViewController.h"
#import "PZXLiveMessageView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    PZXLiveMessageView *liveMsgView = [[PZXLiveMessageView alloc] initWithFrame:CGRectMake(12, SCREEN_HEIGHT - MessageMaxHeight -39, MessageMaxWidth, MessageMaxHeight)];
    [self.view addSubview:liveMsgView];
    
    PZXDYCommentsModel *msg = [[PZXDYCommentsModel alloc]init];
    msg.msgType = RoomMessageTypeText;
    msg.fromUserName = @"樊贷哥";
    msg.msgText = @"今晚有吗？？？？？？";
    [liveMsgView reciveMessage:msg];
    [self MockAddDataWithView:liveMsgView];
    
}

-(void)MockAddDataWithView:(PZXLiveMessageView *)liveMsgView{
    
    
    NSTimer *time = [NSTimer scheduledTimerWithTimeInterval:2.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        PZXDYCommentsModel *msg = [[PZXDYCommentsModel alloc]init];
             msg.msgType = RoomMessageTypeText;
             msg.fromUserName = @"AmazingXS";
             msg.msgText = @"有你吗哦，总是嘴嗨，自己又不来？就喜欢带节奏？";
             [liveMsgView reciveMessage:msg];
    }];
    

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(20 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [time invalidate];
    });
    
}


@end
