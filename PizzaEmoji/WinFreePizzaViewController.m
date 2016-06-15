//
//  WinFreePizzaViewController.m
//  PizzaEmoji
//
//  Created by Amar Bhatia on 6/14/16.
//  Copyright © 2016 Box Score Games. All rights reserved.
//

#import "WinFreePizzaViewController.h"

@interface WinFreePizzaViewController ()

@end

@implementation WinFreePizzaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://itunes.apple.com/us/app/box-score-fantasy-pizza/id696243799?mt=8"]];


}

@end
