#import "LCHClasterAlphabet.h"

@interface LCHClasterAlphabet ()
@property (nonatomic, retain, readwrite) NSArray *alphabets;
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
    NSUInteger iteratedCount = count;
    NSUInteger iteratedIndex = index;
    NSUInteger iterator = 0;
    
    NSAssert(index < count, NSRangeException);
    
    for (LCHAlphabet *alphabet in self.alphabets) {
        if (iterator >= index) {
            return alphabet[iteratedIndex];
        }
        
        iteratedCount = [alphabet count];
        iteratedIndex = iteratedIndex - iteratedCount;
        iterator = iterator + iteratedCount;
    }
    
    return  nil;
}

#pragma mark -
#pragma mark - Private Implementations

- (NSUInteger)countWithAlphabets:(NSArray *)alphabets {
    NSUInteger count = 0;
    
    for (LCHAlphabet *alphabet in self.alphabets) {
        count = count + [alphabet count];
    }
    
    return count;
}

#pragma mark -
#pragma mark NSFastEnumeration

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state
                                  objects:(id _Nonnull [])stackbuf
                                    count:(NSUInteger)len
{
    return [super countByEnumeratingWithState:state objects:stackbuf count:len];
}

@end
