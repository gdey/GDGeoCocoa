//
//  GDGeoCoordMGRS.m
//  test_for_long_lat_2_mgrs
//
//  Created by Gautam Dey on 6/21/11.
//  Copyright 2011 AppZorz. All rights reserved.
//

#import "GDGeoCoordMGRS.h"
#import "GDGeoCoordUTM.h"

@implementation GDGeoCoordMGRS

@synthesize      zone = _zone,
            mgrsEast  = _mgrsEast, 
            mgrsNorth = _mgrsNorth, 
           letterEast = _letterEast, 
          letterNorth = _letterNorth,
            precision = _precision;


- (id)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    [self setZone:nil];
    [self setMgrsNorth:nil];
    [self setMgrsEast:nil];
    [self setLetterEast:nil];
    [self setLetterNorth:nil];
    [self setPrecision:GDGeoCoordMGRS1000000m];
    return self;    
}


- (id)initWithZone:(NSString *)zone 
          mgrsEast:(NSString *)mgrsEast 
         mgrsNorth:(NSString *)mgrsNorth 
        letterEast:(NSString *)letterEast 
       letterNorth:(NSString *)letterNorth
{
    self = [super init];
    
    if(!self) {
        return nil;
    }
    
    [self setZone:zone];
    [self setMgrsNorth:mgrsNorth];
    [self setMgrsEast:mgrsEast];
    [self setLetterNorth:letterNorth];
    [self setLetterEast:letterEast];
    
    return self;
}

- (id)initFromCoord:(CLLocationCoordinate2D) coord
{
    return [self initWithLatitude:coord.latitude andLongitude:coord.longitude];
}

- (id)initWithLatitude:(CLLocationDegrees)latitude andLongitude:(CLLocationDegrees)longitude
{
    return [self initWithEllips:GDGeoCoordConvTypeWGS84 latitude:latitude andLongitude:longitude];
}

- (id)initWithEllips:(kGDGeoCoordEllipsoidType)ellips 
            latitude:(CLLocationDegrees)latitude 
        andLongitude:(CLLocationDegrees)longitude
{
    self = [super init];
    if (!self) {
        return nil;
    }
    if (latitude < -80.0 || latitude > 84.0) {
        self = nil;
        return self;
    }
    
    GDGeoCoordUTM *utm = [[GDGeoCoordUTM alloc] initFromEllips:ellips Latitude:latitude andLongitude:longitude];
    if (!utm) {
        self = nil;
        return self;
    }
    
    return [self initWithUTM:utm];
}
/*
- (id)initWithUPS:(GDGeoCoordUPS *)ups
{
    return nil; 
}
*/
- (id)initWithUTM:(GDGeoCoordUTM *)utm 
{
    self = [super init];
    if (!self) {        
        return nil;
    }
    
    [self setPrecision:GDGeoCoordMGRS1m];
    double northing = [utm northing];
    NSString *north_string = [NSString stringWithFormat:@"%.0f",northing];
    long north_split = [north_string length] - 5;
    if (north_split < 0) {
        north_split = 0;
    }    
    
    double rnd_north = northing;
    while (rnd_north >= 2000000) {
        rnd_north -= 2000000;
    }
    if (rnd_north < 0) {
        rnd_north += 2000000;
    }
    NSInteger num_north = (NSInteger)(rnd_north/100000);
    
    NSInteger zoneNumber = [utm zoneNumber];
    if (zoneNumber % 2 == 0)  
        num_north += 5; // the zoneNumber is Odd we need to add 5 to to the north number?
    while ( num_north >= 20 ){
        num_north -= 20;
    }
    
    NSString *letter_north = [@"ABCDEFGHJKLMNPQRSTUV" substringWithRange:NSMakeRange(num_north, 1)];
    NSString *mgrs_north = [NSString stringWithFormat:@"%0.5i",
                            (north_split == 0) ? 0 :
                            [[north_string substringFromIndex:north_split] intValue]
                            ];
  
    /*************************************************************************************
     ** Work on the East 
     *
     */
    double easting = [utm easting];
    NSString *east_string = [NSString stringWithFormat:@"%.0f",easting];
    
    long east_split = [east_string length] - 5;
    if( east_split < 0 )  
        east_split = 0;
    
    
    NSInteger num_east = [[east_string substringToIndex:east_split] integerValue]; // This will be zero if not a valid number.
    
    NSString *mgrs_east = [NSString stringWithFormat:@"%0.5i",
                           (east_split == 0) ? 0 :
                           [[east_string substringFromIndex:east_split] intValue]];
    
    NSInteger mgrs_zone = zoneNumber;
    while (mgrs_zone >= 4) {
        mgrs_zone -= 3;
    }
    if( mgrs_zone <= 0)
        mgrs_zone = 1;
    
    NSString *easting_zone;
    switch (mgrs_zone) {
        case 1:
            easting_zone = @"ABCDEFGH";
            break;
        case 2:
            easting_zone = @"JKLMNPQR";
            break;
        case 3:
            easting_zone = @"STUVWXYZ";
    }
    
    num_east--;
    NSString *letter_east = [easting_zone substringWithRange:NSMakeRange(num_east, 1)];
    
    [self setZone:[utm zone]];
    [self setLetterEast:letter_east];
    [self setLetterNorth:letter_north];
    [self setMgrsEast:mgrs_east];
    [self setMgrsNorth:mgrs_north];
    
    return self;
}


