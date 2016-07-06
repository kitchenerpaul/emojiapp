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
@property UICollectionView *letterKeyboardCollectionView;
@property NSArray *imageNames;
@property int shiftStatus; //0 = off, 1 = on, 2 = caps lock


//keyboard rows
@property (nonatomic, weak) IBOutlet UIView *numbersRow1View;
@property (nonatomic, weak) IBOutlet UIView *numbersRow2View;
@property (nonatomic, weak) IBOutlet UIView *symbolsRow1View;
@property (nonatomic, weak) IBOutlet UIView *symbolsRow2View;
@property (nonatomic, weak) IBOutlet UIView *numbersSymbolsRow3View;

//keys
@property (nonatomic, strong) IBOutletCollection(UIButton) NSArray *letterButtonsArray;
@property (nonatomic, weak) IBOutlet UIButton *switchModeRow3Button;
@property (nonatomic, weak) IBOutlet UIButton *switchModeRow4Button;
@property (nonatomic, weak) IBOutlet UIButton *shiftButton;
@property (nonatomic, weak) IBOutlet UIButton *spaceButton;
@property (weak, nonatomic) IBOutlet UIButton *globeKey;
@property (weak, nonatomic) IBOutlet UIButton *oneTwoThreeButton;
@property (weak, nonatomic) IBOutlet UIButton *returnButton;

@end

@implementation KeyboardViewController

- (void)updateViewConstraints {
    [super updateViewConstraints];

    // Add custom view sizing constraints here

}

- (void)viewDidLoad {
    [super viewDidLoad];
//    if ([self isOpenAccessGranted] == false) {  //  if user doesn't allow access, show our custom keyboard
//    
//    [self initializeKeyboard];
//    
//
//        
//    } else {
    
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
//    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    if ([self isOpenAccessGranted] == false) {  //  if user doesn't allow access, show our custom keyboard

        // Hide Other Keyboard Buttons
        self.nextKeyboardButton.hidden = YES;
        self.deleteButton.hidden = YES;

        [self initializeKeyboard];

    } else {

        // if the User allows access, show collectionview keyboard

        // Hide Other Keyboard Buttons
        self.shiftButton.hidden = YES;
        self.spaceButton.hidden = YES;
        self.globeKey.hidden = YES;
        self.returnButton.hidden = YES;
        self.oneTwoThreeButton.hidden = YES;

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

}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

 }

