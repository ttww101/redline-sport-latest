//
//  InputAccessoryView.h
//  GQZhiBo
//
//  Created by genglei on 2018/12/3.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol InputAccessoryViewDelegate <NSObject>

- (void)InputAccessoryViewEmojiAction:(UIButton *)sender;

- (void)InputAccessoryViewPicAction:(UIButton *)sender;

@end

@interface InputAccessoryView : UIView

@property (nonatomic, weak) id <InputAccessoryViewDelegate> delegate;

@end


