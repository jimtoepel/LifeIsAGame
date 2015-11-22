//
//  FUNAudioPlayer.m
//  LifeIsAGame
//
//  Created by Jim Toepel on 10/27/15.
//  Copyright © 2015 FunderDevelopment. All rights reserved.
//

#import "FUNAudioPlayer.h"

@implementation FUNAudioPlayer

-(void)initPlayer:(NSString*) audioFile fileExtension:(NSString *)fileExtension
{
    NSURL *audioFileLocationURL = [[NSBundle mainBundle] URLForResource:audioFile withExtension:fileExtension];
    NSError *error;
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:audioFileLocationURL error:&error];
}


- (void)playAudio {
    [self.audioPlayer play];
    [self toggleLooping:(TRUE)];
}


- (void)pauseAudio {
    [self.audioPlayer pause];
}


- (NSString*)timeFormat:(float)value {
    
    float minutes = floor(lroundf(value)/60);
    float seconds = lround(value) - (minutes * 60);
    
    int roundedSeconds = lroundf(seconds);
    int roundedMinutes = lroundf(minutes);
    
    NSString *time = [[NSString alloc] initWithFormat:@"%d:%02d", roundedMinutes, roundedSeconds];
    
    return time;
    
}


- (void)setCurrentAudioTime:(float)value {
    [self.audioPlayer setCurrentTime:value];
}


- (NSTimeInterval)getCurrentAudioTime {
    return [self.audioPlayer currentTime];
}


- (float)getAudioDuration {
    return [self.audioPlayer duration];
}

- (void)toggleLooping:(BOOL)loop {
    if (! loop ) {
        self.audioPlayer.numberOfLoops = 0;
    } else
        self.audioPlayer.numberOfLoops = -1;
}

@end
