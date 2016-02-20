#import "PUCollectionChangeModel.h"

typedef NS_ENUM(NSUInteger, PUSingleArrayModelAction) {
    PUSingleArrayModelActionStart = 0,
    PUArrayModelActionAdd,
    PUArrayModelActionInsert,
    PUArrayModelActionRemove,
    PUArrayModelActionReplace,
    PUSingleArrayModelActionEnd
};

@interface PUArraySingleIndexChangeModel : PUCollectionChangeModel
@property (nonatomic, readonly) NSUInteger  index;

+ (instancetype)changeModelWithAction:(NSUInteger)action index:(NSUInteger)index;

- (instancetype)initWithAction:(NSUInteger)action index:(NSUInteger)index;

@end
