//
//  KeyboardViewController.m
//  PizzaEmojiKeyboard
//
//  Created by Amar Bhatia on 6/14/16.
//  Copyright © 2016 Box Score Games. All rights reserved.
//

#import "KeyboardViewController.h"
#import "Keyboard.h"

@interface KeyboardViewController ()
@property (strong, nonatomic) Keyboard *keyboard;
@end

@implementation KeyboardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Perform Custom Intialization Here
    }
    
    return self;
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    // Add custom view sizing constraints here
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.keyboard = [[[NSBundle mainBundle] loadNibNamed:@"Keyboard" owner:nil options:nil] objectAtIndex:0];
    [self addGesturesToKeyboard];
    self.inputView = self.keyboard;
    
    // Perform custom UI setup here
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated
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
}

#pragma Change Keyboards

// Change Next KeyBoard

- (void)addGesturesToKeyboard {
    [self.keyboard.globeKey addTarget:self action:@selector(advanceToNextInputMode)forControlEvents:UIControlEventTouchUpInside];
    
    for (UIButton *key in self.keyboard.keyEmojisArray) {
        [key addTarget:self action:@selector(pressKey:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)pressKey:(UIButton *)key {
    [self.textDocumentProxy insertText:[key currentTitle]];
}

@end
