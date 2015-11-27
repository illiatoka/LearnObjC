#import <Foundation/Foundation.h>

#import "LCHSourceStringProtocol.h"

@interface NSString (LCHStringExtensions) <LCHSourceStringProtocol>

+ (instancetype)randomStringWithLength:(NSUInteger)length source:(id<LCHSourceStringProtocol>)source;

@end
