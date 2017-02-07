//
//  ViewController.m
//  YYWaterWave
//
//  Created by Moon on 17/1/6.
//  Copyright © 2017年 mac mini. All rights reserved.
//

#import "ViewController.h"
#import "YYWavaView.h"

@interface ViewController ()

@property (weak, nonatomic) YYWavaView *wavaView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupWavaView];
    
}

- (void)setupWavaView {
    
    YYWavaView *wavaView = [[YYWavaView alloc] init];
    wavaView.frame = CGRectMake(0, 100, self.view.frame.size.width, 300);
    wavaView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:wavaView];
    self.wavaView = wavaView;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
