#import <Foundation/Foundation.h>

@protocol LCHAlphabetProtocol <NSObject>

- (uint32_t)count;

- (NSString *)stringAtIndex:(uint32_t)index;

@end
