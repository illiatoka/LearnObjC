#import "Kiwi.h"

#import "LCHAlphabet.h"
#import "LCHClasterAlphabet.h"
#import "LCHRangeAlphabet.h"
#import "LCHStringsAlphabet.h"

SPEC_BEGIN(LCHAlphabetSpec)

describe(@"LCHAlphabet", ^{
    __block LCHAlphabet *alphabet = nil;
    
    context(@"when initialized with +alphabetWithRange:('A' - 'G')", ^{
        beforeAll(^{
            alphabet = [LCHAlphabet alphabetWithRange:NSMakeRange('A', 'G' - 'A')];
        });
        
        afterAll(^{
            alphabet = nil;
        });
        
        it(@"should be of Class LCHRangeAlphabet", ^{
            [[alphabet should] beKindOfClass:[LCHRangeAlphabet class]];
        });
    });
});

SPEC_END
