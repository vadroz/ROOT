<!DOCTYPE html>	
<%@ page import="rciutility.RunSQLStmt, java.sql.*, rciutility.CallAs400SrvPgmSup
    ,java.util.*, java.text.*"%>
<%
	String sSite = request.getParameter("Site");
    String sPrTyId = request.getParameter("ProdTyId");
   
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=MozuItemAddPropList.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	
	
	String sStmt = "Select TPID, TPNAME"
	  + " from RCI.MOTNPRTY"
	  + " where tpsite= '" + sSite + "'"
	  + " and TPID=" + sPrTyId
	  + " order by TPNAME"		      
	 ;
	//System.out.println(sStmt);
	RunSQLStmt runsql = new RunSQLStmt();
	runsql.setPrepStmt(sStmt);
	ResultSet rs = runsql.runQuery();	
	
	String sPtNm = null;	
	if(runsql.readNextRecord())
	{
		sPtNm = runsql.getData("TPNAME");		
	}	
	rs.close();
	rs = null;
	runsql.disconnect();
	runsql = null;
%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE11" />
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">

<script type="text/javascript" src="http://code.jquery.com/jquery-1.4.4.min.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

<title>Bindings on Product Types</title>

<SCRIPT>

//--------------- Global variables -----------------------
var Site = "<%=sSite%>";
var PrTyId = "<%=sPrTyId%>";
var PrTyNm = "<%=sPtNm%>";
var NewName = null;
var NewKibo = null;
var NewClrNm = null;
var NewSizNm = null;

