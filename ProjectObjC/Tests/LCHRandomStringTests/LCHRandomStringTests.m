#import "LCHRandomStringTests.h"
#import "NSString+LCHStringExtensions.h"

@implementation LCHRandomStringTests

#pragma mark -
#pragma mark Public Implementations

- (void)perform {
    uint32_t length = 4;
    NSString *sourceString = @"Hello world";
    NSString *randomString = [NSString randomStringWithLength:length source:sourceString];
    
    NSLog(@"Generated random string is: %@", randomString);
}

@end
