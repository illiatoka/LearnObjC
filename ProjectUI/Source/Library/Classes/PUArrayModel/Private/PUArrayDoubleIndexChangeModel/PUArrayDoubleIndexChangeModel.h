#import "PUArraySingleIndexChangeModel.h"

typedef NS_ENUM(NSUInteger, PUDoubleArrayModelAction) {
    PUArrayModelActionExchange,
    PUArrayModelActionMove
};

@interface PUArrayDoubleIndexChangeModel : PUArraySingleIndexChangeModel
@property (nonatomic, readonly) NSUInteger  toIndex;

+ (instancetype)modelWithAction:(NSUInteger)action idx1:(NSUInteger)idx1 idx2:(NSUInteger)idx2;

- (instancetype)initWithAction:(NSUInteger)action idx1:(NSUInteger)idx1 idx2:(NSUInteger)idx2;

@end
