//
//  NSObject+PCThemeSwitcher.m
//  PCThemeSwitcher
//
//  Created by Lyric Don on 2018/2/26.
//  Copyright © 2018年 PCTheme.com. All rights reserved.
//

#import "NSObject+PCThemeSwitcher.h"

#define FA_COLOR_ARGS_KEY @"FA_COLOR_ARGS_KEY"
#define FA_IMAGE_ARGS_KEY @"FA_IMAGE_ARGS_KEY"

#define RGB(r, g, b) [UIColor colorWithRed:(CGFloat)r / 255.0 green:(CGFloat)g / 255.0 blue:(CGFloat)b / 255.0 alpha:1.0]

@implementation NSObject (PCThemeSwitcher)


/** 主题颜色池 */
static NSMutableArray<NSMapTable *> *_themeColorPool;
/** 当前主题色 */
static UIColor *_currentThemeColor;

/** 用于保存NSMapTable中的参数字典 */
static NSMutableDictionary *_parameterDicts;
/** 主题图片池 */
static NSMutableArray<id> *_themeImagePool;

- (NSMutableArray *)themeColorPool
{
    if (!_themeColorPool) {
        _themeColorPool = [NSMutableArray array];
    }
    return _themeColorPool;
}

- (NSMutableDictionary *)parameterDicts
{
    if (!_parameterDicts) {
        _parameterDicts = [NSMutableDictionary dictionary];
    }
    return _parameterDicts;
}

- (NSMutableArray *)themeImagePool
{
    if (!_themeImagePool) {
        _themeImagePool = [NSMutableArray array];
    }
    return _themeImagePool;
}

