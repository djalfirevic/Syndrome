//
//  PatientTableViewCell.m
//  Syndrome
//
//  Created by Djuro Alfirevic on 9/15/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "PatientTableViewCell.h"
#import "Patient+CoreDataClass.h"

@implementation PatientTableViewCell

#pragma mark - Properties

- (void)setPatient:(Patient *)patient {
    _patient = patient;
    
    self.nameLabel.text = [patient fullName];
    self.probabilityLabel.text = [patient formattedProbability];
}

@end
