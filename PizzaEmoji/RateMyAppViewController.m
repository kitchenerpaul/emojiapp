//
//  RateMyAppViewController.m
//  PizzaEmoji
//
//  Created by Amar Bhatia on 6/14/16.
//  Copyright © 2016 Box Score Games. All rights reserved.
//

#import "RateMyAppViewController.h"

@interface RateMyAppViewController ()

@end

@implementation RateMyAppViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.apple.com"]];
}



@end
