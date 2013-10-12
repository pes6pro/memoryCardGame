//
//  UIDevice+extend.h
//  MaintainLayoutWhenRotate
//
//  Created by techmaster on 9/22/13.
//  Copyright (c) 2013 Techmaster. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (extend)
- (NSString* ) getModel;
+ (float) getVersion;
- (CGSize) getScreenSize;
@end
