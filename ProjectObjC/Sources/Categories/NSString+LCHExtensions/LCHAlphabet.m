#import "LCHAlphabet.h"

#import "LCHRangeAlphabet.h"
#import "LCHClasterAlphabet.h"
#import "LCHStringsAlphabet.h"

#import "NSString+LCHExtensions.h"

@implementation LCHAlphabet

#pragma mark -
#pragma mark Class Methods

+ (instancetype)alphabetWithRange:(NSRange)range {
    return [[[LCHRangeAlphabet alloc] initWithRange:range] autorelease];
}

+ (instancetype)alphabetWithAlphabets:(NSArray *)alphabets {
    return [[[LCHClasterAlphabet alloc] initWithAlphabets:alphabets] autorelease];
}

+ (instancetype)alphabetWithStrings:(NSArray *)strings {
    return [[[LCHStringsAlphabet alloc] initWithStrings:strings] autorelease];
}

+ (instancetype)alphabetWithSymbols:(NSString *)string {
    return [self alphabetWithStrings:[string symbols]];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithRange:(NSRange)range {
    [self release];
    
    return [[LCHRangeAlphabet alloc] initWithRange:range];
}

- (instancetype)initWithAlphabets:(NSArray *)alphabets {
    [self release];
    
    return [[LCHClasterAlphabet alloc] initWithAlphabets:alphabets];
}

- (instancetype)initWithStrings:(NSArray *)strings {
    [self release];
    
    return [[LCHStringsAlphabet alloc] initWithStrings:strings];
}

- (instancetype)initWithSymbols:(NSString *)string {
    return [self initWithStrings:[string symbols]];
}

#pragma mark -
#pragma mark Public Implementations

- (NSUInteger)count {
    [self doesNotRecognizeSelector:_cmd];
    
    return 0;
}

- (NSString *)stringAtIndex:(NSUInteger)index {
    [self doesNotRecognizeSelector:_cmd];
    
    return nil;
}

- (NSString *)objectAtIndexedSubscript:(NSUInteger)index {
    return [self stringAtIndex:index ];
}

#pragma mark -
#pragma mark NSFastEnumeration

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state
                                  objects:(id _Nonnull [])stackbuf
                                    count:(NSUInteger)len
{
    return 0;
}

@end
