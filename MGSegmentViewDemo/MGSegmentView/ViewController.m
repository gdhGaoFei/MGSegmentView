//
//  ViewController.m
//  MGSegmentView
//
//  Created by 高得华 on 16/11/24.
//  Copyright © 2016年 GaoFei. All rights reserved.
//

#import "ViewController.h"
#import "MGSegmentView.h"

@interface ViewController ()<MGSegmentViewDelegate>

@property (weak, nonatomic) IBOutlet MGSegmentView *segmentView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSArray * array = @[@"项目全景", @"在建楼座", @"施工部位", ];
    NSArray * norArray = @[@"Unchecked", @"Unchecked", @"Unchecked", ];
    NSArray * selArray = @[@"Selected", @"Selected", @"Selected", ];
    
    NSMutableArray <MGSegmentModel *>* modelArray = [NSMutableArray array];
    for (NSInteger i = 0; i < array.count; i ++) {
        MGSegmentModel * model = [MGSegmentModel CreateSegmentTitle:array[i] norImg:norArray[i] selImg:selArray[i]];
        [modelArray addObject:model];
    }
    
//   纯代码创建
    //创建segment
    MGSegmentView * segment = [MGSegmentView CreateSegmentTitles:modelArray frame:CGRectMake(0, 100, CGRectGetWidth(self.view.frame), 48)];
    [self.view addSubview:segment];
    
    segment.selectTitleColor = [UIColor redColor];
    segment.defaultSeleted   = 1;
    segment.buttonFont = 14;
    segment.isClickIndexReturn = YES;
    segment.ReturnClickSegmetAtIndex = ^(NSInteger index, NSInteger lastIndex) {
        NSLog(@"====block=====%ld=====%ld===", index, lastIndex);
    };
    
    
//  使用Storyboard加载
    self.segmentView.titles = modelArray;
//    self.segmentView.selectTitleColor = [UIColor purpleColor];
    self.segmentView.defaultSeleted = 1;
    self.segmentView.buttonFont = 20;
    self.segmentView.delegate = self;
}

-(void)segmentView:(MGSegmentView *)segmentView didSelectedSegmentAtIndex:(NSInteger)index lastSelectedSegmentAtIndex:(NSInteger)lastIndex {
    NSLog(@"====delegate=====%ld=====%ld===", index, lastIndex);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
