//
//  GDGeoCLLocationCategory.m
//  test_for_long_lat_2_mgrs
//
//  Created by Gautam Dey on 6/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GDGeoCLLocationCategory.h"

@implementation CLLocation (GDGeoCLLocationCategory)


- (GDGeoCoordMGRS *) mgrs 
{
    GDGeoCoordMGRS *m = [[GDGeoCoordMGRS alloc] initFromCoord:[self coordinate]];
    if (!m) {
        NSLog(@"Was not able to create mgrs for %@",self);
    } else {
        NSLog(@"Created %@ for %@",m,self);
    }
    [m autorelease];
    return m;
}

- (GDGeoCoordUTM *) utm
{
    GDGeoCoordUTM *u = [[GDGeoCoordUTM alloc] initFromCoords:[self coordinate]];
    if (!u) {
        NSLog(@"Was not able to create utm for %@", self);
    } else {
        NSLog(@"Created %@ for %@",u,self);
    }
    [u autorelease];
    return u;
}
@end
