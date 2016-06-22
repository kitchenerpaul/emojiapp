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
    self.shareButton.layer.cornerRadius = 5;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

    //add tap gesture to emoji imageview
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareContent)];
    tap.cancelsTouchesInView = YES;
    tap.numberOfTapsRequired = 1;

    [self.emojiImageView addGestureRecognizer:tap];
    self.emojiImageView.userInteractionEnabled = YES;

    self.slider.maximumValue = 1;
    self.slider.minimumValue = 0.3;
    self.slider.value = 1;

    [self.slider addTarget:self
                    action:@selector(sliderValueChanged:)
          forControlEvents:UIControlEventValueChanged];
}

- (IBAction)onShareButtonPressed:(UIButton *)sender {
    [self shareContent];
}

-(void)shareContent{

    NSString *message = @"#PizzaEmojiApp";
    UIImage *image = self.emoji;
    NSArray *shareItems = @[message, image];
    UIActivityViewController *avc = [[UIActivityViewController alloc] initWithActivityItems:shareItems applicationActivities:nil];
    [self presentViewController:avc animated:YES completion:nil];
}

- (IBAction)sliderValueChanged:(UISlider *)sender {
    self.emojiImageView.transform = CGAffineTransformMakeScale(sender.value, sender.value);
}

@end