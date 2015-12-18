#import "LCHEnterprise.h"
#import "LCHBuilding.h"
#import "LCHCarWash.h"
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
@property (nonatomic, readwrite, retain) NSMutableSet *mutableBuildings;
@property (nonatomic, readwrite, retain) NSMutableSet *mutableEmployees;

- (id)roomWithEmployee:(id)employee;

- (LCHBuilding *)buildingForEmployeeOfClass:(Class)class;
- (LCHRoom *)emptyRoomForEmployeeOfClass:(Class)class;
- (LCHWashBox *)emptyRoomForCars;

- (NSSet *)roomsForEmployeeOfClass:(Class)class;

@end

@implementation LCHEnterprise
@dynamic buildings;
@dynamic employees;

#pragma mark -
#pragma Class Methods
+ (instancetype)enterprise {
    return [[self alloc ] initWithOffice:[LCHBuilding building] carWash:[LCHCarWash building]];
}

+ (instancetype)enterpriseWithOffice:(LCHBuilding *)office carWash:(LCHCarWash *)carWash {
    return [[self alloc ] initWithOffice:office carWash:carWash];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.mutableBuildings = nil;
    self.mutableEmployees = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.mutableBuildings = [NSMutableSet set];
        self.mutableEmployees = [NSMutableSet set];
    }
    
    return self;
}

- (instancetype)initWithOffice:(LCHBuilding *)office carWash:(LCHCarWash *)carWash {
    self = [self init];
    
    if (self) {
        [self.mutableBuildings addObject:office];
        [self.mutableBuildings addObject:carWash];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSSet *)buildings {
    return [[self.mutableBuildings copy] autorelease];
}

- (NSSet *)employees {
    return [[self.mutableEmployees copy] autorelease];
}

#pragma mark -
#pragma mark Public Implementations

- (void)addBuilding:(LCHBuilding *)building {
    [self.mutableBuildings addObject:building];
}

- (void)removeBuilding:(LCHBuilding *)building {
    for (id room in building.rooms) {
        [building removeRoom:room];
    }
    
    [self.mutableBuildings removeObject:building];
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
    LCHWashBox *washBox = [self emptyRoomForCars];
    LCHWasherman *washerman = nil;
    LCHAccountant *accountant = nil;
    LCHManager *manager = nil;
    
    for (id employee in self.employees) {
        if ([employee respondsToSelector:@selector(washCar:)]) {
            washerman = employee;
            
            break;
        }
    }
    
    for (id employee in self.employees) {
        if ([employee respondsToSelector:@selector(countMoney)]) {
            accountant = employee;
            
            break;
        }
    }
    
    for (id employee in self.employees) {
        if ([employee respondsToSelector:@selector(countProfit)]) {
            manager = employee;
            
            break;
        }
    }
    
    if ([car canGiveMoney:kLCHDefaultPrice]) {
        if (washBox && washerman) {
            [washBox addCar:car];
            
            [car giveMoney:kLCHDefaultPrice toReceiver:washerman];
            [washerman washCar:car];
            
            [washBox removeCar:car];
            [washerman giveAllMoneyToReceiver:accountant];
            
            [accountant countMoney];
            [accountant giveAllMoneyToReceiver:manager];
            
            [manager countProfit];
        }
    }
}

- (void)performWorkWithCars:(NSSet *)cars {
    for (LCHCar *car in cars) {
        [self performWorkWithCar:car];
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

- (LCHBuilding *)buildingForEmployeeOfClass:(Class)class {
    Class buildingClass = [LCHWasherman class] == class ? [LCHCarWash class] : [LCHBuilding class];
    
    for (id building in self.mutableBuildings) {
        if ([building isMemberOfClass:buildingClass]) {
            return building;
        }
    }
    
    return nil;
}

- (LCHRoom *)emptyRoomForEmployeeOfClass:(Class)class {
    for (id room in [self roomsForEmployeeOfClass:class]) {
        if (![room isFull]) {
            return room;
        }
    }
    
    return nil;
}

- (LCHWashBox *)emptyRoomForCars {
    for (id building in self.mutableBuildings) {
        for (id room in [building rooms]) {
            if ([room respondsToSelector:@selector(isAbleToContainCars)] && ![room isFullOfCars]) {
                return room;
            }
        }
    }
    
    return nil;
}

- (NSSet *)roomsForEmployeeOfClass:(Class)class {
    Class roomClass = [LCHWasherman class] == class ? [LCHWashBox class] : [LCHRoom class];
    NSMutableSet *rooms = [NSMutableSet set];
    
    for (id room in [[self buildingForEmployeeOfClass:class] rooms]) {
        if ([room isMemberOfClass:roomClass]) {
            [rooms addObject:room];
        }
    }
    
    return rooms;
}

@end
