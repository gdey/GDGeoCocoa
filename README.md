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


  * The library does not handle polar coordinates, at current. Anything above the 84 degrees N. or below 80 degrees S. 
I need to Add that. This requires converting to Polar (UPS) then to MGRS, where as now we first convert to utm then to mgrs.
  * Need to convert the other way around, and go back to Lat, Long from MGRS.
  * Need to be able to get the center coorindate, and each vertix of the box.
  * Alias the description on the mgrs object to the mgrs methods, on the mgrs object.
 