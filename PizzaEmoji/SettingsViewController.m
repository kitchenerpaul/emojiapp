//
//  SetttingsViewController.m
//  PizzaEmoji
//
//  Created by Amar Bhatia on 6/14/16.
//  Copyright © 2016 Box Score Games. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Set navigation bar colors
//    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:207/255.2f green:55/255.2f  blue:33/255.2f  alpha:1]];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"< Back" style:UIBarButtonItemStylePlain target:self action:@selector(dismissView)];

}

-(void)viewDidAppear:(BOOL)animated {

    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"tablecloth"]]];
    
}

-(void)viewWillAppear:(BOOL)animated {
    self.view.hidden = YES;
    if ([self.sourceSegueID isEqualToString:@"FREEPIZZA"]) {
        [self performSegueWithIdentifier:@"WinFreePizzaSegue" sender:self];
    }
    self.view.hidden = NO;
}

- (void)dismissView {
    [[self navigationController] popViewControllerAnimated:YES];
}

- (IBAction)onRateAppButtonPressed:(UIButton *)sender {

    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.apple.com"]];
}

- (IBAction)onInstallKeyboardButtonPressed:(UIButton *)sender {

    [self performSegueWithIdentifier:@"SettingsToTutorialSegue" sender:self];
}

- (IBAction)onShareWithFriendsButtonPressed:(UIButton *)sender {

    [self shareContent];
}

- (IBAction)onFollowUsButtonPressed:(UIButton *)sender {

    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.instagram.com/boxscoregames/"]];
}

- (IBAction)onWinFreePizzaButtonPressed:(UIButton *)sender {

    [self performSegueWithIdentifier:@"WinFreePizzaSegue" sender:self];
//    self.sourceSegueID = nil;

}

- (IBAction)onPrivacyPolicyButtonPressed:(UIButton *)sender {

    [self performSegueWithIdentifier:@"PrivacyPolicySegue" sender:self];

}

- (IBAction)onContactButtonPressed:(UIButton *)sender {

    [self performSegueWithIdentifier:@"ContactUsSegue" sender:self];
}

// Allows separator lines to extend full width of view
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{

    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }

    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(void)shareContent{

    NSString *message = @"Get the glorious combination of pizza and emojis here:\nhttp://boxscoregames.com\n\n#PizzaEmojiApp";
    UIImage *emojiImage = [UIImage imageNamed:@"skull"];
    NSArray *shareItems = [[NSArray alloc]initWithObjects:emojiImage, message, nil];
    UIActivityViewController *avc = [[UIActivityViewController alloc] initWithActivityItems:shareItems applicationActivities:nil];
    [self presentViewController:avc animated:YES completion:nil];
}

#pragma mark - Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UITableViewCell *)cell{

    if ([segue.identifier isEqualToString:@"WinFreePizzaSegue"]) {
        self.sourceSegueID = @"";
    }

}

@end
