//
//  SFSSmallPageCollectionController.m
//  ParallaxCollectionCoordinator
//
//  Created by Dalton Claybrook on 8/8/14.
//  Copyright (c) 2014 Space Factory Studios. All rights reserved.
//

#import "SFSSmallPageCollectionController.h"

@interface SFSSmallPageCollectionController ()

@property (nonatomic, assign) BOOL queuedScrollAnimation;
@property (nonatomic,assign) CGPoint queuedAnimationOffset;

@end

@implementation SFSSmallPageCollectionController

#pragma mark - Initializers

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView
{
    self = [super init];
    if (self)
    {
        _collectionView = collectionView;
    }
    return self;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    CGPoint offset = *targetContentOffset;
    
    CGFloat pageSize = self.itemSize.width + self.lineSpacing;
    NSUInteger page = roundf(offset.x / pageSize);
    offset.x = page * pageSize;
    
    // if the new offset is in the opposite direction of the scrolling direction
    if ((offset.x < scrollView.contentOffset.x && velocity.x > 0) || (offset.x > scrollView.contentOffset.x && velocity.x < 0))
    {
        self.queuedScrollAnimation = YES;
        self.queuedAnimationOffset = offset;
    }
    else
    {
        *targetContentOffset = offset;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (self.queuedScrollAnimation)
    {
        self.queuedScrollAnimation = NO;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.queuedScrollAnimation)
    {
        self.queuedScrollAnimation = NO;
        [scrollView setContentOffset:self.queuedAnimationOffset animated:YES];
    }
}

@end
