//
//  FLXKSharingCellModel.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/3/29.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import "FLXKSharingCellModel.h"

//models
#import "SharingCommentCellModel.h"
#import "FLXKSharingImagesModel.h"

#import "FriendsMomentSharingConfig.h"

//#import "MLLabel.h"

#import "NSAttributedString+EmotionExtension.h"

@implementation FLXKSharingCellModel

-(CGFloat)default_mainSharingContent_Height{
    return CONTENT_LABEL_DEFAULT_HEIGHT;
}

-(void)setMainSharingContent:(NSString *)mainSharingContent{
    _mainSharingContent=mainSharingContent;
    if (mainSharingContent.length>0) {
        _shouldShowMainSharingContent=YES;
        
        CGFloat height;
        UILabel* label=[[UILabel alloc]init];
        label.numberOfLines=0;
        label.font = [UIFont systemFontOfSize:CONTENT_LABEL_FONT_SIZE];
        label.attributedText=[NSAttributedString attributedStringWithPlainString:mainSharingContent];
        height = [label sizeThatFits:SIZE_FOR_TEXT_GET_HEIGHT].height;
        _mainSharingContent_Height=height;
        if (height>_default_mainSharingContent_Height) {
            _shouldShowSharingContentShowAllButton=YES;
            _showContentButton_Height = [self getButtonHeightWithTitle:@"展开" font:[UIFont systemFontOfSize:CONTENT_LABEL_FONT_SIZE]];
        }
        else{
            _showContentButton_Height = 0 ;
        }
    }
}

-(void)setSharingImages:(NSArray<FLXKSharingImagesModel *> *)sharingImages{
    _sharingImages=sharingImages;
    if (sharingImages.count>0) {
        _shouldShowSharingImages=YES;
        
        //get height
        CGFloat height;
        CGFloat width;
        NSInteger count= sharingImages.count;
        switch (count) {
            case 0:{
                width=0;
                height=0;
                break;
            }
            case 1:{
                FLXKSharingImagesModel *  obj = sharingImages[0];
                width= obj.thumberImageWidth;
                height= obj.thumberImageHeight;
                break;
            }
            case 2:
            case 3:
                width=IMAGES_DEFAULT_WIDTH*count;
                height=IMAGES_DEFAULT_HEIGHT*ceil(count/3.0);
                break;
            case 4:
                width=IMAGES_DEFAULT_WIDTH*2;
                height=IMAGES_DEFAULT_HEIGHT*ceil(count/3.0);
                break;
            case 5:
            case 6:
            case 7:
            case 8:
            case 9:
                width=IMAGES_DEFAULT_WIDTH*3;
                height=IMAGES_DEFAULT_HEIGHT*ceil(count/3.0);
                break;
            default:
                width=IMAGES_DEFAULT_WIDTH;
                height=IMAGES_DEFAULT_HEIGHT;
                break;
        }
        if(count>1){
            width-=IMAGES_DEFAULT_SPACE;
            height-=IMAGES_DEFAULT_SPACE;
        }
        _sharingImages_Height=height;
        _sharingImages_Width=width;
    }
}


-(void)setLocationRecord:(NSString *)locationRecord{
    if ([locationRecord isEqualToString:@"显示位置"]||isEmptyString(locationRecord )) {
        
    }
    else{
        _shouldShowLocationRecord=YES;
        _locationRecord_Height = [self getButtonHeightWithTitle:locationRecord font:[UIFont systemFontOfSize:LOCATION_BUTTON_FONT_SIZE]];
        
    }
}

-(CGFloat)sharingMainOperationsContainerView_Height{
    return sharingMainOperationsContainerViewHeight;
}

-(CGFloat)likeTheSharingUserRecords_Height{
    return likeTheSharingRecordScrollViewHeight;
}

-(CGFloat)bottomSeparatorLineView_Height{
    return bottomSeparatorLineViewHeight;
}

