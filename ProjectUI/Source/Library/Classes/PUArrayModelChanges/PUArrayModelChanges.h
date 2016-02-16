#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, PUArrayModelAction) {
    PUArrayModelActionInsert,
    PUArrayModelActionRemove,
    PUArrayModelActionReplace,
    PUArrayModelActionExchange,
    PUArrayModelActionMove
};

@interface PUArrayModelChanges : NSObject
@property (nonatomic, readonly) PUArrayModelAction  action;
@property (nonatomic, readonly) NSUInteger          idx1;
@property (nonatomic, readonly) NSUInteger          idx2;

+ (instancetype)modelOfChangesWithAction:(PUArrayModelAction)action idx1:(NSUInteger)idx1 idx2:(NSUInteger)idx2;

- (instancetype)initWithAction:(PUArrayModelAction)action idx1:(NSUInteger)idx1 idx2:(NSUInteger)idx2;

@end
