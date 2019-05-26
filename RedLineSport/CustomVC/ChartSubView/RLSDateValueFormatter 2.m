#import "RLSDateValueFormatter.h"
@interface RLSDateValueFormatter()
{
    NSArray * _arr;
}
@end
@implementation RLSDateValueFormatter
-(id)initWithArr:(NSArray *)arr{
    self = [super init];
    if (self)
    {
        _arr = arr;
    }
    return self;
}
- (NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis
{
    if (value<0) {
        return @"";
    }
    if ((NSInteger)value >_arr.count-1) {
        return @"";
    }
    return _arr[(NSInteger)value];
}
@end
