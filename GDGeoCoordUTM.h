//
//  GDGeoCoordUTM.h
//  test_for_long_lat_2_mgrs
//
//  Created by Gautam Dey on 6/19/11.
//  Copyright 2011 AppZorz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#import "GDGeoCoordConv.h"




@interface GDGeoCoordUTM : NSObject {
    NSString *_zone;
    double   _easting;
    double   _northing;
}

@property (strong,nonatomic) NSString *zone;
@property (assign,nonatomic) CLLocationDegrees easting;
@property (assign,nonatomic) CLLocationDegrees northing;

- (id)initFromEllips:(kGDGeoCoordEllipsoidType)ellips Zone:(int)zone Latitude:(double)latitude andLongitude:(double)longitude;
- (id)initFromEllips:(kGDGeoCoordEllipsoidType)ellips Latitude:(CLLocationDegrees)latitude andLongitude:(CLLocationDegrees)longitude;
- (id)initFromLatitude:(CLLocationDegrees)latitude andLongitude:(CLLocationDegrees)longitude;
- (id)initFromCoords:(CLLocationCoordinate2D)coords;


- (NSString *) zoneLetter;
- (NSInteger)  zoneNumber;

@end
