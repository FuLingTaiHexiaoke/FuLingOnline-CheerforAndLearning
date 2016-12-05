//
//  FLXKPublishNewsModel.h
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 16/12/5.
//  Copyright © 2016年 com.FuLing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLXKPublishNewsModel : NSObject


/**
 *  基本信息区分
 */
@property(nonatomic,copy)NSNumber* id;//source_id
@property(nonatomic,copy)NSNumber* type_id;//Home explore community
@property(nonatomic,strong)NSString* type_name;
@property(nonatomic,copy)NSNumber* sub_type_id;//cell header
@property(nonatomic,strong)NSString* sub_type_name;


/**
 *  发布时间
 */
@property (nonatomic,copy) NSString *ptime;


/**
 *  标题
 */
@property (nonatomic,copy) NSString *title;


/**
 *  具体描述
 */
@property (nonatomic,copy) NSString *subtitle;
@property (nonatomic,copy) NSString *detail_url;



/**
 *  新闻
 */
@property (nonatomic,copy) NSString *doc_id;
@property (nonatomic,copy) NSString *is_topic;
@property (nonatomic,copy) NSString *doc_url;
//@property (nonatomic,assign)BOOL has_image;
@property (nonatomic,assign)NSNumber* has_image;
@property (nonatomic,copy)NSNumber *has_head;
//@property (nonatomic,assign)BOOL has_video;
@property (nonatomic,assign)NSNumber * has_video;
@property (nonatomic,copy) NSString *video_id;

@property (nonatomic,copy)NSNumber *hasAD;

@property (nonatomic,copy)NSNumber *priority;

/**
 *  图片类型
 */
@property (nonatomic,copy)NSNumber *image_type;


/**
 *  图片链接
 */
@property (nonatomic,copy) NSString *image_url;
@property (nonatomic,copy) NSString *head_url;
//@property (nonatomic,copy) NSArray<NSString *>* image_urls;
@property (nonatomic,copy)NSString * image_urls;
@property (nonatomic,copy)NSNumber *order;


/**
 *  视频链接
 */
@property (nonatomic,copy) NSString *video_url;


/**
 *  作者
 */
@property (nonatomic,strong)NSArray *editor;


/**
 *  跟帖人数
 */
@property (nonatomic,copy)NSNumber *replyCount;
@property (nonatomic,copy)NSNumber *votecount;
@property (nonatomic,copy) NSString *commentid;


@end
