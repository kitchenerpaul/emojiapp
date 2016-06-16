//
//  SetttingsViewController.m
//  PizzaEmoji
//
//  Created by Amar Bhatia on 6/14/16.
//  Copyright © 2016 Box Score Games. All rights reserved.
//

#import "SettingsViewController.h"
#import "SettingsTableViewCell.h"

@interface SettingsViewController () <UITableViewDataSource, UITableViewDelegate>

@property NSArray *settingsTitles;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Set navigation bar colors
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:207/255.2f green:55/255.2f  blue:33/255.2f  alpha:1]];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

    self.settingsTitles = [[NSArray alloc] initWithObjects:@"Rate the App", @"Install Keyboard", @"Share with Friends", @"Follow Us!", nil];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.settingsTitles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SettingsTableViewCell *settingsCell = [tableView dequeueReusableCellWithIdentifier:@"SettingsCellID" forIndexPath:indexPath];
    settingsCell.titleLabel.text = [self.settingsTitles objectAtIndex:indexPath.row];
    return settingsCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

        if (indexPath.row == 0) {
            //Rate the App
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.apple.com"]];
        } else if (indexPath.row == 1) {
            //Install Keyboard Tutorial
            [self performSegueWithIdentifier:@"SettingsToTutorialSegue" sender:self];
        } else if (indexPath.row == 2) {
            //Share with Friends
            [self shareContent];
        } else if (indexPath.row == 3) {
            //Follow Us
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.instagram.com/boxscoregames/"]];
        }
}

- (IBAction)onWinFreePizzaButtonPressed:(UIButton *)sender {

    [self performSegueWithIdentifier:@"WinFreePizzaSegue" sender:self];

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

}

@end
