//
//  UIViewController+ios7.m
//  DemoView
//
//  Created by iOS17 on 10/9/13.
//  Copyright (c) 2013 VT. All rights reserved.
//

#import "UIViewController+ios7.h"

@implementation UIViewController (ios7)

- (CGRect) CGrectMakeWithx  : (float) x y : (float) y  width  : (float) width heigth : (float) heigth
{
    float version = [UIDevice getVersion];
    if (version>=7.0) {
        return CGRectMake(x, y+20.0, width, heigth);
    }
    else
        return CGRectMake(x, y, width, heigth);
}

@end
