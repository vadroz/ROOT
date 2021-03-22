//--------------------------------------------------------
// Replace &, # signs on escape sequense;
//--------------------------------------------------------
if(!String.prototype.replaceSpecChar)
{
	String.prototype.replaceSpecChar = function() 
	{
		var s = this;
		var newStr = "";
		var obj = ["'", "#", "&", "%", '"'];
		for(var i=0; i < s.length; i++)
		{
			var l = s.substring(i,i+1);
			for(var j=0; j < obj.length; j++)
			{
				if(l == obj[j])  {  l = escape(obj[j]); break; }
			}
			newStr += l;
		}
		return newStr;
	}
}
//--------------------------------------------------------
// show  ',  &, # charachters on screen
//--------------------------------------------------------
if(!String.prototype.showSpecChar)
{
	String.prototype.showSpecChar = function()
	{
		var s = this;
		var chk = ["&#39;", "&#38;", "&#35;", "&#37;"];
		var exc = ["%27", "%26", "%23", "%25"];
		for(var i=0; i < chk.length; i++)
		{
			while (s.match(chk[i])) { s = s.replace(chk[i], unescape(exc[i])); }
		}
		return s;
	}
}
//--------------------------------------------------------
// Replace &, # signs on escape sequense;
//--------------------------------------------------------
if(!String.prototype.removeNextLine){
	String.prototype.removeNextLine = function()
	{
		var s = this;
		var newStr = "";
		var obj = [unescape("%0D"), unescape("%0A")];
		for(var i=0; i < s.length; i++)
		{
			var l = s.substring(i,i+1);
			for(var j=0; j < obj.length; j++)
			{				
				if(escape(l) == escape(obj[j]))  {  l = " "; break; }
			}
			newStr += l;
		}
		return newStr;
	}
}


