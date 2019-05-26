//
//  LockQingBaoView.h
//  GQZhiBo
//
//  Created by genglei on 2019/1/21.
//  Copyright © 2019年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LockQingBaoViewDelegate <NSObject>

- (void)LockQingBaoViewTapAction;

@end

@interface LockQingBaoView : UIView

- (instancetype)initWithFrame:(CGRect)frame;

@property (nonatomic , copy) NSDictionary *infoMap;


@property (nonatomic, weak) id <LockQingBaoViewDelegate> delegate;



@end


