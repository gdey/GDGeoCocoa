//
//  GDGeoCoordUTM.m
//  test_for_long_lat_2_mgrs
//
//  Created by Gautam Dey on 6/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GDGeoCoordUTM.h"


@implementation GDGeoCoordUTM 

@synthesize zone = _zone, easting = _easting, northing = _northing;

// Some convience methods.

+ (double) scalerFactorWithEllips:(kGDGeoCoordEllipsoidType) ellips 
                     FromLatitude:(CLLocationDegrees)latitude 
                     andLongitude:(CLLocationDegrees)longitude
{

    double lat_rad = DEGREE2RAD(latitude);
    double lng_rad = DEGREE2RAD(longitude);
    // The general formula for the scale factor is:
    double k0 = 0.996;         // k0 = 0.9996  -- for UTM
                               // λ = longitude
    double l0 = 0;             // λ0 = center of the map. == 0 for us.
    double dl = lng_rad - l0;// ∆λ = λ - λ0
    double dl2 = dl * dl;
    double dl4 = dl2 * dl2;
    double dl6 = dl4 * dl2;
    double e = [GDGeoCoordConv ellipsoidEccentricityForEllips:ellips]; // e = ecentary
    double e2 = (e * e)/(1 - (e * e)); // é2 = (e * e)/(1 - (e * e))
    double e4 = e2 * e2;// é4 = é2 *é2
    double e6 = e4 * e2;
    double c = cos(lat_rad);// c = cosϕ
    double c2 = c * c;// c2 = c * c
    double c4 = c2 * c2;
    double c6 = c4 * c2;
    double t = tan(lat_rad);// t = tanϕ
    double t2 = t * t; // t2 = t * t
    double t4 = t2 * t2;
    double T26 = c2 / 2 * ( 1 + e2 * c2 ); // T26 = c2 / 2 ( 1 + é2 * c2 )
    double T27 = ( c4 / 24 ) * (     // T27 = ( (c2 * c2) / 24 ) * (
                    5 - ( 4 * t2 ) +   //         5 - (4 * t2)  + 
                    ( 24 * e2 * c2 ) + //         ( 24 * é2 * c2 ) + 
                    ( 13 * e4 * c4 ) - //         ( 13 * é4 * c2 *c2 ) -  
                    ( 28 * t2 * e2 * c2 ) + //         ( 28 * t2 * é2 * c2 ) + 
                    (  4 * e6 * c6 ) - //         ( 4 * é2 * é2 * é2 * c2 * c2 * c2 ) -
                    ( 48 * t2 * e4 * c4 ) - //         ( 48 * t2 * é2 * é2 * c2 * c2 ) -
                    ( 24 * t2 * e6 * c6 )//         ( 24 * t2 * é2 * é2 * é2 * c2 * c2 * c2 )
                                  );//       )
    double T28 = (c6 / 720) * ( 61 - (148 * t2) + (16 * t4));// T28 = cos^6ϕ / 720 ( 61 - 148 * tan^2ϕ + 16tan^4ϕ )
    // k0 ( 1 + (∆λ^2 * T26) + (∆λ^4*T27) + (∆λ^6 * T28) )
    
    return k0 * (1 + ( dl2 * T26 ) + ( dl4 * T27 ) + ( dl6 * T28 ));
}


- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here. Set it to longitude of 0 and latitude of 0.
        [self setZone:@"30N"];
        [self setEasting:0];
        [self setNorthing:0];
    }
    return self;
}

- (id)initFromCoords:(CLLocationCoordinate2D)coords
{
    return [self initFromLatitude:coords.latitude andLongitude:coords.longitude];
}

- (id)initFromLatitude:(CLLocationDegrees)latitude andLongitude:(CLLocationDegrees)longitude
{
    return [self initFromEllips:GDGeoCoordConvTypeWGS84 Latitude:latitude andLongitude:longitude];
}

- (id)initFromEllips:(kGDGeoCoordEllipsoidType)ellips Latitude:(double)latitude andLongitude:(double)longitude 
{
    int zone = [GDGeoCoordConv zoneNumberFromLatitude:latitude andLongitude:longitude];
    return [self initFromEllips:ellips Zone:zone Latitude:latitude andLongitude:longitude];
}

