//
//  WinFreePizzaViewController.m
//  PizzaEmoji
//
//  Created by Amar Bhatia on 6/14/16.
//  Copyright © 2016 Box Score Games. All rights reserved.
//

#import "WinFreePizzaViewController.h"

@interface WinFreePizzaViewController ()

@property (strong, nonatomic) IBOutlet UIButton *getAppButton;

@end

@implementation WinFreePizzaViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"FREE PIZZA";
    self.getAppButton.layer.cornerRadius = 5;
}

- (IBAction)onGetAppButtonPressed:(UIButton *)sender {

    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://itunes.apple.com/us/app/box-score-fantasy-pizza/id696243799?mt=8"]];
}

@end
