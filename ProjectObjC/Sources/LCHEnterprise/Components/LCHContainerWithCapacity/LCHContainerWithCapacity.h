#import <Foundation/Foundation.h>

@interface LCHContainerWithCapacity : NSObject
@property (nonatomic, readonly) NSUInteger  capacity;
@property (nonatomic, readonly) NSSet       *items;

+ (instancetype)containerWithCapacity:(NSUInteger)capacity;

- (instancetype)initWithCapacity:(NSUInteger)capacity;

- (void)addItem:(id)item;
- (void)removeItem:(id)item;

- (BOOL)isFull;

@end
