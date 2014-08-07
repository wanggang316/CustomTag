//
//  WGViewController.m
//  CustomTag
//
//  Created by 王刚 on 14/8/4.
//  Copyright (c) 2014年 wwwlife. All rights reserved.
//

#import "WGViewController.h"
#import "WGFlowLayoutWithAnimations.h"
#import "WGStore.h"

@interface WGViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) WGFlowLayoutWithAnimations *flowLayout;

@property (nonatomic, strong) NSMutableArray *sections;

@end

@implementation WGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //数据源
    self.sections = [[NSMutableArray alloc]initWithObjects:[WGStore customTags], [WGStore noCustomTags], nil];
    
    self.flowLayout = [[WGFlowLayoutWithAnimations alloc] init];
    _flowLayout.itemSize = CGSizeMake(140, 30);
    
    _collectionView.collectionViewLayout = _flowLayout;
    
    [self.view addSubview:_collectionView];
    
    
}


- (void)moveItemFromIndexPath:(NSIndexPath *)fromIndexPath {
    
    
    NSInteger toSectionIndex = fromIndexPath.section == 0 ? 1 : 0;
    NSIndexPath *toIndexPath;
    
    NSMutableArray *fromSection = [[self.sections objectAtIndex:fromIndexPath.section] mutableCopy];
    NSMutableArray *toSection = [[self.sections objectAtIndex:toSectionIndex] mutableCopy];
    
    WGTag *moveTag = [fromSection objectAtIndex:fromIndexPath.row];
    
    [fromSection removeObjectAtIndex:fromIndexPath.row];
    [toSection addObject:moveTag];
   
    self.sections[fromIndexPath.section] = [fromSection copy];
    self.sections[toSectionIndex] = [toSection copy];
    
    
    toIndexPath = [NSIndexPath indexPathForItem:toSection.count-1 inSection:toSectionIndex];
    
    
    [self.collectionView moveItemAtIndexPath:fromIndexPath toIndexPath:toIndexPath];
}



#pragma mark - Collection View Data Source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.sections.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [[self.sections objectAtIndex:section] count];
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"DemoCell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    UILabel *tagNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
    tagNameLabel.font = [UIFont systemFontOfSize:15];
    tagNameLabel.textColor = [UIColor darkGrayColor];
    tagNameLabel.textAlignment = NSTextAlignmentCenter;
    tagNameLabel.layer.masksToBounds = YES;
    tagNameLabel.layer.cornerRadius = 6;
    tagNameLabel.layer.borderWidth = 1;
    tagNameLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [cell.contentView addSubview:tagNameLabel];
    
    WGTag *tag = [[self.sections objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    tagNameLabel.text = tag.tagName;
    
//    cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return cell;
}



- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *sectionHeaderView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SectionHeader" forIndexPath:indexPath];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, sectionHeaderView.frame.size.width, sectionHeaderView.frame.size.height)];
    titleLabel.font = [UIFont systemFontOfSize:17];
    titleLabel.textAlignment = NSTextAlignmentCenter;

    
    if (indexPath.section == 0) {
        titleLabel.textColor = [UIColor redColor];
        titleLabel.text = @"我的订阅";
    } else {
        titleLabel.textColor = [UIColor grayColor];
       titleLabel.text = @"标签";
    }
    
    
    [sectionHeaderView addSubview:titleLabel];
    
    return sectionHeaderView;
}


#pragma mark - Collection View Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indexPath];
    CGRect frame = cell.frame;
    self.flowLayout.fromRect = frame;
    
    [self moveItemFromIndexPath:indexPath];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
