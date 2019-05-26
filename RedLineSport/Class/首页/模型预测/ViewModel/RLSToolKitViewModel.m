#import "RLSToolKitViewModel.h"
@implementation RLSToolKitViewModel
+ (NSArray *)createModelListArray {
    NSArray *imageArray = @[@"baolengzhishu", @"lishitongpei", @"yapanzhushou",@"pailvyichang", @"jixianguaidian", @"panwangzhishu", @"jiaoyilengre",@"touzhuyichang"];
    NSArray *titleArray = @[@"爆冷指数", @"历史同赔", @"亚指助手", @"指数异常", @"极限拐点", @"盘王指数", @"交易冷热", @"投注异常"];
    NSMutableArray *array = [NSMutableArray array];
    [imageArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UniversaListCellModel *model = [[UniversaListCellModel alloc]init];
        model.leftIconImageName = imageArray[idx];
        model.content = titleArray[idx];
        model.index = idx;
        [array addObject:model];
    }];
    return array;
}
@end
