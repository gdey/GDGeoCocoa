//
//  GDGeoCoordConv.h
//  test_for_long_lat_2_mgrs
//
//  Created by Gautam Dey on 6/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


// Helpers

#define DEGREE2RAD(degree) degree * M_PI / 180;

// Here are definiations for the keys.

typedef enum {
    GDGeoCoordConvTypeAiry = 0,
    GDGeoCoordConvTypeAustralianNation              ,
    GDGeoCoordConvTypeBessel1941                    ,
    GDGeoCoordConvTypeBessel1941Nambia              ,
    GDGeoCoordConvTypeClarke1866                    ,
    GDGeoCoordConvTypeClarke1880                    ,
    GDGeoCoordConvTypeEverest1830India              ,
    GDGeoCoordConvTypeFischer1960Mercury            ,
    GDGeoCoordConvTypeFischer1968                   ,
    GDGeoCoordConvTypeGRS1967                       ,
    GDGeoCoordConvTypeGRS1980                       ,
    GDGeoCoordConvTypeHelmert1906                   ,
    GDGeoCoordConvTypeHough                         ,
    GDGeoCoordConvTypeInternational                 ,
    GDGeoCoordConvTypeKrassovsky                    ,
    GDGeoCoordConvTypeModifiedAiry                  ,
    GDGeoCoordConvTypeModifiedEverest               ,
    GDGeoCoordConvTypeModifiedFischer1960           ,
    GDGeoCoordConvTypeSouthAmerican1969             ,
    GDGeoCoordConvTypeWGS60                         ,
    GDGeoCoordConvTypeWGS66                         ,
    GDGeoCoordConvTypeWGS72                         ,
    GDGeoCoordConvTypeWGS84                         ,
    GDGeoCoordConvTypeEverest1830Malaysia           ,
    GDGeoCoordConvTypeEverest1956India              ,
    GDGeoCoordConvTypeEverest1964MalaysiaAndSingapor,
    GDGeoCoordConvTypeEverest1969Malaysia           ,
    GDGeoCoordConvTypeEverestPakistan               ,
    GDGeoCoordConvTypeIndonesian1974                
} kGDGeoCoordEllipsoidType;


@interface GDGeoCoordConv : NSObject

+ (int) zoneNumberFromLatitude:(double)latitude andLongitude:(double)longitude;
+ (NSString *) ellipsoidNameForEllips:(kGDGeoCoordEllipsoidType)ellips;
+ (double) ellipsoidRadisForEllips:(kGDGeoCoordEllipsoidType)ellips;
+ (double) ellipsoidEccentricityForEllips:(kGDGeoCoordEllipsoidType)ellips;

@end
