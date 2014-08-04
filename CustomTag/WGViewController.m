//
//  WGViewController.m
//  CustomTag
//
//  Created by 王刚 on 14/8/4.
//  Copyright (c) 2014年 wwwlife. All rights reserved.
//

#import "WGViewController.h"
#import "FJFlowLayoutWithAnimations.h"

@interface WGViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic) NSInteger sectionCount;
@property (nonatomic, strong) NSMutableArray *itemCounts;
@property (nonatomic, strong) FJFlowLayoutWithAnimations *smallLayout;
@end

@implementation WGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.sectionCount = 2;
    self.itemCounts = [NSMutableArray arrayWithArray:@[@(9), @(7)]];
    
    self.smallLayout = [[FJFlowLayoutWithAnimations alloc] init];
    _smallLayout.itemSize = CGSizeMake(50, 50);
    
    _collectionView.collectionViewLayout = _smallLayout;
    
    [self.view addSubview:_collectionView];
    
    UIBarButtonItem *insertItem = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                   target:self
                                   action:@selector(insertItem)];
    
    UIBarButtonItem *deleteItem = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemTrash
                                   target:self
                                   action:@selector(deleteItem)];
    
    self.navigationItem.rightBarButtonItems = @[insertItem, deleteItem];
}


- (void)insertItem:(NSInteger)section
{
    NSInteger randomSection = (section == 0 ? 1 : 0);//arc4random_uniform(_sectionCount);
    
    NSInteger item = [_itemCounts[randomSection] integerValue] + 1;
    _itemCounts[randomSection] = @(item);
    
    [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:item-1 inSection:randomSection]]];
}

- (void)deleteItem:(NSInteger)section
{
    NSInteger randomSection = section;//arc4random_uniform(_sectionCount);
    NSInteger item = [_itemCounts[randomSection] integerValue];
    
    if (item) {
        _itemCounts[randomSection] = @(item-1);
        [self.collectionView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:item-1 inSection:randomSection]]];
    }
    else {
        NSInteger totalItems = 0;
        for (NSNumber *num in _itemCounts) {
            totalItems += [num integerValue];
        }
        if (totalItems) {
            [self deleteItem:section];
        }
        
    }
    
}

- (void)moveFromItem:(NSIndexPath *)fromIndexPath toItem:(NSIndexPath *)toIndexPath {
    [self.collectionView moveItemAtIndexPath:fromIndexPath toIndexPath:toIndexPath];
}


#pragma mark - Collection View Data Source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return _sectionCount;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_itemCounts[section] integerValue];
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"DemoCell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSInteger itemCount = [self collectionView:collectionView numberOfItemsInSection:indexPath.section];
    CGFloat colorValue = 1.0-(indexPath.item+1.0)/(2*itemCount);
    
    cell.backgroundColor = [UIColor colorWithRed:(indexPath.section==0)?colorValue:0.0
                                           green:(indexPath.section==1)?colorValue:0.0
                                            blue:(indexPath.section==2)?colorValue:0.0
                                           alpha:1.0];
    
    return cell;
}

#pragma mark - Collection View Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"------------------>selected section : %d, row : %d", indexPath.section, indexPath.row);
    UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indexPath];
    CGRect frame = cell.frame;
    self.smallLayout.fromRect = frame;
    NSLog(@"cell frame point x : %f, point y : %f", frame.origin.x, frame.origin.y);
//    if (indexPath.section == 1) {
    [self deleteItem:indexPath.section];
    [self insertItem:indexPath.section];
//    }
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
