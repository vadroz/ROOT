//==========================================================
// get left position to visible screen top
//==========================================================
function getLeftScreenPos()
{
	var left = 0;
	if(isIE && ua.indexOf("MSIE 7.0") >= 0)
	{
		left = document.body.scrollLeft;   
	}
	else if(isChrome)
	{
		left = document.body.scrollLeft;		
	}
	else if(isSafari)
	{
		left = document.body.scrollLeft;
	}
	else
	{
		left= document.documentElement.scrollLeft;
	}
	return left;
}
//==========================================================
//get top position to visible screen top
//==========================================================
function getTopScreenPos()
{
	var top = 0;
	if(isIE && document.body.scrollTop > 0 )
	{
		top = document.body.scrollTop;
	}
	else if(isIE && document.documentElement.scrollTop > 0 )
	{
		top = document.documentElement.scrollTop;
	}
	else if(isChrome)
	{
		top = document.body.scrollTop;
	}
	else if(isSafari)
	{
		top = window.pageYOffset;
	}
	else
	{	
		top = document.documentElement.scrollTop;
	}
	return top;
}