//
//  KeyboardCollectionViewCell.m
//  PizzaEmoji
//
//  Created by Paul Kitchener on 6/23/16.
//  Copyright © 2016 Box Score Games. All rights reserved.
//

#import "KeyboardCollectionViewCell.h"

@implementation KeyboardCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    [self setupCell];
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupCell];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupCell];
    }
    return self;
}

- (void)setupCell {

    self.userInteractionEnabled = YES;

//    self.emojiImageView = [[UIImageView alloc] initWithFrame:self.contentView.frame];
//    self.emojiImageView.contentMode = UIViewContentModeScaleAspectFit;
//    [self.contentView addSubview:self.emojiImageView];

    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onCellTap:)];
    [self addGestureRecognizer:recognizer];
}

- (void)onCellTap:(UITapGestureRecognizer *)recognizer {
    NSLog(@"---> TAPPED");

    // causes error
    UIPasteboard *pb = [UIPasteboard generalPasteboard];
    pb.image = [UIImage imageNamed:self.targetName];
    pb.persistent = NO;

    // no error
//    [UIPasteboard generalPasteboard].image = [UIImage imageNamed:@"skull"];

}



@end
