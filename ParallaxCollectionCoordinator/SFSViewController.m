//
//  SFSViewController.m
//  ParallaxCollectionCoordinator
//
//  Created by Dalton Claybrook on 8/9/14.
//  Copyright (c) 2014 Space Factory Studios. All rights reserved.
//

#import "SFSViewController.h"

static NSString * const kTestCellReuseID = @"kTestCellReuseID";

@interface SFSViewController ()

@end

@implementation SFSViewController

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.collectionCoordinator = [[SFSParallaxCollectionCoordinator alloc] initWithCollectionViews:@[ self.collectionView1, self.collectionView2, self.collectionView3 ]];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
{
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [collectionView dequeueReusableCellWithReuseIdentifier:kTestCellReuseID forIndexPath:indexPath];
}

#pragma mark - UICollectionViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.collectionCoordinator scrollViewDidScroll:scrollView];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    [self.collectionCoordinator scrollViewWillEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.collectionCoordinator scrollViewWillBeginDragging:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self.collectionCoordinator scrollViewDidEndDecelerating:scrollView];
}

@end
