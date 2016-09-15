//
//  HomeViewController.m
//  Syndrome
//
//  Created by Djuro Alfirevic on 9/15/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "HomeViewController.h"
#import "WebViewController.h"
#import "MenuView.h"

@interface HomeViewController() <MenuViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *doctorsImageView;
@end

@implementation HomeViewController

#pragma mark - Private API

- (void)animateViewWith3dEffect:(UIView *)view {
    CATransform3D rotation = CATransform3DMakeRotation((90.0f * M_PI)/180.0f, 0.0f, 0.5f, 0.5f);
    view.alpha = 0.8f;
    view.layer.transform = rotation;
    view.layer.anchorPoint = CGPointMake(0.0f, 0.5f);
    
    [UIView animateWithDuration:0.5f
                     animations:^{
                         view.layer.transform = CATransform3DIdentity;
                         view.alpha = 1.0f;
                     } completion:NULL];
}

#pragma mark - View lifecycle

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self animateViewWith3dEffect:self.doctorsImageView];
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[WebViewController class]]) {
        WebViewController *toViewController = segue.destinationViewController;
        toViewController.urlString = @"https://en.wikipedia.org/wiki/Alice_in_Wonderland_syndrome";
    }
}

#pragma mark - MenuViewDelegate

- (void)menuViewOptionTapped:(MenuOption)option {
    if (option == HISTORY_MENU_OPTION) {
        [self performSegueWithIdentifier:@"HistorySegue" sender:self];
    } else if (option == PATIENT_MENU_OPTION) {
        [self performSegueWithIdentifier:@"PatientSegue" sender:self];
    }
}

@end
