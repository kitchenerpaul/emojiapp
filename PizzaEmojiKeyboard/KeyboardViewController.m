//
//  KeyboardViewController.m
//  PizzaEmojiKeyboard
//
//  Created by Amar Bhatia on 6/14/16.
//  Copyright © 2016 Box Score Games. All rights reserved.
//

#import "KeyboardViewController.h"
#import "CustomKeyboardViewController.h"
#import "KeyboardCollectionViewCell.h"


@interface KeyboardViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UIActionSheetDelegate>
@property (nonatomic, strong) UIButton *nextKeyboardButton;
@property (nonatomic, strong) UIButton *deleteButton;
@property (strong, nonatomic)  CustomKeyboardViewController *keyboard;
@property UICollectionView *collectionView;
@property UICollectionViewCell *collectionViewCell;

@property NSArray *imageNames;

@end

@implementation KeyboardViewController

- (void)updateViewConstraints {
    [super updateViewConstraints];

    // Add custom view sizing constraints here

}

- (void)viewDidLoad {
    [super viewDidLoad];

//    self.view.backgroundColor = [UIColor colorWithRed:207/255.2f green:57/255.2f  blue:39/255.2f  alpha:1];
    self.view.backgroundColor = [UIColor whiteColor];

    NSURL *localDirectory = [[NSFileManager defaultManager] URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask][0];
    NSLog(@"KEYBOARD ---> %@", localDirectory.absoluteString);

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onKeyboardHide:) name:UIKeyboardWillHideNotification object:nil];

    self.imageNames = [NSArray arrayWithObjects:
                       @"cheese",
                       @"pepperoni",
                       @"sausage",
                       @"meatlovers",
                       @"veggie",
                       @"deepdish",
                       @"breakfast",
                       @"lunch",
                       @"dinner",
                       @"sunday",
                       @"monday",
                       @"tuesday",
                       @"wednesday",
                       @"thursday",
                       @"friday",
                       @"saturday",
                       @"cheatday",
                       @"mopizza",
                       @"pizzapie",
                       @"sliceaday",
                       @"pizzatown",
                       @"pizzaordeath",
                       @"pizzaparty",
                       @"toppingbacon",
                       @"toppingblackolives",
                       @"toppingmushrooms",
                       @"toppingonions",
                       @"toppingpepperoni",
                       @"toppingpeppers",
                       @"toppingpineapple",
                       @"toppingsausage",
                       @"toppingshrimp",
                       @"toppingbasil",
                       @"toppingtomato",
                       nil];

    [self setupGlobalButton];
    [self setupDeleteButton];

    // Perform custom UI setup here
    [self.keyboard.globeKey addTarget:self action:@selector(advanceToNextInputMode) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

        [[UIPasteboard generalPasteboard] setImage:nil];
    NSLog(@"MEMORY BREACH!");
}

-(void)onKeyboardHide:(NSNotification *)notification
{
    NSLog(@"---> KEYBOARD HIDE NOTIFICATION");
}

- (void)setupGlobalButton {

    UIImage *globeImage = [UIImage imageNamed:@"globebutton"];
    CGRect globeFrame = CGRectMake(0, 0, 88, 44);

    self.nextKeyboardButton = [[UIButton alloc] initWithFrame:globeFrame];
    [self.nextKeyboardButton setBackgroundImage:globeImage forState:UIControlStateNormal];

    [self.nextKeyboardButton sizeToFit];
    self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = NO;

    [self.nextKeyboardButton addTarget:self action:@selector(advanceToNextInputMode) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:self.nextKeyboardButton];

    [self.nextKeyboardButton.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [self.nextKeyboardButton.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;

}

- (void)setupDeleteButton {
    UIImage *deleteImage = [UIImage imageNamed:@"deletebutton"];
    CGRect deleteFrame = CGRectMake(0, 0, 88, 44);

    self.deleteButton = [[UIButton alloc] initWithFrame:deleteFrame];
    [self.deleteButton setBackgroundImage:deleteImage forState:UIControlStateNormal];

    [self.deleteButton sizeToFit];
    self.deleteButton.translatesAutoresizingMaskIntoConstraints = NO;

    [self.deleteButton addTarget:self action:@selector(keyboardViewDidInputDelete) forControlEvents:UIControlEventTouchUpInside];


    [self.view addSubview:self.deleteButton];

    [self.deleteButton.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
    [self.deleteButton.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
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
    layout.sectionInset = UIEdgeInsetsMake(15, 15, 15, 15);
    layout.itemSize = CGSizeMake(60, 60);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;


    CGRect collectionFrame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height - 44);
    self.collectionView = [[UICollectionView alloc] initWithFrame:collectionFrame collectionViewLayout:layout];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[KeyboardCollectionViewCell class] forCellWithReuseIdentifier:@"CellID"];
    [self.view addSubview:self.collectionView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    CGRect collectionFrame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height - 44);

    self.collectionView.frame = collectionFrame;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imageNames.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (KeyboardCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    KeyboardCollectionViewCell *keyboardCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellID" forIndexPath:indexPath];
    if(keyboardCell.emojiImageView == nil) {
        keyboardCell.emojiImageView = [[UIImageView alloc] initWithFrame:keyboardCell.contentView.frame];
        keyboardCell.emojiImageView.contentMode = UIViewContentModeScaleAspectFit;
        [keyboardCell.contentView addSubview:keyboardCell.emojiImageView];
    }

    keyboardCell.targetName = self.imageNames[indexPath.row];
    keyboardCell.imageName = [NSString stringWithFormat:@"%@Keyboard", keyboardCell.targetName];
    keyboardCell.emojiImageView.image = [UIImage imageNamed:keyboardCell.imageName];

    return keyboardCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"SELECTED");

    UIPasteboard *pb = [UIPasteboard generalPasteboard];

    //Uncomment following 3 lines to allow sharing at small size
//    NSString *targetName = self.imageNames[indexPath.row];
//    NSString *imageName = [NSString stringWithFormat:@"%@Keyboard", targetName];
//    pb.image = [UIImage imageNamed:imageName];

    //Comment out following line to disallow sharing full-size images
    pb.image = [UIImage imageNamed:self.imageNames[indexPath.row]];
    pb.persistent = NO;

    UILabel *notify = [[UILabel alloc] initWithFrame:self.view.frame];
//    notify.hidden = YES;
    notify.alpha = 0.0;
    notify.backgroundColor = [UIColor blackColor];

    notify.text = @"Copied to Clipboard!";
    notify.textColor = [UIColor whiteColor];
    notify.textAlignment = NSTextAlignmentCenter;

    [self.view addSubview:notify];
    [UIView animateWithDuration:0.3 animations:^{
        notify.alpha = 0.75;
    } completion:^(BOOL finished) {

        [UIView animateWithDuration:0.3 delay:0.35 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            notify.alpha = 0.0;
        } completion:^(BOOL finished) {
            [notify removeFromSuperview];
        }];
    }];

}

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

// New

@end
