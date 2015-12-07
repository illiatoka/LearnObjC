#import <Foundation/Foundation.h>

#import "LCHAlphabetProtocol.h"

extern const NSUInteger kLCHDefaultRandomStringLength;

@interface NSString (LCHStringExtensions) <LCHAlphabetProtocol>

+ (instancetype)randomString;
+ (instancetype)randomStringWithLength:(NSUInteger)length;
+ (instancetype)randomStringWithLength:(NSUInteger)length alphabet:(id<LCHAlphabetProtocol>)alphabet;

- (NSArray *)symbols;

@end
