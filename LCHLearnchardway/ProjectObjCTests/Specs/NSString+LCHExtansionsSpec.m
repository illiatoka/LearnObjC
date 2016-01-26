#import "Kiwi.h"

#import "NSString+LCHExtensions.h"
#import "LCHAlphabet.h"

SPEC_BEGIN(NSStringLCHExtansionsSpec)

describe(@"NSString", ^{
    __block NSString *string = nil;
    
    afterAll(^{
        string = nil;
    });
    
    context(@"when initialized with +randomString:", ^{
        beforeAll(^{
            string = [NSString randomString];
        });
        
        it(@"should be of count kLCHDefaultRandomStringLength", ^{
            [[string should] haveCountOf:kLCHDefaultRandomStringLength];
        });
    });
    
    context(@"when initialized with +randomStringWithLength: with length 9", ^{
        beforeAll(^{
            string = [NSString randomStringWithLength:9];
        });
        
        it(@"should be of count 9", ^{
            [[string should] haveCountOf:9];
        });
    });
    
    context(@"when initialized with +randomStringWithLength: 12 alphabet: +alphanumericAlphabet:", ^{
        LCHAlphabet *alphabet = [LCHAlphabet alphanumericAlphabet];
        
        beforeAll(^{
            string = [NSString randomStringWithLength:12 alphabet:alphabet];
        });
        
        it(@"should be of count 12", ^{
            [[string should] haveCountOf:12];
        });
    });
});

SPEC_END
