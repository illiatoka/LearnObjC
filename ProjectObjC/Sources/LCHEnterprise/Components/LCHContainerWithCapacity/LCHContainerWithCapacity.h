#import "LCHContainer.h"

@interface LCHContainerWithCapacity : LCHContainer
@property (nonatomic, readonly) NSUInteger  capacity;

+ (instancetype)containerWithCapacity:(NSUInteger)capacity;

- (instancetype)initWithCapacity:(NSUInteger)capacity;

- (BOOL)isFull;

@end
