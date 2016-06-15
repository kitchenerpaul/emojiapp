//
//  Settings.h
//  PizzaEmoji
//
//  Created by Amar Bhatia on 6/14/16.
//  Copyright © 2016 Box Score Games. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Settings : NSObject


@property NSString *name;
@property UIImage *emojiImage;

// Custom Intiailizer
- (instancetype)initWithName:(NSString *)name andImage:(UIImage *)iconImageName;


@end
