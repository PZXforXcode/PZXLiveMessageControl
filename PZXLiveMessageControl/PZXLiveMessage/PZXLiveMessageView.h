//
//  PZXLiveMessageView.h
//  PZXLiveMessageControl
//
//  Created by quark123321 on 2020/7/3.
//  Copyright © 2020 pengzuxin. All rights reserved.
//
#define MessageMaxWidth 280
#define MessageMaxHeight 148
#import <UIKit/UIKit.h>
#import "PZXDYCommentsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PZXLiveMessageView : UIView

@property (nonatomic,strong)UITableView *msgTableView;



//获取字典消息数据
- (void)reciveOrigiMsg:(NSDictionary* )msgDic;
//获取多个字典消息数据
- (void)reciveOrigiMsgs:(NSArray<NSDictionary*>*)msgDics;
- (void)clearMessageData;   //清理消息内容
//获取model消息数据
- (void)reciveMessage:(PZXDYCommentsModel* )msg;
//获取多个model消息数据
- (void)reciveMessages:(NSArray<PZXDYCommentsModel *>*)msgs;
//刷新列表
- (void)reloadMsgList;
@end

NS_ASSUME_NONNULL_END
