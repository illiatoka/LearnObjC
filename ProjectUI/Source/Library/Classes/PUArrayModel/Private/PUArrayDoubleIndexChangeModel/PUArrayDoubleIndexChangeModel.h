#import "PUArraySingleIndexChangeModel.h"

typedef NS_ENUM(NSUInteger, PUDoubleArrayModelAction) {
    PUDoubleArrayModelActionStart = PUSingleArrayModelActionEnd,
    PUArrayModelActionExchange,
    PUArrayModelActionMove,
    PUDoubleArrayModelActionEnd
};

@interface PUArrayDoubleIndexChangeModel : PUArraySingleIndexChangeModel
@property (nonatomic, readonly) NSUInteger  toIndex;

+ (instancetype)changeModelWithAction:(NSUInteger)action idx1:(NSUInteger)idx1 idx2:(NSUInteger)idx2;

- (instancetype)initWithAction:(NSUInteger)action idx1:(NSUInteger)idx1 idx2:(NSUInteger)idx2;

@end
