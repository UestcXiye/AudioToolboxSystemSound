//
//  ViewController.m
//  AudioToolboxSystemSound
//
//  Created by 刘文晨 on 2024/7/8.
//

#import "ViewController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.mLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 100)];
    self.mLabel.textColor = UIColor.blackColor;
    self.mLabel.text = @"使用 Audio Toolbox 设置并播放 SystemSound";
    self.mLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.mButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [self.mButton setTitle:@"play" forState:UIControlStateNormal];
    [self.mButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.mButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.mButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.mLabel];
    [self.view addSubview:self.mButton];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.mLabel.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:100],
        [self.mLabel.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        
        [self.mButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.mButton.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor]
    ]];
}

- (void)btnClick:(UIButton *)sender
{
    self.mButton.hidden = YES;
    NSURL *audioUrl = [[NSBundle mainBundle] URLForResource:@"music" withExtension:@"aac"];
    SystemSoundID soundID;
    // create a system sound object
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)audioUrl, &soundID);
    // register a callback function that is invoked when a specified system sound finishes playing
    AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL, &playCallback, (__bridge void *_Nullable)(self));
    // play a system sound object
    AudioServicesPlaySystemSound(soundID);
}

void playCallback(SystemSoundID ssID, void  *clientData)
{
    ViewController *vc = (__bridge ViewController *)clientData;
    vc->_mButton.hidden = NO;
    // 振动
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

@end
