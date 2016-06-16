//
//  FollowUsViewController.m
//  PizzaEmoji
//
//  Created by Amar Bhatia on 6/14/16.
//  Copyright © 2016 Box Score Games. All rights reserved.
//

#import "FollowUsViewController.h"

@interface FollowUsViewController ()

@end

@implementation FollowUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.instagram.com/boxscoregames/"]];


}

@end
