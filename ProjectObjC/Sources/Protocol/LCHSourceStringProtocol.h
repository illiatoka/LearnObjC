#import <Foundation/Foundation.h>

@protocol LCHSourceStringProtocol <NSObject>

- (uint32_t)count;

- (NSString *)letterAtIndex:(uint32_t)index;

@end