-(void)setSharingComments:(NSMutableArray<SharingCommentCellModel *> *)sharingComments{
    _sharingComments=sharingComments;
    if (sharingComments.count>0) {
        _shouldShow_sharingComments=YES;
        
        __block CGFloat height;
        UILabel* label=[[UILabel alloc]init];
        label.numberOfLines=0;
        label.font = [UIFont systemFontOfSize:COMMENT_CELL_LABEL_FONT_SIZE];
        
        [sharingComments enumerateObjectsUsingBlock:^(SharingCommentCellModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            label.attributedText=[SharingCommentCellModel getCommentString:obj];
            height+=  [label sizeThatFits:SIZE_FOR_TEXT_GET_HEIGHT].height;
        }];
        _sharingComments_Height=height;
    }
}

-(CGFloat)headerSection_Height{
    return avatarImageViewHeight;
}

-(CGFloat)cell_Height{
//    CGFloat height;
//    height+=_headerSection_Height>0?(_headerSection_Height+DEFAULT_VIEW_SPACING):0;
//    if (_isMainSharingContentLabelExpand) {
//        height+=_mainSharingContent_Height>0?(_mainSharingContent_Height+DEFAULT_VIEW_SPACING):0;
//    }
//    else if (_mainSharingContent_Height>_default_mainSharingContent_Height){
//        height+=_default_mainSharingContent_Height>0?(_default_mainSharingContent_Height+DEFAULT_VIEW_SPACING):0;
//    }
//    else{
//        height+=_mainSharingContent_Height>0?(_mainSharingContent_Height+DEFAULT_VIEW_SPACING):0;
//    }
//    
//    height+=_showContentButton_Height>0?(_showContentButton_Height+DEFAULT_VIEW_SPACING):0;
//    height+=_sharingImages_Height>0?(_sharingImages_Height+DEFAULT_VIEW_SPACING):0;
//    height+=_locationRecord_Height>0?(_locationRecord_Height+DEFAULT_VIEW_SPACING):0;
//    height+=self.sharingMainOperationsContainerView_Height>0?(self.sharingMainOperationsContainerView_Height+DEFAULT_VIEW_SPACING):0;
//    height+=_likeTheSharingUserRecords_Height>0?(_likeTheSharingUserRecords_Height+DEFAULT_VIEW_SPACING):0;
//    height+=_bottomSeparatorLineView_Height>0?(_bottomSeparatorLineView_Height+DEFAULT_VIEW_SPACING):0;
//    height+=_sharingComments_Height>0?(_sharingComments_Height+DEFAULT_VIEW_SPACING):0;
//    
//    return height;
    CGFloat height;
    height+=self.headerSection_Height>0?(self.headerSection_Height+DEFAULT_VIEW_SPACING):0;
    if (self.isMainSharingContentLabelExpand) {
        height+=self.mainSharingContent_Height>0?(self.mainSharingContent_Height+DEFAULT_VIEW_SPACING):0;
    }
    else if (self.mainSharingContent_Height>_default_mainSharingContent_Height){
        height+=self.default_mainSharingContent_Height>0?(self.default_mainSharingContent_Height+DEFAULT_VIEW_SPACING):0;
    }
    else{
        height+=self.mainSharingContent_Height>0?(self.mainSharingContent_Height+DEFAULT_VIEW_SPACING):0;
    }
    
    height+=self.showContentButton_Height>0?(self.showContentButton_Height+DEFAULT_VIEW_SPACING):0;
    height+=self.sharingImages_Height>0?(self.sharingImages_Height+DEFAULT_VIEW_SPACING):0;
    height+=self.locationRecord_Height>0?(self.locationRecord_Height+DEFAULT_VIEW_SPACING):0;
    height+=self.sharingMainOperationsContainerView_Height>0?(self.sharingMainOperationsContainerView_Height+DEFAULT_VIEW_SPACING):0;
    height+=self.likeTheSharingUserRecords_Height>0?(self.likeTheSharingUserRecords_Height+DEFAULT_VIEW_SPACING):0;
    height+=self.bottomSeparatorLineView_Height>0?(self.bottomSeparatorLineView_Height+DEFAULT_VIEW_SPACING):0;
    height+=self.sharingComments_Height>0?(self.sharingComments_Height+DEFAULT_VIEW_SPACING):0;
    
    return height;
}

-(CGFloat)getButtonHeightWithTitle:(NSString*)title font:(UIFont*)font{
    UIButton* btn = [[UIButton alloc]init];
    btn.titleLabel.font =font;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn sizeToFit];
    return btn.bounds.size.height;
}
@end
