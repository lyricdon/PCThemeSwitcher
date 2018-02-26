//
//  PCTabBarController.m
//  PCThemeSwitcher
//
//  Created by Lyric Don on 2018/2/26.
//  Copyright © 2018年 PCTheme.com. All rights reserved.
//

#import "PCTabBarController.h"
#import "NSObject+PCThemeSwitcher.h"
#import "PCNaviController.h"
#import "PCThemeCollectionController.h"

@interface PCTabBarController ()

@end

@implementation PCTabBarController

+ (instancetype)tabbar
{
    PCTabBarController *tab = [[PCTabBarController alloc] initWithControllers];
    return tab;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tabBar setBackgroundColor:[UIColor whiteColor]];
    
    [self.tabBar addToThemeColorPool:@"tintColor"];
    
    // tabbar背景图主题管理
    UIImage *tabbarimage=[[UIImage imageNamed:@""] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImageView *tabBarBackgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.tabBar.frame.size.width, self.tabBar.frame.size.height)];
    tabBarBackgroundImageView.image = tabbarimage;
    [self.tabBar insertSubview:tabBarBackgroundImageView atIndex:1];
    [tabBarBackgroundImageView addToThemeImagePoolWithSelector:@selector(setImage:) objects:nil];
}

- (instancetype)initWithControllers
{
    if (self = [super init])
    {
        [self addChildViewController:[[PCThemeCollectionController alloc] init] image:@"tab_home_nor" seletedImage:@"tab_home_press" title:@"职位"];
        [self addChildViewController:[[PCThemeCollectionController alloc] init] image:@"tab_assit_nor"  seletedImage:@"tab_assit_press"  title:@"好友帮"];
        [self addChildViewController:[[PCThemeCollectionController alloc] init] image:@"tab_mes_nor"  seletedImage:@"tab_mes_press"  title:@"消息"];
        [self addChildViewController:[[PCThemeCollectionController alloc] init] image:@"tab_me_nor"  seletedImage:@"tab_me_press"  title:@"我的"];
    }
    return self;
}

- (void)addChildViewController:(UIViewController *)childController image:(NSString *)image seletedImage:(NSString *)selectedImage title:(NSString *)title
{
    childController.title = title;
    [childController.tabBarItem setImage:[[self scaleImage:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
     ];
    [childController.tabBarItem setSelectedImage:[[self scaleImage:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
    [childController.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -3)];
    [childController.tabBarItem setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12]} forState:UIControlStateNormal];
    
    
    // 包装导航条
    PCNaviController *nav = [[PCNaviController alloc] initWithRootViewController:childController];
    
    [self addChildViewController:nav];
}

- (UIImage *)scaleImage:(NSString *)imageName
{
    UIImage *img = [UIImage imageNamed:imageName];
    CGFloat width = 23.6;

    CGSize origin = img.size;
    origin.height = width / origin.width * origin.height;
    origin.width = width;
    
    UIGraphicsBeginImageContextWithOptions(origin, NO, [UIScreen mainScreen].scale);
    [img drawInRect:CGRectMake(0, 0, origin.width, origin.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

@end


