//
//  SectionView.h
//  GQZhiBo
//
//  Created by genglei on 2018/11/22.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayControl.h"

@protocol SectionViewDelegate <NSObject>

- (void)switchType:(NSInteger)type;
- (void)loadWithRecent:(NSInteger)select;


@end

@interface SectionView : UIView

@property (nonatomic, weak) id <SectionViewDelegate> delegate;

@end


