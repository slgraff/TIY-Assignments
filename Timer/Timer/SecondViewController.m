//
//  SecondViewController.m
//  Timer
//
//  Created by Steve Graff on 4/13/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController (){
    
    // Instance variable for an NSTimer timer, NSInteger currentValue
    NSTimer * timer;
    NSInteger currentValue;
}

// Outlets to UIStepper stepper, UILabel timerLabel, UiButtons resetButton, stopButton, startButton
@property (weak, nonatomic) IBOutlet UIStepper *stepper;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;
@property (weak, nonatomic) IBOutlet UIButton *startButton;

// Actions for start, reset and stop buttons
-(IBAction)startTapped:(id)sender;
-(IBAction)resetTapped:(id)sender;
-(IBAction)stopTapped:(id)sender;


@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    currentValue = 60;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Button Actions
// Implementation of button actions

-(IBAction)startTapped:(id)sender{
    
    // Create a new NSTimer timer, time interval is 1 second
    // Target is self, i.e. this view controller
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                             target:self
                                           selector:@selector(processStep)
                                           userInfo:nil
                                            repeats:YES];
}

-(IBAction)resetTapped:(id)sender;
{
    
}

-(IBAction)stopTapped:(id)sender{
    
}

-(void)processStep{
    if (currentValue > 0) {
        currentValue -= 1;
        [self updateLabel];
    }
}

-(void)updateLabel{
    self.timerLabel.text = [NSString stringWithFormat:@"%ld Seconds", currentValue];
}


@end
