//
//  CLLocationManager+Extensions.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/2/17.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import "CLLocationManager+Extensions.h"
#import <objc/runtime.h>

static void *locationManagerCompleteTaskBlockKey = &locationManagerCompleteTaskBlockKey;
static void *updateAuthorizationDescriptionKey = &updateAuthorizationDescriptionKey;


@interface CLLocationManagerHelper()<CLLocationManagerDelegate>

@end

@implementation CLLocationManagerHelper


//get address from current location
-(void)getAddressesFromDeviceLocationWithCompleteBlock:(LocationManagerCompleteTaskBlock)blcok{
    CLLocationManager* sharedLocationManager=  [CLLocationManager sharedLocationManager];
    sharedLocationManager.delegate=self;
    [sharedLocationManager getAddressesFromDeviceLocationWithCompleteBlock:blcok];
}


#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    NSLog(@"%@", locations);
}
- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading{
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"%@", error.description);
}
@end





@interface CLLocationManager ()<CLLocationManagerDelegate>
@property(nonatomic,copy)LocationManagerCompleteTaskBlock locationManagerCompleteTaskBlock;
@property(nonatomic,copy)NSNumber* updateAuthorizationDescription;
@end

@implementation CLLocationManager (Extensions)

+(instancetype)sharedLocationManager{
    static CLLocationManager* locationManager=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        locationManager=[[CLLocationManager alloc]init];
        locationManager.delegate=locationManager;
    });
    return locationManager;
}

//get address from current location
-(void)getAddressesFromDeviceLocationWithCompleteBlock:(LocationManagerCompleteTaskBlock)blcok{
    self.locationManagerCompleteTaskBlock=blcok;
    if ([CLLocationManager locationServicesEnabled]) {
        
        [self setDesiredAccuracy:0 distanceFilter:0 updateAuthorizationDescription:0];
        [self requestAuthorization];
        [self startUpdatingLocation];
    }
    else{
        __block BOOL stopUpdates = NO;
        self.locationManagerCompleteTaskBlock( nil, nil, &stopUpdates);
        if (stopUpdates) {
            [[CLLocationManager sharedLocationManager] stopUpdatingLocation];
            self.locationManagerCompleteTaskBlock = nil;
        }
    }
}

#pragma mark - Private Methods


-(void)setDesiredAccuracy:(CLLocationAccuracy)desiredAccuracy distanceFilter:(CLLocationDistance)distanceFilter updateAuthorizationDescription:(CLLocationUpdateAuthorizationDescription)updateAuthorizationDescription{
    if (desiredAccuracy==0&&distanceFilter==0) {
        self.desiredAccuracy=kCLLocationAccuracyBestForNavigation;
        self.distanceFilter=20;
        self.updateAuthorizationDescription=[NSNumber numberWithInteger: CLLocationUpdateAuthorizationDescriptionWhenInUse];
    }
    else{
        self.desiredAccuracy=desiredAccuracy;
        self.distanceFilter=distanceFilter;
        self.updateAuthorizationDescription=[NSNumber numberWithInteger: updateAuthorizationDescription];
    }
}


-(void)getAddressesFromLocations:(NSArray<CLLocation *> *)locations{
    __block  NSMutableArray<CLPlacemark*>* totalPlacemarks=[NSMutableArray array];
    //setup GCD control
    //    __block NSInteger semaphore_count_test=0;
    static NSInteger semaphore_count=0;
    semaphore_count=locations.count;
    
    dispatch_semaphore_t semaphore=dispatch_semaphore_create(0);
    dispatch_group_t group=dispatch_group_create();
    dispatch_queue_t queue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //        dispatch_queue_t queue=dispatch_queue_create("testQueue",DISPATCH_QUEUE_CONCURRENT);
    
    //start address convert
    [locations enumerateObjectsUsingBlock:^(CLLocation * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"semaphore_count_test_idx out :%ld", (long)idx);
        dispatch_group_async(group, queue, ^{
            CLGeocoder* Geocoder=[[CLGeocoder alloc]init];
            [Geocoder reverseGeocodeLocation:obj completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
                [totalPlacemarks addObjectsFromArray:placemarks];
                dispatch_semaphore_signal(semaphore);
            }];
        });
    }];
    
    //after networks all finished
    dispatch_group_notify(group, queue, ^{
        //creaet wait semaphores
        for (int i=0; i<semaphore_count; i++) {
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        }
        //这里就是所有异步任务请求结束后执行的代码
        LocationManagerCompleteTaskBlock completeTaskBlock = self.locationManagerCompleteTaskBlock;
        if (completeTaskBlock && totalPlacemarks.count>0) {
            __block BOOL stopUpdates = NO;
            completeTaskBlock( totalPlacemarks, nil, &stopUpdates);
            
            if (stopUpdates) {
                [[CLLocationManager sharedLocationManager] stopUpdatingLocation];
                self.locationManagerCompleteTaskBlock = nil;
            }
        }
    });
}

