//
//  PageContentViewController.h
//  PizzaEmoji
//
//  Created by Amar Bhatia on 6/15/16.
//  Copyright © 2016 Box Score Games. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageContentViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property NSUInteger pageIndex;
@property NSString *titleText;
@property NSString *imageFile;

@end
