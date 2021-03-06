#ifndef FLXK_Global_h
#define FLXK_Global_h

/**
   Global header included in every app and test file (see Wikipedia-Prefix.pch).

   Done as a separate header so it can be reused in unit tests.
 */

//dignostic
#import <Tweaks/FBTweakInline.h>
#import "FBTweakViewController.h"


//Utilities

#import "AppConfig.h"
#import "UIView+Extensions.h"
#import "FLXKAPPRouter.h"
#import "FLXKSharedAppSingleton.h"
#import "FLXKPathHelper.h"

#import "DDLogMacros.h"//iOS开源项目之日志框架CocoaLumberjack

//#import "WMFLogging.h"
//#import "WMFDirectoryPaths.h"
//#import "WMFGCDHelpers.h"
//#import "WMFLocalization.h"
//#import "WMFMath.h"
//#import "NSError+WMFExtensions.h"
//#import "NSObjectUtilities.h"
//#import "WMFOutParamUtils.h"
//#import "UIColor+WMFStyle.h"

#import <libextobjc/EXTScope.h>
//#import <KVOController/FBKVOController.h>
//#import <BlocksKit/BlocksKit.h>

// Need to import it this way since umbrella header doesn't have AnyPromise declarations
//#import <PromiseKit/PromiseKit.h>

//#import "WMFBlockDefinitions.h"
//#import "WMFComparison.h"
//#import "WMFDeprecationMacros.h"
//#import "NSProcessInfo+WMFOperatingSystemVersionChecks.h"
//#import "NSArray+WMFMapping.h"
//#import "NSMutableArray+WMFSafeAdd.h"
//#import "NSMutableSet+WMFSafeAdd.h"
//#import "NSDictionary+WMFExtensions.h"
//#import "NSURL+WMFExtras.h"
//#import "NSURL+WMFLinkParsing.h"


//#define URL_PRIVACY_POLICY @"https://m.wikimediafoundation.org/wiki/Privacy_policy"

#endif
