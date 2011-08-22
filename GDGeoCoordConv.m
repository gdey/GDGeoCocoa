//
//  GDGeoCoordConv.m
//  test_for_long_lat_2_mgrs
//
//  Created by Gautam Dey on 6/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


#import "GDGeoCoordConv.h"
#import <math.h>

#define DEGREE2RAD(degree) degree * M_PI / 180;
#define RAD2DEGREE(radian) radian * 180 / M_PI;

#define kGDGeoCoordConvEllipsoidNameKey         0;
#define kGDGeoCoordConvEllipsoidRadiusKey       1;
#define kGDGeoCoordConvEllipsoidEccentricityKey 2;

struct ellipsoidStructure {
    /*__unsafe_unretained*/ NSString* name;
    double radis;
    double eccentricity;
};

const struct ellipsoidStructure ellipsoidStructureTable[] = {
    { @"Airy"                                , 6377563 , 0.00667054  }, // 0
    { @"Australian National"                 , 6378160 , 0.006694542 }, // 1
    { @"Bessel 1841"                         , 6377397 , 0.006674372 }, // 2
    { @"Bessel 1841 Nambia"                  , 6377484 , 0.006674372 }, // 3
    { @"Clarke 1866"                         , 6378206 , 0.006768658 }, // 4
    { @"Clarke 1880"                         , 6378249 , 0.006803511 }, // 5 
    { @"Everest 1830 India"                  , 6377276 , 0.006637847 }, // 6
    { @"Fischer 1960 Mercury"                , 6378166 , 0.006693422 }, // 7
    { @"Fischer 1968"                        , 6378150 , 0.006693422 }, // 8
    { @"GRS 1967"                            , 6378160 , 0.006694605 }, // 9
    { @"GRS 1980"                            , 6378137 , 0.00669438  }, // 10
    { @"Helmert 1906"                        , 6378200 , 0.006693422 }, // 11
    { @"Hough"                               , 6378270 , 0.00672267  }, // 12
    { @"International"                       , 6378388 , 0.00672267  }, // 13
    { @"Krassovsky"                          , 6378245 , 0.006693422 }, // 14
    { @"Modified Airy"                       , 6377340 , 0.00667054  }, // 15
    { @"Modified Everest"                    , 6377304 , 0.006637847 }, // 16
    { @"Modified Fischer 1960"               , 6378155 , 0.006693422 }, // 17
    { @"South American 1969"                 , 6378160 , 0.006694542 }, // 18
    { @"WGS 60"                              , 6378165 , 0.006693422 }, // 19
    { @"WGS 66"                              , 6378145 , 0.006694542 }, // 20
    { @"WGS-72"                              , 6378135 , 0.006694318 }, // 21
    { @"WGS-84"                              , 6378137 , 0.00669438  }, // 22
    { @"Everest 1830 Malaysia"               , 6377299 , 0.006637847 }, // 23
    { @"Everest 1956 India"                  , 6377301 , 0.006637847 }, // 24
    { @"Everest 1964 Malaysia and Singapore" , 6377304 , 0.006637847 }, // 25
    { @"Everest 1969 Malaysia"               , 6377296 , 0.006637847 }, // 26
    { @"Everest Pakistan"                    , 6377296 , 0.006637534 }, // 27
    { @"Indonesian 1974"                     , 6378160 , 0.006694609 }  // 28
};

@implementation GDGeoCoordConv


+ (int) zoneNumberFromLatitude:(double)latitude andLongitude:(double)longitude
{
    
    if( (latitude >  84.0 && latitude <  90.0) ||  // North pole
        (latitude > -80.0 && latitude < -90.0) ) { // South pole
        // This indicates we should UPS.
        return 0;
    }
    // Adjust for projections.
    if ( latitude >= 56 && latitude < 64.0 &&
         longitude >= 3.0 && longitude < 12.0 ) { 
        return 32;                                
    }
    
    if( latitude >= 72.0  && latitude < 84.0 ) {
        if ( longitude >= 0.0  && longitude < 9.0  ) 
            return 31;
        if ( longitude >= 9.0  && longitude < 21.0 )
            return 33;
        if ( longitude >= 21.0 && longitude < 33.0 )
            return 35;
        if ( longitude >= 33.0 && longitude < 42.0 )
            return 37;
    }
    
    // Recast from [-180,180) to [0,360).
    // The w<->w is then divided into 60 zones from 1-60.
    return (int)( (longitude + 180)/6 ) + 1;
}

+ (NSString *) ellipsoidNameForEllips:(kGDGeoCoordEllipsoidType)ellips
{
    return ellipsoidStructureTable[ellips].name;
}

+ (double) ellipsoidRadisForEllips:(kGDGeoCoordEllipsoidType)ellips
{
    return ellipsoidStructureTable[ellips].radis;
}

+ (double) ellipsoidEccentricityForEllips:(kGDGeoCoordEllipsoidType)ellips
{
    return ellipsoidStructureTable[ellips].eccentricity;
}





@end
