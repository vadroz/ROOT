<!DOCTYPE html>
<%@ page import="rciutility.RunSQLStmt, java.text.SimpleDateFormat, java.sql.*, java.util.*
,rciutility.CallAs400SrvPgmSup"%>
<%   
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=RentReturn.jsp&APPL=ALL&" + request.getQueryString());
   }
   else
   {

   	String sUser = session.getAttribute("USER").toString();
   	String sStrAllowed = session.getAttribute("STORE").toString();
   	
   	CallAs400SrvPgmSup srvpgm = new CallAs400SrvPgmSup();
   	
   	String sStmt = "select CtCont, CTPICDT, CTRTNDT, CTSTS, CTSTR"	
   	    + ",(select csfname from rci.recusth where cscust=ctcust) as fname"
   	    + ",(select cslname from rci.recusth where cscust=ctcust) as lname"   		
   		+ " from Rci.ReContH"
   		+ " where exists(select 1 from Rci.ReContG where irCont=ctCont and IRRECDT = current date)"
   	;   
	   	
   	//System.out.println(sStmt);
	   	
	RunSQLStmt runsql = new RunSQLStmt();
	runsql.setPrepStmt(sStmt);		   
	runsql.runQuery();
	   		   
	Vector<String> vCtCont = new Vector<String>();
	Vector<String> vCtPicDt = new Vector<String>();
	Vector<String> vCtRtnDt = new Vector<String>();
	Vector<String> vCtSts = new Vector<String>();
	Vector<String> vCtStr = new Vector<String>();
	Vector<String> vCtFName = new Vector<String>();
	Vector<String> vCtLName = new Vector<String>();
	   		   
	while(runsql.readNextRecord())
	{
		vCtCont.add(runsql.getData("Ctcont").trim());
		vCtPicDt.add(runsql.getData("CtPicDt").trim());
		vCtRtnDt.add(runsql.getData("CtRtnDt").trim());
		vCtSts.add(runsql.getData("CtSts").trim());
		vCtStr.add(runsql.getData("CtStr").trim());
		vCtFName.add(runsql.getData("FName").trim());
		vCtLName.add(runsql.getData("LName").trim());
	}
	
	runsql.disconnect();
	runsql = null;
	
	
	
%>
<html>

<head>

<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE11" />

<title>Rent Returns</title>

<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">

<script type="text/javascript" src="http://code.jquery.com/jquery-1.4.4.min.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>
<script LANGUAGE="JavaScript1.2" src="XXsetFixedTblHdr.js"></script>

<SCRIPT>
//--------------- Global variables -----------------------
var LastAction = "";
var CtCont = new Array();
var CtPicDt = new Array();
var CtRtnDt = new Array();
var CtSts = new Array();
var CtStr = new Array();
var CtFName = new Array();
var CtLName = new Array();

var InvSn = new Array();
var InvId = new Array();

 
var LstCont = null;
var LstSrlN = null;
var LstError = null;
//--------------- End of Global variables ----------------
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)){ isSafari = true; }
	
	setBoxclasses(["BoxName",  "BoxClose"], ["dvChkItm", "dvCont", "dvItem", "dvComment"]);
	
	var srlobj = document.all.SrlNum;
	srlobj.value = "";
	srlobj.focus();
}
 

//==============================================================================
// Hide selection screen
//==============================================================================
function hidePanel(obj)
{   
	if(document.all.CalendarMenu != null){ hidetip2(); }
	document.all[obj].innerHTML = " ";
   	document.all[obj].style.visibility = "hidden";   
}  

