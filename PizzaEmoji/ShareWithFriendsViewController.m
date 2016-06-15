//
//  ShareWithFriendsViewController.m
//  PizzaEmoji
//
//  Created by Amar Bhatia on 6/14/16.
//  Copyright © 2016 Box Score Games. All rights reserved.
//

#import "ShareWithFriendsViewController.h"

@interface ShareWithFriendsViewController ()

@end

@implementation ShareWithFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self shareContent];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)shareContent{
    
    NSString *message = @"#PizzaEmojiApp";
    UIImage *image = self.emoji;
    
    NSArray *shareItems = @[message, image];
    
    UIActivityViewController *avc = [[UIActivityViewController alloc] initWithActivityItems:shareItems applicationActivities:nil];
    
    [self presentViewController:avc animated:YES completion:nil];
}

@end
