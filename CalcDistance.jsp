<script name="javascript">
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   var lat1 = 29.8339900;
   var lon1 = -95.4342410;
   var lat = 0;
   var lon = 0;

   var d = 50;
   var tc = 90;

   var latlon = new LatLon(lat1, lon)
   var newlatlon = latlon.destPoint(tc, d);
   alert("lat: " + newlatlon.lat + "\nlon: " + newlatlon.lon)
}


/*
 * calculate destination point given start point, initial bearing (deg) and distance (km)
 *   see http://williams.best.vwh.net/avform.htm#LL
 */
LatLon.prototype.destPoint = function(brng, d) {
  var R = 3956; // earth's mean radius in miles
  var lat1 = this.lat.toRad(), lon1 = this.lon.toRad();
  brng = brng.toRad();

  var lat2 = Math.asin( Math.sin(lat1)*Math.cos(d/R) +
                        Math.cos(lat1)*Math.sin(d/R)*Math.cos(brng) );
  var lon2 = lon1 + Math.atan2(Math.sin(brng)*Math.sin(d/R)*Math.cos(lat1),
                               Math.cos(d/R)-Math.sin(lat1)*Math.sin(lat2));

  if (isNaN(lat2) || isNaN(lon2)) return null;
  return new LatLon(lat2.toDeg(), lon2.toDeg());
}

// extend Number object with methods for converting degrees/radians

Number.prototype.toRad = function() {  // convert degrees to radians
  return this * Math.PI / 180;
}

Number.prototype.toDeg = function() {  // convert radians to degrees (signed)
  return this * 180 / Math.PI;
}


/*
 * construct a LatLon object: arguments in numeric degrees
 *
 * note all LatLong methods expect & return numeric degrees (for lat/long & for bearings)
 */
function LatLon(lat, lon) {
  this.lat = lat;
  this.lon = lon;
}



</script>
<BODY onload="bodyLoad();">
</BODY></HTML>
