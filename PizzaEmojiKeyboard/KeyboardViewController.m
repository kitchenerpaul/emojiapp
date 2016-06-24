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


@interface KeyboardViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
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

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onKeyboardHide:) name:UIKeyboardWillHideNotification object:nil];


    self.imageNames = [NSArray arrayWithObjects:@"fantasypizza", @"mopizza", @"pizzaordeath", @"skull", @"sliceaday", @"pizzapie", @"pizzaparty", @"pizzatown", @"fantasypizza", @"mopizza", @"pizzaordeath", @"skull", @"sliceaday", @"pizzapie", @"pizzaparty", @"pizzatown", @"fantasypizza", @"mopizza", @"pizzaordeath", @"skull", @"sliceaday", @"pizzapie", @"pizzaparty", @"pizzatown", @"fantasypizza", @"mopizza", @"pizzaordeath", @"skull", @"sliceaday", @"pizzapie", @"pizzaparty", @"pizzatown", @"fantasypizza", @"mopizza", @"pizzaordeath", @"skull", @"sliceaday", @"pizzapie", @"pizzaparty", @"pizzatown", @"fantasypizza", @"mopizza", @"pizzaordeath", @"skull", @"sliceaday", @"pizzapie", @"pizzaparty", @"pizzatown", @"fantasypizza", @"mopizza", @"pizzaordeath", @"skull", @"sliceaday", @"pizzapie", @"pizzaparty", @"pizzatown", @"fantasypizza", @"mopizza", @"pizzaordeath", @"skull", @"sliceaday", @"pizzapie", @"pizzaparty", @"pizzatown",nil];

    NSMutableArray *images = [NSMutableArray new];

    for (NSString *imageName in self.imageNames) {
        [images addObject:[UIImage imageNamed:imageName]];
    }

    self.emojiIcons = [NSArray arrayWithArray:images];

    [self setupGlobalButton];
    [self setupDeleteButton];

    // Perform custom UI setup here
    [self.keyboard.globeKey addTarget:self action:@selector(advanceToNextInputMode) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

    //    [[UIPasteboard generalPasteboard] setImage:nil];
    NSLog(@"MEMORY BREACH!");
}

-(void)onKeyboardHide:(NSNotification *)notification
{
    NSLog(@"---> KEYBOARD HIDE NOTIFICATION");
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

- (void)setupDeleteButton {
    self.deleteButton = [UIButton buttonWithType:UIButtonTypeSystem];

    [self.deleteButton setTitle:NSLocalizedString(@"Delete", @"Title for 'Delete' button") forState:UIControlStateNormal];
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
    layout.sectionInset = UIEdgeInsetsMake(0, 10, 10, 0);
    layout.itemSize = CGSizeMake(60, 60);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

    CGRect collectionFrame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height - 44);
    self.collectionView = [[UICollectionView alloc] initWithFrame:collectionFrame collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[KeyboardCollectionViewCell class] forCellWithReuseIdentifier:@"CellID"];
    [self.view addSubview:self.collectionView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.emojiIcons.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (KeyboardCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    KeyboardCollectionViewCell *keyboardCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellID" forIndexPath:indexPath];
    if(keyboardCell.emojiImageView == nil) {
        keyboardCell.emojiImageView = [[UIImageView alloc] initWithFrame:keyboardCell.contentView.frame];
        keyboardCell.emojiImageView.contentMode = UIViewContentModeScaleAspectFit;
        [keyboardCell.contentView addSubview:keyboardCell.emojiImageView];
    }

    keyboardCell.imageName = self.imageNames[indexPath.row];
    keyboardCell.emojiImageView.image = self.emojiIcons[indexPath.row];

    return keyboardCell;
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
