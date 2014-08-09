//
//  SFSSmallPageCollectionController.h
//  ParallaxCollectionCoordinator
//
//  Created by Dalton Claybrook on 8/8/14.
//  Copyright (c) 2014 Space Factory Studios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SFSSmallPageCollectionController : NSObject <UIScrollViewDelegate>

@property (nonatomic, strong, readonly) UICollectionView *collectionView;
@property (nonatomic, assign) CGSize itemSize;
@property (nonatomic, assign) CGFloat lineSpacing;

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView;

@end

@interface SFSSmallPageCollectionController (ScrollViewDelegate)

/**
 *  You are required to forward these three methods.
 */

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset;
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;

@end