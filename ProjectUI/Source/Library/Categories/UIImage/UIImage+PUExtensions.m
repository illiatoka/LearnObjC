#import "UIImage+PUExtensions.h"

static NSString * const kPUCheckImageName = @"check";
static NSString * const kPUUncheckImageName = @"uncheck";

@implementation UIImage (PUExtensions)

#pragma mark -
#pragma mark Class Methods

+ (instancetype)checkedImage {
    return [self imageForCheckedStatus:YES];
}

+ (instancetype)uncheckedImage {
    return [self imageForCheckedStatus:NO];
}

+ (UIImage *)imageForCheckedStatus:(BOOL)checked {
    static UIImage *__checkImage = nil;
    static UIImage *__uncheckImage = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __checkImage = [UIImage imageNamed:kPUCheckImageName];
        __uncheckImage = [UIImage imageNamed:kPUUncheckImageName];
    });
    
    return checked ? __checkImage : __uncheckImage;
}

@end
