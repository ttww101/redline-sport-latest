#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
@interface RLSMessageSoundMgr : NSObject {
    SystemSoundID soundID;
}
@property (nonatomic,assign) BOOL isON;
+ (id) sharedInstanceForVibrate;
+ (id) sharedInstanceForSound;
-(id)initForPlayingVibrate;
-(id)initForPlayingSystemSoundEffectWith:(NSString *)resourceName ofType:(NSString *)type;
-(id)initForPlayingSoundEffectWith:(NSString *)filename;
-(void)play;
-(void)cancleSound;
@end
