//
//  PCThemeCollectionController.m
//  PCThemeSwitcher
//
//  Created by Lyric Don on 2018/2/26.
//  Copyright © 2018年 PCTheme.com. All rights reserved.
//

#import "PCThemeCollectionController.h"
#import "NSObject+PCThemeSwitcher.h"

// 颜色
#define RGB(r,g,b) [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:1.0]
#define RANDOM_RGB  RGB(arc4random_uniform(256),arc4random_uniform(256),arc4random_uniform(256))

@interface PCThemeCollectionController ()

@end

@implementation PCThemeCollectionController

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)init
{
    // 设置流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat width = ([UIScreen mainScreen].bounds.size.width - 80) / 3;
    layout.itemSize = CGSizeMake(width, width);
    layout.minimumLineSpacing = layout.minimumInteritemSpacing = 20;
    
    if (self = [super initWithCollectionViewLayout:layout]) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.frame = CGRectMake(20, 0, [UIScreen mainScreen].bounds.size.width - 40, [UIScreen mainScreen].bounds.size.height - 40);
    self.collectionView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsVerticalScrollIndicator = NO;
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 51;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = RANDOM_RGB;
    cell.layer.cornerRadius = 5;
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 取出cell
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    UIImage *img = [UIImage new];
    switch (indexPath.row % 5)
    {
        case 0:
            img = [[UIImage imageNamed:@"banner"] resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeStretch];
            break;
        
        case 1:
            img = [[UIImage imageNamed:@"bannerA"] resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeStretch];
            break;
            
        case 2:
            img = [[UIImage imageNamed:@"bannerB"] resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeStretch];
            break;
            
        case 3:
            img = [[UIImage imageNamed:@"bannerC"] resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeStretch];
            break;
            
        default:
            break;
    }
    
    // 设置主题色
    [self setThemeColor:cell.backgroundColor image:img];
}

@end