- (id)initFromEllips:(kGDGeoCoordEllipsoidType)ellips Zone:(int)zone Latitude:(double)latitude andLongitude:(double)longitude
{
    
    self = [super init];
    if (!self) {
        return nil;
    }
    
    if (latitude < -80.0 || latitude > 84.0) {
        self = nil;
        return self;
    }
    
    double radius = [GDGeoCoordConv ellipsoidRadisForEllips:ellips];
    double eccentricity = [GDGeoCoordConv ellipsoidEccentricityForEllips:ellips];
        
    double lat_radian = DEGREE2RAD(latitude);
    double lng_radian = DEGREE2RAD(longitude);
    
    double longorigin = (zone - 1)*6 - 180 + 3;
    double longoriginradian = DEGREE2RAD(longorigin);
    double eccentprime = eccentricity/(1 - eccentricity);
    
    double scale = 0.9996;
    
    double n = radius / sqrt(1 - eccentricity * sin(lat_radian) * sin(lat_radian));
    double t0 = (lat_radian == 0) ? 0 : tan(lat_radian);
    double t = t0 * t0;
    double c = eccentprime * cos(lat_radian) * cos(lat_radian);
    double a = cos(lat_radian) * (lng_radian - longoriginradian);
    double m = radius * 
    (
     ( 1 - eccentricity/4 - 3 * eccentricity * eccentricity/64
      - eccentricity * eccentricity * eccentricity/256
      ) * lat_radian
     - ( 3 * eccentricity/8 + 3 * eccentricity * eccentricity/32
        + 45 * eccentricity  * eccentricity * eccentricity/1024
        ) * sin(2 * lat_radian)
     + ( 15 * eccentricity * eccentricity/256 
        + 45 * eccentricity * eccentricity * eccentricity/1024
        ) * sin(4 * lat_radian)
     - ( 35 * eccentricity * eccentricity * eccentricity/3072
        ) * sin(6 * lat_radian)
    );
    
    double utm_easting = scale * n * ( a + (1-t+c) * a * a * a/6
                                      + (5-10*t+t*t+72*c-58*eccentprime)*a*a*a*a*a/120)
    + 500000.0;
    
    double utm_northing = scale * ( m + n * t0 * (a*a/2+(5-t+9*c+4*c*c)*a*a*a*a/24 + (61-58*t+t*t+600*c-330*eccentprime) * a * a * a * a * a * a/720));
    
    if (latitude < 0) {
        utm_northing += 10000000.0;
    }
    
    char utm_letter 
    = (  84 >= latitude && latitude >=  72 ) ? 'X'
    : (  72 >  latitude && latitude >=  64 ) ? 'W'
    : (  64 >  latitude && latitude >=  56 ) ? 'V'
    : (  56 >  latitude && latitude >=  48 ) ? 'U'
    : (  48 >  latitude && latitude >=  40 ) ? 'T'
    : (  40 >  latitude && latitude >=  32 ) ? 'S'
    : (  32 >  latitude && latitude >=  24 ) ? 'R'
    : (  24 >  latitude && latitude >=  16 ) ? 'Q'
    : (  16 >  latitude && latitude >=   8 ) ? 'P'
    : (   8 >  latitude && latitude >=   0 ) ? 'N'
    : (   0 >  latitude && latitude >=  -8 ) ? 'M'
    : (  -8 >  latitude && latitude >= -16 ) ? 'L'
    : ( -16 >  latitude && latitude >= -24 ) ? 'K'
    : ( -24 >  latitude && latitude >= -32 ) ? 'J'
    : ( -32 >  latitude && latitude >= -40 ) ? 'H'
    : ( -40 >  latitude && latitude >= -48 ) ? 'G'
    : ( -48 >  latitude && latitude >= -56 ) ? 'F'
    : ( -56 >  latitude && latitude >= -64 ) ? 'E'
    : ( -64 >  latitude && latitude >= -72 ) ? 'D'
    : ( -72 >  latitude && latitude >= -80 ) ? 'C'
    : 0;
    
    [self setZone:[NSString stringWithFormat:@"%d%c",zone,utm_letter]];
    [self setEasting:utm_easting];
    [self setNorthing:utm_northing];
    return self;
    
}

- (NSString *)zoneLetter
{
    NSString *zone = [self zone];
    return [zone substringFromIndex:[zone length] - 1];
}

- (NSInteger) zoneNumber
{
    NSString *zone = [self zone];
    return [[zone substringToIndex:[zone length] -1] integerValue];
}

@end
