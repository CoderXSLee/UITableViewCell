/**************************************************************
 文件名称：MCCommentCell.h
 作   者：李雪松
 备   注：
 创建时间：15/5/21.
 修改历史：
 版权信息：  Copyright (c) 2015年 Beijing Mooc Technology Center ltd. All rights reserved.
***************************************************************/

#import <UIKit/UIKit.h>
@class MCCommentCell;
@protocol MCCommentDelegate <NSObject>

- (void)commentOpenButtonClick:(MCCommentCell *)currentCell;
- (void)userIconClick:(MCCommentCell *)cell;

@end
@interface MCCommentCell : UITableViewCell

@property (nonatomic, weak) id <MCCommentDelegate> delegate;

@property (strong, nonatomic) id cellData;
 /**
 *  用户头像
 */
@property (strong, nonatomic) UIImageView *userIcon;
/**
 *  用户昵称
 */
@property (strong, nonatomic) UILabel *nameLabel;
/**
 *  评论日期
 */
@property (strong, nonatomic) UILabel *commentDateLabel;
/**
 *  评论内容
 */
@property (strong, nonatomic) UILabel *commentDetail;
/**
 *  分割线
 */
@property (strong, nonatomic) UIView *splitLine;

@end
