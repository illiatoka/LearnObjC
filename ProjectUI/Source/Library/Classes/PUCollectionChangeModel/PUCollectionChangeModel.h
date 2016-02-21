#import <Foundation/Foundation.h>

@interface PUCollectionChangeModel : NSObject
@property (nonatomic, readonly) NSUInteger  modelAction;

+ (instancetype)collectionModelWithAction:(NSUInteger)action;

- (instancetype)initCollectionModelWithAction:(NSUInteger)action;

@end
