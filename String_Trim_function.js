//---------------------------------------------------------
//create String method Trim
//---------------------------------------------------------
if(!String.prototype.trim)
{
	String.prototype.trim = function()
	{ 
		//trim leading and trailing spaces
    	var s = this;
    	var obj = /^(\s*)([\W\w]*)(\b\s*$)/;
    	if (obj.test(s)) { s = s.replace(obj, '$2'); }
    	var obj = /  /g;
    	while (s.match(obj)) { s = s.replace(obj, ""); }

    	return s;
	}
}

//---------------------------------------------------------
//create String method Trim with spase
//---------------------------------------------------------
if(!String.prototype.trim)
{
	String.prototype.trim = function(space)
	{ 
		//trim leading and trailing spaces
    	var s = this;

	    if (s != null)
    	{
       		if(space != null)
       		{
          		var obj = /^(\s*)([\W\w]*)(\b\s*$)/;
          		if (obj.test(s)) { s = s.replace(obj, '$2'); }
          		var obj = /  /g;
          		while (s.match(obj)) { s = s.replace(obj, space); }
       		}
       		else
       		{
        		while (s.match("  ")) { s = s.replace("  ", " "); }
          		if (s.substring(0, 1) == " ") { s = s.replace(" ", "");}
          		while (s.substring(s.length - 1) == " ") { s = s.substring(0, s.length - 1);}
       		}
    	}

    	return s;
	}

	String.prototype.toFirstCapitalLetter = function()
	{
    	var s = this;
    	var space = true;
    	var t = null;
    	if(s != null)
    	{
       		t = "";
       		var l = null;
       		for(var i=0; i < s.length; i++)
       		{
          		if(space && s.substring(i, i+1)!= " ") { l = s.substring(i, i+1).toUpperCase(); space = false;}
          		else {l = s.substring(i, i+1).toLowerCase() }
          		if(s.substring(i, i+1)== " ") space = true;
          		t = t + l;
       		}
    	}
    	return t;
	}
}