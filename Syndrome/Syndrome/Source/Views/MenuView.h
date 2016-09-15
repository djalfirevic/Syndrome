//
//  MenuView.h
//  Syndrome
//
//  Created by Djuro Alfirevic on 9/15/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MenuOption) {
    PATIENT_MENU_OPTION = 1,
    HISTORY_MENU_OPTION
};

@protocol MenuViewDelegate <NSObject>
@required
- (void)menuViewOptionTapped:(MenuOption)option;
@end

@interface MenuView : UIView
@property (weak, nonatomic) IBOutlet id<MenuViewDelegate> delegate;
@end
