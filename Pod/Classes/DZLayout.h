//
//  DZLayout.h
//  Sentence
//
//  Created by stonedong on 16/2/23.
//  Copyright © 2016年 stonedong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@protocol DZLayoutProtocol <NSObject>
@property(nonatomic) CGRect frame;
@property(nonatomic) CGRect bounds;
@property(nonatomic) CGPoint center;
@property (nonatomic, weak, readonly) id<DZLayoutProtocol> superLayout;
- (void) layoutContent;
@end

@class DZLayout;
@interface UIView (DZLayout) <DZLayoutProtocol>
@property (nonatomic, strong) DZLayout* layout;
@end


@interface DZLayout : NSObject <DZLayoutProtocol>
{
    @protected
    NSMutableArray* _subLayouts;
    CGRect _frame;
}
@property (nonatomic, strong, readonly) NSArray* subLayouts;



- (void) addSubLayout:(DZLayout*)layout;
- (void) addSubLayout:(DZLayout *)layout atIndex:(NSInteger)index;

@end

@interface DZMarginLayout : DZLayout
@property (nonatomic, strong) id<DZLayoutProtocol> contentLayout;
@property (nonatomic, assign, readonly) UIEdgeInsets edgeInsets;
- (instancetype) initWithXMargin:(CGFloat)xMargin yMargin:(CGFloat)yMargin;
- (instancetype) initWithEdgheInsets:(UIEdgeInsets)edgeInsets;
@end


@interface DZ2PartLayout : DZLayout
{
    CGFloat _fix;
    CGRectEdge _edge;
}
@property (nonatomic, strong) id<DZLayoutProtocol> part1;
@property (nonatomic, strong) id<DZLayoutProtocol> part2;
- (instancetype) initWithFix:(CGFloat) fix edge:(CGRectEdge) edge;
@end



@interface DZHorizontalLayout : DZLayout

@property (nonatomic, strong, readonly) NSArray* ratio;

- (instancetype) initWithSubLayouts:(NSArray*)sublayouts ratio:(NSArray*)ratio;
@end
