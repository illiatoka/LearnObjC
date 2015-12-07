#import "NSString+LCHExtensions.h"
#import "LCHAlphabet.h"

@implementation NSString (LCHStringExtensions)

const NSUInteger kLCHDefaultRandomStringLength = 31;

#pragma mark -
#pragma mark Class Methods

+ (instancetype)randomString {
    return [self randomStringWithLength:kLCHDefaultRandomStringLength];
}

+ (instancetype)randomStringWithLength:(NSUInteger)length {
    return [self randomStringWithLength:length alphabet:[LCHAlphabet alphanumericAlphabet]];
}

+ (instancetype)randomStringWithLength:(NSUInteger)length alphabet:(id<LCHAlphabetProtocol>)alphabet {
    NSMutableString *result = [NSMutableString stringWithCapacity:length];
    
    for (NSUInteger index = 0; index < length; index++) {
        [result appendString:[alphabet stringAtIndex:arc4random_uniform((uint32_t)[alphabet count])]];
    }
    
    return [self stringWithString:result];
}

#pragma mark -
#pragma mark Public Implementations

- (NSArray *)symbols {
    NSUInteger length = [self length];
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:length];
    
    for (NSUInteger index = 0; index < length; index++) {
        [result addObject:[NSString stringWithFormat:@"%c", [self characterAtIndex:index]]];
    }
    
    return [[result copy] autorelease];
}

#pragma mark -
#pragma mark LCHAlphabetProtocol

- (NSUInteger)count {
    return [self length];
}

- (NSString *)stringAtIndex:(NSUInteger)index {
    return [NSString stringWithFormat:@"%c", [self characterAtIndex:index]];
}

@end
