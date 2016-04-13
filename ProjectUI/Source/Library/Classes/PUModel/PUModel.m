#import "PUModel.h"

#import "PUModelObserver.h"

static NSString * const kPUFolderName   = @"projectTemp";
static NSString * const kPUFileName     = @"shoplist.plist";

@interface PUModel ()
@property (nonatomic, strong)   NSString    *folderPath;

@end

@implementation PUModel

@dynamic filePath;

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    self = [super init];
    if (self) {
        self.state = PUModelStateDefault;
    }
    
    return self;
}

- (NSString *)filePath {
    return [self.folderPath stringByAppendingPathComponent:kPUFileName];
}

- (NSString *)folderPath {
    if (!_folderPath) {
        NSArray *libraryPaths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        NSString *libraryDirectory = [libraryPaths firstObject];
        NSString *projectDirectory = [libraryDirectory stringByAppendingPathComponent:kPUFolderName];
        
        self.folderPath = projectDirectory;
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSError *error = nil;
        BOOL isDirectory = NO;
        
        if (![fileManager fileExistsAtPath:projectDirectory isDirectory:&isDirectory]) {
            BOOL success = [fileManager createDirectoryAtPath:projectDirectory
                                  withIntermediateDirectories:NO
                                                   attributes:nil
                                                        error:&error];
            if (!success || error) {
                NSLog(@"Error: %@", [error localizedDescription]);
            }
            NSAssert(success, @"Failed to create folder at path:%@", projectDirectory);
        }
    }

    return _folderPath;
}

#pragma mark -
#pragma mark Public

- (void)save {

}

- (void)load {

}

#pragma mark -
#pragma mark PUObservableObject

- (SEL)selectorForState:(NSUInteger)state {
    switch (state) {
        case PUModelStateDidLoad:
            return @selector(modelDidLoad:);
        
        case PUModelStateLoading:
            return @selector(modelIsLoading:);
            
        default:
            return [super selectorForState:state];
    };
}

@end