var progressIntFunc = null;
var progressTime = 0;
//--------------- End of Global variables ----------------
//==============================================================================
// initial process
//==============================================================================
function bodyLoad()
{   
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)) 
	{
		isSafari = true;
		setDraggable();
	}
	else
	{
	   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
	}
	
}
//==============================================================================
//show fedex data
//==============================================================================
function setBind(site, ptid, cls, ven, sty, clr, siz, oldpar, oldchi, action)
{
	var hdr = "Add Extra";
	if(action=="UPD"){ hdr = "Update Binding"; }
	else if(action=="DLT"){ hdr = "Delete Binding"; }
	
	var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
	     + "<tr>"
	       + "<td class='BoxName' nowrap>" + hdr + "</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
	       + "</td></tr>"
	     + "<tr><td class='Prompt' colspan=2>" + popBind(site, ptid, cls, ven, sty, clr, siz, action )
	       + "</td></tr>"
	     + "</table>"

	  document.all.dvItem.style.width=600;
	  document.all.dvItem.innerHTML = html;
	  document.all.dvItem.style.pixelLeft=document.documentElement.scrollLeft + 300;
	  document.all.dvItem.style.pixelTop=document.documentElement.scrollTop + 50;
	  document.all.dvItem.style.visibility = "visible";	  
	  
	  document.all.Site.value = Site;
	  document.all.PtID.value = PrTyId;
	  document.all.spnPtNme.innerHTML = PrTyNm; 
	  if(action != "ADD")
	  {
		  document.all.selPtId.disabled = true;
		  var bind = setExtraItem(cls,ven,sty, clr,siz, oldpar, oldchi); 
		  document.all.Bind.value = bind;
		  if(getScannedItem(bind)) { document.all.BindNm.value = NewName; }
		  document.all.btnSubmit.innerHTML = "Delete";
	  }
}
//==============================================================================
// set extra item number for Kibo
//==============================================================================
function setExtraItem(cls,ven,sty, clr,siz, oldpar, oldchi)
{
	var item = "";
	if(oldpar=="Y")	{ item += cls + ven.substring(1) + sty.substring(3); }
	else{ item += cls + ven + sty; }
	if(oldchi=="Y")	{ item += "-" + clr.substring(1) + siz.substring(1); }
	else{ item += "-" + clr + siz; }	
	
	return item;
}
//==============================================================================
// populate panel
//==============================================================================
function popBind(site, ptid, cls, ven, sty, clr, siz, action )
{		   
   var panel = "<table class='tbl01' id='tblLog'>"
    + "<tr>"
       	+ "<td class='td08'>Site: </td>"
       	+ "<td class='td08'><input class='Small' name='Site' maxlength=10 size=12   readOnly>" + "</td>" 
    + "</tr>"
    + "<tr>"
    	+ "<td class='td08' nowrap>Product Type: </td>"
    	+ "<td class='td08'><input  class='Small'name='PtID' maxlength=5 size=10 readOnly>"
    	    + "&nbsp; <span id='spnPtNme'></span>" 
       + "</td>" 
    + "</tr>"
    + "<tr>"
		+ "<td class='td08' nowrap>Extra Product Id (Child): </td>"
		+ "<td class='td08'><input class='Small' name='Bind' maxlength=40 size=40></td>" 
	+ "</tr>"
	+ "<tr>"
		+ "<td class='td08' nowrap>Extra Product Name:</td>"
		+ "<td class='td08'><input class='Small' name='BindNm' maxlength=100 size=100 readOnly></td>" 
	+ "</tr>"
 	;
       
   panel += "</table> <br/>";
   panel += "<tr>"
  		  + "<td id='tdError' class='Small' colspan=2 style='color:red;font-size:12px;'></td>"
		   + "</tr>";
		   
    panel += "</table>"
        + "<button id='btnSubmit' onClick='vldPropValue(&#34;" + action + "&#34;);' class='Small'>Save Changes</button>&nbsp; &nbsp;"
        + "<button onClick='hidePanel();' class='Small'>Close</button>&nbsp;"
	    ;
	        
	return panel;
}
//==============================================================================
// set selected product type
//==============================================================================
function setSelPtId(obj)
{
	document.all.PtID.value = obj.options[obj.selectedIndex].value;
}
//==============================================================================
//validate new value
//==============================================================================
function vldPropValue(action)
{
	var error = false;
  	var msg = "";
  	var br = "";
  	var bindnm = "";
  	var kibo = "";
  	document.all.tdError.innerHTML="";

  	var site = document.all.Site.value.trim();
  	var ptid = document.all.PtID.value;
  	if(ptid=="" || ptid=="0"){ error=true; msg += br + "Please, select Product Type."; br = "<br>"; }
  	
  	var bind = document.all.Bind.value.trim();
  	
  	bind = setParent(bind);
  	//alert(bind)
  	
  	if(bind==""){ error=true; msg += br + "Please, Enter Binding Code.";  br = "<br>";}
  	
  	var bindnm = "";
  	var sep = "";
  	if(!getScannedItem(bind)) { error=true; msg += br + "Binding Code is not found.";  br = "<br>";}
  	else
  	{
  		bindnm = NewName;
  		
  		if(NewSizNm != "" || NewClrNm != ""){ bindnm += " [";}
  		
  		if(NewSizNm != "")
  		{	
  			bindnm += " Size: " + NewSizNm;
  			sep = ";";
  		}
  		
  		if(NewClrNm != "")
  		{	
  			bindnm += sep + " Color: " + NewClrNm;
  		}
  		
  		if(NewSizNm != "" || NewClrNm != ""){ bindnm += " ]";}
  		
  		kibo = NewKibo;
  		document.all.BindNm.value = bindnm;
  	}
  	
  	if(error){ document.all.tdError.innerHTML=msg; }
  	else{ sbmPropValue(site, ptid, bind, bindnm, kibo,  action); }
}
//==============================================================================
//set parent  - remove deshes 
//==============================================================================
function setParent(parent)
{
	var newpar = "";
	var chk = rmvNonNum(parent);
	var cls = "";
	var ven = "";
	var sty = "";
	var clr = "";
	var siz = "";
	
	if(chk.length == 20)
	{ 
		cls = addLeadZero(chk.substring(0, 4), 4);
		ven = addLeadZero(chk.substring(4, 9), 6);
		sty = addLeadZero(chk.substring(9, 13), 7);
		clr = addLeadZero(chk.substring(13, 16), 4);
		siz = addLeadZero(chk.substring(16), 5);
		newpar = cls + ven + sty + clr + siz;
	}
	else if(chk.length == 26)
	{
		cls = chk.substring(0, 4);
		ven = chk.substring(4, 10);
		sty = chk.substring(10, 17);
		clr = chk.substring(17, 21);
		siz = chk.substring(21);
		newpar = cls + ven + sty + clr + siz;
	}
	else
	{
		newpar = splitParent(parent)
	}
	
	return newpar; 	
}
//==============================================================================
//split parent  - remove deshes 
//==============================================================================
function splitParent(parent)
{
	var newpar = "";
	var apar = new Array();
	var j=0;
	
	var hasChar = false;
	for(var i=0; i < parent.length; i++)
	{
		var single = parent.substring(i, i+1);
		
		if(single < "0"  || single > "9")
		{ 
			hasChar = true; 
		}		
	}
	
	if(hasChar) 
	{
		for(var i=0; i < parent.length; i++)
		{
			var single = parent.substring(i, i+1);
			
			if(single >= "0"  && single <= "9")
			{
				if(apar[j] == null){ apar[j] = ""; }			
				apar[j] += parent.substring(i, i+1);
			}		
			else if(parent.substring(i, i+1) != " ") 
			{ 
				j++; 
			}
		}
	}	
	
	if(j == 4) 
	{ 
		newpar += addLeadZero(apar[0], 4) + addLeadZero(apar[1], 6) + addLeadZero(apar[2], 7)
		  + addLeadZero(apar[3], 4) + addLeadZero(apar[4], 5)
		;
	}
	else
	{
		newpar = parent;
	}
	
	
	return newpar; 	
}
//==============================================================================
// add leading zero 
//==============================================================================
function addLeadZero(oldstr, len)
{
	var  str = oldstr;
	
	while(str.length < len)
	{
		str = "0" + str;
	}
	return str;
}
//==============================================================================
// remove non numeric 
//==============================================================================
function rmvNonNum(str)
{
	str = str.replace(/\D/g,'');
	return str;
}
//==============================================================================
//submit store status changes
//==============================================================================
function sbmPropValue(site, ptid, bind, bindnm, kibo, action)
{	
  	var nwelem = window.frame1.document.createElement("div");
  	nwelem.id = "dvSbmStrSts"
  	
  	var html = "<form name='frmItmProp'"
     + " METHOD=Post ACTION='MozuBindProdSv.jsp'>"
     + "<input name='Site'>"
     + "<input name='PtId'>"
     + "<input name='Bind'>"
     + "<input name='BindNm'>"
     + "<input name='KiboItem'>"
     + "<input name='Action'>"

  	html += "</form>"
  	
  		
  	nwelem.innerHTML = html;
  	window.frame1.document.body.appendChild(nwelem);

  	window.frame1.document.all.Site.value = site;
  	window.frame1.document.all.PtId.value = ptid;
  	window.frame1.document.all.Bind.value = bind;
  	window.frame1.document.all.BindNm.value = bindnm;
  	window.frame1.document.all.KiboItem.value = kibo;
  	window.frame1.document.all.Action.value=action;  
  	window.frame1.document.frmItmProp.submit();
  	
  	hidePanel();
  	
  	progressIntFunc = setInterval(function() {showWaitBanner() }, 1000); 
}
//==============================================================================
//show exist options for selection
//==============================================================================
function showWaitBanner()
{	
	progressTime++; 
	var html = "<table><tr style='font-size:12px;'>"
	html += "<td>Please wait...</td>";  
	
	for(var i=0; i < progressTime; i++)
	{ 
		html += "<td style='background:blue;'>&nbsp;</td><td>&nbsp;</td>";
	}
	html += "</tr></table>";
	
	if(progressTime >= 10){ progressTime=0; }
	
	document.all.dvWait.innerHTML = html;
	document.all.dvWait.style.height = "20px";
	document.all.dvWait.style.pixelLeft= document.documentElement.scrollLeft + 340;
	document.all.dvWait.style.pixelTop= document.documentElement.scrollTop + 205;
	document.all.dvWait.style.backgroundColor="#cccfff"
	document.all.dvWait.style.visibility = "visible";
}
//==============================================================================
//check scanned item against order
//==============================================================================
function getScannedItem(item)
{
	var url = "MozuValidateItem.jsp?Item=" + item 
		+ "&Site=<%=sSite%>";
    var valid = false;
	
	var xmlhttp;
	// code for IE7+, Firefox, Chrome, Opera, Safari
	if (window.XMLHttpRequest){ xmlhttp=new XMLHttpRequest(); }
	// code for IE6, IE5
	else { xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");}

	xmlhttp.onreadystatechange=function()
	{
		if (xmlhttp.readyState==4 && xmlhttp.status==200)
		{
  			var  resp = xmlhttp.responseText;
  		
  			valid = parseElem(resp, "Item_Valid") == "true";
			NewName = parseElem(resp, "Desc");
			NewKibo = parseElem(resp, "Kibo");
			NewClrNm = parseElem(resp, "ClrNm");
			NewSizNm = parseElem(resp, "SizNm");
		}
	}
	xmlhttp.open("GET",url,false); // synchronize with this apps
	xmlhttp.send();

	//alert(sku.trim());
	return valid;
}
//==============================================================================
//parse XML elements
//==============================================================================
function parseElem(resp, tag )
{
	var taglen = tag.length + 2;
	var beg = resp.indexOf("<" + tag + ">") + taglen;
	var end = resp.indexOf("</" + tag+ ">");
	return resp.substring(beg, end);
}
//==============================================================================
//Hide selection screen
//==============================================================================
function showError(error)
{
	clearInterval( progressIntFunc );
	document.all.dvWait.style.visibility = "hidden";
	
	alert(error);
}  
//==============================================================================
//Hide selection screen
//==============================================================================
function hidePanel()
{
	document.all.dvItem.innerHTML = " ";
	document.all.dvItem.style.visibility = "hidden";
}

</SCRIPT>
<script src="StrSelBox.js"></script>
<script src="MoveBox.js"></script>
<script src="String_Trim_function.js"></script>
<script src="Get_Object_Position.js"></script>
<script src="Calendar.js"></script>

</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<div id="dvItem" class="dvItem"></div>
<div id="dvWait" class="dvItem"></div>
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->

<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table class="tbl01">
        <tr class="trHdr">
          <th colspan=45>
            <b>Retail Concepts, Inc
            <br>Mozu - Control Extra attached<br>to Product Type: <%=sPtNm%>     
            </b>
            
            <br>
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;
              <font size="-1">This Page.</font> &nbsp; &nbsp; &nbsp; &nbsp;
              <a class="Small" href="javascript: setBind(null, null, null, null, null, null, null, null,null, 'ADD')">Add</a>
                          
          </th>
        </tr>
        <tr>
          <td>  
         
      <!-- ======================================================================= -->    
          
          
      <table class="tbl02">
<!------------------------------- Detail --------------------------------->
       
              <tr id="trId" class="trHdr01">
                <th class="th01" nowrap>Site</th>
                <th class="th01" nowrap>Product Type</th>
                <th class="th01" nowrap>Extra<br>Item Number<br>(Child)</th>
                <th class="th01" nowrap>Description</th>
                <th class="th01" nowrap>Color</th>
                <th class="th01" nowrap>Size</th>
                <th class="th01" nowrap>User</th>
                <th class="th01" nowrap>Date/Time</th>
                <th class="th01" nowrap>Delete</th>
              </tr>
       <%
       String sTrCls = "trDtl04";
       sStmt = "select BPSITE, BPPTID, digits(BPCLS) as cls, digits(BPVEN) as ven, digits(BPSTY) as sty"  
    	 + ",digits(BPCLR) as clr, digits(BPSIZ) as siz, BPRECUS, char(BPRECDT,usa) as BPRECDT"
    	 + " , char(BPRECTM, usa) as BPRECTM"
    	 + ", PMTYNM, ides"
    	 + ",(select case when ILDWNDT <= sdStrDt then 'Y' else 'N' end  from Rci.MOPRTDtl where ilCls=bpcls" 
    	 + " and ilVen=bpven and ilSty=bpsty) as oldpar"
    	 + ",(select case when wddat <= sdStrDt then 'Y' else 'N' end  from Rci.MOItWeb where wCls=bpcls" 
    	 + " and wVen=bpven and wSty=bpsty and wclr = bpclr and wsiz = bpsiz) as oldchi"
    	 + ", idline"
    	 + ", case when cival is not null then cival else ' ' end as clrnm"
    	 + ", case when sival is not null then sival else ' ' end as siznm"
    	 + " from rci.MoBindPr"
    	 + " inner join rci.MOPRDTYM on PMTYID=bpptid"
    	 + " inner join iptsfil.ipithdr on icls=BPCLS and iven=BPVen and iSty=BPSty"
    	 + " and iclr=BPClr and isiz=BPSiz"
    	 + " inner join rci.MoPrtDtl on ilcls=BPCLS and ilven=BPVen and ilSty=BPSty"
    	 + " left join rci.MoPrtDsc on idcls=BPCLS and idven=BPVen and idSty=BPSty"
    	 + " and idType = 'WName' and idseq=1"
    	 + " inner join rci.MoItWeb on wcls=BPCLS and wven=BPVen and wSty=BPSty"    	 
    	 + " and wclr=BPClr and wsiz=BPSiz"
    	 + " inner join rci.MOIP40C on 1=1"
    	 + " left join rci.MoColor on cisite='" + sSite + "' and  char(ciOpt) = trim(wClrNm)"
    	 + " left join rci.MoSize  on sisite='" + sSite + "' and  char(siOpt) = trim(wSizNm)"
    	 + " where BPSITE='" + sSite + "'" 
		;
       
    	//System.out.println("\n" + sStmt);
      	
    	runsql = new RunSQLStmt();
		runsql.setPrepStmt(sStmt);
		rs = runsql.runQuery();	
		int i=0;
			
			String sProdTypeId = "";
			String sProdTypeNm = "";			
			String sPtSite = "";
			String sCls = "";
			String sVen = "";
			String sSty = "";
			String sClr = "";
			String sSiz = "";
			String sDesc = "";
			String sRecUs = "";
			String sRecDt = "";
			String sRecTm = "";
			String sOldPar = "";
			String sOldChi = "";
			String sWebName = "";
			String sClrNm = "";
			String sSizNm = "";
			
			while(runsql.readNextRecord())
			{
				sPtSite = runsql.getData("BpSite");
				sProdTypeId = runsql.getData("BPPTID");
				sProdTypeNm = runsql.getData("PMTYNM");
				sCls = runsql.getData("cls");
			    sVen =  runsql.getData("ven");
			    sSty =  runsql.getData("sty");
			    sClr =  runsql.getData("clr");
			    sSiz =  runsql.getData("siz");
			    sRecUs =  runsql.getData("BPRECUS");
			    sRecDt =  runsql.getData("BPRECDT");
			    sRecTm =  runsql.getData("BPRECTM");
			    sDesc =  runsql.getData("ides");
			    sOldPar =  runsql.getData("oldpar");
			    sOldChi =  runsql.getData("oldchi");
			    
			    sWebName =  runsql.getData("idline");
			    if(sWebName != null){ sWebName = sWebName.trim(); }
			    else{ sWebName = ""; }
			    
			    if(sWebName.equals("")){ sWebName = sDesc; }
			    
			    sClrNm =  runsql.getData("clrnm");
			    sSizNm =  runsql.getData("siznm");
        %>
            <tr class="<%=sTrCls%>">                         
                <td class="td11" nowrap><%=sSite%></td>        
                <td class="td11" nowrap><%=sProdTypeId%> - <%=sProdTypeNm%></td>
                <td class="td12" nowrap><%=sCls%><%=sVen%><%=sSty%>-<%=sClr%><%=sSiz%></td>
                <td class="td11" nowrap><%=sWebName%></td>
                <td class="td11" nowrap><%=sClrNm%></td>
                <td class="td11" nowrap><%=sSizNm%></td>
                <td class="td12" nowrap><%=sRecUs%></td>
                <td class="td12" nowrap><%=sRecDt%> &nbsp; &nbsp; <%=sRecTm%></td>
                <td class="td12" nowrap><a class="Small" href="javascript: setBind('<%=sSite%>', '<%=sProdTypeId%>', '<%=sCls%>','<%=sVen%>','<%=sSty%>','<%=sClr%>','<%=sSiz%>','<%=sOldPar%>','<%=sOldChi%>', 'DLT')">Delete</a></td>
            </tr>    
        <%} %>
         </table>
      <!----------------------- end of table ------------------------>
      </tr>
   </table>
 </body>
</html>
<%
}
%>