//==============================================================================
// refresh table
//==============================================================================
function refreshTbl(invid, cls, clsnm)
{	
	var tbody = document.getElementById("tbodyCont");
	var row = tbody.insertRow(0);
	row.className = "trDtl04";

	var td = new Array(12);
	td[0] = addElem("td", "td11", NwStr);
	td[1] = addElem("td", "td11", clsnm);
	td[2] = addElem("td", "td11", NwSizNm);
	
	td[3] = addElem("td", "td11", "");
	var newlink = document.createElement("a");
	var func = "javascript: updInvId('" + NwSn + "')";
	newlink.setAttribute("href", func);
	newlink.innerHTML = NwSn;
	td[3].appendChild(newlink);
	
	td[4] = addElem("td", "td11", NwVenNm);
	td[5] = addElem("td", "td11", NwModel);
	td[6] = addElem("td", "td11", NwMfgSn);
	td[7] = addElem("td", "td18", NwPurchYr);
    td[8] = addElem("td", "td11", NwLife);    
    td[9] = addElem("td", "td18", NwTrade);
    td[10] = addElem("td", "td18", NwAddDt);
    
    td[11] = addElem("td", "td18", "");
    var newlink = document.createElement("a");
	var func = "javascript: dltInvId('" + invid + "', '" + NwSn + "')";
	newlink.setAttribute("href", func);
	newlink.innerHTML = "D";
	td[11].appendChild(newlink);  
    
    
    for(var i=0; i < td.length; i++)
	{
    	row.appendChild(td[i]);
	}	
    
    clearEntryPanel();
}

