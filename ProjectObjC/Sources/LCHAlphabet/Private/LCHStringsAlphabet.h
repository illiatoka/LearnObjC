#import "LCHAlphabet.h"

@interface LCHStringsAlphabet : LCHAlphabet
@property (nonatomic, readonly) NSArray *strings;

- (instancetype)initWithStrings:(NSArray *)strings;

@end
