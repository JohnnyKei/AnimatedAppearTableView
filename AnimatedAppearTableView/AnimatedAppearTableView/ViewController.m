//
//  ViewController.m
//  AnimatedAppearTableView
//
//  Created by kei on 2015/01/19.
//  Copyright (c) 2015年 kei. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "CustomCell.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSIndexPath *topVisibleIndexPath;
@property (nonatomic, strong)NSIndexPath *bottomVisibleIndexPath;

@property (nonatomic, assign) CATransform3D bottomTransformation;
@property (nonatomic, assign) CATransform3D topTransformation;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _tableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView registerClass:[CustomCell class] forCellReuseIdentifier:@"Cell"];
    [self.view addSubview:_tableView];
    
    _topVisibleIndexPath = _tableView.indexPathsForVisibleRows.firstObject;
    _bottomVisibleIndexPath = _tableView.indexPathsForVisibleRows.lastObject;
    
    
    CGPoint offsetPositioning = CGPointMake(0, 30);
    CATransform3D transform1 = CATransform3DIdentity;
    transform1 = CATransform3DTranslate(transform1, offsetPositioning.x, offsetPositioning.y, 20);
    _bottomTransformation = transform1;
    
    CATransform3D transform2 = CATransform3DIdentity;
    transform2 = CATransform3DTranslate(transform2, offsetPositioning.x, -offsetPositioning.y, 20);
    _topTransformation = transform2;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [CustomCell cellHeight];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CustomCell *cell = (CustomCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[CustomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.mainLabel.text = [NSString stringWithFormat:@"row:%ld",indexPath.row];
    CALayer *layer = cell.mainView.layer;
    layer.opacity = 0;
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(CustomCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld,top:%ld,below:%ld",indexPath.row,self.topVisibleIndexPath.row,self.bottomVisibleIndexPath.row);
    
    
    CALayer *layer = cell.mainView.layer;
    NSTimeInterval duration = 0.1;
    NSTimeInterval delay = 0.1;
    
    if (indexPath.row<self.topVisibleIndexPath.row) {
        NSLog(@"top");
        
        layer.transform = _topTransformation;
        
        [UIView animateWithDuration:duration delay:delay*abs((int)indexPath.row-(int)self.topVisibleIndexPath.row) options:0 animations:^{
            layer.opacity = 1.0;
            layer.transform = CATransform3DIdentity;
            
        } completion:^(BOOL finished) {
            
        }];
    }else if (indexPath.row > self.bottomVisibleIndexPath.row){
        NSLog(@"below");
        layer.transform = _bottomTransformation;
        
        [UIView animateWithDuration:duration delay:delay*abs((int)indexPath.row-(int)self.bottomVisibleIndexPath.row) options:0 animations:^{
            layer.opacity = 1.0;
            layer.transform = CATransform3DIdentity;
            
        } completion:^(BOOL finished) {
            
        }];
    }else{
        NSLog(@"Normal");
        [UIView animateWithDuration:duration delay:delay*indexPath.row options:0 animations:^{
            layer.opacity = 1.0;
            layer.transform = CATransform3DIdentity;
        } completion:^(BOOL finished) {
            
        }];
    }

    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    _topVisibleIndexPath = _tableView.indexPathsForVisibleRows.firstObject;
    _bottomVisibleIndexPath = _tableView.indexPathsForVisibleRows.lastObject;
    
    NSLog(@"%s,top:%ld,below:%ld",__func__,self.topVisibleIndexPath.row,self.bottomVisibleIndexPath.row);
}





@end
