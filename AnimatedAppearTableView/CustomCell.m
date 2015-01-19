//
//  CustomCell.m
//  TableTest
//
//  Created by kei on 2015/01/19.
//  Copyright (c) 2015年 kei. All rights reserved.
//

#import "CustomCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation CustomCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initilizer];
    }
    return self;
}


- (void)initilizer{
    
    
    self.contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    CGFloat cellHeight = [CustomCell cellHeight];
    CGFloat cellWidth = [[UIScreen mainScreen] applicationFrame].size.width-10*2;
    CGFloat xMargin = 10.f;
    CGFloat yMargin = 10.f;
    _mainView = [[UIView alloc]initWithFrame:CGRectMake(xMargin, yMargin, cellWidth, cellHeight-yMargin*2)];
    _mainView.backgroundColor = [UIColor whiteColor];
    
    _mainView.layer.masksToBounds = NO;
    _mainView.layer.shadowOffset = CGSizeMake(0, 0);
    _mainView.layer.shadowRadius = 1.0;
    _mainView.layer.shadowColor = [UIColor blackColor].CGColor;
    _mainView.layer.shadowOpacity = 0.5;
    _mainView.layer.shadowPath = [UIBezierPath bezierPathWithRect:_mainView.bounds].CGPath;
    [self.contentView addSubview:_mainView];
    
    _mainLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 20, 160, 30)];
    _mainLabel.textColor = [UIColor blackColor];
    [self.mainView addSubview:_mainLabel];
    
    
    
}

- (void)prepareForReuse{
    [_mainLabel removeFromSuperview];
    [_mainView removeFromSuperview];
    [self initilizer];
    [super prepareForReuse];
}



+ (CGFloat)cellHeight{
    return 180;
}

@end
