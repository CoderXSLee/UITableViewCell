/**************************************************************
 文件名称：MCCommentCell.m
 作   者：李雪松
 备   注：
 创建时间：15/5/21.
 修改历史：
 版权信息：  Copyright (c) 2015年 Beijing ‘ Technology Center ltd. All rights reserved.
***************************************************************/

#import "MCCommentCell.h"
#import "MCCommnetModel.h"

@interface MCCommentCell ()
{
    UIButton *_btn;
    CGSize _commentDetailSize;
}

@end

@implementation MCCommentCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
   
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        // 0. 设置cell的背景以及选时中背景颜色
        self.backgroundColor  = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // 1. 设置cell的子控件
        [self setSubViews];
        
        // 2. 设置cell子控件的属性样式
        [self setSubViewsOfStyle];
        
        // 2. 设置cell内部子控件的约束
        [self setAllConstraints];
        
    }
    return self;
}

// 设置cell的子控件
- (void)setSubViews {
    
    _userIcon = [[UIImageView alloc] init]; // 用户头像
    [self.contentView addSubview:_userIcon];
    
    _nameLabel = [[UILabel alloc] init];    // 用户昵称
    [self.contentView addSubview:_nameLabel];
    
    _commentDateLabel = [[UILabel alloc] init]; // 评论日期
    [self.contentView addSubview:_commentDateLabel];
    
    _commentDetail = [[UILabel alloc] init];    // 评论内容
    [self.contentView addSubview:_commentDetail];
    
    _btn = [[UIButton alloc] init];         // 展开按钮
    [self.contentView addSubview:_btn];
    
    _splitLine = [[UIView alloc] init];       // cell 分割线
    [self.contentView addSubview:_splitLine];
}

// 设置cell内部的数据
- (void)setCellData:(id)cellData {
    
    // 0. 获取模型的数据
    MCCommnetModel *model = cellData;
    
    // 1. 设置cell的数据
    UIImage *imageName = [UIImage imageNamed:model.pic];
//    [self.userIcon sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:imageName];
    [self.userIcon setImage:imageName];
    
    self.nameLabel.text = model.nickName;
    self.commentDateLabel.text = model.publishTime;
    self.commentDetail.text = model.content;
    _commentDetail.numberOfLines = model.isOpenAllCommentDetail ? 0 : 3;
    [_btn setTitle:model.isOpenAllCommentDetail ? @"收起" : @"展开" forState:UIControlStateNormal];
    
    // 2. 更改cell的样式、超过评论内容超过 3 行，显示展开按钮
    [self changeCellStyle];
}

- (void)changeCellStyle {
    
    // 1. 计算cell数据内容的大小以及尺寸
    CGSize size = [_commentDetail.text sizeWithFont:_commentDetail.font constrainedToSize:CGSizeMake(APP_CONTENT_WIDTH-75, 999)lineBreakMode:NSLineBreakByWordWrapping];
    
    _commentDetailSize.width = ceilf(size.width);
    _commentDetailSize.height = ceilf(size.height);
    
    if ( _commentDetailSize.height > 51) {
        
        // 评论内容超过 3 行 ，显示 展开按钮
        _btn.hidden = NO;
        
        // 添加展开按钮，并更新评论详情内容的约束
        [self setButtomConstraints];

        
    }else {
        
        // 评论内容未超过 3 行 ，不需要显示 展开按钮
        _btn.hidden = YES;
        
    /*          // 这里不能使用 update 来更新它的约束，会造成后台系统警告，所以重新制定约束
        // 更新评论框的约束
        [_commentDetail mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(_commentDetailSize.height));
            make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-15);
        }];
     */
        
        // 重新设置约束
        [_commentDetail mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_nameLabel.mas_bottom).with.offset(15);
            make.left.equalTo(_nameLabel.mas_left);
            make.right.equalTo(_commentDateLabel.mas_right);
            make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-15);
        }];
    }
}

