 #'use_frameworks!'
target ‘FuLingOnline-CheerforAndLearning’ do
# use_frameworks!
##     网络请求
pod 'AFNetworking', '~> 3.1.0'
#pod 'AFNetworking'
pod 'SDWebImage'
#pod 'CocoaAsyncSocket'
#pod 'MJRefresh'


##      Utilities
pod 'libextobjc/EXTScope','~>0.4.1'
pod 'BlocksKit/Core', '~> 2.2.0'
pod 'BlocksKit/UIKit', '~> 2.2.0'
pod 'KVOController'
pod 'MJExtension'
pod 'Tweaks'
pod 'Masonry','~>1.0.2'
pod 'UITableView+FDTemplateLayoutCell'
pod 'Reveal-SDK',:configurations => ['Debug']
#pod 'JHChainableAnimations', '~> 2.0'
pod 'JHChainableAnimations'
##      UI BULDER
pod 'RTRootNavigationController'
#pod 'LTNavigationBar'
pod 'TZImagePickerController'
#pod 'vfrReader', '~> 2.8.6'
#pod 'FDFullscreenPopGesture', '1.1'
#pod 'SwipeBack', '~> 1.1'
pod 'MLLabel', '~> 1.8'
#pod 'JMAnimatedImageView'


##      custom views
# pod 'HPGrowingTextView'


##      Diagnostics
#百度
pod 'BaiduMobStat'
#腾讯
pod 'Bugly'

end




#
##    网络请求
##    PsyHttpHelper
#pod 'AFNetworking', '~> 3.1.0'
##    PsySocketHelper
#pod 'CocoaAsyncSocket','~>7.5.0'
#pod 'SDWebImage'
##    pod 'MJRefresh'
##pod 'MJRefresh'
#
#
##      定制视图
##    PsyInputView
#pod 'HPGrowingTextView', '~> 1.1'
#pod 'MBProgressHUD', '~> 0.9.2'
#pod 'SCLAlertView-Objective-C', '~> 1.0.3'
#pod 'WEPopover', '~> 2.3.4'
#pod 'TSUIKit', '~> 0.1'
#
#use_frameworks!
#pod 'Charts', '~> 2.2.4'
##pod 'Masonry'
#
#
##数据记录
#pod 'FMDB', '~> 2.6.2'
#
#
#
##数据转换
#pod 'MJExtension', '~> 3.0.13'
#pod 'JSONModel', '~> 1.3.0'
#pod 'SSZipArchive', '~> 1.4'
#
##    pod 'IQKeyboardManager'
#
##    pod 'FPPopover''~> 1.4.1'
#
#
#
#
#
#
#
##pod 'ZXingObjC'
#
#
##pod 'CocoaLumberjack', '~> 2.1.0'
##pod 'SVWebViewController'
##    ~/.cocoapods/








## HTML
#pod 'hpple', '~> 0.2'
#
## Networking / Parsing
#pod 'AFNetworking', :git => 'https://github.com/wikimedia/AFNetworking.git', :branch => 'release/3.1.1'
#pod 'Mantle', '~> 2.0.0'
#pod 'GCDWebServer', '~> 3.3'
#
## Images
#pod 'SDWebImage', :git => 'https://github.com/wikimedia/SDWebImage.git', :commit => 'bb49df83e72f2231a191e9477a85f0effe13430a'
#pod 'AnimatedGIFImageSerialization', :git => 'https://github.com/wikimedia/AnimatedGIFImageSerialization.git'
#
## Utilities
#pod 'libextobjc/EXTScope', '~> 0.4.1'
#pod 'BlocksKit/Core', '~> 2.2.0'
#pod 'BlocksKit/UIKit', '~> 2.2.0'
#pod 'KVOController'
#
## Dates
#pod 'NSDate-Extensions', :git => 'git@github.com:wikimedia/NSDate-Extensions.git'
#
## Database
#pod 'YapDatabase'
#
## Datasources
#pod 'SSDataSources', '~> 0.8.0'
#
## Autolayout
#pod 'Masonry', '0.6.2'
#
## Views
#pod 'OAStackView', :git => 'git@github.com:wikimedia/OAStackView.git'
#pod 'TSMessages', :git => 'https://github.com/wikimedia/TSMessages.git'
#pod 'SVWebViewController', '~> 1.0'
## pod "SWStepSlider", :git => 'https://github.com/wikimedia/SWStepSlider.git'
#
## Activities
#pod 'TUSafariActivity'
#
## Licenses
#pod 'VTAcknowledgementsViewController'
#
## Photo Gallery
#pod 'NYTPhotoViewer'
#
## Diagnostics
#pod 'PiwikTracker', :head
#pod 'HockeySDK', '~> 3.8.2'
#pod 'Tweaks', :head
#
#target 'WikipediaUnitTests', :exclusive => true do
#    pod 'OCMockito', '~> 1.4.0'
#    pod 'OCHamcrest', '~> 4.2.0'
#    pod 'Nocilla'
#    # pod 'FBSnapshotTestCase', :head
#    # pod 'Quick', '~> 0.9.0'
#    # pod 'Nimble', '~> 4.0.0'
#end
#
#
#post_install do |installer|
#    plist_buddy = "/usr/libexec/PlistBuddy"
#    version = `#{plist_buddy} -c "Print CFBundleShortVersionString" Wikipedia/Wikipedia-Info.plist`.strip
#    
#    def enable_tweaks(target)
#    target.build_configurations.each { |c|
#        c.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= ['$(inherited)', 'FB_TWEAK_ENABLED=1'] unless c.name == "Release"
#    }
#end
#
#installer.pods_project.targets.each { |target|
#    enable_tweaks(target) if target.name == "Tweaks"
#    puts "Updating #{target} version number to #{version}"
#    `#{plist_buddy} -c "Set CFBundleShortVersionString #{version}" "Pods/Target Support Files/#{target}/Info.plist"`
#}
