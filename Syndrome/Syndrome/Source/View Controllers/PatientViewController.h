//
//  PatientViewController.h
//  Syndrome
//
//  Created by Djuro Alfirevic on 9/15/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Patient;

@interface PatientViewController : UIViewController
@property (strong, nonatomic) Patient *patient;
@end