#pragma mark 设置cell子控件的属性样式
- (void)setSubViewsOfStyle {
    
    _userIcon.userInteractionEnabled = YES;
    [_userIcon setUserInteractionEnabled:YES];
    [_userIcon addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headeImageViewClick)]];
    
    _nameLabel.font = [UIFont systemFontOfSize:14]; // 14px
    _nameLabel.textColor = UIColorFromSameRGB(153);
    _commentDateLabel.font = _nameLabel.font;
    _commentDateLabel.textColor = _nameLabel.textColor;
    _commentDateLabel.textAlignment = NSTextAlignmentRight;
    _commentDetail.numberOfLines = 3;
    _commentDetail.font = [UIFont systemFontOfSize:14];  // 字体 14
    _commentDetail.textColor = UIColorFromSameRGB(51);  // RGB 51
    _btn.backgroundColor = [UIColor whiteColor];
    _btn.titleLabel.font = [UIFont systemFontOfSize:12];  // 字体 12
    [_btn setTitleColor:UIColorFromSameRGB(51) forState:UIControlStateNormal];  // RGB 153
    _btn.layer.borderWidth = 0.5f;
    _btn.layer.borderColor = [UIColorFromSameRGB(153) CGColor];  // RGB 153
    _btn.layer.cornerRadius = 2;
    _btn.clipsToBounds = YES;
    [_btn addTarget:self action:@selector(openCommentDetail:) forControlEvents:UIControlEventTouchUpInside];
    _splitLine.backgroundColor = UIColorFromSameRGB(218);
    
    // 参照最大值
    CGFloat preferredWidth = APP_CONTENT_WIDTH - 75;
    _nameLabel.preferredMaxLayoutWidth = preferredWidth;
    _commentDetail.preferredMaxLayoutWidth = preferredWidth;

}
#pragma mark - 设置约束
#pragma mark 设置subViews的约束
- (void)setAllConstraints {
    
    _userIcon.backgroundColor = [UIColor greenColor];
    _nameLabel.backgroundColor = [UIColor greenColor];
    _commentDateLabel.backgroundColor = [UIColor redColor];
    _btn.backgroundColor = [UIColor yellowColor];
    _commentDetail.backgroundColor = [UIColor yellowColor];
    _splitLine.backgroundColor = [UIColor redColor];
    
    // 添加用户头像的约束
    [_userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@30);
        _userIcon.layer.cornerRadius = 15;
        _userIcon.clipsToBounds = YES;
        make.top.left.equalTo(self.contentView).with.offset(15);
    }];
    
    // 添加用户名称的约束
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(25).with.priority(751);
        make.left.equalTo(_userIcon.mas_right).with.offset(15);
        make.right.equalTo(_commentDateLabel.mas_left).with.offset(-10);
        make.height.equalTo(@14);
    }];
    
    // 添加评论日期的约束
    [_commentDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLabel.mas_top);
        make.width.equalTo(@80);
        make.right.equalTo(self.contentView.mas_right).with.offset(-15);
        make.height.equalTo(_nameLabel.mas_height);
    }];
    
    // 添加评论内容的约束
    [_commentDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLabel.mas_bottom).with.offset(15);
        make.left.equalTo(_nameLabel.mas_left);
        make.right.equalTo(_commentDateLabel.mas_right);
//        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-15);
        make.height.equalTo(@51);
    }];
    
    // 添加分割线的约束
    [_splitLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(15);
        make.right.equalTo(_commentDateLabel.mas_right);
        make.height.equalTo(@.5);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
}
#pragma mark 设置展开按钮的约束
- (void)setButtomConstraints {
    
    [_btn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_commentDetail.mas_right);  // x
        make.width.equalTo(@39);                       // W
        make.height.equalTo(@18);                       // H
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-15);   // y
    }];
    
    [_commentDetail mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLabel.mas_bottom).with.offset(15);
        make.left.equalTo(_nameLabel.mas_left);
        make.right.equalTo(_commentDateLabel.mas_right);
        make.bottom.equalTo(_btn.mas_top).with.offset(-15);
    }];
}

#pragma mark 展开评论按钮
- (void)openCommentDetail:(UIButton *)sender {

    if ([_delegate respondsToSelector:@selector(commentOpenButtonClick:)]) {
        
        if ([_btn.titleLabel.text isEqualToString:@"展开"]) {
            [_btn setTitle:@"收起" forState:UIControlStateNormal];
        }else {
            [_btn setTitle:@"展开" forState:UIControlStateNormal];
        }
        
        [_delegate commentOpenButtonClick:self];
    }

}

#pragma mark 头像的点击事件
-(void)headeImageViewClick
{
    if([_delegate respondsToSelector:@selector(userIconClick:)]) {
        [_delegate userIconClick:self];
    }
}




@end
