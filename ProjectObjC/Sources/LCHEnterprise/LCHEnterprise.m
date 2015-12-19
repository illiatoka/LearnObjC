#import "LCHEnterprise.h"
#import "LCHRoom.h"
#import "LCHWashBox.h"
#import "LCHEmployee.h"
#import "LCHManager.h"
#import "LCHAccountant.h"
#import "LCHWasherman.h"
#import "LCHCar.h"
#import "LCHContainerWithCapacity.h"
#import "LCHConstants.h"

@interface LCHEnterprise ()
@property (nonatomic, readwrite, retain) NSMutableSet *mutableRooms;
@property (nonatomic, readwrite, retain) NSMutableSet *mutableEmployees;

- (id)roomWithEmployee:(id)employee;

- (id)freeEmployeeOfClass:(Class)class;

- (LCHRoom *)emptyRoomForEmployeeOfClass:(Class)class;
- (LCHWashBox *)emptyRoomForCar;

- (NSSet *)roomsForEmployeeOfClass:(Class)class;

@end

@implementation LCHEnterprise
@dynamic employees;

#pragma mark -
#pragma Class Methods
+ (instancetype)enterprise {
    return [[self alloc ] initWithOffice:[LCHRoom room] washBox:[LCHWashBox room]];
}

+ (instancetype)enterpriseWithOffice:(LCHRoom *)office washBox:(LCHWashBox *)washBox {
    return [[self alloc ] initWithOffice:office washBox:washBox];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.mutableRooms = nil;
    self.mutableEmployees = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.mutableRooms = [NSMutableSet set];
        self.mutableEmployees = [NSMutableSet set];
    }
    
    return self;
}

- (instancetype)initWithOffice:(LCHRoom *)office washBox:(LCHWashBox *)washBox {
    self = [self init];
    
    if (self) {
        [self.mutableRooms addObject:office];
        [self.mutableRooms addObject:washBox];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSSet *)rooms {
    return [[self.mutableRooms copy] autorelease];
}

- (NSSet *)employees {
    return [[self.mutableEmployees copy] autorelease];
}

#pragma mark -
#pragma mark Public Implementations

- (void)addRoom:(LCHRoom *)room {
    [self.mutableRooms addObject:room];
}

- (void)hireAnEmployee:(LCHEmployee *)employee {
    id room = [self emptyRoomForEmployeeOfClass:[employee class]];
    
    if (room) {
        [room addEmployee:employee];
        
        [self.mutableEmployees addObject:employee];
    }
}

- (void)fireAnEmployee:(LCHEmployee *)employee {
    [[self roomWithEmployee:employee] removeEmployee:employee];
    
    [self.mutableEmployees removeObject:employee];
}

- (void)performWorkWithCar:(LCHCar *)car {
    LCHWashBox *washBox = [self emptyRoomForCar];
    LCHWasherman *washerman = [self freeEmployeeOfClass:[LCHWasherman class]];
    LCHAccountant *accountant = [self freeEmployeeOfClass:[LCHAccountant class]];
    LCHManager *manager = [self freeEmployeeOfClass:[LCHManager class]];
    
    if ([car canGiveMoney:kLCHDefaultPrice]) {
        if (washBox && washerman) {
            [washerman addObserver:accountant];
            [accountant addObserver:manager];
            
            [washBox addCar:car];
            
            [washerman performWorkWithObject:car];
            
            [washBox removeCar:car];
            
            [washerman removeObserver:accountant];
            [accountant removeObserver:manager];
        }
    }
}

#pragma mark -
#pragma mark Private Implementations

- (id)roomWithEmployee:(id)employee {
    for (LCHRoom *room in [self roomsForEmployeeOfClass:[employee class]]) {
        for (id item in [[room employees] items]) {
            if (item == employee) {

                return room;
            }
        }
    }
    
    return nil;
}

- (id)freeEmployeeOfClass:(Class)class {
    for (id employee in self.employees) {
        if ([employee isMemberOfClass:class] && kLCHEmployeeIsFree == [employee state]) {
            return employee;
        }
    }
    
    return nil;
}

- (LCHRoom *)emptyRoomForEmployeeOfClass:(Class)class {
    for (id room in [self roomsForEmployeeOfClass:class]) {
        if (![room isFullOfEmployees]) {
            
            return room;
        }
    }
    
    return nil;
}

- (LCHWashBox *)emptyRoomForCar {
    for (id room in self.mutableRooms) {
        if ([room respondsToSelector:@selector(addCar:)] && ![room isFullOfCars]) {
            
            return room;
        }
    }
    
    return nil;
}

- (NSSet *)roomsForEmployeeOfClass:(Class)class {
    Class roomClass = [LCHWasherman class] == class ? [LCHWashBox class] : [LCHRoom class];
    NSMutableSet *rooms = [NSMutableSet set];
    
    for (id room in self.mutableRooms) {
        if ([room isMemberOfClass:roomClass]) {
            [rooms addObject:room];
        }
    }
    
    return rooms;
}

@end
