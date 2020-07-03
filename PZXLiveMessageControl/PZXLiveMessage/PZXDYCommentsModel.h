//
//  PZXDYCommentsModel.h
//  PZXLiveMessageControl
//
//  Created by quark123321 on 2020/7/3.
//  Copyright © 2020 pengzuxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger,PZX_MessageType){
    

    RoomMessageTypeText,    //普通聊天消息
    RoomMessageTypeShare,  //分享商品消息
    RoomMessageTypeBuy,  //购买商品消息
    
};

@interface PZXDYCommentsModel : NSObject

@property (nonatomic,assign)PZX_MessageType  msgType;// 消息类型

@property (nonatomic,strong)NSString *fromUserName;      //发送者
@property (nonatomic,copy)NSString *msgText;        //消息内容

@property (nonatomic,strong)NSMutableAttributedString *msgTextAttributContext;//内容富文本,用于计算宽高
@property (nonatomic,strong)NSMutableAttributedString *fromUserNameAttributContext;//发送者富文本，用于计算宽高

@property (nonatomic,assign)CGSize  contextSize;
@property (nonatomic,assign)CGRect  nameRect;


- (instancetype)initWithMsgType:(PZX_MessageType)type;
- (void)creatMessageContext;


@end

NS_ASSUME_NONNULL_END
