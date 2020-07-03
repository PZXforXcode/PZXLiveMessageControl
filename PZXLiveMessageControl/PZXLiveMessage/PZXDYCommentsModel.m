//
//  PZXDYCommentsModel.m
//  PZXLiveMessageControl
//
//  Created by quark123321 on 2020/7/3.
//  Copyright © 2020 pengzuxin. All rights reserved.
//

#import "PZXDYCommentsModel.h"
#import "PZXLiveMessageView.h"



@implementation PZXDYCommentsModel

- (instancetype)initWithMsgType:(PZX_MessageType)type{
    if (self = [super init]) {
        _msgType = type;
    }
    return self;
}

- (void)creatMessageContext{
    
    switch (_msgType) {

        case RoomMessageTypeText:
            [self creatChatTextMessage];
            break;
        case RoomMessageTypeShare:
            [self creatChatShareMessage];
            break;
        case RoomMessageTypeBuy:
            [self creatChatBuyMessage];
            break;

        default:
            break;
    }
    [self creatContextSize];

}

- (void)creatChatTextMessage{

    NSMutableAttributedString *aString = [[NSMutableAttributedString alloc]initWithString:self.msgText];
    [aString addAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:12]} range:NSMakeRange(0, aString.length)];
    
    NSMutableAttributedString *bString = [[NSMutableAttributedString alloc]initWithString:self.fromUserName];
    [bString addAttributes:@{NSForegroundColorAttributeName:[UIColor yellowColor],NSFontAttributeName:[UIFont systemFontOfSize:12]} range:NSMakeRange(0, bString.length)];
    
    self.msgTextAttributContext = aString;
    self.fromUserNameAttributContext = bString;

}
- (void)creatChatShareMessage{

}
- (void)creatChatBuyMessage{

}

- (void)creatContextSize{
    CGSize size;

    CGSize nameSize =  [self.fromUserNameAttributContext boundingRectWithSize:CGSizeZero options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin  context:nil].size;
    CGFloat 昵称左间距 =  12;
    CGFloat 昵称右间距 =  8;
    CGFloat 内容右间距 =  8;
    CGFloat 图片右间距 =  8;
    CGFloat 总间距 = 昵称左间距 + 昵称右间距 + 内容右间距 +图片右间距;
    CGFloat 小图标宽 =  16;

        size = [self.msgTextAttributContext boundingRectWithSize:CGSizeMake(MessageMaxWidth - ceil(nameSize.width) -总间距 -小图标宽, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin context:nil].size;


    self.contextSize = CGSizeMake(ceil(size.width), ceil(size.height));

    
}
@end
