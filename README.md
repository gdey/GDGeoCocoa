How To Use
==========

Copy the all the files into your source directory.
Then import GDGeoCLlocationCategory.h into the source
file, you need mrgs conversions for.

In that file a CLLocation will now have an mgrs and utm
method to do the conversion for you.

    #import "GDGeoCLLocaitonCategory"
    
    ...
    
    - (void) someMethod:(CLLocaiton *)aLocation {
       ...
       
         NSLog(@"MGRS cord: %@",[[aLocation mgrs] mgrsWithPrecision:GDGeoGoordMGRS100m]]);
      ...
    }
    
What is MGRS
============

TODO
====


  * The library does not handle polar coordinates, at current. Anything above the 48 degrees Lat. or below -48 degrees Lat. 
I need to Add that. This requires converting to Polar then to MGRS, where as now we first convert to utm then to mgrs.
  * Need to convert the other way around, and go back to Lat, Long from MGRS.
  * Need to be able to get the center coorindate, and each vertix of the box.
  * 