#import "RLSDCPlaySound.h"
@implementation RLSDCPlaySound
- (id)initWithForPlayingVibrate
{
    self = [super init];
    if (self) {
        soundID = kSystemSoundID_Vibrate;
    }
    return self;
}
- (id)initWithForPlayingSystemSoundEffrctWith:(NSString *)ResourceName ofType:(NSString *)type
{
    self = [super init];
    if (self) {
        NSString *path = [[NSBundle bundleWithIdentifier:@"com.apple.UIKit"] pathForResource:ResourceName ofType:type];
        if (path) {
            SystemSoundID theSoundId;
            OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &theSoundId);
            if (error == kAudioServicesNoError) {
                soundID = theSoundId;
            }else{
                NSLog(@"不能创建音频播放文件");
            }
        }
    }
    return self;
}
- (id)initWithForPlayingSoundEffectWith:(NSString *)filename ofType:(NSString *)type
{
    self = [super init];
    if (self) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"music2" ofType:@"wav"];
        if (path) {
            SystemSoundID theSoundId;
            OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &theSoundId);
            if (error == kAudioServicesNoError) {
                soundID = theSoundId;
            }else{
                NSLog(@"不能创建音频播放文件");
            }
        }
    }
    return self;
}
- (void)play
{
    AudioServicesPlayAlertSound(soundID);
}
- (void)dealloc
{
    AudioServicesDisposeSystemSoundID(soundID);
}
@end
