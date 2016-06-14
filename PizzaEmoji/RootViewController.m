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
        [emojis addObject:[UIImage imageNamed:@"skull"]];
    }
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

    float cellWidth = size.width/4;
    return cellWidth;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    selectedEmoji = [emojis objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"RootToEmojiSegue" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    // Pass emoji to EmojiViewController

    if ([segue.identifier isEqualToString:@"RootToEmojiSegue"]) {
        EmojiViewController *evc = segue.destinationViewController;
        evc.emoji = selectedEmoji;
    }
}



@end
