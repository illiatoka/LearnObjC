#import <Foundation/Foundation.h>

@interface PURandomName : NSObject
@property (nonatomic, readonly) NSArray *names;

- (NSString *)randomName;

@end
