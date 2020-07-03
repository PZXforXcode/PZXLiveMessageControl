//
//  PZXLiveMessageView.m
//  PZXLiveMessageControl
//
//  Created by quark123321 on 2020/7/3.
//  Copyright © 2020 pengzuxin. All rights reserved.
//

#import "PZXLiveMessageView.h"
#import "PZXDYCommentsCell.h"


@interface PZXLiveMessageView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)NSMutableArray *msgDataArray;

//线程，赞不知道用处
@property (nonatomic,strong) dispatch_queue_t queue;


@end

@implementation PZXLiveMessageView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self initUI];
        self.transform = CGAffineTransformMakeScale(1, -1);
    }
    return self;
}

#pragma mark - 初始化tableView
- (void)initUI{
    _msgDataArray = [[NSMutableArray alloc]init];
    //暂时不知道用处
    _queue = dispatch_queue_create("RWLock", DISPATCH_QUEUE_CONCURRENT);
    CGRect rect = CGRectMake(0, 0, MessageMaxWidth, MessageMaxHeight);
    _msgTableView = [[UITableView alloc]initWithFrame:rect style:UITableViewStylePlain];
    _msgTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _msgTableView.backgroundColor = [UIColor clearColor];
//    _msgTableView.contentInset = UIEdgeInsetsMake(-30, 0, 0, 0);//top, left, bottom, right
    _msgTableView.delegate = self;
    _msgTableView.dataSource = self;
    _msgTableView.showsVerticalScrollIndicator = NO;
    [self addSubview:_msgTableView];
    [_msgTableView registerClass:[PZXDYCommentsCell class] forCellReuseIdentifier:@"PZXDYCommentsCell"];
    _msgTableView.estimatedRowHeight = 0;
    _msgTableView.estimatedSectionFooterHeight = 0;
    _msgTableView.estimatedSectionHeaderHeight = 0;
    _msgTableView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
}
#pragma mark - 公用方法
- (void)reciveOrigiMsg:(NSDictionary* )messageDic {
    [self reciveOrigiMsgs:@[messageDic]];
}
- (void)reciveOrigiMsgs:(NSArray<NSDictionary *> *)msgDics{
    NSMutableArray *arry = [NSMutableArray array];
    [msgDics enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull messageDic, NSUInteger idx, BOOL * _Nonnull stop) {
        #warning //此位置根据后端数据做调整
        NSString *msgType = [NSString stringWithFormat:@"%@",[messageDic valueForKey:@"type"]];
         if ([msgType isEqualToString:@"TEXT"]) {
             PZXDYCommentsModel *msg = [[PZXDYCommentsModel alloc]init];
             msg.msgText = [[messageDic valueForKey:@"content"] valueForKey:@"text"];
             msg.fromUserName = [[messageDic valueForKey:@"operator"] valueForKey:@"chatNickName"]; //nickName
             msg.msgType = RoomMessageTypeText;
             [arry addObject:msg];
         }
    }];
    [self reciveMessages:arry];
}

- (void)reciveMessage:(PZXDYCommentsModel *)msg{
    if (!msg) {
        return;
    }
    [self reciveMessages:@[msg]];
}

- (void)reciveMessages:(NSArray<PZXDYCommentsModel *> *)msgs{
    if (!msgs.count) {
        return;
    }
    [msgs enumerateObjectsUsingBlock:^(PZXDYCommentsModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj creatMessageContext];
        //添加数据到数组
        dispatch_barrier_sync(_queue, ^{
            [self.msgDataArray insertObject:obj atIndex:0];
        });
    }];

    NSMutableArray *indexpathAry = [NSMutableArray array];
    for (int i = 0; i < msgs.count; i ++ ) {
        NSIndexPath * indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        [indexpathAry addObject:indexPath];
    }
    [self.msgTableView insertRowsAtIndexPaths:indexpathAry withRowAnimation:UITableViewRowAnimationTop];
}

- (void)clearMessageData{
    [self.msgDataArray removeAllObjects];
    [self.msgTableView reloadData];
}

- (void)reloadMsgList{
    [_msgTableView reloadData];
}

#pragma mark - TableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.msgDataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    __block PZXDYCommentsModel *msg;
     dispatch_sync(_queue, ^{
         msg = self.msgDataArray[indexPath.row];
     });
    CGFloat 黑色框上下间距 =16;
    CGFloat 文字上下间距 =16;

     return msg.contextSize.height + 黑色框上下间距+文字上下间距;//16是上下间距8
//    return 50;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    PZXDYCommentsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PZXDYCommentsCell" forIndexPath:indexPath];
    __block PZXDYCommentsModel *msg;
       dispatch_sync(_queue, ^{
           msg = self.msgDataArray[indexPath.row];
       });
//    cell.message = msg;
    cell.contentLabel.text = msg.msgText;
    cell.nickNameLabel.text = msg.fromUserName;
    cell.transform = CGAffineTransformMakeScale(1, -1);
    return cell;
    
}


@end
