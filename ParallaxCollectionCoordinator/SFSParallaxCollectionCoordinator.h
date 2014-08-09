//
//  SFSParallaxCollectionCoordinator.h
//  ParallaxCollectionCoordinator
//
//  Created by Dalton Claybrook on 8/9/14.
//  Copyright (c) 2014 Space Factory Studios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SFSParallaxCollectionCoordinator : NSObject <UIScrollViewDelegate>

@property (nonatomic, copy, readonly) NSArray *collectionViews;
@property (nonatomic, assign, getter = isPagingEnabled) BOOL pagingEnabled;

- (instancetype)initWithCollectionViews:(NSArray *)collectionViews;

@end

@interface SFSParallaxCollectionCoordinator (ScrollViewDelegate)

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset;
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;

@end