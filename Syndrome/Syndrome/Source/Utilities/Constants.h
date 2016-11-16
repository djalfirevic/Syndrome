//
//  Constants.h
//  Syndrome
//
//  Created by Djuro Alfirevic on 9/15/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

typedef NS_ENUM(NSInteger, Gender) {
    MALE_GENDER = 0,
    FEMALE_GENDER
};

#define kBeginningAge 1
#define kAgeBoundaryForToddSyndrome 15
#define kEndingAge                  80
#define kZeroValue                  0
#define kKeyboardHeight             216.0f
#define kNavigationBarHeight        44.0f
#define kAnimationDuration          0.3f
#define kFontSize                   16.0f
#define kStatusBarHeight            20.0f
#define kTransitionX                300.0f

// Strings
static NSString *const OK_STRING        = @"OK";
static NSString *const HISTORY_SEGUE    = @"HistorySegue";
static NSString *const PATIENT_SEGUE    = @"PatientSegue";
static NSString *const WIKI_URL         = @"https://en.wikipedia.org/wiki/Alice_in_Wonderland_syndrome";


#endif /* Constants_h */
