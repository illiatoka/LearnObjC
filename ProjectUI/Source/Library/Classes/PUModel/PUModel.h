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
@property (nonatomic, readonly) NSString    *filePath;

- (void)load;

@end
