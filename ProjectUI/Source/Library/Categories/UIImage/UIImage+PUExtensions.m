#import "UIImage+PUExtensions.h"

static NSString * const kPUCheckImageName = @"check";
static NSString * const kPUUncheckImageName = @"uncheck";

@implementation UIImage (PUExtensions)

#pragma mark -
#pragma mark Class Methods

+ (instancetype)checkedImage {
    static UIImage *__checkImage = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __checkImage = [UIImage imageNamed:kPUCheckImageName];
    });
    
    return __checkImage;
}

+ (instancetype)uncheckedImage {
    static UIImage *__uncheckImage = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __uncheckImage = [UIImage imageNamed:kPUUncheckImageName];
    });
    
    return __uncheckImage;
}

@end
