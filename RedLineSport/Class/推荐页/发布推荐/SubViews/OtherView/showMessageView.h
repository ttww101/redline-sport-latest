//
//  showMessageView.h
//  GQZhiBo
//
//  Created by genglei on 2018/12/19.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface showMessageView : UIView

+ (showMessageView *)showMessage:(NSString *)message;

- (instancetype)initWithFrame:(CGRect)frame message:(NSString *)message;


@end