-(void)createdItemsForView {
    //        // Create Exit Button
    //
    //        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    //        [button addTarget:self
    //                   action:@selector(keyboardViewShouldAdvanceToNextInputMode)
    //         forControlEvents:UIControlEventTouchUpInside];
    //        [button setImage:[UIImage imageNamed:@"globebutton"] forState:UIControlStateNormal];
    //        button.frame = CGRectMake(0, 0, 100, 40.0);
    //        [self.view addSubview:button];
    //
    //        // Create Label
    //        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(60, -35, 200, 130)];
    //        label.backgroundColor = [UIColor clearColor];
    //        label.textAlignment = NSTextAlignmentCenter;
    //        label.textColor = [UIColor redColor];
    //        label.text = @"Allow Full Access ";
    //
    //
    //        // Create UITextView
    //        CGRect textViewFrame = CGRectMake(70 , 40, 200, 130);
    //        UITextView *textView = [[UITextView alloc] initWithFrame:textViewFrame];
    //        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    //        view.backgroundColor = [UIColor redColor];
    //        textView.text=@"To use PizzaEmoji you must authorize 'Allow Full Access' in SETTINGS. This is simply an iOS requirement. We do not read or record anything you type. Our user's privacy is very important to us. Alterntively, all of the content can be seen directly from the app";
    //        textView.editable = NO;
    //        textView.scrollEnabled = NO;
    //        textView.alwaysBounceVertical = YES;
    //        UIFont *font = [UIFont fontWithName:@"soupofjustice" size:12];
    //        [textView setFont:font];
    //        textView.backgroundColor = [UIColor whiteColor];
    //        textView.textColor = [UIColor redColor];
    //
    //
    //        [self.view addSubview:textView];
    //        [self.view addSubview:label];
    //        [self.view addSubview:button];
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

-(BOOL)isOpenAccessGranted{
//    return [UIPasteboard generalPasteboard];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    NSLog(@"pasteboard: %@", pasteboard);
    if(pasteboard){
        NSLog(@"Full Access On");
        return YES;
    }else{
        NSLog(@"Full Access: Off");
        return NO;
    }
}


- (BOOL)isCustomKeyboardEnabled {
    NSString *bundleID = @"com.boxscoregames.pizzaemojiapp"; // Replace this string with your custom keyboard's bundle ID
    NSArray *keyboards = [[[NSUserDefaults standardUserDefaults] dictionaryRepresentation] objectForKey:@"Keyboard"]; // Array of all active keyboards
    for (NSString *keyboard in keyboards) {
        if ([keyboard isEqualToString:bundleID])
            return YES;
    }
    
    return NO;
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

        [UIView animateWithDuration:0.3 delay:0.2 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
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


- (void)keyboardViewShouldAdvanceToNextInputMode:(id) sender
{
    [self advanceToNextInputMode];
}

- (void) initializeKeyboard {
    
    //start with shift on
    _shiftStatus = 1;
    
    //initialize space key double tap
    UITapGestureRecognizer *spaceDoubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(spaceKeyDoubleTapped:)];
    
    spaceDoubleTap.numberOfTapsRequired = 2;
    [spaceDoubleTap setDelaysTouchesEnded:NO];
    
    [self.spaceButton addGestureRecognizer:spaceDoubleTap];
    
    //initialize shift key double and triple tap
    UITapGestureRecognizer *shiftDoubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shiftKeyDoubleTapped:)];
    UITapGestureRecognizer *shiftTripleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shiftKeyPressed:)];
    
    shiftDoubleTap.numberOfTapsRequired = 2;
    shiftTripleTap.numberOfTapsRequired = 3;
    
    [shiftDoubleTap setDelaysTouchesEnded:NO];
    [shiftTripleTap setDelaysTouchesEnded:NO];
    
    [self.shiftButton addGestureRecognizer:shiftDoubleTap];
    [self.shiftButton addGestureRecognizer:shiftTripleTap];
    
}

#pragma mark - key methods

- (IBAction) globeKeyPressed:(id)sender {
    
    //required functionality, switches to user's next keyboard
    [self advanceToNextInputMode];
}

- (IBAction) keyPressed:(UIButton*)sender {
    
    //inserts the pressed character into the text document
    [self.textDocumentProxy insertText:sender.titleLabel.text];
    
    //if shiftStatus is 1, reset it to 0 by pressing the shift key
    if (_shiftStatus == 1) {
        [self shiftKeyPressed:self.shiftButton];
    }
    
}

-(IBAction) backspaceKeyPressed: (UIButton*) sender {
    
    [self.textDocumentProxy deleteBackward];
}



-(IBAction) spaceKeyPressed: (UIButton*) sender {
    
    [self.textDocumentProxy insertText:@" "];
    
}


-(void) spaceKeyDoubleTapped: (UIButton*) sender {
    
    //double tapping the space key automatically inserts a period and a space
    //if necessary, activate the shift button
    [self.textDocumentProxy deleteBackward];
    [self.textDocumentProxy insertText:@". "];
    
    if (_shiftStatus == 0) {
        [self shiftKeyPressed:self.shiftButton];
    }
}


-(IBAction) returnKeyPressed: (UIButton*) sender {
    
    [self.textDocumentProxy insertText:@"\n"];
}


