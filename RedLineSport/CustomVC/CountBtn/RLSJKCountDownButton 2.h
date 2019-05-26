#import <UIKit/UIKit.h>
@class RLSJKCountDownButton;
typedef NSString* (^DidChangeBlock)(RLSJKCountDownButton *countDownButton,int second);
typedef NSString* (^DidFinishedBlock)(RLSJKCountDownButton *countDownButton,int second);
typedef void (^TouchedDownBlock)(RLSJKCountDownButton *countDownButton,NSInteger tag);
@interface RLSJKCountDownButton : UIButton
{
    int _second;
    int _totalSecond;
    NSTimer *_timer;
    NSDate *_startDate;
    DidChangeBlock _didChangeBlock;
    DidFinishedBlock _didFinishedBlock;
    TouchedDownBlock _touchedDownBlock;
}
-(void)addToucheHandler:(TouchedDownBlock)touchHandler;
-(void)didChange:(DidChangeBlock)didChangeBlock;
-(void)didFinished:(DidFinishedBlock)didFinishedBlock;
-(void)startWithSecond:(int)second;
- (void)stop;
@end
