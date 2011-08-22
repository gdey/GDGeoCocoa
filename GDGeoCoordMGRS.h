//
//  GDGeoCoordMGRS.h
//  test_for_long_lat_2_mgrs
//
//  Created by Gautam Dey on 6/21/11.
//  Copyright 2011 AppZorz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#import "GDGeoCoordUTM.h"

typedef enum {
    GDGeoCoordMGRS1m = 0,
    GDGeoCoordMGRS10m,
    GDGeoCoordMGRS100m,
    GDGeoCoordMGRS1000m,
    GDGeoCoordMGRS10000m,
    GDGeoCoordMGRS100000m,
    GDGeoCoordMGRS1000000m
} kGDGeoCoordMGRSPrecision;


@interface GDGeoCoordMGRS : NSObject {
    
    NSString *_zone;
    NSString *_letterEast;
    NSString *_letterNorth;
    NSString *_mgrsEast;
    NSString *_mgrsNorth;
    kGDGeoCoordMGRSPrecision _precision;

}

@property (retain, nonatomic) NSString* zone;
@property (retain, nonatomic) NSString* letterEast;
@property (retain, nonatomic) NSString* letterNorth;
@property (retain, nonatomic) NSString* mgrsEast;
@property (retain, nonatomic) NSString* mgrsNorth;
@property (assign, nonatomic) kGDGeoCoordMGRSPrecision precision;



- (id)initWithUTM:(GDGeoCoordUTM *)utm;
//- (id)initWithUPS:(GDGeoCoordUPS *)ups;

- (id)initFromCoord:(CLLocationCoordinate2D) coord;
- (id)initWithLatitude:(CLLocationDegrees)latitude andLongitude:(CLLocationDegrees)longitude;
- (id)initWithEllips:(kGDGeoCoordEllipsoidType)ellips 
            latitude:(CLLocationDegrees)latitude 
        andLongitude:(CLLocationDegrees)longitude;

- (id)initWithZone:(NSString *)zone 
          mgrsEast:(NSString *)mgrsEast 
         mgrsNorth:(NSString *)mgrsNorth 
        letterEast:(NSString *)letterEast 
       letterNorth:(NSString *)letterNorth;

- (NSString *)mgrs;
- (void)setMgrs:(NSString *)mgrs;
- (NSString *)mgrsWithPrecision:(kGDGeoCoordMGRSPrecision)precision;

@end
