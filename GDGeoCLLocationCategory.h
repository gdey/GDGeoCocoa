//
//  GDGeoCLLocationCategory.h
//  test_for_long_lat_2_mgrs
//
//  Created by Gautam Dey on 6/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "GDGeoCoordUTM.h"
#import "GDGeoCoordMGRS.h"

@interface CLLocation (GDGeoCLLocationCategory)


- (GDGeoCoordMGRS *) mgrs;
- (GDGeoCoordUTM *)  utm;


@end
