//
//  ADCalendarMenuView.m
//  ADCalendarView
//
//  Created by 董安东 on 2017/3/6.
//  Copyright © 2017年 andong. All rights reserved.
//

#import "ADCalendarMenuView.h"

@implementation ADCalendarMenuView

- (UIButton *)leftButton {
    if (_leftButton == nil) {
        _leftButton = [[UIButton alloc] init];
        
    }
    return _leftButton;
}

- (UIButton *)rightButton {
    if (_rightButton == nil) {
        _rightButton = [[UIButton alloc]init];
        
    }
    return _rightButton;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(!self){
        return nil;
    }
    
    [self commonInit];
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(!self){
        return nil;
    }
    
    [self commonInit];
    
    return self;
}

- (void)commonInit {
    
    [super commonInit];
    
    [self.leftButton setImage:[UIImage imageNamed:@"next_button_left"] forState:UIControlStateNormal];
    [self.leftButton setImage:[UIImage imageNamed:@"next_button_left_click"] forState:UIControlStateHighlighted];
    [self.leftButton addTarget:self action:@selector(loadPreviousPageWithAnimation) forControlEvents:UIControlEventTouchUpInside];
    
    [self.rightButton setImage:[UIImage imageNamed:@"next_button"] forState:UIControlStateNormal];
    [self.rightButton setImage:[UIImage imageNamed:@"next_button_click"] forState:UIControlStateHighlighted];
    [self.rightButton addTarget:self action:@selector(loadNextPageWithAnimation) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.leftButton sizeToFit];
    [self.rightButton sizeToFit];
    
    [self.leftButton setCenter:CGPointMake(self.scrollView.frame.size.width/4, self.scrollView.frame.size.height/2)];
    [self.rightButton setCenter:CGPointMake(self.scrollView.frame.size.width/4 *3, self.scrollView.frame.size.height/2)];
    
    [self.manager.menuView addSubview:_leftButton];
    [self.manager.menuView bringSubviewToFront:_leftButton];
    [self.manager.menuView addSubview:_rightButton];
    [self.manager.menuView bringSubviewToFront:_rightButton];
}

- (void)loadPreviousPageWithAnimation
{
    [self.manager.contentView loadPreviousPageWithAnimation];
}

- (void)loadNextPageWithAnimation
{
    [self.manager.contentView loadNextPageWithAnimation];
}
@end
