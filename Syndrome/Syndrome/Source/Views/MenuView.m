//
//  MenuView.m
//  Syndrome
//
//  Created by Djuro Alfirevic on 9/15/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "MenuView.h"

@interface MenuView()
@property (weak, nonatomic) IBOutlet UIButton *menuButton;
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (nonatomic) BOOL menuOpened;
@end

@implementation MenuView

#pragma mark - Designated Initializers

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self loadViewFromNib];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self loadViewFromNib];
    }
    
    return self;
}

#pragma mark - Actions

- (IBAction)menuButtonTapped {
    if (self.menuOpened) {
        [self closeMenu];
    } else {
        [self openMenu];
    }
}

- (IBAction)menuOptionButtonTapped:(UIButton *)sender {
    [self closeMenu];
    
    if ([self.delegate respondsToSelector:@selector(menuViewOptionTapped:)]) {
        [self.delegate menuViewOptionTapped:sender.tag];
    }
}

#pragma mark - Private API

- (void)loadViewFromNib {
    UIView *view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
    view.frame = self.bounds;
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:view];
}

- (void)prepareMenu {
    [self configureButton:self.button1];
    [self configureButton:self.button2];
}

- (void)closeMenu {
    self.menuOpened = NO;
    
    [UIView animateWithDuration:kAnimationDuration animations:^{
        self.button2.center = self.menuButton.center;
        self.button2.alpha = kZeroValue;
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:kAnimationDuration animations:^{
            self.button1.center = self.menuButton.center;
            self.button1.alpha = kZeroValue;
        }];
    });
}

- (void)openMenu {
    self.menuOpened = YES;
    
    [UIView animateWithDuration:kAnimationDuration animations:^{
        self.button1.frame = CGRectMake(self.button1.frame.origin.x, 22, self.button1.frame.size.width, self.button1.frame.size.height);
        self.button1.alpha = 1.0f;
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:kAnimationDuration animations:^{
            self.button2.frame = CGRectMake(self.button2.frame.origin.x, 60, self.button2.frame.size.width, self.button2.frame.size.height);
            self.button2.alpha = 1.0f;
        }];
    });
}

- (void)configureButton:(UIButton *)button {
    button.alpha = kZeroValue;
    button.center = self.menuButton.center;
}

#pragma mark - View lifecycle

- (void)layoutSubviews {
    [self prepareMenu];
}

@end
