#import <Foundation/Foundation.h>

@interface LCHContainerWithCapacity : NSObject
@property (nonatomic, readonly) NSUInteger  capacity;
@property (nonatomic, readonly) NSSet       *items;

@end
