#import "LCHAlphabet.h"

@interface LCHRangeAlphabet : LCHAlphabet
@property (nonatomic, readonly) NSRange range;

- (instancetype)initWithRange:(NSRange)range;

@end
