//
//  NSDictionary+Log.m
//  log
//
//  Created by Marjoice on 7/19/17.
//  Copyright © 2017 zhuliang. All rights reserved.
//

#import "NSDictionary+Log.h"
#import "NSString+unicode.h"
#import <objc/runtime.h>

@implementation NSDictionary (Log)

#ifdef DEBUG
- (NSString *)descriptionWithLocale:(id)locale{
    return self.debugDescription;
}
- (NSString *)debugDescription{
    return [super debugDescription];
}
- (NSString *)xy_debugDescription{
    return self.xy_debugDescription.unicodeString;
}

+ (void)load{
    [self swapMethod];
}

+ (void)swapMethod{
    Method method1 = class_getInstanceMethod(self, @selector(debugDescription));
    Method method2 = class_getInstanceMethod(self, @selector(xy_debugDescription));
    
    method_exchangeImplementations(method1, method2);
}
#endif

@end
