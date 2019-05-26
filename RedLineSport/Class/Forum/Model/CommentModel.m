//
//  CommentModel.m
//  GQZhiBo
//
//  Created by genglei on 2018/11/21.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import "CommentModel.h"

@implementation CommentModel

- (void)calculateCellHeight {
    if (self.cellHeight > 0) {
        return;
    }
    if (self.content) {
        self.contentHeight = [self.content heightForFont:[UIFont systemFontOfSize:14] width:Width - 30];
    }
    self.cellHeight = 77 + self.contentHeight;
    self.avaterUrl = [NSString stringWithFormat:@"http://mobile.gunqiu.com/avatar/%@",self.userId];
    self.dateStr = [RLSMethods compareCurrentTime:self.publishTime];
}

@end
