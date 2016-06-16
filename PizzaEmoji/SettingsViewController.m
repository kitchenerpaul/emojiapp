//
//  SetttingsViewController.m
//  PizzaEmoji
//
//  Created by Amar Bhatia on 6/14/16.
//  Copyright © 2016 Box Score Games. All rights reserved.
//

#import "SettingsViewController.h"
#import "RateMyAppViewController.h"
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

//    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
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
        [self performSegueWithIdentifier:@"RateMyAppSegue" sender:self];
    } else if (indexPath.row == 1) {
        [self performSegueWithIdentifier:@"SettingsToTutorialSegue" sender:self];
    } else if (indexPath.row == 2) {
        [self performSegueWithIdentifier:@"ShareWithFriendsSegue" sender:self];
    } else if (indexPath.row == 3) {
        [self performSegueWithIdentifier:@"FollowUsSegue" sender:self];
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

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{

    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }

    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark - Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UITableViewCell *)cell{
    
}

- (IBAction)onBackBarButtonPressed:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"SettingsToRootSegue" sender:self];
}



@end
