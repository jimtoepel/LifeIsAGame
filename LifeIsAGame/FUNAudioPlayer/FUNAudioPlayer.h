//
//  FUNAudioPlayer.h
//  LifeIsAGame
//
//  Created by Jim Toepel on 10/27/15.
//  Copyright © 2015 FunderDevelopment. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface FUNAudioPlayer : UIViewController



@property (nonatomic, retain) AVAudioPlayer *audioPlayer;


- (void)initPlayer:(NSString*) audioFile fileExtension:(NSString*)fileExtension;
- (void)playAudio;
- (void)pauseAudio;
- (void)setCurrentAudioTime:(float)value;
- (float)getAudioDuration;
- (NSString*)timeFormat:(float)value;
- (NSTimeInterval)getCurrentAudioTime;
- (void)toggleLooping:(BOOL)loop;


@end