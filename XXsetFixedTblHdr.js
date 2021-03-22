var hdr = new Array();
var hWidth = new Array();
var drow1 = new Array();
var dWidth = new Array();
var FixedThdr = null;

//=========================================================
// get Header Width
//=========================================================
function getHdrWidth(thdrNm)
{	 
	FixedThdr = "#" + thdrNm;
	var thdr = document.getElementById(thdrNm);
	var k=0;
	for(var i=0; i < thdr.rows.length; i++)
	{
		for(var j=0; j < thdr.rows[i].cells.length; j++)
		{
			hdr[k] = thdr.rows[i].cells[j];
			hWidth[k] = hdr[k].scrollWidth;
			k++;
		}	
	}
} 

//=========================================================
//get detail Row 1 Width
//=========================================================
function getDtlRowWidth(tbodyNm)
{
	var tbody = document.getElementById(tbodyNm);
	var k=0;
	for(var i=0; i < tbody.rows[0].cells.length; i++)
	{
		drow1[k] = tbody.rows[0].cells[i];
		if(drow1[k].scrollWidth > 0)
		{
			dWidth[k] = drow1[k].scrollWidth;
		}
		else{ dWidth[k] = 1; }
		k++;
	}
}
//=========================================================
// check scroll
//=========================================================
$(window).scroll(function() 
{	
	var row = document.all.thead1;
	var elementTop = $(row).offset().top;
	var elementBottom = elementTop + $(row).outerHeight();
	var viewportTop = $(window).scrollTop();
	var viewportBottom = viewportTop + $(window).height();

	if(elementTop + 20 < viewportTop  )
	{
		var offsetTop = viewportTop; // $(this).scrollTop();
		$(FixedThdr).css({position : "absolute", "z-index" : 60, top: offsetTop});
		
		//set original cell width
		setOrigWidth();		
	}
	else 
	{
		// return table in original status
		$(FixedThdr).css({position : "static"});		
	}
		
	window.status = "elementTop=" + elementTop + " | viewportTop=" + viewportTop
	  + " offsetTop=" + offsetTop

});
//=========================================================
//set original cell width
//=========================================================
function setOrigWidth()
{
	for(var i=0; i < hdr.length; i++)
	{
		hdr[i].width = hWidth[i];
	}
	
	for(var i=0; i < drow1.length; i++)
	{
		drow1[i].width = dWidth[i];
	}
	
}