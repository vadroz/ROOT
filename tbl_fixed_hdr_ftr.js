<script type="text/javascript" src="http://code.jquery.com/jquery-1.4.4.min.js"></script>
alert(123)
$(window).load(function(){
	var tableOffset = $(TblWithFxd).offset().top;

	// made relative position for header and footer	
	for(i in  FixedHdrFtr.hdr)	{ $(FixedHdrFtr.hdr[i]).css("position", "relative"); }	
	for(i in  FixedHdrFtr.footer) {	$(FixedHdrFtr.footer[i]).css("position", "relative"); }
		
	var height = $(window).height();
	var footTop = $('body').scrollTop() + height-158;
	for(i in  FixedHdrFtr.footer) {	$(FixedHdrFtr.footer[i]).css("top", footTop); }
		
	$(window).bind("scroll", function() 
	{
		var offset = $(this).scrollTop();
		var hdrPos = $('body').scrollTop();
		var tblHgt = $(TblWithFxd).height();
		
		if (offset >= tableOffset) 
		{
			for(i in  FixedHdrFtr.hdr)	{ $(FixedHdrFtr.hdr[i]).css("top", hdrPos-20); }					
		}
	    else if (offset < tableOffset) 
	    {
	    	for(i in  FixedHdrFtr.hdr)	{ $(FixedHdrFtr.hdr[i]).css("top", hdrPos-2); }	    	 	
	    }
		
		if(FixedHdrFtr.bottom.length > 0) { showBottomLine(offset); }
		
						
		var height = $(window).height();
		footTop = $('body').scrollTop() + height-158;  
		for(i in  FixedHdrFtr.footer) {	$(FixedHdrFtr.footer[i]).css("top", footTop); }
	});
		
});
//======================================================================
// show/hide bottom line when visible  
//======================================================================
function showBottomLine(offset)
{
	var footTop = $(FixedHdrFtr.bottom[0]).offset().top;
	var height = $(window.top).height();
	if (offset + height >= footTop)	
	{
		for(i in  FixedHdrFtr.footer) {	$(FixedHdrFtr.footer[i]).hide(); }			
	}
	else 
	{ 
		for(i in  FixedHdrFtr.footer) {	$(FixedHdrFtr.footer[i]).show(); }			
	}
}
//======================================================================
// on window resize get new position of window bottom and replace footer 
//======================================================================
$(window).resize(function() 
{
	var height = $(window).height();
	footTop = $('body').scrollTop() + height-158;
	for(i in  FixedHdrFtr.footer) {	$(FixedHdrFtr.footer[i]).css("top", footTop); }		 
});

//]]> 
