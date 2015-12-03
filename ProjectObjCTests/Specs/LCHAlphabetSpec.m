#import "Kiwi.h"

#import "LCHAlphabet.h"
#import "LCHClasterAlphabet.h"
#import "LCHRangeAlphabet.h"
#import "LCHStringsAlphabet.h"

SPEC_BEGIN(LCHAlphabetSpec)

describe(@"LCHAlphabet", ^{
    __block LCHAlphabet *alphabet = nil;
    
    afterEach(^{
        alphabet = nil;
    });
    
    context(@"when initialized with +alphabetWithRange:('A' - 'G')", ^{
        beforeAll(^{
            alphabet = [LCHAlphabet alphabetWithRange:NSMakeRange('A', 'G' - 'A')];
        });
        
        it(@"should be of Class LCHRangeAlphabet", ^{
            [[alphabet should] beKindOfClass:[LCHRangeAlphabet class]];
        });
    });
    
    context(@"when initialized with -initWithRange:('A' - 'G')", ^{
        beforeAll(^{
            alphabet = [[LCHAlphabet alloc ] initWithRange:NSMakeRange('A', 'G' - 'A')];
        });
        
        it(@"should be of Class LCHRangeAlphabet", ^{
            [[alphabet should] beKindOfClass:[LCHRangeAlphabet class]];
        });
    });
});

SPEC_END
