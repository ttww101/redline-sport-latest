#import "RLSModelPredictionViewModel.h"
@implementation RLSModelPredictionViewModel
+ (NSArray *)createModelListArray {
    NSArray *imageArray = @[@"winorfail", @"yapan", @"daxiaoqiu"];
    NSArray *titleArray = @[@"胜平负", @"亚指", @"进球数"];
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