- (NSString *)mgrsWithPrecision:(kGDGeoCoordMGRSPrecision)precision
{
    
    
#define TRUNCATE_BY(string, num) [string substringToIndex:[string length] - num]
    
    switch (precision) {
        case GDGeoCoordMGRS1m:
            return [NSString stringWithFormat:@"%@%@%@%@%@", 
                    [self zone], 
                    [self letterEast],
                    [self letterNorth],
                    [self mgrsEast],
                    [self mgrsNorth]];
            break;
        case GDGeoCoordMGRS10m:
            return [NSString stringWithFormat:@"%@%@%@%@%@",
                    [self zone],
                    [self letterEast],
                    [self letterNorth],
                    TRUNCATE_BY([self mgrsEast], 1),
                    TRUNCATE_BY([self mgrsNorth], 1)];
            break;
        case GDGeoCoordMGRS100m:
            return [NSString stringWithFormat:@"%@%@%@%@%@",
                    [self zone],
                    [self letterEast],
                    [self letterNorth],
                    TRUNCATE_BY([self mgrsEast], 2),
                    TRUNCATE_BY([self mgrsNorth], 2)];
            break;
        case GDGeoCoordMGRS1000m:
            return [NSString stringWithFormat:@"%@%@%@%@%@",
                    [self zone],
                    [self letterEast],
                    [self letterNorth],
                    TRUNCATE_BY([self mgrsEast], 3),
                    TRUNCATE_BY([self mgrsNorth], 3)];
            break;
        case GDGeoCoordMGRS10000m:
            return [NSString stringWithFormat:@"%@%@%@%@%@",
                    [self zone],
                    [self letterEast],
                    [self letterNorth],
                    TRUNCATE_BY([self mgrsEast], 4),
                    TRUNCATE_BY([self mgrsNorth], 4)];
            break;
        case GDGeoCoordMGRS100000m:
            return [NSString stringWithFormat:@"%@%@%@",
                    [self zone],
                    [self letterEast],
                    [self letterNorth]];
            break;
        case GDGeoCoordMGRS1000000m:
            return [NSString stringWithFormat:@"%@",[self zone]];
            break;
        default:
            return nil;
            break;
    }

#undef TRUNCATE_BY
                      
}

- (NSString *)mgrs
{
    return [self mgrsWithPrecision:[self precision]];
}

- (NSString *)description
{
    return [self mgrs];
}

- (void)setMgrs:(NSString *)aMgrs
{
    
    NSString *mgrs = [aMgrs uppercaseString];
    NSScanner *scanner = [[NSScanner alloc] initWithString:mgrs];

    NSInteger gzdn  = 0;
    NSAssert([scanner scanInteger:&gzdn], @"Was passed a string that does not look like an mgrs string");

    NSInteger location =  [scanner scanLocation] + 1;
    scanner = nil;
    NSString *gzd = [mgrs substringToIndex:location];
    NSString *east_letter = [mgrs substringWithRange:NSMakeRange(location, 1)];
    NSString *north_letter = [mgrs substringWithRange:NSMakeRange(location + 1, 1)];
    NSString *mgrsne = [mgrs substringFromIndex:location + 2];
    NSString *mgrs_east = [mgrsne substringToIndex:[mgrsne length]/2];
    NSString *mgrs_north = [mgrsne substringFromIndex:[mgrsne length]/2];
    
    // TODO: Need to pad the values up for things that are smaller then the 1 meter precision
    [self setZone:gzd];
    [self setMgrsEast:mgrs_east];
    [self setMgrsNorth:mgrs_north];
    [self setLetterEast:east_letter];
    [self setLetterNorth:north_letter];
    
}

@end
