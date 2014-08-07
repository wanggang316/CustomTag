//
//  FJFlowLayoutWithPopAnimations.m
//  CollectionViewAnimations
//
//  Created by Engin Kurutepe on 26/04/14.
//  Copyright (c) 2014 Fifteen Jugglers Software. All rights reserved.
//

#import "WGFlowLayoutWithAnimations.h"

@interface WGFlowLayoutWithAnimations ()

@property (nonatomic) CGSize previousSize;
@property (nonatomic, strong) NSMutableArray *indexPathsToAnimate;

@property (nonatomic, strong) NSIndexPath *pinchedItem;
@property (nonatomic) CGSize pinchedItemSize;

@end

@implementation WGFlowLayoutWithAnimations

- (void)commonInit
{
    self.itemSize = CGSizeMake(50, 50);
    self.minimumLineSpacing = 10;
    self.sectionInset = UIEdgeInsetsMake(8, 8, 8, 8);
    self.headerReferenceSize = CGSizeMake(self.collectionView.frame.size.width, 40);
}

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        [self commonInit];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self commonInit];
    }
    
    return self;
}

- (NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{

    NSArray *attrs = [super layoutAttributesForElementsInRect:rect];
    
    if (_pinchedItem) {
        UICollectionViewLayoutAttributes *attr = [[attrs filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"indexPath == %@", _pinchedItem]] firstObject];
        
        attr.size = _pinchedItemSize;
        attr.zIndex = 100;
    }
    return attrs;
}

- (UICollectionViewLayoutAttributes*)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attr = [super layoutAttributesForItemAtIndexPath:indexPath];
    
    if ([indexPath isEqual:_pinchedItem]) {
        attr.size = _pinchedItemSize;
        attr.zIndex = 100;
    }
    
    return attr;
}

- (UICollectionViewLayoutAttributes*)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
    
    if ([_indexPathsToAnimate containsObject:itemIndexPath]) {
        
//        attr.center = self.fromRect.origin;
        attr.frame = self.fromRect;
        [_indexPathsToAnimate removeObject:itemIndexPath];
    }

    return attr;
}

- (UICollectionViewLayoutAttributes*)finalLayoutAttributesForDisappearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:itemIndexPath];

//    if ([_indexPathsToAnimate containsObject:itemIndexPath]) {
//
//        CATransform3D flyUpTransform = CATransform3DIdentity;
//        flyUpTransform.m34 = 1.0 / -20000;
//        flyUpTransform = CATransform3DTranslate(flyUpTransform, 0, 0, 19500);
//        attr.transform3D = flyUpTransform;
//        attr.center = self.collectionView.center;
//
//        attr.alpha = 0.2;
//        attr.zIndex = 1;
//        
//        [_indexPathsToAnimate removeObject:itemIndexPath];
//    }
//    else{
//        attr.alpha = 1.0;
//    }
    
    return attr;
}

- (void)prepareLayout
{
//    NSLog(@"%@ preparing layout", self);
    [super prepareLayout];
    self.previousSize = self.collectionView.bounds.size;
}

- (void)prepareForCollectionViewUpdates:(NSArray *)updateItems
{
//    NSLog(@"%@ prepare for updated", self);
    [super prepareForCollectionViewUpdates:updateItems];
    NSMutableArray *indexPaths = [NSMutableArray array];
    for (UICollectionViewUpdateItem *updateItem in updateItems) {
        switch (updateItem.updateAction) {
            case UICollectionUpdateActionInsert:
                [indexPaths addObject:updateItem.indexPathAfterUpdate];
                break;
            case UICollectionUpdateActionDelete:
                [indexPaths addObject:updateItem.indexPathBeforeUpdate];
                break;
            case UICollectionUpdateActionMove:
                [indexPaths addObject:updateItem.indexPathBeforeUpdate];
                [indexPaths addObject:updateItem.indexPathAfterUpdate];
                break;
            default:
                NSLog(@"unhandled case: %@", updateItem);
                break;
        }
    }
    
    self.indexPathsToAnimate = indexPaths;
}

- (void)finalizeCollectionViewUpdates
{
    [super finalizeCollectionViewUpdates];
    self.indexPathsToAnimate = nil;
}

- (void)prepareForAnimatedBoundsChange:(CGRect)oldBounds
{
    [super prepareForAnimatedBoundsChange:oldBounds];
}

- (void)finalizeAnimatedBoundsChange {
    [super finalizeAnimatedBoundsChange];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    CGRect oldBounds = self.collectionView.bounds;
    if (!CGSizeEqualToSize(oldBounds.size, newBounds.size)) {
        return YES;

    }
    return NO;
}


- (void)resizeItemAtIndexPath:(NSIndexPath*)indexPath withPinchDistance:(CGFloat)distance
{
    self.pinchedItem = indexPath;
    self.pinchedItemSize = CGSizeMake(distance, distance);

}

- (void)resetPinchedItem
{
    self.pinchedItem = nil;
    self.pinchedItemSize = CGSizeZero;
}


@end
