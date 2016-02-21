#import "PUCollectionChangeModel.h"

@interface PUCollectionChangeModel (PUArrayChangeModel)

+ (instancetype)addingModelWithIndex:(NSUInteger)index;
+ (instancetype)insertingModelWithIndex:(NSUInteger)index;
+ (instancetype)removingModelWithIndex:(NSUInteger)index;
+ (instancetype)replacingModelWithIndex:(NSUInteger)index;

+ (instancetype)exchangingModelWithIndex:(NSUInteger)index toIndex:(NSUInteger)toIndex;
+ (instancetype)movingModelWithIndex:(NSUInteger)index toIndex:(NSUInteger)toIndex;

@end
