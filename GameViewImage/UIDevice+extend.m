//
//  UIDevice+extend.m
//  MaintainLayoutWhenRotate
//
//  Created by techmaster on 9/22/13.
//  Copyright (c) 2013 Techmaster. All rights reserved.
//

#import "UIDevice+extend.h"
#import <sys/utsname.h>
@implementation UIDevice (extend)

static NSString* modelName;
static CGSize screenSize;
static float version;

+ (float) getVersion
{
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        version = [[[UIDevice currentDevice] systemVersion] floatValue];
    });
    return version;
}
- (CGSize) getScreenSize
{
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        screenSize = [[UIScreen mainScreen] bounds].size;
    });
    return screenSize;
    
}
- (NSString*) getModel
{
    static dispatch_once_t onceToken = 0;
    //Luôn chỉ gọi một lần và chỉ một lần !
    dispatch_once(&onceToken, ^{
    
        struct utsname systemInfo;
        uname(&systemInfo);
        NSString *temp = [NSString stringWithCString:systemInfo.machine
                                            encoding:NSUTF8StringEncoding];
       
     
        NSDictionary *commonNamesDictionary =
        @{
          @"i386":     @"Simulator",
          @"x86_64":   @"Simulator",
          @"iPhone1,1":    @"iPhone",
          @"iPhone1,2":    @"iPhone 3G",
          @"iPhone2,1":    @"iPhone 3GS",
          @"iPhone3,1":    @"iPhone 4",
          @"iPhone3,2":    @"iPhone 4(Rev A)",
          @"iPhone3,3":    @"iPhone 4(CDMA)",
          @"iPhone4,1":    @"iPhone 4S",
          @"iPhone5,1":    @"iPhone 5(GSM)",
          @"iPhone5,2":    @"iPhone 5(GSM+CDMA)",
          
          @"iPad1,1":  @"iPad",
          @"iPad2,1":  @"iPad 2(WiFi)",
          @"iPad2,2":  @"iPad 2(GSM)",
          @"iPad2,3":  @"iPad 2(CDMA)",
          @"iPad2,4":  @"iPad 2(WiFi Rev A)",
          @"iPad2,5":  @"iPad Mini(WiFi)",
          @"iPad2,6":  @"iPad Mini(GSM)",
          @"iPad2,7":  @"iPad Mini(GSM+CDMA)",
          @"iPad3,1":  @"iPad 3(WiFi)",
          @"iPad3,2":  @"iPad 3(GSM+CDMA)",
          @"iPad3,3":  @"iPad 3(GSM)",
          @"iPad3,4":  @"iPad 4(WiFi)",
          @"iPad3,5":  @"iPad 4(GSM)",
          @"iPad3,6":  @"iPad 4(GSM+CDMA)",
          
          @"iPod1,1":  @"iPod 1st Gen",
          @"iPod2,1":  @"iPod 2nd Gen",
          @"iPod3,1":  @"iPod 3rd Gen",
          @"iPod4,1":  @"iPod 4th Gen",
          @"iPod5,1":  @"iPod 5th Gen"};
        
        modelName =  commonNamesDictionary[temp];
    
    });
    return modelName;

}
@end
