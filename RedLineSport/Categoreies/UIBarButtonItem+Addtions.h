//
//  UIBarButtonItem+Addtions.h
//  GQapp
//
//  Created by WQ on 2016/11/29.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Addtions)
+(UIBarButtonItem *)itemWithNormalImage:(UIImage *)normalImage HighImage:(UIImage *)highImage target:(id)target action:(SEL)section;
@end
