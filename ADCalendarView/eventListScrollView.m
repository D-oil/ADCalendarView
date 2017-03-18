//
//  eventListScrollView.m
//  ADCalendarView
//
//  Created by 董安东 on 2017/3/7.
//  Copyright © 2017年 andong. All rights reserved.
//

#import "eventListScrollView.h"

@interface eventListScrollView ()

@property (nonatomic,assign) CGSize lastSize;

@property (nonatomic,strong) UITableView *leftTableView;
@property (nonatomic,strong) UITableView *centerTableView;
@property (nonatomic,strong) UITableView *rightTableView;



@end

@implementation eventListScrollView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    self.pagingEnabled = YES;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    //如果子视图超过了父view的大小，将会被剪裁掉。
    self.clipsToBounds = YES;
}

- (void)setInfo:(id)info {
    
    if (info != nil) {
        
        self.leftTableView = [UITableView new];
        self.centerTableView = [UITableView new];
        self.rightTableView = [UITableView new];
        self.leftTableView.backgroundColor = [UIColor redColor];
        self.rightTableView.backgroundColor = [UIColor blueColor];
        [self addSubview:self.leftTableView];
        [self addSubview:self.centerTableView];
        [self addSubview:self.rightTableView];
    }
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [self resizeViewsIfWidthChanged];
//    [self viewDidScroll];
}

- (void)resizeViewsIfWidthChanged
{
    CGSize size = self.frame.size;
    if(size.width != _lastSize.width){
        _lastSize = size;
        
        [self repositionViews];
    }
    else if(size.height != _lastSize.height){
        _lastSize = size;
        
        _leftTableView.frame = CGRectMake(_leftTableView.frame.origin.x, 0, size.width, size.height);
        _centerTableView.frame = CGRectMake(_centerTableView.frame.origin.x, 0, size.width, size.height);
        _rightTableView.frame = CGRectMake(_rightTableView.frame.origin.x, 0, size.width, size.height);
        
        self.contentSize = CGSizeMake(self.contentSize.width, size.height);
    }
}



- (void)repositionViews
{
    CGSize size = self.frame.size;
    self.contentInset = UIEdgeInsetsZero;
    

    self.contentSize = CGSizeMake(size.width * 3, size.height);
    
    _leftTableView.frame   = CGRectMake(0, 0, size.width, size.height);
    _centerTableView.frame = CGRectMake(size.width, 0, size.width, size.height);
    _rightTableView.frame  = CGRectMake(size.width * 2, 0, size.width, size.height);
    
    self.contentOffset = CGPointMake(size.width, 0);
 
//    self.contentOffset = CGPointZero;
    
    
}
@end
