//
//  BiaoQianModel.m
//  GQapp
//
//  Created by 叶忠阳 on 16/9/21.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import "BiaoQianModel.h"

@implementation BiaoQianModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    
    return @{
             @"BQid" : @"id",
             @"name":@"name",
             @"remark" : @"remark"
             };
}
@end
