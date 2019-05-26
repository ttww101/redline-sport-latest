//
//  DCImageViewRoundCorner.m
//  GQapp
//
//  Created by WQ on 2017/1/18.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "DCImageViewRoundCorner.h"
#import "UIImage+Corner.h"
@implementation DCImageViewRoundCorner

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)addCornerRadius:(CGFloat)radius
{
    
   self.image =  [self.image imageAddCornerWithRadius:radius andSize:self.bounds.size];
}


@end
