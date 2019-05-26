#import "RLSSymbolsValueFormatter.h"
@implementation RLSSymbolsValueFormatter
-(id)init{
    if (self = [super init]) {
    }
    return self;
}
- (NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis
{
    return [NSString stringWithFormat:@"%ld%%",(NSInteger)value];
}
@end
