//
//  PZXDYCommentsCell.m
//  PZXTestFun
//
//  Created by quark123321 on 2020/7/2.
//  Copyright © 2020 pengzuxin. All rights reserved.
//

#import "PZXDYCommentsCell.h"
#import "PureLayout.h"
@implementation PZXDYCommentsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];

    }
    
    return self;
    
}

-(void)layoutSubviews{
    [self FrameUpdate];
}

-(void)initView{

    self.bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.bottomView.backgroundColor =[UIColor colorWithWhite:0 alpha:0.6];
//    self.bottomView.transform = CGAffineTransformMakeScale(1, -1);
    [self addSubview:self.bottomView];
    
    self.nickNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 8, 60, 16)];
    self.nickNameLabel.textColor = [UIColor yellowColor];
    self.nickNameLabel.text = @"昵称昵称";
    self.nickNameLabel.font = [UIFont systemFontOfSize:12.f];
    [self.bottomView addSubview: self.nickNameLabel];
    [self.nickNameLabel sizeToFit];

    
//    self.contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.nickNameLabel.frame)+8, 8, self.bottomView.frame.size.width - self.nickNameLabel.frame.size.width - 24, self.bottomView.frame.size.height-16)];
    self.contentLabel = [UILabel newAutoLayoutView];
    self.contentLabel.textColor = [UIColor whiteColor];
    self.contentLabel.text = @"内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容";
    CGFloat margin = 8.f;
    self.contentLabel.font = [UIFont systemFontOfSize:12.f];
    self.contentLabel.numberOfLines = 0;
    [self.bottomView addSubview: self.contentLabel];
    
    
    self.tipImageView = [[UIImageView alloc]init];
    self.tipImageView.backgroundColor = [UIColor redColor];
    [self.bottomView addSubview: self.tipImageView];

    
    [self.contentLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.nickNameLabel withOffset:margin];
    [self.contentLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:margin];
    [self.contentLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:margin];
    [self.contentLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.tipImageView withOffset:-margin];

    
}
-(void)FrameUpdate{
    
    CGFloat tipWH = 16.f;
    tipWH = 0;
    self.bottomView.frame = CGRectMake(0, 8, self.frame.size.width, self.frame.size.height-16);
    self.bottomView.layer.cornerRadius = self.bottomView.frame.size.height/2;
    self.nickNameLabel.frame = CGRectMake(12, 8, 0, 16);
    [self.nickNameLabel sizeToFit];
    self.tipImageView.frame = CGRectMake(self.bottomView.frame.size.width - tipWH - 8, (self.bottomView.frame.size.height - tipWH)/2, tipWH, tipWH);
    

}







@end