//==============================================================================
//reload
//==============================================================================
function refreshSrl()
{
	window.location.reload();
}
//==============================================================================
//check serial number
//==============================================================================
function chkSrlNum(obj)
{
	e = window.event;     
	var keyCode = null;    
	if(e != null ){ keyCode = e.keyCode || e.which; }

	if ( keyCode == '13' )
	{  	 	
		getScannedItem(obj.value.trim());
		e.keyCode = 0;
		
	}    
}
//==============================================================================
//check scanned item against order
//==============================================================================
function getScannedItem(sn)
{
	var valid = true;
	var url = "RentChkContBySn.jsp?Sn=" + sn;

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
			
			valid = getXmlValue("SN_Valid", resp) == "true";
			if(valid)
			{				
				var ctcont = getXmlValue("CtCont", resp);
				var ctpicdt = getXmlValue("CtPicDt", resp);
				var ctrtndt = getXmlValue("CtRtnDt", resp);
				var ctsts = getXmlValue("CtSts", resp);
				var ctstr = getXmlValue("CtStr", resp);
				var ctfname = getXmlValue("CtFName", resp);
				var ctlname = getXmlValue("CtLName", resp);
				  
				var invid = getXmlValueArr("InvId", resp); 
				var srln = getXmlValueArr("SrlN", resp); 
				var cls = getXmlValueArr("Cls", resp); 
				var siz = getXmlValueArr("Siz", resp); 
				var brand = getXmlValueArr("Brand", resp); 
				var model = getXmlValueArr("Model", resp); 
				var clsnm = getXmlValueArr("ClsNm", resp); 
				var vennm = getXmlValueArr("VenNm", resp); 
				var siznm = getXmlValueArr("SizNm", resp); 
				var pairqty = getXmlValueArr("PairQty", resp);
				var poles = getXmlValue("Poles", resp);
				
				popContTbl(ctcont, ctpicdt, ctrtndt, ctsts, ctstr, ctfname, ctlname
						, invid, srln, cls, siz, brand, model, clsnm, vennm, siznm, sn, pairqty, poles);
				
				var srlobj = document.all.SrlNum;
				srlobj.value = "";
				srlobj.focus();
				
				sbmScanItem(ctcont, sn);
				
						
			}
		}
	}
	xmlhttp.open("GET",url,false); // synchronize with this apps
	xmlhttp.send();

	//alert(sku.trim());
	return valid;
}
//==============================================================================
// get XML value 
//==============================================================================
function getXmlValue(tag, resp)
{
	var opntag = "<" + tag + ">";
	var beg = resp.indexOf(opntag) + opntag.length;
	var clstag = "</" + tag + ">";
	var end = resp.indexOf(clstag);
	xmlval = resp.substring(beg, end);
	return xmlval;
}
//==============================================================================
//get XML value 
//==============================================================================
function getXmlValueArr(tag, resp)
{
	var arrval = new Array();
	
	var opntag = "<" + tag + ">";
	var beg = resp.indexOf(opntag);
	var clstag = "</" + tag + ">";
	
	while(beg >= 0)
	{
		beg += opntag.length;		
		var end = resp.indexOf(clstag, beg);
		var xmlval = resp.substring(beg, end);		
	  	arrval[arrval.length] = xmlval;
	  	
	  	beg = resp.indexOf(opntag, beg+1);
	}
	return arrval;
}
//==============================================================================
// populate Contracts on main table 
//==============================================================================
function popContTbl(ctcont, ctpicdt, ctrtndt, ctsts, ctstr, ctfname, ctlname
		,invid, srln, cls, siz, brand, model, clsnm, vennm, siznm, sn, pairqty, poles)
{
	var found = false
	for(var i=0; i < CtCont.length; i++)
	{
		if(ctcont == CtCont[i]){ found = true; break;}
	}
	
	
	if(!found)
	{			
		var iTbl = CtCont.length;
		CtCont[iTbl] = ctcont;
		CtPicDt[iTbl] = ctpicdt;
		CtRtnDt[iTbl] = ctrtndt;
		CtSts[iTbl] = ctsts;
		CtStr[iTbl] = ctstr;
		CtFName[iTbl] = ctfname;
		CtLName[iTbl] = ctlname;
		
		// 1st contract row - and header
		var tbody = document.getElementById("tbodyCont");
		var row = tbody.insertRow(0);
		row.className = "trHdr01";
		row.id = "tr" + iTbl;
		
		var td = new Array(6);
		td[0] = addElem("th", "th31", ctcont, "200px", "thOrd" + iTbl);
		td[1] = addElem("th", "th13", "Str", "50px", "th" + iTbl + "_" + 1);
		td[2] = addElem("th", "th13", "Pickup Date", "200px", "th" + iTbl + "_" + 2);
		td[3] = addElem("th", "th13", "Return Date", "200px", "th" + iTbl + "_" + 3);
		td[4] = addElem("th", "th13", "Status", "100px", "th" + iTbl + "_" + 4);
		td[5] = addElem("th", "th13", "Return Receipt", "50px", "th" + iTbl + "_" + 5);
		
		for(var i=0; i < td.length; i++)
		{
	    	row.appendChild(td[i]);
		}
		
		 		
		// 2nd contract row - header
		var tbody = document.getElementById("tbodyCont");
		var row = tbody.insertRow(1);
		row.className = "trDtl06";
		row.id = "tr" + iTbl + "_2";
		
		td[0] = addElem("td", "td18", ctfname + " " + ctlname, "200px", "td" + iTbl + "_" + 0);
		td[1] = addElem("td", "td18", ctstr, "50px", "td" + iTbl + "_" + 1);
		td[2] = addElem("td", "td18", ctpicdt, "200px", "td" + iTbl + "_" + 2);
		td[3] = addElem("td", "td18", ctrtndt, "200px", "td" + iTbl + "_" + 3);
		td[4] = addElem("td", "td18", ctsts, "100px", "td" + iTbl + "_" + 4);
		td[5] = addElem("td", "td18", " ", "50px", "td" + iTbl + "_" + 5);
		
		for(var i=0; i < td.length; i++)
		{
	    	row.appendChild(td[i]);
		}
		
		
		// add detail row for this contract
		row = tbody.insertRow(2);
		row.className = "trDtl04";
		td[0] = addElem("td", "td18", "", null, "td" + iTbl + "_Itm");
		td[0].colSpan="6";
		row.appendChild(td[0]);
		
		var thlink  = document.getElementById("thOrd" + iTbl);
		var alink = "<a href='RentContractInfo.jsp?Grp=SKI&ContId=" + ctcont + "' target='_blank'>" + ctcont + "</a>";
		thlink.innerHTML = alink;
		
		tdlink  = document.getElementById("td" + iTbl + "_" + 5);
		alink = "<a href='RentReturnPrt.jsp?ContId=" + ctcont + "&Print=Y' target='_blank'>Print</a>";
		tdlink.innerHTML = alink;
		
		popItemTbl(invid, srln, cls, siz, brand, model, clsnm, vennm, siznm, sn, pairqty, iTbl, poles);		 
	}
	// if at least one s/n from contract found - update item table with color if second part of pair
	// saw found
	else 
	{
		updItemTbl(ctcont, invid, srln, cls, siz, brand, model, clsnm, vennm, siznm, sn, pairqty);
	}
}
//==============================================================================
//populate Contract Item List on main table 
//==============================================================================
function popItemTbl(invid, srln, cls, siz, brand, model, clsnm, vennm, siznm, sn, pairqty, iTbl, poles)
{	
	InvId[InvId.length] = invid;
	InvSn[InvSn.length] = srln; 
	
	var tbl = "<table class='tbl02' width='100%'>"
	 + "<tr class='trHdr01'>"
	 	+ "<th class='th13'>S/N</th>"
	 	+ "<th class='th13'>Class</th>"
	 	+ "<th class='th13'>Brand</th>"
	 	+ "<th class='th13'>Size</th>"
	 	+ "<th class='th13'>Model</th>"
	 	+ "<th class='th13'>pair</th>"
	 + "</tr>";
	 
	var clsdtl = "trDtl04";
	
	for(var i=0; i < invid.length; i++)
	{
		if(srln[i] == sn &&  invid.length > 1){ clsdtl = "trDtl34"; }
		if(srln[i] == sn &&  invid.length == 1){ clsdtl = "trDtl35"; }
		
		tbl += "<tr class='" + clsdtl + "' id='trInv" + iTbl + "_" + i + "'>"
		 	+ "<td class='td11' id='tdInv" + iTbl + "_" + i + "'>" 
		 	   + "<a href='RentInvAdd.jsp?SrlNum=" + srln[i] + "&Action=UpdInvBySrlNum' target='_blank'>" + srln[i] + "</a></td>"
		 	+ "<td class='td11'>" + clsnm[i] + "</td>"
		 	+ "<td class='td11'>" + vennm[i] + "</td>"
		 	+ "<td class='td11'>" + siznm[i] + "</td>"
		 	+ "<td class='td11'>" + model[i] + "</td>"
		 ;
		 if(cls == "9750" || cls == "9766" || cls == "9690" || cls == "9733" )
		 {
		 	tbl += "<td class='td18'>N/A</td>";
		 }
		 else
		 {
			 tbl += "<td class='td18'>"
			 if(srln[i] == sn ) 
			 {
			    tbl += "<img id='imgPair1_" + iTbl + "_" + i + "' src='CheckBox_checked_001.jpg'" 
			    + " width='15' height='15'> &nbsp; "
			 }
			 else
			 {
				 tbl += "<img id='imgPair1_" + iTbl + "_" + i + "' src='CheckBox_unchecked_001.jpg'" 
				    + " width='15' height='15'> &nbsp; "
			 }
			 
			 tbl += "<img id='imgPair2_" + iTbl + "_" + i + "' src='CheckBox_unchecked_001.jpg'"
			    + " width='15' height='15'>";			    
			 tbl += "</td>";
			
		 }
		 
		 
		 tbl += "</tr>"
		
		clsdtl = "trDtl04";
	}
	 
	if(poles > 0)
	{
		tbl += "<tr class='trDtl04' id='trInv" + iTbl + "_" + invid.length + "'>"
	 	+ "<td class='td11' id='tdInv" + iTbl + "_" + invid.length + "'>Poles</td>"
	 	+ "<td class='td11'>&nbsp;</td>"
	 	+ "<td class='td11'>&nbsp;</td>"
	 	+ "<td class='td11'>&nbsp;</td>"
	 	+ "<td class='td11'>&nbsp;</td>"
	 	+ "<td class='td18'>" + poles + " set(s)</td>"
	}
	
	tbl += "</table>";
	
	document.getElementById("td" + iTbl + "_Itm").innerHTML = tbl;
}
//==============================================================================
//refresh table
//==============================================================================
function addElem(elem, cls, value, width, id)
{
	var td = document.createElement(elem);
  td.className = cls;
  td.appendChild (document.createTextNode(value));
  
  if(width != null)
  {
	  td.style.width = width;
  }
  if(id != null)
  {
	  td.id = id;
  }
  
  return td;
}
//==============================================================================
//update s/n line with color if full pair was entered  
//==============================================================================
function updItemTbl(ctcont, invid, srln, cls, siz, brand, model, clsnm, vennm, siznm, sn, pairqty)
{
	for(var i=0; i < CtCont.length; i++)
	{
		var tcont  = document.getElementById("thOrd" + i);
		var contVal = tcont.innerHTML;
		if(tcont.innerHTML.indexOf(ctcont) >= 0)
		{
			for(var j=0; j < invid.length; j++)
			{
				var trsn = document.getElementById("trInv" + i + "_" + j);
				var tdsn = document.getElementById("tdInv" + i + "_" + j);
				 
				var snsng = srln[j];
				var tdsnval = tdsn.innerHTML;
				var pq = pairqty[j];
				var pair = cls[j] != "9750" && cls[j] != "9766" && cls[j] != "9690" && cls[j] != "9733";
				
				if(tdsnval.indexOf(sn) >= 0 && pq == 1 && pair)
				{
					trsn.className = "trDtl35";
					var img = document.getElementById("imgPair2_" + i + "_" + j);
					img.src = "CheckBox_checked_001.jpg";
				}
				else if(sn == tdsnval && pq == 0 && pair)
				{	 
						
					trsn.className = "trDtl34";
					var img = document.getElementById("imgPair1_" + i + "_" + j);
					img.src = "CheckBox_checked_001.jpg";
				}
				else if(sn == tdsnval && !pair)
				{
					trsn.className = "trDtl35";					
				}
			}
		}		
	}
}
//==============================================================================
// save scanned item 
//==============================================================================
function sbmScanItem(ctcont, sn)
{
	var url = "RentContractSave.jsp?"
	   + "&Cont=" + ctcont
	   + "&SrlNm=" + sn 
	   + "&Action=Add_Rtn_SN"
	 ;
	window.frame1.location.href=url;
}
//==============================================================================
//save scanned item 
//==============================================================================
function sbmChgSts(cont, action)
{
	var url = "RentContractSave.jsp?"
	   + "&Cont=" + cont
	   + "&Action=" + action	    
	 ;
	window.frame1.location.href=url;
}
 
