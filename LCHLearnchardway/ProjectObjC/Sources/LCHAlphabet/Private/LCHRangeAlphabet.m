#import "LCHRangeAlphabet.h"

@interface LCHRangeAlphabet ()
@property (nonatomic, readwrite, assign) NSRange range;

@end

@implementation LCHRangeAlphabet

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithRange:(NSRange)range {
    self = [super init];
    
    if (self) {
        self.range = range;
    }
    
    return self;
}

#pragma mark -
#pragma mark Public Implementations

- (NSUInteger)count {
    return self.range.length;
}

- (NSString *)stringAtIndex:(NSUInteger)index {
    NSRange range = self.range;
    
    NSAssert(index < range.length, NSRangeException);
    
    return [NSString stringWithFormat:@"%c", (unichar)(range.location + index)];
}

@end
