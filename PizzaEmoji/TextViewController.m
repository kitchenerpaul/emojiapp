//
//  TextViewController.m
//  PizzaEmoji
//
//  Created by Amar Bhatia on 6/30/16.
//  Copyright © 2016 Box Score Games. All rights reserved.
//

#import "TextViewController.h"
#import "EmojiViewController.h"

@interface TextViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation TextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(0,0,140,140)];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"before after"];
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
    textAttachment.image = [UIImage imageNamed:@"skull"];
    
    CGFloat oldWidth = textAttachment.image.size.width;
    
    //I'm subtracting 10px to make the image display nicely, accounting
    //for the padding inside the textView
    CGFloat scaleFactor = oldWidth / (self.textView.frame.size.width - 10);
    textAttachment.image = [UIImage imageWithCGImage:textAttachment.image.CGImage scale:scaleFactor orientation:UIImageOrientationUp];
    NSAttributedString *attrStringWithImage = [NSAttributedString attributedStringWithAttachment:textAttachment];
    [attributedString replaceCharactersInRange:NSMakeRange(6, 1) withAttributedString:attrStringWithImage];
    self.textView.attributedText = attributedString;

}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
