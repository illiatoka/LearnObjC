#import "LCHAlphabet.h"

@interface LCHClasterAlphabet : LCHAlphabet
@property (nonatomic, readonly) NSArray *alphabets;

- (instancetype)initWithAlphabets:(NSArray *)alphabets;

@end
