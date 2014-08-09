//
//  SFSViewController.h
//  ParallaxCollectionCoordinator
//
//  Created by Dalton Claybrook on 8/9/14.
//  Copyright (c) 2014 Space Factory Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFSParallaxCollectionCoordinator.h"

@interface SFSViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) SFSParallaxCollectionCoordinator *collectionCoordinator;

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView1;
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView2;
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView3;

@end
