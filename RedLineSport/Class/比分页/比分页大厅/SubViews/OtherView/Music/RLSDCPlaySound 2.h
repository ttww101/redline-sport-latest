#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
@interface RLSDCPlaySound : NSObject
{
    SystemSoundID soundID;
}
- (id)initWithForPlayingVibrate;
- (id)initWithForPlayingSystemSoundEffrctWith:(NSString *)ResourceName ofType:(NSString *)type;
- (id)initWithForPlayingSoundEffectWith:(NSString *)filename ofType:(NSString *)type;
- (void)play;
@end
