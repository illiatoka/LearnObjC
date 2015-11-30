#import "LCHRandomStringTests.h"
#import "NSString+LCHExtensions.h"

@implementation LCHRandomStringTests

#pragma mark -
#pragma mark Public Implementations

- (void)perform {
    NSLog(@"Generated random string is: %@", [NSString randomString]);
    NSLog(@"Generated random string with length is: %@", [NSString randomStringWithLength:9]);
    NSLog(@"Generated random string with length from alphanumeric alphabet is: %@",
          [NSString randomStringWithLength:9
                                  alphabet:[NSString alphanumericAlphabet]]);
    NSLog(@"Generated random string with length from lowercase alphabet is: %@",
          [NSString randomStringWithLength:5
                                  alphabet:[NSString lowercaseLetterAlphabet]]);
    NSLog(@"Generated random string with length from capitalized alphabet is: %@",
          [NSString randomStringWithLength:9
                                  alphabet:[NSString capitalizedLetterAlphabet]]);
    NSLog(@"Generated random string with length from numeric alphabet is: %@",
          [NSString randomStringWithLength:9
                                  alphabet:[NSString numericAlphabet]]);
}

@end
