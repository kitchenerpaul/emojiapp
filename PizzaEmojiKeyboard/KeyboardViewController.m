//
//  KeyboardViewController.m
//  PizzaEmojiKeyboard
//
//  Created by Amar Bhatia on 6/14/16.
//  Copyright © 2016 Box Score Games. All rights reserved.
//

#import "KeyboardViewController.h"
#import "KeyboardCollectionViewCell.h"
#import "CustomKeyboardViewController.h"

@interface KeyboardViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UIButton *nextKeyboardButton;
@property (strong, nonatomic)  CustomKeyboardViewController *keyboard;
@property UICollectionView *collectionView;

@end

@implementation KeyboardViewController

- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    // Add custom view sizing constraints here
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.emojiIcons = [NSArray arrayWithObjects:@"fantasypizza", @"mopizza", @"pizzaordeath", @"skull", nil];
    
    [self setupGlobalButton];
    
    // Perform custom UI setup here
    [self.keyboard.globeKey addTarget:self action:@selector(advanceToNextInputMode) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setupGlobalButton {
    self.nextKeyboardButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [self.nextKeyboardButton setTitle:NSLocalizedString(@"Next Keyboard", @"Title for 'Next Keyboard' button") forState:UIControlStateNormal];
    [self.nextKeyboardButton sizeToFit];
    self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.nextKeyboardButton addTarget:self action:@selector(advanceToNextInputMode) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.nextKeyboardButton];
    
    [self.nextKeyboardButton.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [self.nextKeyboardButton.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated
}

#pragma Change Keyboards

// Change Next KeyBoard

- (void)addGesturesToKeyboard {
    [self.keyboard.globeKey addTarget:self action:@selector(advanceToNextInputMode)forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)pressKey:(UIButton *)key {
    [self.textDocumentProxy insertText:[key currentTitle]];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.itemSize = CGSizeMake(150, 150);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    CGRect collectionFrame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height - 44);
    self.collectionView = [[UICollectionView alloc] initWithFrame:collectionFrame collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"KeyboardCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CELL"];
    
    
    
    [self.view addSubview:self.collectionView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.emojiIcons.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (KeyboardCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    KeyboardCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    cell.emojiImageView.image = [UIImage imageNamed:self.emojiIcons[indexPath.row]];
    
    // Code below does not load the images
    
//    UIImageView *emojiImageView = [[UIImageView alloc] init];
//    emojiImageView.image = [self.emojiIcons objectAtIndex:indexPath.row];
//    [cell addSubview:emojiImageView];
    
    // End code that does not load the images

    if (indexPath.row % 2 == 0) {
        cell.backgroundColor = [UIColor redColor];
    } else {
        cell.backgroundColor = [UIColor blueColor];
    }
    
    return cell;
}

//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    KeyboardCollectionViewCell *cell = (KeyboardCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
//    NSArray *views = [cell.contentView subviews];
//    UILabel *label = [views objectAtIndex:0];
//    NSLog(@"Select %@",label.text);
    
    // Copy the data to the Clipboard
//    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
//    NSData *imgData = UIImagePNGRepresentation(@"skull");
//    [pasteboard setData:imgData forPasteboardType:[UIPasteboardTypeListImage objectAtIndex:0]];
//
//}


- (void)textWillChange:(id<UITextInput>)textInput {
    // The app is about to change the document's contents. Perform any preparation here.
}

- (void)textDidChange:(id<UITextInput>)textInput {
    // The app has just changed the document's contents, the document context has been updated.
    
    UIColor *textColor = nil;
    if (self.textDocumentProxy.keyboardAppearance == UIKeyboardAppearanceDark) {
        textColor = [UIColor whiteColor];
    } else {
        textColor = [UIColor blackColor];
    }
    [self.nextKeyboardButton setTitleColor:textColor forState:UIControlStateNormal];
}

#pragma mark -

- (void)keyboardViewShouldAdvanceToNextInputMode
{
    [self advanceToNextInputMode];
}

- (void)keyboardViewShouldDismiss
{
    [self dismissKeyboard];
}

- (void)keyboardViewDidInputDelete
{
    [self.textDocumentProxy deleteBackward];
}

- (void)keyboardViewDidInputReturn
{
    [self.textDocumentProxy insertText:@"\n"];
}

- (void)keyboardViewBackCursor
{
    [self.textDocumentProxy adjustTextPositionByCharacterOffset:-1];
}

- (void)keyboardViewForwardCursor
{
    [self.textDocumentProxy adjustTextPositionByCharacterOffset:1];
}

- (void)keyboardView:(KeyboardViewController *)keyboardViewController didAcceptCandidate:(NSString *)candidate
{
    [self.textDocumentProxy insertText:candidate];
}



@end
