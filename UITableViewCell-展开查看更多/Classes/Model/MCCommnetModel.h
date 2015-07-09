/**************************************************************
 文件名称：MCCommnetModel.h
 作   者：李雪松
 备   注：
 创建时间：15/5/22.
 修改历史：
 版权信息：  Copyright (c) 2015年 Beijing Mooc Technology Center ltd. All rights reserved.
***************************************************************/

#import <Foundation/Foundation.h>
#import "Common.h"

@interface MCCommnetModel : NSObject
/**
 *  用户的ID
 */
@property (nonatomic, assign) long uid;
/**
 *  用户的昵称
 */
@property (nonatomic, strong) NSString *nickName;
/**
 *  用户头像的 URL
 */
@property (nonatomic, strong) NSString *pic;
/**
 *  评论内容
 */
@property (strong, nonatomic) NSString *content;
/** 
 *  评论的ID
 */
//@property (nonatomic, assign) MCLong Id;
/**
 *  评论日期
 */
@property (nonatomic, strong) NSString *publishTime;
/**
 *  评论数 (时时更新) 需要返回
 */
@property (nonatomic, assign) long commentnum;

/**
 *  展开还是关闭 （YES numberOfLine 为0,  NO numberOfLine 为 3 ）
 *  此为本地，非网络获取的值，用来保存  commnentDetail 这个 Label 的行数  
 */
@property (nonatomic, assign) BOOL isOpenAllCommentDetail;


@end
