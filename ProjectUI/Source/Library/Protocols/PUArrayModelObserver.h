#import <Foundation/Foundation.h>

@protocol PUArrayModelObserver <NSObject>

@optional
- (void)arrayModelDidChange:(id)model;

@end
