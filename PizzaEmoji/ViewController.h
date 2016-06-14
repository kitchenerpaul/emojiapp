//
//  ViewController.h
//  PizzaEmoji
//
//  Created by Paul Kitchener on 6/13/16.
//  Copyright © 2016 Box Score Games. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate> {

    IBOutlet UICollectionView *emojiCollectionView;
    IBOutlet UICollectionViewFlowLayout *layout;

}


@end