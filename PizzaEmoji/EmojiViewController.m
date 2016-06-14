//
//  EmojiViewController.m
//  PizzaEmoji
//
//  Created by Paul Kitchener on 6/14/16.
//  Copyright © 2016 Box Score Games. All rights reserved.
//

#import "EmojiViewController.h"

@interface EmojiViewController ()

@end

@implementation EmojiViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.emojiImageView.image = self.emoji;
}

- (IBAction)onShareButtonPressed:(UIButton *)sender {
    [self shareContent];
}

- (IBAction)onXButtonPressed:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)shareContent{

    NSString *message = @"#PizzaEmojiApp";
    UIImage *image = self.emoji;

    NSArray *shareItems = @[message, image];

    UIActivityViewController *avc = [[UIActivityViewController alloc] initWithActivityItems:shareItems applicationActivities:nil];

    [self presentViewController:avc animated:YES completion:nil];
}

@end