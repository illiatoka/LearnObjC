#import "PUObservableObject.h"

typedef NS_ENUM(NSUInteger, PUModelState) {
    PUModelStateDefault,
    PUModelStateDidSave,
    PUModelStateDidLoad,
    PUModelStateSaving,
    PUModelStateLoading,
    PUModelStateError
};

@interface PUModel : PUObservableObject
@property (nonatomic, readonly, getter=isCached)    BOOL        cached;
@property (nonatomic, readonly)                     NSString    *filePath;

- (void)save;
- (void)load;

@end
