//
//  CustomKeyboardViewController.h
//  PizzaEmoji
//
//  Created by Amar Bhatia on 6/17/16.
//  Copyright © 2016 Box Score Games. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyboardCollectionViewCell.h"

@interface CustomKeyboardViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end
