//
//  CustomCell.h
//  TableTest
//
//  Created by kei on 2015/01/19.
//  Copyright (c) 2015年 kei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell

@property (nonatomic, strong)UIView *mainView;
@property (nonatomic, strong)UILabel *mainLabel;

+ (CGFloat)cellHeight;



@end
