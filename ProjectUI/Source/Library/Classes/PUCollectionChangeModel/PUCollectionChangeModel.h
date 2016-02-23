#import <Foundation/Foundation.h>

@interface PUCollectionChangeModel : NSObject
@property (nonatomic, readonly) NSUInteger  modelAction;

+ (instancetype)modelWithAction:(NSUInteger)action;

- (instancetype)initWithAction:(NSUInteger)action;

@end
