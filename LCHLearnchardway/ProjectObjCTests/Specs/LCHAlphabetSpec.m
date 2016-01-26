#import "Kiwi.h"

#import "LCHAlphabet.h"
#import "LCHClasterAlphabet.h"
#import "LCHRangeAlphabet.h"
#import "LCHStringsAlphabet.h"

SPEC_BEGIN(LCHAlphabetSpec)

describe(@"LCHAlphabet", ^{
    __block LCHAlphabet *alphabet = nil;
    
    afterAll(^{
        alphabet = nil;
    });
    
    context(@"when initialized with +alphabetWithRange: with range ('A' - 'G')", ^{
        NSRange range = NSMakeRange('A', 'G' - 'A' + 1);

        beforeAll(^{
            alphabet = [LCHAlphabet alphabetWithRange:range];
        });

        it(@"should be of Class LCHRangeAlphabet", ^{
            [[alphabet should] beKindOfClass:[LCHRangeAlphabet class]];
        });
        
        it(@"should be of count 7", ^{
            [[alphabet should] haveCountOf:7];
        });
        
        it(@"should contain A at index 0", ^{
            [[[alphabet stringAtIndex:0] should] equal:@"A"];
        });
        
        it(@"should contain B at index 1", ^{
            [[alphabet[1] should] equal:@"B"];
        });
        
        it(@"should raise if requested object at index is out of range", ^{
            [[theBlock(^{
                [alphabet stringAtIndex:7];
            }) should] raise];
            
            [[theBlock(^{
                id string = alphabet[7];
                [string description];
            }) should] raise];
        });
        
        it(@"should return 'ABCDEFG' from -string", ^{
            NSLog(@"\n\n String is: \n %@ \n\n", [alphabet string]);
            [[[alphabet string] should] equal:@"ABCDEFG"];
        });
    });

    context(@"when initialized with -initWithRange: with range ('A' - 'G')", ^{
        NSRange range = NSMakeRange('A', 'G' - 'A' + 1);
        
        beforeAll(^{
            alphabet = [[LCHAlphabet alloc] initWithRange:range];
        });
        
        it(@"should be of Class LCHRangeAlphabet", ^{
            [[alphabet should] beKindOfClass:[LCHRangeAlphabet class]];
        });
    });
    
    context(@"when initialized with +alphabetWithRange: with range ('A' - 'G') and enumerated", ^{
        NSRange range = NSMakeRange('A', 'z' - 'A' + 1);
        
        beforeAll(^{
            alphabet = [LCHAlphabet alphabetWithRange:range];
        });
        
        it(@"should be of Class LCHRangeAlphabet", ^{
            [[alphabet should] beKindOfClass:[LCHRangeAlphabet class]];
        });
        
        it(@"should not raise during enumeration", ^{
            [[theBlock(^{
                for (NSString *symbol in alphabet) {
                    [symbol description];
                }
            }) shouldNot] raise];
        });
        
        it(@"should return count of symbols equal to 'A - z' range", ^{
            NSUInteger count = 0;
            
            for (NSString *symbol in alphabet) {
                [symbol description];

                count++;
            }
            
            [[theValue(count) should] equal:@(range.length)];
        });
        
        it(@"should return symbols in range 'A - z'", ^{
            unichar character = range.location;
            
            for (NSString *symbol in alphabet) {
                [[symbol should] equal:[NSString stringWithFormat:@"%c", character]];
                
                character++;
            }
        });
    });
    
    context(@"when initialized with +alphabetWithStrings: with array @[@'A', 'B', 'C']", ^{
        beforeAll(^{
            alphabet = [LCHAlphabet alphabetWithStrings:@[@"A", @"B", @"C"]];
        });
        
        it(@"should be of Class LCHStringsAlphabet", ^{
            [[alphabet should] beKindOfClass:[LCHStringsAlphabet class]];
        });
        
        it(@"should be of count 3", ^{
            [[alphabet should] haveCountOf:3];
        });
        
        it(@"should contain A at index 0", ^{
            [[[alphabet stringAtIndex:0] should] equal:@"A"];
        });
        
        it(@"should contain B at index 1", ^{
            [[alphabet[1] should] equal:@"B"];
        });
        
        it(@"should raise if requested object at index is out of range", ^{
            [[theBlock(^{
                [alphabet stringAtIndex:3];
            }) should] raise];
            
            [[theBlock(^{
                id string = alphabet[3];
                [string description];
            }) should] raise];
        });
        
        it(@"should return 'ABC' from -string", ^{
            [[[alphabet string] should] equal:@"ABC"];
        });
    });

    context(@"when initialized with -initWithStrings: with array @[@'A', 'B', 'C']", ^{
        beforeAll(^{
            alphabet = [[LCHAlphabet alloc] initWithStrings:@[@"A", @"B", @"C"]];
        });
        
        it(@"should be of Class LCHStringsAlphabet", ^{
            [[alphabet should] beKindOfClass:[LCHStringsAlphabet class]];
        });
    });
    
    context(@"when initialized with +alphabetWithStrings: with array @'[@'A', 'B', 'C']' and enumerated", ^{
        NSRange range = NSMakeRange('A', 'z' - 'A' + 1);
        NSMutableArray *strings = [NSMutableArray array];
        
        beforeAll(^{
            for (unichar symbol = range.location; symbol < NSMaxRange(range); symbol++) {
                [strings addObject:[NSString stringWithFormat:@"%c", symbol]];
            }
            
            alphabet = [LCHAlphabet alphabetWithStrings:strings];
        });
        
        it(@"should be of Class LCHStringsAlphabet", ^{
            [[alphabet should] beKindOfClass:[LCHStringsAlphabet class]];
        });
        
        it(@"should not raise during enumeration", ^{
            [[theBlock(^{
                for (NSString *symbol in alphabet) {
                    [symbol description];
                }
            }) shouldNot] raise];
        });
        
        it(@"should return count of symbols equal to 'A - z' range", ^{
            NSUInteger count = 0;
            
            for (NSString *symbol in alphabet) {
                [symbol description];
                
                count++;
            }
            
            [[theValue(count) should] equal:@(range.length)];
        });
        
        it(@"should return symbols in range 'A - z'", ^{
            unichar character = range.location;
            
            for (NSString *symbol in alphabet) {
                [[symbol should] equal:[NSString stringWithFormat:@"%c", character]];
                
                character++;
            }
        });
    });
    
    context(@"when initialized with +alphabetWithAlphabets: with alphabets in range ('A - Z', 'a - z')", ^{
        LCHAlphabet *capitalizedAlphabet = [LCHAlphabet alphabetWithRange:NSMakeRange('A', 'Z' - 'A' + 1)];
        LCHAlphabet *lowercaseAlphabet = [LCHAlphabet alphabetWithRange:NSMakeRange('a', 'z' - 'a' + 1)];
        
        beforeAll(^{
            alphabet = [LCHAlphabet alphabetWithAlphabets:@[capitalizedAlphabet, lowercaseAlphabet]];
        });
        
        it(@"should be of Class LCHClasterAlphabet", ^{
            [[alphabet should] beKindOfClass:[LCHClasterAlphabet class]];
        });
        
        it(@"should contain A at index 0", ^{
            [[[alphabet stringAtIndex:0] should] equal:@"A"];
        });
        
        it(@"should contain B at index 1", ^{
            [[[alphabet stringAtIndex:1] should] equal:@"B"];
        });
        
        it(@"should be of count 52", ^{
            [[alphabet should] haveCountOf:52];
        });

        it(@"should raise if requested object at index is out of range", ^{
            [[theBlock(^{
                [alphabet stringAtIndex:52];
            }) should] raise];
            
            [[theBlock(^{
                id string = alphabet[52];
                [string description];
            }) should] raise];
        });

        it(@"should return 'A-Za-z' from -string", ^{
            NSString *string = [NSString stringWithFormat:@"%@%@",
                                [capitalizedAlphabet string],
                                [lowercaseAlphabet string]];
            
            [[[alphabet string] should] equal:string];
        });
    });
    
    context(@"when initialized with -initWithAlphabets: with alphabets in range ('A - Z', 'a - z')", ^{
        LCHAlphabet *capitalizedAlphabet = [LCHAlphabet alphabetWithRange:NSMakeRange('A', 'Z' - 'A' + 1)];
        LCHAlphabet *lowercaseAlphabet = [LCHAlphabet alphabetWithRange:NSMakeRange('a', 'z' - 'a' + 1)];
        
        beforeAll(^{
            alphabet = [LCHAlphabet alphabetWithAlphabets:@[capitalizedAlphabet, lowercaseAlphabet]];
        });
        
        it(@"should be of Class LCHClasterAlphabet", ^{
            [[alphabet should] beKindOfClass:[LCHClasterAlphabet class]];
        });
    });
    
    context(@"when initialized with +alphabetWithStrings: with array @'[@'A', 'B', 'C']' and enumerated", ^{
        NSRange capitalizedRange = NSMakeRange('A', 'Z' - 'A' + 1);
        NSRange lowercaseRange = NSMakeRange('a', 'z' - 'a' + 1);
        
        LCHAlphabet *capitalizedAlphabet = [LCHAlphabet alphabetWithRange:capitalizedRange];
        LCHAlphabet *lowercaseAlphabet = [LCHAlphabet alphabetWithRange:lowercaseRange];
        
        beforeAll(^{
            alphabet = [LCHAlphabet alphabetWithAlphabets:@[capitalizedAlphabet, lowercaseAlphabet]];
        });
        
        it(@"should be of Class LCHClasterAlphabet", ^{
            [[alphabet should] beKindOfClass:[LCHClasterAlphabet class]];
        });
        
        it(@"should not raise during enumeration", ^{
            [[theBlock(^{
                for (NSString *symbol in alphabet) {
                    [symbol description];
                }
            }) shouldNot] raise];
        });
        
        it(@"should return count of symbols equal to 'A - z' + 'a - z' range", ^{
            NSUInteger count = 0;
            
            for (NSString *symbol in alphabet) {
                [symbol description];
                
                count++;
            }
            
            [[theValue(count) should] equal:@([capitalizedAlphabet count] + [lowercaseAlphabet count])];
        });
        
        it(@"should return symbols in range 'A - z' + 'a - z'", ^{
            NSUInteger index = 0;
            NSString *string = [NSString stringWithFormat:@"%@%@",
                                       [capitalizedAlphabet string],
                                       [lowercaseAlphabet string]];
            
            for (NSString *symbol in alphabet) {
                [[symbol should] equal:[NSString stringWithFormat:@"%c", [string characterAtIndex:index]]];
                
                index++;
            }
        });
    });
    
    context(@"when initialized with +alphabetWithSymbols: with symbols ('ABCDEF')", ^{
        NSString *string = @("ABCDEF");
        
        beforeAll(^{
            alphabet = [LCHAlphabet alphabetWithSymbols:string];
        });
        
        it(@"should be of Class LCHStringsAlphabet", ^{
            [[alphabet should] beKindOfClass:[LCHStringsAlphabet class]];
        });
        
        it(@"should be of count 6", ^{
            [[alphabet should] haveCountOf:6];
        });
        
        it(@"should contain A at index 0", ^{
            [[[alphabet stringAtIndex:0] should] equal:@"A"];
        });
        
        it(@"should contain B at index 1", ^{
            [[alphabet[1] should] equal:@"B"];
        });
        
        it(@"should raise if requested object at index is out of range", ^{
            [[theBlock(^{
                [alphabet stringAtIndex:6];
            }) should] raise];
            
            [[theBlock(^{
                id string = alphabet[6];
                [string description];
            }) should] raise];
        });
        
        it(@"should return 'ABC' from -string", ^{
            [[[alphabet string] should] equal:string];
        });
    });
    
    context(@"when initialized with -initWithStrings: with symbols ('ABCDEF')", ^{
        NSString *string = @("ABCDEF");
        
        beforeAll(^{
            alphabet = [[LCHAlphabet alloc] initWithSymbols:string];
        });
        
        it(@"should be of Class LCHStringsAlphabet", ^{
            [[alphabet should] beKindOfClass:[LCHStringsAlphabet class]];
        });
    });
    
    context(@"when initialized with +alphabetWithStrings: with symbols ('ABCDEF') and enumerated", ^{
        NSString *string = @("ABCDEF");
        NSRange range = NSMakeRange('A', 'F' + 1);
        
        beforeAll(^{
            alphabet = [LCHAlphabet alphabetWithSymbols:string];
        });
        
        it(@"should be of Class LCHStringsAlphabet", ^{
            [[alphabet should] beKindOfClass:[LCHStringsAlphabet class]];
        });
        
        it(@"should not raise during enumeration", ^{
            [[theBlock(^{
                for (NSString *symbol in alphabet) {
                    [symbol description];
                }
            }) shouldNot] raise];
        });
        
        it(@"should return count of symbols equal to 6", ^{
            NSUInteger count = 0;
            
            for (NSString *symbol in alphabet) {
                [symbol description];
                
                count++;
            }
            
            [[theValue(count) should] equal:@(string.length)];
        });
        
        it(@"should return 'ABCDEF' symbols", ^{
            unichar character = range.location;
            
            for (NSString *symbol in alphabet) {
                [[symbol should] equal:[NSString stringWithFormat:@"%c", character]];
                
                character++;
            }
        });
    });
});

SPEC_END
