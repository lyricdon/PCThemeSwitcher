//
//  NSObject+PCThemeSwitcher.h
//  PCThemeSwitcher
//
//  Created by Lyric Don on 2018/2/26.
//  Copyright © 2018年 PCTheme.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#define FA_THEME_COLOR @"FA_THEME_COLOR"
#define FA_THEME_IMAGE @"FA_THEME_IMAGE"

@interface NSObject (PCThemeSwitcher)

// 添加到主题属性池
- (void)addToThemeColorPool:(NSString *)propertyName;

// 添加到主题属性池,颜色参数为缺省
// 例子: [button addToThemeColorPoolWithSelector:@selector(setTitleColor:forState:) objects:@[FA_THEME_COLOR, @(UIControlStateSelected)]];
- (void)addToThemeColorPoolWithSelector:(SEL)selector objects:(NSArray *)objects;

// 添加到主题图片池,图片参数为缺省
// 例子: [tabBarBackgroundImageView addToThemeImagePoolWithSelector:@selector(setImage:) objects:@[FA_THEME_IMAGE]];
// 图片注意使用拉伸避免导航显示问题: UIImage *img = [[UIImage imageNamed:@"testImage/bannerB"] resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeStretch];
// 图片注意 imageWithRenderingMode 会和拉伸冲突
- (void)addToThemeImagePoolWithSelector:(SEL)selector objects:(NSArray *)objects;

// 设置主题色
- (void)setThemeColor:(UIColor *)color;

// 设置主题色和主题背景图
- (void)setThemeColor:(UIColor *)color image:(UIImage *)themeImage;

// 从主题池移除
- (void)removeFromThemeColorPoolWithSelector:(SEL)selector;


@end