#pragma mark - performSelector 多参调用
- (id)performSelector:(SEL)selector withObjects:(const NSArray<id> *)objects
{
    // 创建方法签名
    NSMethodSignature *methodSignate = [[self class] instanceMethodSignatureForSelector:selector];
    if (!methodSignate)
    {
        return self;
    }
    
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignate];
    
    invocation.target = self;
    
    invocation.selector = selector;
    
    NSInteger paramsCount = methodSignate.numberOfArguments - 2;
    
    NSInteger count = MIN(paramsCount, objects.count);
    
    NSMutableDictionary *objCopy = nil;
    
    for (int i = 0; i < count; i++)
    {
        
        id obj = objects[i];
        
        if ([obj isKindOfClass:[NSString class]] && [obj isEqualToString:FA_THEME_COLOR])
        {
            obj = _currentThemeColor;
        }
        //        if ([obj isKindOfClass:[NSString class]] && [obj isEqualToString:FA_THEME_IMAGE])
        //        {
        //            obj = [self getCurrentImage];
        //        }
        
        if ([obj isKindOfClass:[NSNull class]])
        {
            obj = nil;
        }
        
        const char *argumentType = [methodSignate getArgumentTypeAtIndex:i + 2];
        
        NSString *argumentTypeString = [NSString stringWithUTF8String:argumentType];
        if ([argumentTypeString isEqualToString:@"@"])
        {
            
            if ([obj isKindOfClass:[NSDictionary class]])
            {
                objCopy = [obj mutableCopy];
                
                NSArray *keys = [objCopy allKeys];
                for (NSString *key in keys)
                {
                    id value = objCopy[key];
                    if ([value isKindOfClass:[NSString class]] && [value isEqualToString:FA_THEME_COLOR])
                    {
                        [objCopy setValue:_currentThemeColor forKey:key];
                    }
                }
                [invocation setArgument:&objCopy atIndex:i + 2];
            }
            else
            {
                [invocation setArgument:&obj atIndex:i + 2];
            }
        }
        else if ([argumentTypeString isEqualToString:@"B"])
        {
            bool objVaule = [obj boolValue];
            [invocation setArgument:&objVaule atIndex:i + 2];
        }
        else if ([argumentTypeString isEqualToString:@"f"])
        {
            float objVaule = [obj floatValue];
            [invocation setArgument:&objVaule atIndex:i + 2];
        }
        else if ([argumentTypeString isEqualToString:@"d"])
        {
            double objVaule = [obj doubleValue];
            [invocation setArgument:&objVaule atIndex:i + 2];
        }
        else if ([argumentTypeString isEqualToString:@"c"])
        {
            char objVaule = [obj charValue];
            [invocation setArgument:&objVaule atIndex:i + 2];
        }
        else if ([argumentTypeString isEqualToString:@"i"])
        {
            int objVaule = [obj intValue];
            [invocation setArgument:&objVaule atIndex:i + 2];
        }
        else if ([argumentTypeString isEqualToString:@"I"])
        {
            unsigned int objVaule = [obj unsignedIntValue];
            [invocation setArgument:&objVaule atIndex:i + 2];
        }
        else if ([argumentTypeString isEqualToString:@"S"])
        {
            unsigned short objVaule = [obj unsignedShortValue];
            [invocation setArgument:&objVaule atIndex:i + 2];
        }
        else if ([argumentTypeString isEqualToString:@"L"])
        {
            unsigned long objVaule = [obj unsignedLongValue];
            [invocation setArgument:&objVaule atIndex:i + 2];
        }
        else if ([argumentTypeString isEqualToString:@"s"])
        {
            short objVaule = [obj shortValue];
            [invocation setArgument:&objVaule atIndex:i + 2];
        }
        else if ([argumentTypeString isEqualToString:@"l"])
        {
            long objVaule = [obj longValue];
            [invocation setArgument:&objVaule atIndex:i + 2];
        }
        else if ([argumentTypeString isEqualToString:@"q"])
        {
            long long objVaule = [obj longLongValue];
            [invocation setArgument:&objVaule atIndex:i + 2];
        }
        else if ([argumentTypeString isEqualToString:@"C"])
        {
            unsigned char objVaule = [obj unsignedCharValue];
            [invocation setArgument:&objVaule atIndex:i + 2];
        }
        else if ([argumentTypeString isEqualToString:@"Q"])
        {
            unsigned long long objVaule = [obj unsignedLongLongValue];
            [invocation setArgument:&objVaule atIndex:i + 2];
        }
        else if ([argumentTypeString isEqualToString:@"{CGRect={CGPoint=dd}{CGSize=dd}}"])
        {
            CGRect objVaule = [obj CGRectValue];
            [invocation setArgument:&objVaule atIndex:i + 2];
        }
        else if ([argumentTypeString isEqualToString:@"{UIEdgeInsets=dddd}"])
        {
            UIEdgeInsets objVaule = [obj UIEdgeInsetsValue];
            [invocation setArgument:&objVaule atIndex:i + 2];
        }
    }
    
    [invocation invoke];
    
    id returnValue = nil;
    if (methodSignate.methodReturnLength != 0)
    {
        [invocation getReturnValue:&returnValue];
    }
    return returnValue;
}

#pragma mark - Theme Color

// nil需包装为[NSNull null]
- (void)addToThemeColorPoolWithSelector:(SEL)selector objects:(NSArray *)objects
{
    [self addToThemeColorPoolWithSelector:selector objectsKey:FA_COLOR_ARGS_KEY objects:objects];
}

- (void)addToThemeImagePoolWithSelector:(SEL)selector objects:(NSArray *)objects
{
    [self addToThemeColorPoolWithSelector:selector objectsKey:FA_IMAGE_ARGS_KEY objects:objects];
}

