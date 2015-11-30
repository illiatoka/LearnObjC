#import <Foundation/Foundation.h>

#import "LCHAlphabetProtocol.h"

@interface NSString (LCHStringExtensions)

+ (instancetype)alphanumericAlphabet;
+ (instancetype)numericAlphabet;
+ (instancetype)lowercaseLetterAlphabet;
+ (instancetype)capitalizedLetterAlphabet;
+ (instancetype)letterAlphabet;

+ (instancetype)alphabetWithUnicodeRange:(NSRange)range;

+ (instancetype)randomString;
+ (instancetype)randomStringWithLength:(NSUInteger)length;
+ (instancetype)randomStringWithLength:(NSUInteger)length alphabet:(id)alphabet;

@end
