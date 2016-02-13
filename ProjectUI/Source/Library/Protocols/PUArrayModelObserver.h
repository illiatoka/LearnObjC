#import <Foundation/Foundation.h>

@protocol PUArrayModelObserver <NSObject>

@optional
- (void)arrayModelDidChange:(id)model;
- (void)arrayModelDidChange:(id)model withObject:(id)object;

@end
