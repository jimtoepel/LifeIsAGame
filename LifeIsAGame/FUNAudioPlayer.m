//
//  AudioPlayer.m
//  LifeIsAGame
//
//  Created by Jim Toepel on 10/26/15.
//  Copyright © 2015 FunderDevelopment. All rights reserved.
//

#import "FUNAudioPlayer.h"

@implementation FUNAudioPlayer

// Init the player with Filename and File Extension


-(void)initPlayer:(NSString *)audioFile fileExtension:(NSString *)fileExtension
{
    NSURL *audioFileLocationURL = [[NSBundle mainBundle] URLForResource:audioFile withExtension:fileExtension];
    NSError *error;
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:audioFileLocationURL error:&error];
}




@end
