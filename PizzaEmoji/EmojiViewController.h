//
//  EmojiViewController.h
//  PizzaEmoji
//
//  Created by Paul Kitchener on 6/14/16.
//  Copyright © 2016 Box Score Games. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmojiViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *emojiImageView;
@property UIImage *emoji;
@property (strong, nonatomic) IBOutlet UIButton *shareButton;
@property (strong, nonatomic) IBOutlet UISlider *slider;

@end
