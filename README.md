How To Use
==========

Copy the all the files into your source directory.
Then import GDGeoCLlocationCategory.h into the source
file, you need mrgs conversions for.

In that file a CLLocation will now have an mgrs and utm
method to do the conversion for you.

    #import "GDGeoCLLocaitonCategory"
    
    ...
    
    - (void) someMethod:(CLLocation *)aLocation { //* (comment For vim formatting of Markdown)
       ...
       
         NSLog(@"MGRS cord: %@",[[aLocation mgrs] mgrsWithPrecision:GDGeoGoordMGRS100m]]);
      ...
    }
    
    

What is MGRS
============

[Wikipedia link](http://en.wikipedia.org/wiki/MGRS)



SEE ALSO
========

Since, it was a while since I worked on this; I had to redo a lot of the learning I did when I originally
wrote this piece of software. I have taken insperation for the conversion back from MGRS to UTM from 
http://www.stellman-greene.com/mgrs_to_utm/. This code is GPL and I would recommend using it over this 
library if it makes sense. However, if you still want to use my code go ahead. I will continue to work
on this library as I have the time.


TODO
====


  * The library does not handle polar coordinates, at current. Anything above the 84 degrees N. or below 80 degrees S. 
I need to Add that. This requires converting to Polar (UPS) then to MGRS, where as now we first convert to utm then to mgrs.
  * Need to convert the other way around, and go back to Lat, Long from MGRS.
  * Need to be able to get the center coorindate, and each vertix of the box.
  * Alias the description on the mgrs object to the mgrs methods, on the mgrs object.


BSD License
===========

Copyright © belongs to the Gautam Dey

All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following 
conditions are met:

  * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
  * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
  * Neither the name of the owner nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

**THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, 
BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT 
SHALL THE COPYRIGHT HOLDER BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING 
IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.**
 
