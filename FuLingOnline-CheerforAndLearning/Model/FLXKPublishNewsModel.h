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
@property(nonatomic,assign)NSInteger id;//source_id
@property(nonatomic,assign)NSInteger type_id;//Home explore community
@property(nonatomic,strong)NSString* type_name;
@property(nonatomic,assign)NSInteger sub_type_id;//cell header
@property(nonatomic,strong)NSString* sub_type_name;


/**
 *  发布时间
 */
@property (nonatomic) NSDate *ptime;


/**
 *  标题
 */
@property (nonatomic) NSString *title;


/**
 *  具体描述
 */
@property (nonatomic) NSString *subtitle;
@property (nonatomic) NSString *detail_url;



/**
 *  新闻
 */
@property (nonatomic) NSString *doc_id;
@property (nonatomic) NSString *is_topic;
@property (nonatomic) NSString *doc_content;
@property (nonatomic) NSString *doc_url;
@property (nonatomic,assign)NSInteger has_image;
@property (nonatomic,assign)NSInteger has_head;
@property (nonatomic,assign)NSInteger has_video;
@property (nonatomic) NSString *video_id;

@property (nonatomic,assign)NSInteger *hasAD;

@property (nonatomic,assign)NSInteger *priority;

/**
 *  图片类型
 */
@property (nonatomic,assign)NSInteger *image_type;


/**
 *  图片链接
 */
@property (nonatomic) NSString *image_url;
@property (nonatomic) NSString *head_url;
//@property (nonatomic) NSArray<NSString *>* image_urls;
@property (nonatomic)NSString * image_urls;
@property (nonatomic,assign)NSInteger order;


/**
 *  视频链接
 */
@property (nonatomic) NSString *video_url;


/**
 *  作者
 */
@property (nonatomic,strong)NSString *editor;


/**
 *  跟帖人数
 */
@property (nonatomic,assign)NSInteger replyCount;
@property (nonatomic,assign)NSInteger thumbsupCount;
@property (nonatomic) NSString *commentid;


@end