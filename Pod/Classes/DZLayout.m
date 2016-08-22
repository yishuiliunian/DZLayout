//
//  DZLayout.m
//  Sentence
//
//  Created by stonedong on 16/2/23.
//  Copyright © 2016年 stonedong. All rights reserved.
//

#import "DZLayout.h"
#import <objc/runtime.h>

static void* DZLayoutViewKey = &DZLayoutViewKey;
@implementation UIView (DZLayout)

- (void) layoutContent
{
    
}

- (id<DZLayoutProtocol>) superLayout
{
    return self.superview;
}

- (void) setLayout:(DZLayout *)layout
{
    objc_setAssociatedObject(self, DZLayoutViewKey, layout, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (DZLayout*) layout
{
    return objc_getAssociatedObject(self, DZLayoutViewKey);
}

@end


@implementation DZLayout

@synthesize frame = _frame;
@synthesize bounds = _bounds;
@synthesize center = _center;
- (instancetype) init
{
    self = [super init];
    if (!self) {
        return self;
    }
    _subLayouts = [NSMutableArray new];
    return self;
}

- (void) addSubLayout:(DZLayout *)layout atIndex:(NSInteger)index
{
    [_subLayouts insertObject:layout atIndex:index];
}

- (CGRect) bounds
{
    return CGRectMake(0, 0, self.frame.size.width, self.frame.size.width);
}

- (CGPoint) center
{
    return CGPointMake((CGRectGetWidth(self.frame) - CGRectGetMinX(self.frame) /2), (CGRectGetHeight(self.frame) - CGRectGetMinY(self.frame) )/2);
}
- (void) layout
{
    for (DZLayout* l  in _subLayouts) {
        [l layout];
    }
}

- (void) setFrame:(CGRect)frame
{
    if (!CGRectEqualToRect(self.frame, frame)) {
        _frame = frame;
        [self layoutContent];
    }
}
- (void) addSubLayout:(DZLayout*)layout
{
    [_subLayouts addObject:layout];
}
@end


@implementation DZHorizontalLayout

- (instancetype) initWithSubLayouts:(NSArray*)sublayouts ratio:(NSArray*)set
{
    self = [super init];
    if (!self) {
        return self;
    }
    _subLayouts = [NSMutableArray arrayWithArray:sublayouts];
    _ratio = set;
    return self;
}

- (void) layoutContent
{
    
}

@end


@implementation DZMarginLayout

- (instancetype) initWithEdgheInsets:(UIEdgeInsets )edgeInsets
{
    self = [super init];
    if (!self) {
        return self;
    }
    _edgeInsets = edgeInsets;
    return self;
}

- (instancetype) initWithXMargin:(CGFloat)xMargin yMargin:(CGFloat)yMargin
{
    self = [super init];
    if (!self) {
        return self;
    }
    _edgeInsets = UIEdgeInsetsMake(yMargin, xMargin, yMargin, xMargin);
    return self;
}



- (void) layoutContent
{
    CGRect contentRect = [self frame];
    contentRect = CGRectMake(_edgeInsets.left, _edgeInsets.top, CGRectGetWidth(contentRect) - _edgeInsets.left - _edgeInsets.right, CGRectGetHeight(contentRect) - _edgeInsets.top - _edgeInsets.bottom);
    self.contentLayout.frame = contentRect;
}
@end


@implementation DZ2PartLayout

- (instancetype) initWithFix:(CGFloat)fix edge:(CGRectEdge)edge
{
    self = [super init];
    if (!self) {
        return self;
    }
    _fix = fix;
    _edge = edge;
    return self;
}


- (void) layoutContent
{
    CGRect content = self.frame;
    CGRect oneR;
    CGRect otherR;
    CGRectDivide(content, &oneR, &otherR, _fix, _edge);
    _part1.frame = otherR;
    _part2.frame = oneR;
    
    [_part1 layoutContent];
    [_part2 layoutContent];
    
    
}

@end

