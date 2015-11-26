#import <Foundation/Foundation.h>

@protocol LCHHumanProtocol <NSObject>

@required
@property (nonatomic, copy)     NSString    *name;
@property (nonatomic, readonly) NSSet       *children;
@property (nonatomic, assign)   uint8_t     age;
@property (nonatomic, assign)   uint8_t     weight;

- (void)performGenderSpecificOperation;

@optional
- (void)sayHello;
- (void)fight;
- (instancetype)reproduce;

@end
