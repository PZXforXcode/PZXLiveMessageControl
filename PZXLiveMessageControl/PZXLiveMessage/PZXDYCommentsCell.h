//
//  PZXDYCommentsCell.h
//  PZXTestFun
//
//  Created by quark123321 on 2020/7/2.
//  Copyright © 2020 pengzuxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PZXDYCommentsModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface PZXDYCommentsCell : UITableViewCell


@property (nonatomic,strong)PZXDYCommentsModel *message;


@property(nonatomic,strong)UIView *bottomView;
@property(nonatomic,strong)UILabel *nickNameLabel;
@property(nonatomic,strong)UILabel *contentLabel;
@property(nonatomic,strong)UIImageView *tipImageView;



@end

NS_ASSUME_NONNULL_END
