# PZXLiveMessageControl
直播评论弹幕控件


![image](https://github.com/PZXforXcode/PZXLiveMessageControl/blob/master/弹幕.gif)

     
//使用方法
导入PZXLiveMessage文件夹 和 PureLayout文件夹（用于布局，如果自己有其他布局方式可以不要PureLayout）
PZXDYCommentsCell.m59行用到了PureLayout autolayout布局 可以替换成自己的
```
    [self.contentLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.nickNameLabel withOffset:margin];
    [self.contentLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:margin];
    [self.contentLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:margin];
    [self.contentLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.tipImageView withOffset:-margin];
```
```
#import "PZXLiveMessageView.h"

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
```
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
```
    
//具体见demo
 