//==============================================================================
//save scanned item 
//==============================================================================
function refreshRtn(cont,srln, error)
{
	LstCont = cont;
	LstSrlN = srln;
	LstError = error;
	if(error != ""){ alert(error); }
	else 
	{ 
		sbmChgSts(cont, "Rtn_Sts_Cont"); 
	}
}
//==============================================================================
//refresh contract status  
//==============================================================================
function refreshContSts(cont, chgsts)
{
	if(chgsts == "Y")
	{
		for(var i=0; i < CtCont.length; i++)
		{			
			var tcont  = document.getElementById("thOrd" + i);
			if(tcont.innerHTML.indexOf(cont) >= 0)
			{
				var contline = document.getElementById("td" + i + "_4");
				contline.innerHTML = "RETURNED";
				contline.style.color = "green";
			}
		}
	}
}
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Get_Object_Position.js"></script>

</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvItem" class="dvItem"></div>
<!-------------------------------------------------------------------->

    <table class="tbl01">
     <tr>
      <td ALIGN="center" VALIGN="TOP"nowrap>
        <b>Retail Concepts, Inc
        <br>Rental Inventory Return 
      </td>
    </tr>

    <tr>
      <td ALIGN="center" VALIGN="TOP">
      <a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;
       This Page. &nbsp; &nbsp;
            
   <!----------------------- Order List ------------------------------>
     <table class="tbl02" id="tbEntry" width = "1000">
       <!-- ========= S/N Barcode ID -->
       <tr class="trHdr01" height="25">
          <th align="right" nowrap>SS Barcode ID (or Mfg Barcode ID) :&nbsp;</th>
          <td colspan=6 align=left>
             <input name="SrlNum" size=17 maxlength=15 onkeypress="chkSrlNum(this)">
             &nbsp; <span id="spnSts"></span>
          </td>
       </tr>
       <tr class="trHdr01" height="25">
        <td colspan=6>
             <table class="tbl04" id="tblCont">
               <tr class="trDtl04">
                  <tbody id="tbodyCont">
                  <%for(int i=0; i < vCtCont.size(); i++){%>
                  <tr class="trHdr01" id="trContHdr<%=i%>">
                      <th class="th31" id="thOrd<%=i%>" width="200px">Contract: &nbsp;
                      <a href="http://localhost:8080/RentContractInfo.jsp?Grp=SKI&ContId=<%=vCtCont.get(i)%>" target="_blank"><%=vCtCont.get(i)%></a>
                      </th>
                      <th class="th13" id="th<%=i%>_1" width="200px">Str</th>
                      <th class="th13" id="th<%=i%>_2" width="200px">Pickup Date</th>
                      <th class="th13" id="th<%=i%>_3" width="200px">Return Date</th>
                      <th class="th13" id="th<%=i%>_4" width="100px">Status</th>
                      <th class="th13" id="th<%=i%>_5" width="100px">Return Receipt</th>
                  </tr>
                  
                  <tr class="trDtl06" id="trCont<%=i%>">
                    <td class="td18" style="font-size: 16px;"><%=vCtFName.get(i)%> <%=vCtLName.get(i)%></td>
                    <td class="td18"><%=vCtStr.get(i)%></td>
                    <td class="td18"><%=vCtPicDt.get(i)%></td>
                    <td class="td18"><%=vCtRtnDt.get(i)%></td>
                    <td class="td18" id="td<%=i%>_4"><%=vCtSts.get(i)%></td>
                    <td class="td18">
                    	<%if(vCtSts.get(i).equals("RETURNED")){%>
                    		<a href="RentReturnPrt.jsp?ContId=<%=vCtCont.get(i)%>&Print=Y" target="_blank">Print</a>
                    	<%}%>
                    </td>
                  </tr>
                  
                  <!-- ============= Item Table ================ -->
                  
                  <tr class="trDtl04" id="tr<%=i%>_itm">
                     <td class="td18" colspan=6>
                    
                      <table class="tbl02" width="100%">
	                 	<tr class='trHdr01'>
	                 		<th class='th13'>S/N</th>
	                 		<th class='th13'>Class</th>
	                 		<th class='th13'>Brand</th>
	                 		<th class='th13'>Size</th>
	                 		<th class='th13'>Model</th>
	                 		<th class='th13'>pair</th>
	                 	</tr>
                      
                     
                     <%
                     sStmt = "select IVINVID, IVCUST, EISRLN, EICLS, EIVEN, EISIZ, EIBRAND, EIMODEL"
                       + ", clnm, vnam, snam"
                       + ", case when (select IrQty from rci.ReContG where IvCont=IrCont and IvInvId=IrInvId) is null then 0"
                       + " else (select IrQty from rci.ReContG where IvCont=IrCont and IvInvId=IrInvId) end as Qty"
                   	   + " from Rci.ReConti"
                       + " inner join Rci.ReInv on IVINVID=EiInvId"
                       + " inner join IpTsFil.ipClass on ccls=EiCls"
                       + " inner join IpTsFil.ipMrVen on vven=EiBrand"
                       + " inner join IpTsFil.ipSizes on ssiz=EiSiz"
                       + " where ivCont = " + vCtCont.get(i)
                       + " order by IVCUST"
                  	;   
                    
                    System.out.println("RentReturn.jsp stmt= " + sStmt);
                    
                    RunSQLStmt runsql_itm = new RunSQLStmt();
                    runsql_itm.setPrepStmt(sStmt);		   
                    runsql_itm.runQuery();
                    		   		   
                    int  j=0;		   		
                    String sSvCust = null;
                    while(runsql_itm.readNextRecord())
                    {
                    	String sInvId = runsql_itm.getData("IVINVID").trim();
                    	String sCust = runsql_itm.getData("IVCUST").trim();
                    	String sSrlN = runsql_itm.getData("EISRLN").trim();
                    	String sCls = runsql_itm.getData("EICLS").trim(); 
                    	String sSiz = runsql_itm.getData("EiSiz").trim();
                    	String sBrand = runsql_itm.getData("EiBrand").trim();
                    	String sModel = runsql_itm.getData("EiModel").trim();
                    	String sClsNm = runsql_itm.getData("clnm").trim();
                    	String sVenNm = runsql_itm.getData("vnam").trim();
                    	String sSizNm = runsql_itm.getData("snam").trim();
                    	String sQty = runsql_itm.getData("qty").trim();                    	
                    	
                    	String sPair = "N/A";
                    	String sClsDtl = "trDtl04";
                    	
                    	if(!sCls.equals("9750") && !sCls.equals("9766") 
                    	    && !sCls.equals("9690") && !sCls.equals("9733") )
               		 	{
                    		if(sQty.equals("0"))
                    		{
               		 			sPair = "<img id='imgPair1_" + i + "_" + j + "' src='CheckBox_unchecked_001.jpg'" 
               				   	+ " width='15' height='15'> &nbsp; "
               				   	+ "<img id='imgPair2_" + i + "_" + j + "' src='CheckBox_unchecked_001.jpg'"
               				   	+ " width='15' height='15'> &nbsp; "
               					;
               				 sClsDtl = "trDtl04";
                    		}
                    		else if(sQty.equals("1"))
                    		{
                    			sPair = "<img id='imgPair1_" + i + "_" + j + "' src='CheckBox_checked_001.jpg'" 
                       			 + " width='15' height='15'> &nbsp; "
                       			 + "<img id='imgPair2_" + i + "_" + j + "' src='CheckBox_unchecked_001.jpg'"
                       			 + " width='15' height='15'> &nbsp; "
                       			;
                    			sClsDtl = "trDtl34";
                    		}   
                    		else if(sQty.equals("2"))
                    		{
                    			sPair = 
                    			   "<img id='imgPair1_" + i + "_" + j + "' src='CheckBox_checked_001.jpg'" 
                       			 + " width='15' height='15'> &nbsp; "
                       			 + "<img id='imgPair2_" + i + "_" + j + "' src='CheckBox_checked_001.jpg'"
                       			 + " width='15' height='15'> &nbsp; "
                       			;
                    			sClsDtl = "trDtl35";
                    		}                    		
               		 }
                     else
                     {
                    	 if(sQty.equals("0")){sClsDtl = "trDtl04";}
                    	 else if(sQty.equals("1")){sClsDtl = "trDtl35";}
                    	 
                     }
                    %>
                    <%if(sSvCust != null && !sSvCust.equals(sCust)){%>	
                    	<tr class='Divider1'><td colspan=6>&nbsp;</td></tr>
                    <%} %>   
                    <tr class='<%=sClsDtl%>' id="trInv<%=i%>_<%=j%>">
                       <td class="td11" id="tdInv<%=i%>_<%=j%>">
                       <a href="RentInvAdd.jsp?SrlNum=<%=sSrlN%>&Action=UpdInvBySrlNum" target="_blank"><%=sSrlN%></a>
                       </td>
                       <td class="td11"><%=sClsNm%></td>
                       <td class="td11"><%=sVenNm%></td>
                       <td class="td11"><%=sSizNm%></td>
                       <td class="td11"><%=sModel%></td>
                       <td class="td11"><%=sPair%></td>                       
                    </tr>                    
                	<%	j++;
                	    sSvCust = sCust;
                	  }		
                    runsql_itm.disconnect();
                    runsql_itm = null;
                   %>
                   <%
                   	sStmt = "select count(*) as count"
                    	+ " from Rci.ReConti"
                        + " where ivCont = " + vCtCont.get(i)
                        + " and ivinvid=9999999999"
                      	;   
                     
                   RunSQLStmt runsql_pole = new RunSQLStmt();
                   runsql_pole.setPrepStmt(sStmt);		   
                   runsql_pole.runQuery();
                        
                   if(runsql_pole.readNextRecord())
                   {
                		String sPole = runsql_pole.getData("count").trim();
                   %>  
                      <%if(!sPole.equals("0")){%>
                      <tr class='Divider1'><td colspan=6>&nbsp;</td></tr>
                      <tr class='trDtl04' id="trPole<%=i%>">
                      	<td class="td11" id="tdPole<%=i%>">Poles</td>
                       	<td class="td11">&nbsp;</td>
                       	<td class="td11">&nbsp;</td>
                       	<td class="td11">&nbsp;</td>
                       	<td class="td11">&nbsp;</td>
                       	<td class="td18"><%=sPole%> sets</td>                       
                    </tr>    
                    <%}%>
                 <%}	
                        runsql_pole.disconnect();
                        runsql_pole = null;
                   %>
                     </table>
                     </td>
                  </tr>
                  <script>   
                  var icont = CtCont.length; 
                  CtCont[icont] = "<%=vCtCont.get(i) %>";
                  CtPicDt[icont] = "<%=vCtPicDt.get(i) %>";
                  CtRtnDt[icont] = "<%=vCtRtnDt.get(i) %>";
                  CtSts[icont] = "<%=vCtSts.get(i) %>";
                  CtStr[icont] = "<%=vCtStr.get(i) %>";
                  CtFName[icont] = "<%=vCtFName.get(i) %>";
                  CtLName[icont] = "<%=vCtLName.get(i) %>";
                  </script>
                  <%}%>
                  
                  </tbody>               	  
               </tr>
             </table> 
             
            
        </td>
       </td> 
       
       
       <!-- ======== Store ============ -->
          
       
       
              
     
  </table>
 </body>
</html>


<%  
  }%>