-(IBAction) shiftKeyPressed: (UIButton*) sender {
    
    //if shift is on or in caps lock mode, turn it off. Otherwise, turn it on
    _shiftStatus = _shiftStatus > 0 ? 0 : 1;
    
    [self shiftKeys];
}



-(void) shiftKeyDoubleTapped: (UIButton*) sender {
    
    //set shift to caps lock and set all letters to uppercase
    _shiftStatus = 2;
    
    [self shiftKeys];
    
}


- (void) shiftKeys {
    
    //if shift is off, set letters to lowercase, otherwise set them to uppercase
    if (_shiftStatus == 0) {
        for (UIButton* letterButton in self.letterButtonsArray) {
            [letterButton setTitle:letterButton.titleLabel.text.lowercaseString forState:UIControlStateNormal];
        }
    } else {
        for (UIButton* letterButton in self.letterButtonsArray) {
            [letterButton setTitle:letterButton.titleLabel.text.uppercaseString forState:UIControlStateNormal];
        }
    }
    
    //adjust the shift button images to match shift mode
    NSString *shiftButtonImageName = [NSString stringWithFormat:@"shift_%i.png", _shiftStatus];
    [self.shiftButton setImage:[UIImage imageNamed:shiftButtonImageName] forState:UIControlStateNormal];
    
    
    NSString *shiftButtonHLImageName = [NSString stringWithFormat:@"shift_%iHL.png", _shiftStatus];
    [self.shiftButton setImage:[UIImage imageNamed:shiftButtonHLImageName] forState:UIControlStateHighlighted];
    
}


- (IBAction) switchKeyboardMode:(UIButton*)sender {
    
    self.numbersRow1View.hidden = YES;
    self.numbersRow2View.hidden = YES;
    self.symbolsRow1View.hidden = YES;
    self.symbolsRow2View.hidden = YES;
    self.numbersSymbolsRow3View.hidden = YES;
    
    //switches keyboard to ABC, 123, or #+= mode
    //case 1 = 123 mode, case 2 = #+= mode
    //default case = ABC mode
    
    switch (sender.tag) {
            
        case 1: {
            self.numbersRow1View.hidden = NO;
            self.numbersRow2View.hidden = NO;
            self.numbersSymbolsRow3View.hidden = NO;
            
            //change row 3 switch button image to #+= and row 4 switch button to ABC
            [self.switchModeRow3Button setImage:[UIImage imageNamed:@"symbols.png"] forState:UIControlStateNormal];
            [self.switchModeRow3Button setImage:[UIImage imageNamed:@"symbolsHL.png"] forState:UIControlStateHighlighted];
            self.switchModeRow3Button.tag = 2;
            [self.switchModeRow4Button setImage:[UIImage imageNamed:@"abc.png"] forState:UIControlStateNormal];
            [self.switchModeRow4Button setImage:[UIImage imageNamed:@"abcHL.png"] forState:UIControlStateHighlighted];
            self.switchModeRow4Button.tag = 0;
        }
            break;
            
        case 2: {
            self.symbolsRow1View.hidden = NO;
            self.symbolsRow2View.hidden = NO;
            self.numbersSymbolsRow3View.hidden = NO;
            
            //change row 3 switch button image to 123
            [self.switchModeRow3Button setImage:[UIImage imageNamed:@"numbers.png"] forState:UIControlStateNormal];
            [self.switchModeRow3Button setImage:[UIImage imageNamed:@"numbersHL.png"] forState:UIControlStateHighlighted];
            self.switchModeRow3Button.tag = 1;
        }
            break;
            
        default:
            //change the row 4 switch button image to 123
            [self.switchModeRow4Button setImage:[UIImage imageNamed:@"numbers.png"] forState:UIControlStateNormal];
            [self.switchModeRow4Button setImage:[UIImage imageNamed:@"numbersHL.png"] forState:UIControlStateHighlighted];
            self.switchModeRow4Button.tag = 1;
            break;
    }
}

// Unused Keyboard Methods 

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
