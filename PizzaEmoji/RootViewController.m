//
//  ViewController.m
//  PizzaEmoji
//
//  Created by Paul Kitchener on 6/13/16.
//  Copyright © 2016 Box Score Games. All rights reserved.
//

#import "RootViewController.h"
#import "EmojiCollectionViewCell.h"
#import "EmojiViewController.h"

@interface RootViewController ()
{
    CGFloat cellHeight;
    NSMutableArray *emojis;
    UIImage *selectedEmoji;
}

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    cellHeight = 150;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    CGFloat cellWidth =  [self calcCellWidth:self.view.frame.size];
    layout.itemSize = CGSizeMake(cellWidth, cellHeight);

    emojis = [NSMutableArray new];

    for (int i = 0; i < 30; i++) {
        if (i%2==0) {
            [emojis addObject:[UIImage imageNamed:@"mopizza"]];
        } else if (i%3==0) {
            [emojis addObject:[UIImage imageNamed:@"pizzapie"]];
        } else {
            [emojis addObject:[UIImage imageNamed:@"pizzaordeath"]];
        }
    }

    // Set navigation bar to a red color
//    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:207/255.2f green:57/255.2f  blue:39/255.2f  alpha:1]];
    // Set navigation bar title color to white
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};

    UIImage *freePizzaImage = [UIImage imageNamed:@"freepizza"];
    CGRect pizzaFrame = CGRectMake(0, 0, 70, 35);
    UIButton *pizzaButton = [[UIButton alloc] initWithFrame:pizzaFrame];
    [pizzaButton setBackgroundImage:freePizzaImage forState:UIControlStateNormal];
    [pizzaButton addTarget:self action:@selector(segueToPizzaPage)
         forControlEvents:UIControlEventTouchUpInside];
    [pizzaButton setShowsTouchWhenHighlighted:YES];

    UIBarButtonItem *pizzaBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:pizzaButton];
    self.navigationItem.leftBarButtonItem = pizzaBarButtonItem;

}

-(void)viewDidAppear:(BOOL)animated {

    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"tablecloth"]]];

}

#pragma mark UICollectionView DataSource

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    EmojiCollectionViewCell *emojiCell =  [collectionView dequeueReusableCellWithReuseIdentifier:@"EmojiCellID" forIndexPath:indexPath];
    emojiCell.emojiImageView.image = [emojis objectAtIndex:indexPath.row];
    return emojiCell;

}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return emojis.count;

}

-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {

    CGFloat cellWidth = [self calcCellWidth:size];
    layout.itemSize = CGSizeMake(cellWidth, 200);

}

-(CGFloat) calcCellWidth :(CGSize) size {

    float cellWidth = size.width/3;
    return cellWidth;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    selectedEmoji = [emojis objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"RootToEmojiSegue" sender:self];
}


-(void)segueToPizzaPage {
    NSLog(@"Yay for Pizza!");
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    // Pass emoji to EmojiViewController

    if ([segue.identifier isEqualToString:@"RootToEmojiSegue"]) {
        EmojiViewController *evc = segue.destinationViewController;
        evc.emoji = selectedEmoji;
    }
}



@end
