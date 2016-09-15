//
//  PatientViewController.m
//  Syndrome
//
//  Created by Djuro Alfirevic on 9/15/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "PatientViewController.h"
#import "ToddSyndromeDetector.h"
#import "Patient+CoreDataClass.h"
#import "DataManager.h"

@interface PatientViewController() <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *surnameTextField;
@property (weak, nonatomic) IBOutlet UITextField *ageTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *genderSegmentedControl;
@property (weak, nonatomic) IBOutlet UISwitch *drugsSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *migrainesSwitch;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *probabilityLabel;
@property (strong, nonatomic) UIPickerView *pickerView;
@property (strong, nonatomic) NSArray *pickerValuesArray;
@end

@implementation PatientViewController

#pragma mark - Properties

- (NSArray *)pickerValuesArray {
    if (!_pickerValuesArray) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (int i = 10; i <= 80; i++) {
            [array addObject:[NSString stringWithFormat:@"%d", i]];
        }
        
        _pickerValuesArray = array;
    }
    
    return _pickerValuesArray;
}

#pragma mark - Actions

- (IBAction)saveButtonTapped {
    if ([self validationPassed]) {
        // If we have patient, that means we're editing the one which already exists
        // If not, we should store it in the database
        if (!self.patient) {
            self.patient = [[DataManager sharedInstance] savePatientWithName:self.nameTextField.text
                                                                     surname:self.surnameTextField.text
                                                                      gender:self.genderSegmentedControl.selectedSegmentIndex
                                                                         age:[self.ageTextField.text integerValue]
                                                                   migraines:self.migrainesSwitch.isOn
                                                                    drugsUse:self.drugsSwitch.isOn];
        } else {
            self.patient.name = self.nameTextField.text;
            self.patient.surname = self.surnameTextField.text;
            self.patient.gender = self.genderSegmentedControl.selectedSegmentIndex;
            self.patient.age = [self.ageTextField.text integerValue];
            self.patient.migraines = self.migrainesSwitch.isOn;
            self.patient.drugsUse = self.drugsSwitch.isOn;
            [[DataManager sharedInstance] updatePatient:self.patient];
        }
        
        self.probabilityLabel.text = [self.patient formattedProbability];
        [self toggleProbability:YES];
    }
}

- (void)pickerDone {
    if (self.ageTextField.text.length == 0) {
        self.ageTextField.text = [self.pickerValuesArray objectAtIndex:0];
    }
    
    [self.ageTextField resignFirstResponder];
}

#pragma mark - Private API

/**
 Make UIPickerView as inputView for UITextField

 @param text      Default value for picker
 @param textField For what textField
 @param values    Which values should be available in pickerView
 */
- (void)configurePickerInputViewWithText:(NSString *)text forTextField:(UITextField *)textField withValues:(NSArray *)values {
    UIView *inputView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, [UIScreen mainScreen].bounds.size.height-216.0f, [UIScreen mainScreen].bounds.size.width, 216.0f)];
    inputView.backgroundColor = [UIColor whiteColor];
    
    UIPickerView *pickerView = [[UIPickerView alloc] init];
    pickerView.frame = CGRectMake(0.0f, 0.0f, [UIScreen mainScreen].bounds.size.width, pickerView.frame.size.height);
    pickerView.dataSource = self;
    pickerView.delegate = self;
    pickerView.backgroundColor = [UIColor clearColor];
    pickerView.tintColor = [UIColor whiteColor];
    
    [inputView addSubview:pickerView];
    
    textField.inputView = inputView;
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [UIScreen mainScreen].bounds.size.width, 44.0f)];
    toolbar.translucent = NO;
    toolbar.tintColor = [UIColor darkGrayColor];
    toolbar.barTintColor = [UIColor lightGrayColor];
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                   target:nil
                                                                                   action:nil];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(pickerDone)];
    [toolbar setItems:@[flexibleSpace, doneButton]];
    textField.inputAccessoryView = toolbar;
    
    if (text) {
        NSUInteger index = INT_MAX;
        if ([self.pickerValuesArray containsObject:text]) {
            index = [self.pickerValuesArray indexOfObject:text];
        }
        
        if (index != INT_MAX) {
            [pickerView selectRow:index inComponent:0 animated:YES];
        }
    }
    
    self.pickerView = pickerView;
    self.pickerValuesArray = values;
}

- (void)toggleProbability:(BOOL)option {
    [UIView animateWithDuration:0.3f animations:^{
        self.titleLabel.alpha = option ? 1.0f : 0.0f;
        self.probabilityLabel.alpha = option ? 1.0f: 0.0f;
    }];
}

- (void)populateData {
    if (self.patient) {
        self.nameTextField.text = self.patient.name;
        self.surnameTextField.text = self.patient.surname;
        self.ageTextField.text = [NSString stringWithFormat:@"%hd", self.patient.age];
        self.genderSegmentedControl.selectedSegmentIndex = self.patient.gender;
        self.drugsSwitch.on = self.patient.drugsUse;
        self.migrainesSwitch.on = self.patient.migraines;
        self.probabilityLabel.text = [self.patient formattedProbability];
        
        [self toggleProbability:YES];
    }
}

/**
 Form validation.

 @return YES/NO
 */
- (BOOL)validationPassed {
    if (self.nameTextField.text.length == 0) {
        [self presentErrorWithTitle:@"Validation Error" andError:@"Please fill in your name"];
        return NO;
    }
    
    if (self.surnameTextField.text.length == 0) {
        [self presentErrorWithTitle:@"Validation Error" andError:@"Please fill in your surname"];
        return NO;
    }
    
    if (self.ageTextField.text.length == 0) {
        [self presentErrorWithTitle:@"Validation Error" andError:@"Please fill in your age"];
        return NO;
    }
    
    return YES;
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    [self populateData];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == self.ageTextField) {
        [self configurePickerInputViewWithText:self.ageTextField.text.length > 0 ? self.ageTextField.text : [self.pickerValuesArray firstObject]
                                  forTextField:self.ageTextField
                                    withValues:self.pickerValuesArray];
    }
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.pickerValuesArray.count;
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *string = [self.pickerValuesArray objectAtIndex:row];
    NSDictionary *attributes = @{
                                 NSFontAttributeName : [UIFont fontWithName:@"AvenirNext-Regular" size:16.0],
                                 NSForegroundColorAttributeName : [UIColor blackColor]
                                 };
    
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:string attributes:attributes];
    
    return attributedString;
}

#pragma mark - UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSString *string = [self.pickerValuesArray objectAtIndex:row];
    
    self.ageTextField.text = string;
}

@end
