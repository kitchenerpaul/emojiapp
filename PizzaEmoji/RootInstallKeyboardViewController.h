//
//  RootInstallKeyboardViewController.h
//  PizzaEmoji
//
//  Created by Amar Bhatia on 6/15/16.
//  Copyright © 2016 Box Score Games. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageContentViewController.h"

@interface RootInstallKeyboardViewController : UIViewController
- (IBAction)startWalkthrough:(id)sender;
@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pageTitles;
@property (strong, nonatomic) NSArray *pageImages;


@end