- (void)addToThemeColorPoolWithSelector:(SEL)selector objectsKey:(NSString *)argsKey objects:(NSArray *)objects
{
    if (!objects)
    {
        objects = [NSArray arrayWithObject:@""];
    }
    
    Class appearanceClass = NSClassFromString(@"_UIAppearance");
    
    if ([self isMemberOfClass:appearanceClass])
    {
        return;
    }
    
    NSString *pointSelectorString = [NSString stringWithFormat:@"%p%@", self, NSStringFromSelector(selector)];
    
    NSMapTable *mapTable = [NSMapTable mapTableWithKeyOptions:NSMapTableCopyIn valueOptions:NSMapTableWeakMemory];
    [mapTable setObject:self forKey:pointSelectorString];
    [mapTable setObject:objects forKey:argsKey];
    
    NSString *mapTablePointString = [NSString stringWithFormat:@"%p", mapTable];
    [[self parameterDicts] setValue:objects forKey:mapTablePointString];
    
    for (NSMapTable *subMapTable in [[self themeColorPool] copy])
    {
        if ([[subMapTable description] isEqualToString:[mapTable description]])
        {
            return;
        }
    }
    
    // 不存在，添加主题色池中
    [[self themeColorPool] addObject:mapTable];
    
    if ([argsKey isEqualToString:FA_IMAGE_ARGS_KEY])
    {
        UIImage *img = [self getCurrentImage];
        if (img)
        {
            NSMutableArray *arr = [NSMutableArray arrayWithArray:objects];
            [arr replaceObjectAtIndex:0 withObject:img];
            [self performSelector:selector withObjects:arr];
        }
    }
    else if ([argsKey isEqualToString:FA_COLOR_ARGS_KEY])
    {
        _currentThemeColor = [self getThemeColor];
        if (_currentThemeColor)
        {
            [self performSelector:selector withObjects:objects];
        }
    }
}

- (void)addToThemeColorPool:(NSString *)propertyName
{
    Class appearanceClass = NSClassFromString(@"_UIAppearance");
    if ([self isMemberOfClass:appearanceClass])
    {
        return;
    }
    NSString *pointString = [NSString stringWithFormat:@"%p%@", self, propertyName];
    
    NSMapTable *mapTable = [NSMapTable mapTableWithKeyOptions:NSMapTableCopyIn valueOptions:NSMapTableWeakMemory];
    [mapTable setObject:self forKey:pointString];
    
    for (NSMapTable *subMapTable in [[self themeColorPool] copy])
    {
        if ([[subMapTable description] isEqualToString:[mapTable description]])
        {
            return;
        }
    }
    
    [[self themeColorPool] addObject:mapTable];
    
    _currentThemeColor = [self getThemeColor];
    if (_currentThemeColor)
    {
        [self setValue:_currentThemeColor forKey:propertyName];
    }
}

- (void)setThemeColor:(UIColor *)color
{
    [self setThemeColor:color image:nil];
}

- (void)setThemeColor:(UIColor *)color image:(UIImage *)themeImage
{
    _currentThemeColor = color;
    [self saveThemeColor:color];
    
    if (themeImage)
    {
        dispatch_async(dispatch_queue_create("themeSave", NULL), ^{
            [self saveCurrentImage:themeImage];
        });
    }
    
    // 遍历缓主题池，设置统一主题色
    for (NSMapTable *mapTable in [_themeColorPool copy]) {
        
        NSString *objectKey = nil;
        
        NSEnumerator *enumerator = [mapTable keyEnumerator];
        NSString *key;
        
        while (key = [enumerator nextObject])
        {
            // 不能是参数key
            if (![key isEqualToString:FA_COLOR_ARGS_KEY] && ![key isEqualToString:FA_IMAGE_ARGS_KEY])
            {
                objectKey = key;
                break;
            }
        }
        if (!key)
        {
            [_parameterDicts removeObjectForKey:[NSString stringWithFormat:@"%p", mapTable]];
            [_themeColorPool removeObject:mapTable];
        }
        
        id object = [mapTable objectForKey:objectKey];
        if ([objectKey containsString:@":"])
        {
            NSString *selectorName = [objectKey substringFromIndex:[[NSString stringWithFormat:@"%p", object] length]];
            SEL selector = NSSelectorFromString(selectorName);
            
            // 判断是否为图片设置
            BOOL isImage = NO;
            NSEnumerator *enumerator = [mapTable keyEnumerator];
            NSString *key;
            while (key = [enumerator nextObject])
            {
                if ([key isEqualToString:FA_IMAGE_ARGS_KEY])
                {
                    isImage = YES;
                    break;
                }
            }
            
            if (isImage)
            {
                
                if (themeImage != nil)
                {
                    NSArray *args = [mapTable objectForKey:FA_IMAGE_ARGS_KEY];
                    NSMutableArray *arr = [NSMutableArray arrayWithArray:args];
                    [arr replaceObjectAtIndex:0 withObject:themeImage];
                    [object performSelector:selector withObjects:arr];
                }
            }
            else
            {
                NSArray *args = [mapTable objectForKey:FA_COLOR_ARGS_KEY];
                [object performSelector:selector withObjects:args];
            }
        }
        else
        {
            NSString *propertyName = [objectKey substringFromIndex:[[NSString stringWithFormat:@"%p", object] length]];
            [object setValue:color forKeyPath:propertyName];
        }
    }
}

