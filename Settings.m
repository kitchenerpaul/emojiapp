//
//  Settings.m
//  PizzaEmoji
//
//  Created by Amar Bhatia on 6/14/16.
//  Copyright © 2016 Box Score Games. All rights reserved.
//

#import "Settings.h"

@implementation Settings

- (instancetype)initWithName:(NSString *)name andImage:(UIImage *)iconImageName {
    if ((self = [super init])) {
        self.name = name;
        self.emojiImage = iconImageName;
        
    }
    
    return self;
}

@end
