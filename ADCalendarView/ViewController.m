//
//  ViewController.m
//  ADCalendarView
//
//  Created by 董安东 on 2017/3/6.
//  Copyright © 2017年 andong. All rights reserved.
//

#import "ViewController.h"
#import "JTCalendar.h"
#import "ADCalendarDayView.h"
#import "ADCalendarMenuView.h"

@interface ViewController () <JTCalendarDelegate>

@property (weak, nonatomic) IBOutlet UIView *allCalendarView;

@property (weak, nonatomic) IBOutlet ADCalendarMenuView *CalendarMenu;
@property (weak, nonatomic) IBOutlet JTHorizontalCalendarView *CalendarView;

@property (strong, nonatomic) JTCalendarManager *calendarManager;

@property (nonatomic,strong) NSDate *dateSelected;
@property (nonatomic,assign) NSInteger tag;

@end

@implementation ViewController

- (IBAction)itemButtonAction:(UIBarButtonItem *)sender {
    if (self.allCalendarView.hidden == YES) {
        
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSDate *today = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *weekdayComponents =
    [gregorian components:(NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitSecond | NSCalendarUnitYear) fromDate:today];
    NSInteger day = [weekdayComponents day];
    NSInteger weekday = [weekdayComponents weekday];
    NSInteger second = [weekdayComponents second];
    
    _calendarManager = [JTCalendarManager new];
    _calendarManager.delegate = self;
    
    [_calendarManager setMenuView:self.CalendarMenu];
    [_calendarManager setContentView:self.CalendarView];
    [_calendarManager setDate:[NSDate date]];
    
    _calendarManager.settings.weekDayFormat = JTCalendarWeekDayFormatShort;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)calendar:(JTCalendarManager *)calendar prepareDayView:(ADCalendarDayView *)dayView
{
    dayView.hidden = NO;
    
    // Test if the dayView is from another month than the page
    // Use only in month mode for indicate the day of the previous or next month
    if([dayView isFromAnotherMonth]){
        dayView.hidden = YES;
    } else if([dayView isHaveEvent] == NO){
        dayView.circleView.hidden = YES;
        dayView.dotView.backgroundColor = [UIColor redColor];
        dayView.textLabel.textColor = [UIColor lightGrayColor];
    }
    // Selected date
    else if(_dateSelected && [_calendarManager.dateHelper date:_dateSelected isTheSameDayThan:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = [UIColor orangeColor];
        dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    // Another day of the current month
    else{
        dayView.circleView.hidden = YES;
        dayView.dotView.backgroundColor = [UIColor redColor];
        dayView.textLabel.textColor = [UIColor blackColor];
    }
    

    dayView.dotView.hidden = YES;

}

- (void)calendar:(JTCalendarManager *)calendar didTouchDayView:(JTCalendarDayView *)dayView
{
    self.dateSelected = dayView.date;
    
    dayView.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
    [UIView transitionWithView:dayView
                      duration:.3
                       options:0
                    animations:^{
                        dayView.circleView.transform = CGAffineTransformIdentity;
                        [_calendarManager reload];
                    } completion:nil];
    
    
    // Don't change page in week mode because block the selection of days in first and last weeks of the month
    if(_calendarManager.settings.weekModeEnabled){
        return;
    }
    
    // Load the previous or next page if touch a day from another month
    
//    if(![_calendarManager.dateHelper date:_calendarContentView.date isTheSameMonthThan:dayView.date]){
//        if([_calendarContentView.date compare:dayView.date] == NSOrderedAscending){
//            [_calendarContentView loadNextPageWithAnimation];
//        }
//        else{
//            [_calendarContentView loadPreviousPageWithAnimation];
//        }
//    }
}

- (void)calendar:(JTCalendarManager *)calendar prepareMenuItemView:(UILabel *)menuItemView date:(NSDate *)date
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"MMMM yyyy";
        
        dateFormatter.locale = _calendarManager.dateHelper.calendar.locale;
        dateFormatter.timeZone = _calendarManager.dateHelper.calendar.timeZone;
    }
    
    menuItemView.text = [dateFormatter stringFromDate:date];
}

- (UIView<JTCalendarDay> *)calendarBuildDayView:(JTCalendarManager *)calendar
{
    
    
    ADCalendarDayView *view = [ADCalendarDayView new];
    view.textLabel.font = [UIFont fontWithName:@"Avenir-Light" size:13];
    view.textLabel.textColor = [UIColor blackColor];
    self.tag++;
    if (self.tag % 5 == 0) {
        view.isHaveEvent = YES;
    }
    
    return view;
}



@end
