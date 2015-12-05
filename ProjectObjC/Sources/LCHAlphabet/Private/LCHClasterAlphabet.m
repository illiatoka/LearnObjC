#import "LCHClasterAlphabet.h"

@interface LCHClasterAlphabet ()
@property (nonatomic, retain, readwrite) NSArray    *alphabets;
@property (nonatomic, assign, readwrite) NSUInteger count;

- (NSUInteger)countWithAlphabets:(NSArray *)alphabets;

@end

@implementation LCHClasterAlphabet

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.alphabets = nil;
    
    [super dealloc];
}


- (instancetype)initWithAlphabets:(NSArray *)alphabets {
    self = [super init];
    
    if (self) {
        self.alphabets = alphabets;
        self.count = [self countWithAlphabets:alphabets];
    }
    
    return self;
}

#pragma mark -
#pragma mark Public Implementations

- (NSString *)stringAtIndex:(NSUInteger)index {
    NSUInteger count = self.count;
    NSUInteger iteratedIndex = index;
    
    NSAssert(index < count, NSRangeException);
    
    for (LCHAlphabet *alphabet in self.alphabets) {
        count = [alphabet count];
        
        if (iteratedIndex < count) {
            return alphabet[iteratedIndex];
        }
        
        iteratedIndex = iteratedIndex - count;
    }
    
    return nil;
}

- (NSString *)string {
    NSMutableString *string = [NSMutableString stringWithCapacity:[self count]];
    
    for (LCHAlphabet *alphabet in self.alphabets) {
        [string appendString:[alphabet string]];
    }
    
    return [[string copy] autorelease];
}

#pragma mark -
#pragma mark - Private Implementations

- (NSUInteger)countWithAlphabets:(NSArray *)alphabets {
    NSUInteger count = 0;
    
    for (LCHAlphabet *alphabet in alphabets) {
        count += [alphabet count];
    }
    
    return count;
}

@end
