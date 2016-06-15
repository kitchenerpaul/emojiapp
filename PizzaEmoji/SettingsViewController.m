//
//  SetttingsViewController.m
//  PizzaEmoji
//
//  Created by Amar Bhatia on 6/14/16.
//  Copyright © 2016 Box Score Games. All rights reserved.
//

#import "SettingsViewController.h"
#import "Settings.h"
#import "RateMyAppViewController.h"
#import "SettingsTableViewCell.h"

@interface SettingsViewController () <UITableViewDataSource, UITableViewDelegate>

@property NSArray *settings;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Settings *one = [[Settings alloc] initWithName:@"Rate App" andImage:[UIImage imageNamed:@"default"]];
    Settings *two = [[Settings alloc] initWithName:@"Install Keyboard" andImage:[UIImage imageNamed:@"default"]];
    Settings *three = [[Settings alloc] initWithName:@"Share With Friends" andImage:[UIImage imageNamed:@"default"]];
    Settings *four = [[Settings alloc] initWithName:@"Contact Us" andImage:[UIImage imageNamed:@"default"]];
    Settings *five = [[Settings alloc] initWithName:@"Follow Us" andImage:[UIImage imageNamed:@"default"]];
    Settings *six = [[Settings alloc] initWithName:@"WIN FREE PIZZA" andImage:[UIImage imageNamed:@"default"]];
    Settings *seven = [[Settings alloc] initWithName:@"Privacy Policy" andImage:[UIImage imageNamed:@"default"]];

    self.settings = [NSArray arrayWithObjects:one, two, three, four, five, six, seven, nil];

    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.settings.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SettingsTableViewCell *settingsCell = [tableView dequeueReusableCellWithIdentifier:@"SettingsCell"];
    Settings *settings = [self.settings objectAtIndex:indexPath.row];
    settingsCell.titleLabel.text = settings.name;
    //    settingsCell.emojiImageView.image = settings.emojiImage;
    return settingsCell;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 1:
            [self performSegueWithIdentifier:@"rateMyApp" sender:self];
            break;
        case 2:
            [self performSegueWithIdentifier:@"installKeyboard" sender:self];
            break;
        case 3:
            [self performSegueWithIdentifier:@"shareWithFriends" sender:self];
            break;
        case 4:
            [self performSegueWithIdentifier:@"contactUs" sender:self];
            break;
        case 5:
            [self performSegueWithIdentifier:@"followUs" sender:self];
            break;
        case 6:
            [self performSegueWithIdentifier:@"winFreePizza" sender:self];
            break;
        case 7:
            [self performSegueWithIdentifier:@"privacyPolicy" sender:self];
            break;
        default:
            break;
    }
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
