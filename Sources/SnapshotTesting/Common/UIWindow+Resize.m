//
//  UIWindow+Resize.m
//
//  Created by Simon Cook on 31/07/18.
//  Copyright © 2018 Trade Me Ltd. All rights reserved.
//

#import "UIWindow+Resize.h"

@interface UIWindow ()

- (void)_adjustSizeClassesAndResizeWindowToFrame:(CGRect)frame;

@end

@implementation UIWindow (Resize)

- (void)resizeToSize:(CGSize)size {
    [self _adjustSizeClassesAndResizeWindowToFrame:CGRectMake(0, 0, size.width, size.height)];
}

@end
