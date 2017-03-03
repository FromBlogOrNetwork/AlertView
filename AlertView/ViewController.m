//
//  ViewController.m
//  AlertView
//
//  Created by lwj on 16/12/27.
//  Copyright © 2016年 WenJin Li. All rights reserved.
//

#import "ViewController.h"
#import "VourcherAlertView.h"
@interface ViewController ()<WJLALertviewDelegate>

- (IBAction)testAlertViewBtn:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)testAlertViewBtn:(id)sender {
    VourcherAlertView*alertView = [[VourcherAlertView alloc]initWithwithType:2];//type = 1 充值 type = 2 兑换
    alertView.delegate = self;
    [alertView show];
}
-(void)didClickButtonAtIndex:(NSUInteger)index{
    
}
@end
