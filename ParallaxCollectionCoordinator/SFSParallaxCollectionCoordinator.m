//
//  SFSParallaxCollectionCoordinator.m
//  ParallaxCollectionCoordinator
//
//  Created by Dalton Claybrook on 8/9/14.
//  Copyright (c) 2014 Space Factory Studios. All rights reserved.
//

#import "SFSParallaxCollectionCoordinator.h"
#import "SFSSmallPageCollectionController.h"

@interface SFSParallaxCollectionCoordinator ()

@property (nonatomic, weak) UIScrollView *scrollingView;
@property (nonatomic, strong) NSArray *pageControllers;

@end

@implementation SFSParallaxCollectionCoordinator

#pragma mark - Initializers

- (instancetype)initWithCollectionViews:(NSArray *)collectionViews
{
    self = [super init];
    if (self)
    {
        _collectionViews = [collectionViews copy];
        [self SFSMultiPagingCollectionControllerCommonInit];
    }
    return self;
}

- (void)SFSMultiPagingCollectionControllerCommonInit
{
    [self setupCollectionViews];
}

#pragma mark - Accessors

- (void)setPagingEnabled:(BOOL)pagingEnabled
{
    if (_pagingEnabled == pagingEnabled)
    {
        return;
    }
    _pagingEnabled = pagingEnabled;
    
    [self updateDecelerationRates];
}

#pragma mark - Private

- (void)setupCollectionViews
{
    NSMutableArray *pageControllers = [NSMutableArray arrayWithCapacity:self.collectionViews.count];
    
    for (UICollectionView *collectionView in self.collectionViews)
    {
        UICollectionViewFlowLayout *flowLayout = (id)collectionView.collectionViewLayout;
        
        SFSSmallPageCollectionController *pageController = [[SFSSmallPageCollectionController alloc] initWithCollectionView:collectionView];
        pageController.itemSize = flowLayout.itemSize;
        pageController.lineSpacing = flowLayout.minimumLineSpacing;
        [pageControllers addObject:pageController];
    }
    
    self.pageControllers = [pageControllers copy];
}

- (SFSSmallPageCollectionController *)pageControllerForScrollView:(UIScrollView *)scrollView
{
    SFSSmallPageCollectionController *pageController = nil;
    
    NSUInteger index = [self.pageControllers indexOfObjectPassingTest:^BOOL(SFSSmallPageCollectionController *controller, NSUInteger idx, BOOL *stop) {
        return (controller.collectionView == scrollView);
    }];
    if (index != NSNotFound)
    {
        pageController = self.pageControllers[index];
    }
    
    return pageController;
}

- (void)updateDecelerationRates
{
    for (UICollectionView *collectionView in self.collectionViews)
    {
        collectionView.decelerationRate = (self.isPagingEnabled) ? UIScrollViewDecelerationRateFast : UIScrollViewDecelerationRateNormal;
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.scrollingView)
    {
        CGFloat firstScrollableWidth = scrollView.contentSize.width - CGRectGetWidth(scrollView.frame);
        CGFloat normalizedOffset = (scrollView.contentOffset.x / firstScrollableWidth);
        
        for (UICollectionView *collectionView in self.collectionViews)
        {
            if (collectionView != scrollView)
            {
                CGFloat secondScrollableWidth = collectionView.contentSize.width - CGRectGetWidth(collectionView.frame);
                CGFloat xOffset = normalizedOffset * secondScrollableWidth;
                
                [collectionView setContentOffset:CGPointMake(xOffset, collectionView.contentOffset.y) animated:NO];
            }
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.scrollingView = scrollView;
    
    if (self.isPagingEnabled)
    {
        SFSSmallPageCollectionController *pageController = [self pageControllerForScrollView:scrollView];
        
        [pageController scrollViewWillBeginDragging:scrollView];
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if (self.isPagingEnabled)
    {
        SFSSmallPageCollectionController *pageController = [self pageControllerForScrollView:scrollView];
        
        [pageController scrollViewWillEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.isPagingEnabled)
    {
        SFSSmallPageCollectionController *pageController = [self pageControllerForScrollView:scrollView];
        
        [pageController scrollViewDidEndDecelerating:scrollView];
    }
}

@end