- (void)removeFromThemeColorPoolWithSelector:(SEL)selector
{
    Class appearanceClass = NSClassFromString(@"_UIAppearance");
    if ([self isMemberOfClass:appearanceClass])
    {
        return;
    }
    
    NSString *pointSelectorString = [NSString stringWithFormat:@"%p%@", self, NSStringFromSelector(selector)];
    
    for (NSMapTable *subMapTable in [[self themeColorPool] copy])
    {
        NSString *objectKey = nil;
        
        NSEnumerator *enumerator = [subMapTable keyEnumerator];
        NSString *key;
        while (key = [enumerator nextObject])
        {
            if (![key isEqualToString:FA_COLOR_ARGS_KEY]) {
                objectKey = key;
                break;
            }
        }
        if([objectKey isEqualToString:pointSelectorString])
        {
            // 移除参数数组
            [_parameterDicts removeObjectForKey:[NSString stringWithFormat:@"%p", subMapTable]];
            [[self themeColorPool] removeObject:subMapTable];
            return;
        }
    }
}

- (void)removeFromThemeColorPool:(NSString *)propertyName
{
    Class appearanceClass = NSClassFromString(@"_UIAppearance");
    if ([self isMemberOfClass:appearanceClass]) return;
    
    NSString *pointString = [NSString stringWithFormat:@"%p%@", self, propertyName];
    
    for (NSMapTable *subMapTable in [[self themeColorPool] copy])
    {
        NSEnumerator *enumerator = [subMapTable keyEnumerator];
        if([[enumerator nextObject] isEqualToString:pointString])
        {
            [[self themeColorPool] removeObject:subMapTable];
            return;
        }
    }
}

#pragma mark - 主题存储
- (void)saveThemeColor:(UIColor *)color
{
    NSString *defaultColorStr = [self hexStringFromColor:color];
    [[NSUserDefaults standardUserDefaults] setObject:defaultColorStr forKey:@"themeColor"];
}

- (NSString *)hexStringFromColor:(UIColor *)color
{
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    
    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];
    
    return [NSString stringWithFormat:@"#%02lX%02lX%02lX",
            lroundf(r * 255),
            lroundf(g * 255),
            lroundf(b * 255)];
}

- (UIColor *)getThemeColor
{
    NSString *colorStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"themeColor"];
    if (colorStr == nil)
    {
        return nil;
    }
    
    UIColor *color = [self colorWithHexString:colorStr];
    return color;
}

- (UIColor *)colorWithHexString:(NSString *)hexString
{
    NSString *cString = [[hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if (cString.length < 6)
        return [UIColor clearColor];
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if (cString.length != 6)
        return [UIColor clearColor];
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return RGB(r, g, b);
}

- (void)saveCurrentImage:(UIImage *)image
{
    NSData *date = UIImagePNGRepresentation(image);
    NSString *privateDirectory = [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"Theme"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:privateDirectory])
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:privateDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *path = [NSString stringWithFormat:@"%@/themeImage.dat",privateDirectory];
    [date writeToFile:path atomically:YES];
}

- (UIImage *)getCurrentImage
{
    NSString *privateDirectory = [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"Theme"];
    
    NSString *path = [NSString stringWithFormat:@"%@/themeImage.dat",privateDirectory];
    NSData *data = [NSData dataWithContentsOfFile:path];
    UIImage *img = [UIImage imageWithData:data];
    return img;
}

@end
