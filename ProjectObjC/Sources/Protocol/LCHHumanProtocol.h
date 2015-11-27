#import <Foundation/Foundation.h>

@protocol LCHHumanProtocol <NSObject>

@property (nonatomic, copy)     NSString    *name;
@property (nonatomic, readonly) NSSet       *children;
@property (nonatomic, assign)   uint8_t     age;
@property (nonatomic, assign)   uint8_t     weight;

- (void)performGenderSpecificOperation;

@optional

- (void)sayHello;

@end
