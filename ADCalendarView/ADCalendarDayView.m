//
//  ADCalendarDayView.m
//  ADCalendarView
//
//  Created by 董安东 on 2017/3/6.
//  Copyright © 2017年 andong. All rights reserved.
//

#import "ADCalendarDayView.h"

@implementation ADCalendarDayView

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

@end
