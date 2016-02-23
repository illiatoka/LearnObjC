#import "PUCollectionChangeModel.h"

typedef NS_ENUM(NSUInteger, PUSingleArrayModelAction) {
    PUArrayModelActionAdd,
    PUArrayModelActionInsert,
    PUArrayModelActionRemove,
    PUArrayModelActionReplace
};

@interface PUArraySingleIndexChangeModel : PUCollectionChangeModel
@property (nonatomic, readonly) NSUInteger  index;

+ (instancetype)modelWithAction:(NSUInteger)action index:(NSUInteger)index;

- (instancetype)initWithAction:(NSUInteger)action index:(NSUInteger)index;

@end
