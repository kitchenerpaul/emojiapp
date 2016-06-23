//
//  PrivacyPolicyViewController.m
//  PizzaEmoji
//
//  Created by Amar Bhatia on 6/14/16.
//  Copyright © 2016 Box Score Games. All rights reserved.
//

#import "PrivacyPolicyViewController.h"

@interface PrivacyPolicyViewController ()

@end

@implementation PrivacyPolicyViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"Privacy Policy";
}

-(void)viewDidLayoutSubviews {

    self.privacyPolicyTextView.text = @"1. PizzaEmoji (\"Application\") will not ask or obtain any personal information. The Application will not collect any personal data. Any information typed via the Application by user, will not be logged or saved.\n\n2. The iOS 8 warns users about the information and materials that third-party keyboards can have access to. The Application will not save or log any information. The \"Full Access\" is needed for the adaptations between Application and the keyboard, to apply the additional features that PizzaEmoji provides.\n\n3. Our company uses electronic and procedural safeguards to protect information we process and maintain. Only authorized employees can access the information to operate, develop or improve our Application.\n\n4. The Application is provided to you AS IS.\n\n5. We reserve the right to modify this Privacy Policy at any time for any reason. Please check this Privacy Policy regularly for any changes.";

}

@end
