//
//  ViewController.m
//  LifeIsAGame
//
//  Created by Jim Toepel on 10/26/15.
//  Copyright © 2015 FunderDevelopment. All rights reserved.
//

#import "ViewController.h"
NSString *currentHour;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.audioPlayer = [[FUNAudioPlayer alloc] init];
    [self updateMood:0];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"hh a"];
    
    NSLog(@"%@",[dateFormatter stringFromDate:[NSDate date]]);
    self.currentHour.text = [dateFormatter stringFromDate:[NSDate date]];
    
    [dateFormatter setDateFormat:@"MMM"];
    NSString *currentMonthText = [dateFormatter stringFromDate:[NSDate date]];
    self.currentMonth.text = currentMonthText;
    
    [self updateTime];
}


- (void)updateTime
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"hh a"];
    
    NSString *hour = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:[NSDate date]]];
    if (currentHour != hour) {
        // This should be a separate call!
        [self setupAudioPlayer:hour];
        [self.audioPlayer playAudio];
        currentHour = hour;
    }
    
}

- (void)updateMood:(int)change
{
    self.moodValue = self.moodValue + change;
    NSLog(@"Mood is now %i\n", self.moodValue);
    if (self.moodValue < 1) {
        
        [self.currentMoodDisplay setImage:[UIImage imageNamed:@"lightGreen.png"]];
        [self setupAudioPlayer:@"12 PM"];
        [self.audioPlayer playAudio];

    } if (self.moodValue >= 1 && self.moodValue <= 4) {
    
        [self.currentMoodDisplay setImage:[UIImage imageNamed:@"lightYellow.png"]];
        [self setupAudioPlayer:@"PyreLight"];
        [self.audioPlayer playAudio];
    
    } if (self.moodValue >4 ) {
        [self setupAudioPlayer:@"Being Chased by a Bee"];
        [self.currentMoodDisplay setImage:[UIImage imageNamed:@"lightRed.png"]];
        [self.audioPlayer playAudio];    
    }
    
}


/*
 * Setup the AudioPlayer with
 * Filename and FileExtension like mp3
 * Loading audioFile and sets the time tables
 */

- (void)setupAudioPlayer:(NSString*)filename
{
    
    //insert Filename and Fileextension
    NSString *fileExtension = @"mp3";
    
    // init the player to get file properties to se tht etime labels
    [self.audioPlayer initPlayer:filename fileExtension:fileExtension];
    self.currentTimeSlider.maximumValue = [self.audioPlayer getAudioDuration];
    
    // init the current timedisplay and the lavels. if a current time was stored
    // for this player then take it and update the time display
    self.timeElapsed.text = @"0:00";
    
    self.duration.text = [NSString stringWithFormat:@"-%@", [self.audioPlayer timeFormat:[self.audioPlayer getAudioDuration]]];
    
    self.titleDisplay.text = filename;
    
}


/*
 * PlayButton is pressed
 * plays or pauses the audio and sets
 * the play/pause Text of the Button
 */

-(IBAction)playAudioPressed:(id)playButton
{
    [self.timer invalidate];
    // play audio for the first time or if pause was pressed
    if (!self.isPaused) {
        [self.playButton setBackgroundImage:[UIImage imageNamed:@"audioplayer_paused.png"] forState:UIControlStateNormal];
        
        // start a time to update the time label display
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                     target:self
                                                   selector:@selector(updateTime:)
                                                   userInfo:nil
                                                    repeats:YES];
        [self.audioPlayer playAudio];
        self.isPaused = TRUE;
        
    } else {
        //player is paused and Buttons is pressed again
        [self.playButton setBackgroundImage:[UIImage imageNamed:@"audioplayer_play.png"] forState:UIControlStateNormal];
        [self.audioPlayer pauseAudio];
        self.isPaused = FALSE;
    }
}



-(IBAction)victoryButtonPressed:(id)victoryButton
{
    [self updateMood:-1];
    self.mood = @"win";
    NSLog(@"Victory!, %@", self.mood);
    return;
}


-(IBAction)challengeButtonPressed:(id)challengeButton
{
    [self updateMood:1];
    self.mood = @"FIGHT";
    NSLog(@"Are you asking for a challenge?, %@", self.mood);
    return;
}

/*
 * Update the current time label display and
 * the current value of the slider
 * while audio is playing
 */

-(void)updateTime:(NSTimer *)timer {
    //to don't update every second. When scrubber is mouseDown then the slider will not set
    if (!self.scrubbing) {
        self.currentTimeSlider.value = [self.audioPlayer getCurrentAudioTime];
    }
    self.timeElapsed.text = [NSString stringWithFormat:@"%@", [self.audioPlayer timeFormat:[self.audioPlayer getCurrentAudioTime]]];
    self.duration.text = [NSString stringWithFormat:@"-%@", [self.audioPlayer timeFormat:[self.audioPlayer getAudioDuration] - [self.audioPlayer getCurrentAudioTime]]];
    [self updateTime];
    // Update Hour + Month
    // If Hour changes, play "Celebration"
    // And change to new audio
    
}


/*
 * Sets the current value of the scrubber
 * to the audio file when slider/scrubber is used
 */
-(IBAction)setCurrentTime:(id)scrubber {
    //if scubbing update the timestate, call updatetimefaster not to wait a second and don't repeat it
    [NSTimer scheduledTimerWithTimeInterval:0.01
                                     target:self
                                   selector:@selector(updateTime:)
                                   userInfo:nil
                                    repeats:NO];
    [self.audioPlayer setCurrentAudioTime:self.currentTimeSlider.value];
    self.scrubbing = FALSE;
}

/*
 * Sets if the user is scrubbing right no
 * to avoid slider update while dragging the slider
 */
-(IBAction)userIsScrubbing:(id)sender {
    self.scrubbing = TRUE;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
