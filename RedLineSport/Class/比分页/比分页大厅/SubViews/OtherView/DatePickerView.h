//
//  DatePickerView.h
//  GQZhiBo
//
//  Created by genglei on 2018/12/6.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DatePickerViewDelegate <NSObject>

- (void)didSelectedDate:(NSString *)selectDate;

@end


@interface DatePickerView : UIView

+ (DatePickerView *)showDatePicker:(NSArray *)dates title:(NSString *)title;

@property (nonatomic , strong) UILabel *recentLab;

@property (nonatomic, weak) id <DatePickerViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame titlesModel:(NSArray *)titlesModel title:(NSString *)title;

@end


