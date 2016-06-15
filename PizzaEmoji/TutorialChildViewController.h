//
//  TutorialChildViewController.h
//  PizzaEmoji
//
//  Created by Amar Bhatia on 6/15/16.
//  Copyright © 2016 Box Score Games. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TutorialChildViewController : UIViewController
@property (assign, nonatomic) NSInteger *index;
@property (weak, nonatomic) IBOutlet UILabel *screenNumber;

@end
