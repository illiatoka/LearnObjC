#import <Foundation/Foundation.h>

@protocol PUModelObserver <NSObject>

@optional
- (void)modelDidLoad:(id)model;

@end
