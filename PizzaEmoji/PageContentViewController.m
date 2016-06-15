//
//  PageContentViewController.m
//  PizzaEmoji
//
//  Created by Amar Bhatia on 6/15/16.
//  Copyright © 2016 Box Score Games. All rights reserved.
//

#import "PageContentViewController.h"

@interface PageContentViewController ()

@end

@implementation PageContentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.backgroundImageView.image = [UIImage imageNamed:self.imageFile];
    self.titleLabel.text = self.titleText;

    [self.view bringSubviewToFront:self.titleLabel];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
