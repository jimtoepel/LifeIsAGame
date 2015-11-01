//
//  ViewController.h
//  LifeIsAGame
//
//  Created by Jim Toepel on 10/26/15.
//  Copyright © 2015 FunderDevelopment. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FUNAudioPlayer.h"

@interface ViewController : UIViewController

@property (nonatomic, strong) FUNAudioPlayer *audioPlayer;

@property (weak, nonatomic) IBOutlet UISlider *currentTimeSlider;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UILabel *duration;
@property (weak, nonatomic) IBOutlet UILabel *timeElapsed;
@property (weak, nonatomic) IBOutlet UIButton *victoryButton;
@property (weak, nonatomic) IBOutlet UIButton *challengeButton;
@property (weak, nonatomic) IBOutlet UIImageView *currentMoodDisplay;

@property BOOL isPaused;
@property BOOL scrubbing;

@property NSString *mood;
@property int moodValue;

@property NSTimer *timer;



@end

