#import <Foundation/Foundation.h>
#import "LCHAlphabetProtocol.h"

@interface LCHAlphabet : NSObject <NSFastEnumeration, LCHAlphabetProtocol>

+ (instancetype)alphanumericAlphabet;
+ (instancetype)numericAlphabet;
+ (instancetype)lowercaseLetterAlphabet;
+ (instancetype)capitalizedLetterAlphabet;
+ (instancetype)letterAlphabet;

+ (instancetype)alphabetWithRange:(NSRange)range;
+ (instancetype)alphabetWithAlphabets:(NSArray *)alphabets;
+ (instancetype)alphabetWithStrings:(NSArray *)strings;
+ (instancetype)alphabetWithSymbols:(NSString *)string;

- (instancetype)initWithRange:(NSRange)range;
- (instancetype)initWithAlphabets:(NSArray *)alphabets;
- (instancetype)initWithStrings:(NSArray *)strings;
- (instancetype)initWithSymbols:(NSString *)string;

- (NSUInteger)count;

- (NSString *)stringAtIndex:(NSUInteger)index;
- (NSString *)objectAtIndexedSubscript:(NSUInteger)index;
- (NSString *)string;

@end
