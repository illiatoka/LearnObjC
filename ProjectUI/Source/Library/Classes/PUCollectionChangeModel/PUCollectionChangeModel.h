#import <Foundation/Foundation.h>

@interface PUCollectionChangeModel : NSObject
@property (nonatomic, readonly) NSUInteger  modelAction;

+ (instancetype)changeModelWithAction:(NSUInteger)action;

- (instancetype)initModelWithAction:(NSUInteger)action;

@end
