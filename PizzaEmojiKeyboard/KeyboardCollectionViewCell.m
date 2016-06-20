//
//  KeyboardCollectionViewCell.m
//  PizzaEmoji
//
//  Created by Amar Bhatia on 6/17/16.
//  Copyright © 2016 Box Score Games. All rights reserved.
//

#import "KeyboardCollectionViewCell.h"

@implementation KeyboardCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (IBAction)backButtonPressed:(id)sender {
    [self.backButton addTarget:self action:@selector(advanceToNextInputMode) forControlEvents:UIControlEventTouchUpInside];
}

@end
