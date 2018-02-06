//
//  ModelHomeHeaderView.h
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 16/11/24.
//  Copyright © 2016年 com.FuLing. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ModelHomeHeaderView : NSObject

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


//+ (instancetype)newsModelWithDict:(NSDictionary *)dict;
@end

































@interface SXNewsEntity : NSObject

@property (nonatomic,copy) NSString *tname;
/**
 *  新闻发布时间
 */
@property (nonatomic,copy) NSString *ptime;
/**
 *  标题
 */
@property (nonatomic,copy) NSString *title;
/**
 *  多图数组
 */
@property (nonatomic,strong)NSArray *imgextra;
@property (nonatomic,copy) NSString *photosetID;
@property (nonatomic,copy)NSNumber *hasHead;
@property (nonatomic,copy)NSNumber *hasImg;
@property (nonatomic,copy) NSString *lmodify;
@property (nonatomic,copy) NSString *template;
@property (nonatomic,copy) NSString *skipType;
/**
 *  跟帖人数
 */
@property (nonatomic,copy)NSNumber *replyCount;
@property (nonatomic,copy)NSNumber *votecount;
@property (nonatomic,copy)NSNumber *voteCount;

@property (nonatomic,copy) NSString *alias;
/**
 *  新闻ID
 */
@property (nonatomic,copy) NSString *docid;
@property (nonatomic,assign)BOOL hasCover;
@property (nonatomic,copy)NSNumber *hasAD;
@property (nonatomic,copy)NSNumber *priority;
@property (nonatomic,copy) NSString *cid;
@property (nonatomic,strong)NSArray *videoID;
/**
 *  图片连接
 */
@property (nonatomic,copy) NSString *imgsrc;
@property (nonatomic,assign)BOOL hasIcon;
@property (nonatomic,copy) NSString *ename;
@property (nonatomic,copy) NSString *skipID;
@property (nonatomic,copy)NSNumber *order;
/**
 *  描述
 */
@property (nonatomic,copy) NSString *digest;

@property (nonatomic,strong)NSArray *editor;


@property (nonatomic,copy) NSString *url_3w;
@property (nonatomic,copy) NSString *specialID;
@property (nonatomic,copy) NSString *timeConsuming;
@property (nonatomic,copy) NSString *subtitle;
@property (nonatomic,copy) NSString *adTitle;
@property (nonatomic,copy) NSString *url;
@property (nonatomic,copy) NSString *source;


@property (nonatomic,copy) NSString *TAGS;
@property (nonatomic,copy) NSString *TAG;
/**
 *  大图样式
 */
@property (nonatomic,copy)NSNumber *imgType;
@property (nonatomic,strong)NSArray *specialextra;


@property (nonatomic,copy) NSString *boardid;
@property (nonatomic,copy) NSString *commentid;
@property (nonatomic,copy)NSNumber *speciallogo;
@property (nonatomic,copy) NSString *specialtip;
@property (nonatomic,copy) NSString *specialadlogo;

@property (nonatomic,copy) NSString *pixel;
@property (nonatomic,strong)NSArray *applist;

@property (nonatomic,copy) NSString *wap_portal;
@property (nonatomic,copy) NSString *live_info;
@property (nonatomic,copy) NSString *ads;
@property (nonatomic,copy) NSString *videosource;

+ (instancetype)newsModelWithDict:(NSDictionary *)dict;

@end