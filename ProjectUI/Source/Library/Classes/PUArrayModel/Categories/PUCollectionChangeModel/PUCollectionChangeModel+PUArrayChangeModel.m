#import "PUCollectionChangeModel+PUArrayChangeModel.h"

#import "PUArraySingleIndexChangeModel.h"
#import "PUArrayDoubleIndexChangeModel.h"

@implementation PUCollectionChangeModel (PUArrayChangeModel)

#pragma mark -
#pragma mark Class Methods

+ (instancetype)addingModelWithIndex:(NSUInteger)index {
    return [PUArraySingleIndexChangeModel modelWithAction:PUArrayModelActionAdd index:index];
}

+ (instancetype)insertingModelWithIndex:(NSUInteger)index {
    return [PUArraySingleIndexChangeModel modelWithAction:PUArrayModelActionInsert index:index];
}

+ (instancetype)removingModelWithIndex:(NSUInteger)index {
    return [PUArraySingleIndexChangeModel modelWithAction:PUArrayModelActionRemove index:index];
}

+ (instancetype)replacingModelWithIndex:(NSUInteger)index {
    return [PUArraySingleIndexChangeModel modelWithAction:PUArrayModelActionReplace index:index];
}

+ (instancetype)exchangingModelWithIndex:(NSUInteger)index toIndex:(NSUInteger)toIndex {
    return [PUArrayDoubleIndexChangeModel modelWithAction:PUArrayModelActionExchange idx1:index idx2:toIndex];
}

+ (instancetype)movingModelWithIndex:(NSUInteger)index toIndex:(NSUInteger)toIndex {
    return [PUArrayDoubleIndexChangeModel modelWithAction:PUArrayModelActionMove idx1:index idx2:toIndex];
}

@end
