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
//        [self setupCell];
    }
    return self;
}

- (void)setupCell {
    

    self.userInteractionEnabled = YES;

}




@end
