//
//  PCNaviController.m
//  PCThemeSwitcher
//
//  Created by Lyric Don on 2018/2/26.
//  Copyright © 2018年 PCTheme.com. All rights reserved.
//

#import "PCNaviController.h"
#import "NSObject+PCThemeSwitcher.h"

@interface PCNaviController ()

@end

@implementation PCNaviController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // navi背景图片主题管理
    [self.navigationBar setBackgroundImage:[[UIImage imageNamed:@"banner/banner"] resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeStretch] forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar addToThemeImagePoolWithSelector:@selector(setBackgroundImage:forBarMetrics:) objects:@[FA_THEME_IMAGE ,@(UIBarMetricsDefault)]];

}


@end
