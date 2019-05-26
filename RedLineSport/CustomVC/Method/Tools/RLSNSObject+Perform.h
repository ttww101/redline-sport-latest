#import <Foundation/Foundation.h>
@interface NSObject (Perform)
- (void)performSelectorAlongChain:(SEL)sel;
- (void)performSelectorAlongChainReversed:(SEL)sel;
- (void)performMsgSendWithTarget:(id)target sel:(SEL)sel signal:(id)signal;
- (BOOL)performMsgSendWithTarget:(id)target sel:(SEL)sel;
@end
