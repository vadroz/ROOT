//-------------------------------------------------------------
// global variables
//-------------------------------------------------------------
var SG_Grp = new Array();
var SG_Str = new Array();
//-------------------------------------------------------------
// get store groups from DBase
//-------------------------------------------------------------
function getStrGrp()
{
   var url = "InetStrGrpRtv.jsp";
   window.frame100.location.href=url;	   
}
//-------------------------------------------------------------
//Set store groups
//-------------------------------------------------------------
function setStrGrp(grp, str)
{
	SG_Grp = grp; 
	SG_Str = str;	
}
//-------------------------------------------------------------
//Set store groups
//-------------------------------------------------------------
function setStrGrpPanel()
{
	var panel = "<table style='width=100%'>"	
	  + "<tr class='SelButton'>";	
	   + "<td class='SelButton'>";
	var space = "";   
	for(var i=0; i < SG_Grp.length; i++)
	{
		panel += space + "<button class='Small' onclick='alert(&#34;" + SG_Grp[i] + "&#34;)'>" + SG_Grp[i] + "</button>";
		space = "&nbsp;";		
	}
	 
	panel += "</td></tr>"	
	panel += "</table>"
	
	return panel;
}
