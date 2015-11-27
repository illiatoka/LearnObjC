#import "NSString+LCHStringExtensions.h"

@implementation NSString (LCHStringExtensions)

#pragma mark -
#pragma mark Class Methods

+ (instancetype)randomStringWithLength:(NSUInteger)length source:(id<LCHSourceStringProtocol>)source {
    NSMutableString *randomString = [NSMutableString string];
    uint32_t sourceCount = [source count];
    
    for (NSUInteger index = 0; index < length; index++) {
        [randomString appendString:[source letterAtIndex:(arc4random_uniform(sourceCount))]];
    }
    
    return [self stringWithString:randomString];
}

#pragma mark -
#pragma mark LCHSourceStringProtocol

- (NSUInteger)count {
    return [self length];
}

- (NSString *)letterAtIndex:(NSUInteger)index {
    return [NSString stringWithFormat:@"%c", [self characterAtIndex:index]];
}

@end