- (void)requestAuthorization
{
#if defined(__IPHONE_OS_VERSION_MAX_ALLOWED) && __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
    if ([self respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        CLLocationUpdateAuthorizationDescription description = self.updateAuthorizationDescription.integerValue;
        if (description == CLLocationUpdateAuthorizationDescriptionWhenInUse) {
            [self requestWhenInUseAuthorization];
        } else {
            [self requestAlwaysAuthorization];
        }
    }
#endif
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    [self getAddressesFromLocations:locations];
}
- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading{
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"%@", error.description);
}

#pragma mark - CLGeocoder


#pragma mark - Dynamic Extensions Properties

-(LocationManagerCompleteTaskBlock)locationManagerCompleteTaskBlock
{
    return objc_getAssociatedObject(self, &locationManagerCompleteTaskBlockKey);
}

-(void)setLocationManagerCompleteTaskBlock:(LocationManagerCompleteTaskBlock)locationManagerCompleteTaskBlock
{
    objc_setAssociatedObject(self, & locationManagerCompleteTaskBlockKey, locationManagerCompleteTaskBlock, OBJC_ASSOCIATION_COPY);
}

-(NSNumber*)updateAuthorizationDescription
{
    return objc_getAssociatedObject(self, &updateAuthorizationDescriptionKey);
}

-(void)setUpdateAuthorizationDescription:(NSNumber*)updateAuthorizationDescription
{
    objc_setAssociatedObject(self, & updateAuthorizationDescriptionKey, updateAuthorizationDescription, OBJC_ASSOCIATION_COPY);
}
@end



//                NSString* name=placemark.name;
//                NSLog(@"name:%@", name);
//                CLLocation* location=placemark.location;
//                NSLog(@"location %@", location);
//
//                CLRegion* region=placemark.region;
//                NSLog(@"region %@", region);
//                NSTimeZone* timeZone=placemark.timeZone;
//                NSLog(@"timeZone %@", timeZone);
//
//
//
//                NSString* ISOcountryCode=placemark.ISOcountryCode;
//                NSLog(@"ISOcountryCode %@", ISOcountryCode);
//                NSString* country=placemark.country;
//                NSLog(@"country %@", country);
//                NSString* postalCode=placemark.postalCode;
//                NSLog(@"postalCode %@", postalCode);
//                NSString* administrativeArea=placemark.administrativeArea;
//                NSLog(@"administrativeArea %@", administrativeArea);
//                NSString* subAdministrativeArea=placemark.subAdministrativeArea;
//                NSLog(@"subAdministrativeArea %@", subAdministrativeArea);
//                NSString* locality=placemark.locality;
//                NSLog(@"locality %@", locality);
//                NSString* subLocality=placemark.subLocality;
//                NSLog(@"subLocality %@", subLocality);
//                NSString* thoroughfare=placemark.thoroughfare;
//                NSLog(@"thoroughfare %@", thoroughfare);
//
//                NSString* subThoroughfare=placemark.subThoroughfare;
//                NSLog(@"subThoroughfare %@", subThoroughfare);
//                NSString* inlandWater=placemark.inlandWater;
//                NSLog(@"inlandWater %@", inlandWater);
//                NSString* ocean=placemark.ocean;
//                NSLog(@"ocean %@", ocean);
//                NSArray<NSString *> *areasOfInterest=placemark.areasOfInterest;
//                NSLog(@"areasOfInterest %@", areasOfInterest);




//addressDictionary	__NSDictionaryM *	10 key/value pairs	0x000000012908f5a0
//[0]	(null)	@"SubLocality" : @"普陀区"
//[1]	(null)	@"CountryCode" : @"CN"
//[2]	(null)	@"Street" : @"金沙江路998号"
//[3]	(null)	@"State" : @"上海市"
//[4]	(null)	@"Name" : @"金沙江路998号"
//[5]	(null)	@"Thoroughfare" : @"金沙江路"
//[6]	(null)	@"FormattedAddressLines" : @"1 element"
//key	__NSCFConstantString *	@"FormattedAddressLines"	0x000000019c4a0c50
//value	__NSArrayM *	@"1 element"	0x000000012908bf90
//[0]	__NSCFString *	@"中国上海市普陀区长风新村街道金沙江路998号"	0x0000000129081180
//[7]	(null)	@"SubThoroughfare" : @"998号"
//[8]	(null)	@"Country" : @"中国"
//[9]	(null)	@"City" : @"上海市"
