//
//  CLLocationManager+Extensions.h
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/2/17.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

///--------------------------------
/// @name Authorization Description
///--------------------------------

/**
 Enum used to specify the authorization description
 */
typedef NS_ENUM(NSUInteger, CLLocationUpdateAuthorizationDescription) {
    CLLocationUpdateAuthorizationDescriptionAlways,
    CLLocationUpdateAuthorizationDescriptionWhenInUse,
};

/**
 Block used to notify about updates to the location manager.
 
 On success the updated location will be provided. If we have an error the location will be nil.
 
 @param manager The location manager that sends the update
 @param locations The updated locations
 @param addresses The updated addresses
 addresses
 @param error Used if there was an error during update
 @param stopUpdating Set this to YES in order to stop location updates
 */
typedef void (^LocationManagerCompleteTaskBlock)(NSArray<CLPlacemark *>* placemarks, NSError *error, BOOL *stopUpdating);

@interface CLLocationManagerHelper:NSObject

-(void)getAddressesFromDeviceLocationWithCompleteBlock:(LocationManagerCompleteTaskBlock)blcok;

@end

@interface CLLocationManager (Extensions)


//@property(nonatomic,copy)LocationManagerCompleteTaskBlock locationManagerCompleteTaskBlock;
//@property(nonatomic,assign)CLLocationUpdateAuthorizationDescription updateAuthorizationDescription;


+(instancetype)sharedLocationManager;

//init LocationManager monitoring accuracy
-(void)setDesiredAccuracy:(CLLocationAccuracy)desiredAccuracy distanceFilter:(CLLocationDistance)distanceFilter updateAuthorizationDescription:(CLLocationUpdateAuthorizationDescription)updateAuthorizationDescription;

//get address from current location
-(void)getAddressesFromDeviceLocationWithCompleteBlock:(LocationManagerCompleteTaskBlock)blcok;

@end
