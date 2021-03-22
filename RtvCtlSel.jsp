<%@ page import="rciutility.RunSQLStmt, java.text.SimpleDateFormat, java.sql.*
	, java.util.*, rciutility.CallAs400SrvPgmSup
	, rciutility.StoreSelect "
%>
<%
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=RtvCtlSel.jsp&APPL=ALL");
   }
   else
   {
	   	String sStrAllowed = session.getAttribute("STORE").toString();
	   	String sUser = session.getAttribute("USER").toString();
       	
	   	String sPrepStmt = "select RHCTLID,RHSTR,RHVEN,RHCTLSTS,RHNAME, RHRECUS,RHRECDT,RHRECTM "
	   	 + ",vnam"
       	 + " from rci.rvhdr"
       	 + " inner join IpTsFil.IpMrVen on vven=rhven"
       	 + " order by RHCTLID desc";       	
      	
       	//System.out.println(sPrepStmt);
       	
      	ResultSet rslset = null;
      	RunSQLStmt runsql = new RunSQLStmt();
    	runsql.setPrepStmt(sPrepStmt);		   
    	runsql.runQuery();
    		   		   
    	Vector<String> vCtl = new Vector<String>();
    	Vector<String> vCStr = new Vector<String>();
    	Vector<String> vVen = new Vector<String>();
    	Vector<String> vSts = new Vector<String>();
    	Vector<String> vName = new Vector<String>();
    	Vector<String> vRecUsr = new Vector<String>();
    	Vector<String> vRecDt = new Vector<String>();
    	Vector<String> vRecTm = new Vector<String>();
    	Vector<String> vVenNm = new Vector<String>();
    		   		   
    	while(runsql.readNextRecord())
    	{
    		vCtl.add(runsql.getData("rhctlid"));
    		vCStr.add(runsql.getData("RHSTR"));
    		vVen.add(runsql.getData("RHVEN"));
    		vSts.add(runsql.getData("RHCTLSTS"));
    		vName.add(runsql.getData("RHNAME"));
    		vRecUsr.add(runsql.getData("RHRECUS"));
    		vRecDt.add(runsql.getData("RHRECDT"));
    		vRecTm.add(runsql.getData("RHRECTM"));	
    		vVenNm.add(runsql.getData("vnam"));
        }
    		    
    	CallAs400SrvPgmSup srvpgm = new CallAs400SrvPgmSup();	
    	
    	String [] sCtl = vCtl.toArray(new String[]{});
    	String [] sCStr = vCStr.toArray(new String[]{});
    	String [] sVen = vVen.toArray(new String[]{});
    	String [] sSts = vSts.toArray(new String[]{});
    	String [] sName = vName.toArray(new String[]{});
    	String [] sRecUsr = vRecUsr.toArray(new String[]{});
    	String [] sRecDt = vRecDt.toArray(new String[]{});
    	String [] sRecTm = vRecTm.toArray(new String[]{});
    	String [] sVenNm = vVenNm.toArray(new String[]{});    	
    	
    	sPrepStmt = "select RRREAS from rci.RVHDREAS order by RRSORT";
    	//System.out.println(sPrepStmt);    	
    	runsql = new RunSQLStmt();
    	runsql.setPrepStmt(sPrepStmt);		   
    	runsql.runQuery();
    	    		   		   
    	Vector<String> vReas = new Vector<String>();
    	    		   		   
    	while(runsql.readNextRecord())
    	{ 		
    		vReas.add(runsql.getData("RRREAS"));
        }
    	    		    
    	String [] sReas = vReas.toArray(new String[]{});
    	String sReasJva = srvpgm.cvtToJavaScriptArray(sReas);
    	    	
    	StoreSelect strlst = null;
    	if (sStrAllowed != null && sStrAllowed.startsWith("ALL"))
        {
          strlst = new StoreSelect(23);
        }
        else if (sStrAllowed != null && sStrAllowed.trim().equals("70"))
        {
          strlst = new StoreSelect(21);
        }
        else
        {
          Vector vStr = (Vector) session.getAttribute("STRLST");
          String [] sStrAlwLst = new String[ vStr.size()];
          Iterator iter = vStr.iterator();

          int iStrAlwLst = 0;
          while (iter.hasNext()){ sStrAlwLst[iStrAlwLst] = (String) iter.next(); iStrAlwLst++; }

          if (vStr.size() > 1) { strlst = new StoreSelect(sStrAlwLst); }
          else strlst = new StoreSelect(new String[]{sStrAllowed});
       }

       String sStrJsa = strlst.getStrNum();
       String sStrNameJsa = strlst.getStrName();
%>
<html>
<head>		 
	<title>RTV Control Selection</title>
</head>

<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">


<script name="javascript">
var User = "<%=sUser%>";
var Vendor = null;
var VenName = null;
var LastTr = -1;
var LastVen = "";
var Reason = [<%=sReasJva%>];

var ArrStr = [<%=sStrJsa%>];
var ArrStrNm = [<%=sStrNameJsa%>];

//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{    
	rtvVendors()
	setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
  	popStrSelect();  
  	popRtvReason();
}

//==============================================================================
//Load Stores
//==============================================================================
function popStrSelect()
{
	document.all.SelStr.options[0] = new Option("--- Select store ----","NONE");
	for (idx = 1; idx < ArrStr.length; idx++)
 	{
   		document.all.SelStr.options[idx] = new Option(ArrStr[idx] + " - " + ArrStrNm[idx],ArrStr[idx]);
 	}
}
//==============================================================================
// retreive vendors
//==============================================================================
function rtvVendors()
{
   if (Vendor==null)
   {
      var url = "RetreiveVendorList.jsp"
      //alert(url);
      //window.location.href = url;
      window.frame1.location = url;
   }
   else { document.all.dvVendor.style.visibility = "visible"; }
}
//==============================================================================
// popilate division selection
//==============================================================================
function showVendors(ven, venName)
{
   Vendor = ven;
   VenName = venName;
   var html = "<input name='FndVen' class='Small' size=4 maxlength=4>&nbsp;"
     + "<input name='FndVenName' class='Small1' size=25 maxlength=25>&nbsp;"
     + "<button onclick='findSelVen()' class='Small'>Find</button>&nbsp;"
     + "<button onclick='document.all.dvVendor.style.visibility=&#34;hidden&#34;' class='Small'>Close</button><br>"
   var dummy = "<table>"

   html += "<div id='dvInt' class='dvInternal1'>"
         + "<table border=0 width='100%' cellPadding=0 cellSpacing=0 style='font-size:10px;'>"
   for(var i=0; i < ven.length; i++)
   {
     html += "<tr id='trVen'><td style='cursor:default;' onclick='javascript: showVenSelect(&#34;" + ven[i] + "&#34;, &#34;" + venName[i] + "&#34;)'>" + venName[i] + "</td></tr>"
   }
   html += "</table></div>"
   var pos = objPosition(document.all.VenName)

   document.all.dvVendor.innerHTML = html;
   document.all.dvVendor.style.pixelLeft= pos[0];
   document.all.dvVendor.style.height = "70px";
   document.all.dvVendor.style.pixelTop= pos[1] + 25;
   document.all.dvVendor.style.visibility = "visible";
}
//==============================================================================
//find selected vendor
//==============================================================================
function popRtvReason()
{
	document.all.SelReas.options[0] = new Option("--- Select Reason ---", "NONE");
	for (var i = 0; i < Reason.length; i++)
	{
		document.all.SelReas.options[i+1] = new Option(Reason[i], Reason[i]);
	}
}
//==============================================================================
// find selected vendor
//==============================================================================
function findSelVen()
{
  var ven = document.all.FndVen.value.trim().toUpperCase();
  var vennm = document.all.FndVenName.value.trim().toUpperCase();
  var dvVen = document.all.dvVendor
  var fnd = false;

  // zeroed last search
  if(ven != "" && ven != " " || LastVen != vennm) LastTr=-1;
  LastVen = vennm;

  for(var i=LastTr+1; i < Vendor.length; i++)
  {
     if(ven != "" && ven != " " && ven == Vendor[i]) {  fnd = true; LastTr=i; break}
     else if(vennm != "" && vennm != " " && VenName[i].indexOf(vennm) >= 0) { fnd = true; LastTr=i; break}
     document.all.trVen[i].style.color="black";
  }

  // if found set value and scroll div to the found record
  if(fnd)
  {
     var pos = document.all.trVen[LastTr].offsetTop;
     document.all.trVen[LastTr].style.color="red";
     dvInt.scrollTop=pos;
  }
  else { LastTr=-1; }
}
//==============================================================================
// show selected Department Selected
//==============================================================================
function showVenSelect(ven, vennm)
{
   document.all.VenName.value = vennm
   document.all.Ven.value = ven
}

//==============================================================================
// find object postition
//==============================================================================
function objPosition(obj)
{
   var pos = new Array(2);
   pos[0] = 0;
   pos[1] = 0;
   // position menu on the screen
   if (obj.offsetParent)
   {
     while (obj.offsetParent)
     {
       pos[0] += obj.offsetLeft
       pos[1] += obj.offsetTop
       obj = obj.offsetParent;
     }
   }
   else if (obj.x)
   {
     pos[0] += obj.x;
     pos[1] += obj.y;
   }
   return pos;
}
//==============================================================================
// show date selection
//==============================================================================
function showDates(type)
{
   if(type==1)
   {
     document.all.tdDate1.style.display="none"
     document.all.tdDate2.style.display="block"
   }
   else
   {
     document.all.tdDate1.style.display="none"
     document.all.tdDate2.style.display="block"
   }
}

//==============================================================================
// Validate form
//==============================================================================
function Validate()
{
  var error = false;
  var msg = "";

  var ven = document.all.Ven.value.trim();
  var vennm = document.all.VenName.value.trim();  
  if(ven=="NONE"){error=true; msg += "\nVendor must be selected for new RTV Control Number";}
  
  var str = document.all.SelStr.options[document.all.SelStr.selectedIndex].value;
  if(str=="NONE"){error=true; msg += "\nStore must be selected for new RTV Control Number";}
  
  var reas = document.all.SelReas.options[document.all.SelReas.selectedIndex].value;
  if(reas=="NONE"){error=true; msg += "\nReason must be selected for new RTV Control Number";}
  
  var bcomm = document.all.BComment.value.trim();
  
  if (error) alert(msg);
  else { sbmCtl(ven, str, "0", reas, bcomm, "ADDCTL"); }
  return error == false;
}
//==============================================================================
// Submit list
//==============================================================================
function sbmCtl(ven, str, ctl, reas, commt, action)
{
	var nwelem = window.frame3.document.createElement("div");
	nwelem.id = "dvSbmCtl";	
		
	var html = "<form name='frmAddCtl'"
   	+ " METHOD=Post ACTION='RtvCtlSv.jsp'>"
   	+ "<input class='Small' name='Ven'>"
   	+ "<input class='Small' name='Str'>"
   	+ "<input class='Small' name='Ctl'>"
   	+ "<input class='Small' name='CtlReas'>"
   	+ "<input class='Small' name='Commt'>"   	
   	+ "<input class='Small' name='Action'>"       
 	+ "</form>"
 	;

	nwelem.innerHTML = html; 
	 
	window.frame3.document.appendChild(nwelem);
	
	window.frame3.document.all.Ven.value=ven;
	window.frame3.document.all.Str.value=str;
	window.frame3.document.all.Ctl.value=ctl;
	window.frame3.document.all.CtlReas.value=reas;
	window.frame3.document.all.Commt.value=commt;
	window.frame3.document.all.Action.value=action;	

	window.frame3.document.frmAddCtl.submit();
}
//==============================================================================
// Set new batch number
//==============================================================================
function setNewBatchNumber(batch, bWhse, bComment)
{
  var selbatch = document.all.Batch;
  var nxtEnt = selbatch.length;
  selbatch.options[nxtEnt] = new Option(batch + " - " + bComment, batch);
  selbatch.selectedIndex = selbatch.length - 1;
  BWhse[BWhse.length] = bWhse;
  if (selbatch.selectedIndex > 0) {Validate(); }
}
//==============================================================================
// close Submitting frame
//==============================================================================
function closeFrame()
{
   window.frame1.close();
   alert("Report has been submitted")
}

//==============================================================================
// open Batch Item List in new Window
//==============================================================================
function openBatchItmWdw()
{
  var batch = document.all.Batch.options[document.all.Batch.selectedIndex].value.trim();
  var comment = document.all.Batch.options[document.all.Batch.selectedIndex].text.trim();
  var bwhse = BWhse[document.all.Batch.selectedIndex-1];

  var url = 'ItemTrfBachItemList.jsp?Batch=' + batch + "&BWhse=" + bwhse + "&BComment=" + comment;
  var WindowName = 'Batch_Item_List';
  var WindowOptions =
     'width=600,height=400, toolbar=yes, location=yes, directories=yes, status=yes, scrollbars=yes,resizable=yes, menubar=yes';

  //alert(url)
  window.open(url, WindowName, WindowOptions);
}
//==============================================================================
// show Batch Button
//==============================================================================
function showBatchButton(sel)
{
   if(sel.selectedIndex > 0)
   {
      document.all.btnOpenWdw.style.visibility='visible'
      document.all.btnDltBatch.style.visibility='visible'
   }
   else
   {
      document.all.btnOpenWdw.style.visibility='hidden'
      document.all.btnDltBatch.style.visibility='hidden'
   }
}
//==============================================================================
// delete Batch number and Items belong to batch
//==============================================================================
function dltBatch()
{
   if(BCrtByUser[document.all.Batch.selectedIndex - 1] == "<%=sUser%>"
      || "<%=sUser%>" == "vrozen" || "<%=sUser%>" == "phelfert")
   {

      var batch = document.all.Batch.options[document.all.Batch.selectedIndex].value.trim();
      var comment = document.all.Batch.options[document.all.Batch.selectedIndex].text.trim();

      var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
        + "<tr>"
          + "<td class='BoxName' nowrap>Batch:" + comment + "</td>"
          + "<td class='BoxClose' valign=top>"
             +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
          + "</td></tr>"
        + "<tr><td class='Prompt' colspan=2>" + popBatch(batch) + "</td></tr></table>"

      document.all.dvItem.innerHTML = html;
      document.all.dvItem.style.pixelLeft=200;
      document.all.dvItem.style.pixelTop=document.documentElement.scrollTop + 100;
      document.all.dvItem.style.visibility = "visible";
   }
   else { alert("This batch is not created by you.\nYou may to delete only your own batch.") }
}
//==============================================================================
// populate batch deletion panel
//==============================================================================
function popBatch(batch)
{
  var panel = "<table border=0 style='font-size:16px; font-weight:bold' width='100%' cellPadding='0' cellSpacing='0'>"
  panel += "<tr><td >Delete selected batch number and all items assign for this batch.</td></tr>"
         + "<tr><td style='color:red;'>Do you want to delete this batch?</td></tr>"

  panel += "<tr><td class='Prompt1' colspan='5'><br>"
        + "<button style='font-size:10px' onClick='sbmBatchDlt(&#34;" + batch + "&#34;);' >Delete</button> &nbsp; &nbsp;"
        + "<button style='font-size:10px' onClick='hidePanel();' >Close</button></td></tr>"

  panel += "</table>";

  return panel;
}
//==============================================================================
// submit control number 
//==============================================================================
function sbmBatchDlt(batch)
{
  var url = 'RtvCtlDtl.jsp?'
    + "Batch=" + batch
    + "&ACTION=DLTBATCH";

    if(confirm("This is a last chance. Are You Sure?????"))
   {
       document.all.btnOpenWdw.style.visibility='hidden';
       document.all.btnDltBatch.style.visibility='hidden';

       //alert(url);
       //window.location.href = url;
       window.frame2.location = url;       
   }

   hidePanel();
}
//==============================================================================
// show RTV List for selected control number   
//==============================================================================
function  showRtvLst(ctl)
{
	var url = "RtvCtlInfo.jsp?Ctl=" + ctl
	window.location.href = url;
}
//==============================================================================
// delete batch number 
//==============================================================================
function dltCtl(i ,ctl, user)
{	
	if(User != user)
	{
		var nm = "tdName" + i;		
		var name = document.all[nm].innerHTML;

	    var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
	        + "<tr>"
	          + "<td class='BoxName' nowrap>Control: " + ctl + "</td>"
	          + "<td class='BoxClose' valign=top>"
	             +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
	          + "</td></tr>"
	        + "<tr><td class='Prompt' colspan=2>" + popCtl(ctl, name) + "</td></tr></table>"

	      document.all.dvItem.innerHTML = html;
	      document.all.dvItem.style.pixelLeft=200;
	      document.all.dvItem.style.pixelTop=document.documentElement.scrollTop + 100;
	      document.all.dvItem.style.visibility = "visible";
	   }
	   else { alert("This batch is not created by you.\nYou may to delete only your own batch.") }
	}
//==============================================================================
// populate batch deletion panel
//==============================================================================
function popCtl(ctl, name)
{
  var panel = "<table border=0 style='font-size:16px; font-weight:bold' width='100%' cellPadding='0' cellSpacing='0'>"
  panel += "<tr><td >Comments: " + name + "</td></tr>"
	  +  "<tr><td >Delete selected control number and all items assign for this control.</td></tr>"
         + "<tr><td style='color:red;'>Do you want to delete this control?</td></tr>"
  panel += "<tr><td class='Prompt1' colspan='5'><br>"
        + "<button style='font-size:10px' onClick='sbmCtlDlt(&#34;" + ctl + "&#34;);' >Delete</button> &nbsp; &nbsp;"
        + "<button style='font-size:10px' onClick='hidePanel();' >Close</button></td></tr>"
  panel += "</table>";

  return panel;
}
//==============================================================================
// submit control deletion
//==============================================================================
function sbmCtlDlt(ctl)
{
	var url = 'RtvCtlSv.jsp?'
  		+ "Ctl=" + ctl
  		+ "&Action=DLTCTL";

  	if(confirm("This is a last chance. Are You Sure?????"))
 	{
     	window.frame2.location = url;     	
 	}

 	hidePanel();
}
//--------------------------------------------------------
// Hide selection screen
//--------------------------------------------------------
function hidePanel()
{
   document.all.dvItem.innerHTML = " ";
   document.all.dvItem.style.visibility = "hidden";
}
</script>


<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript" src="Get_Object_Position.js"></script>



<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe id="frame1" src="" frameborder=0 height="0" width="0"></iframe>
<iframe id="frame2" src="" frameborder=0 height="0" width="0"></iframe>
<iframe id="frame3" src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<!-------------------------------------------------------------------->
<div id="dvVendor" class="dvVendor"></div>
<div id="dvItem" class="dvItem"></div>
<!-------------------------------------------------------------------->

<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR>
    <TD height="20%"><IMG
    src="Sun_ski_logo4.png"></TD></TR>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>RTV Control Number - Selection</B>
        <br><a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;<font size="-1">This Page</font>

      <TABLE>
        <TBODY>
        
        
        <!-- ========================== Vendor ============================== -->
        
        <TR><TD style="text-align:center" colspan=4>Create a new Control number:</TD></tr>          
        <tr>
            <TD class="Cell" >Store:</TD>
            <TD class="Cell1" nowrap>
            	<select class="Small" name="SelStr"></select>
            </TD>
        </tr>        
        <tr>
            <TD class="Cell" >Vendor:</TD>
            <TD class="Cell1" nowrap>
            	<input class="Small" name="VenName" size=50 value="--- Select Vendor ---" readonly>
            	<input class="Small" name="Ven" type="hidden" value="NONE">
           	</TD>           	
        </tr>
        <tr><td><br><br><br><br><br></td></tr>
        <tr>
            <TD class="Cell" >Reason:</TD>
            <TD class="Cell1" nowrap>
            	<select class="Small" name="SelReas"></select>            	            	
           	</TD>           	
        </tr>
        <tr>
        	<TD class="Cell" id="tdComment">Comments:</td>
        	<TD class="Cell1" nowrap>
              <input class="Small" name="BComment" size=100 maxlength=100>              
            </TD>
        </tr>
        <tr>           
        	<TD style="text-align:center;" colspan=2>        	
        	<button onClick="Validate()">Create a New Batch</button><br>
        	</TD>
        </tr>
        <!-- ========================== Control ============================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <tr style="text-align:center">
        	<td colspan=4 style="text-align:center">
        	Select Control Number:<br>
        		<div id="dvCtlExt" style="border: gray solid 1px;
                          width:500; height:150; z-index:10; 
                          text-align:center; font-size:10px">
        		<div id="dvCtlInt" style="text-align:center; width: 499px; height: 149px; overflow: auto; font-size:10px">
        			<table class="tbl02" width=100%>
        			  <tr class="trHdr01">
        				<th class="th02">Control</th>
        				<th class="th02">Store</th>
        				<th class="th02">Vendor</th>
        				<th class="th02">Status</th>        				
        				<th class="th02">Created by user, date and time</th>
        				<th class="th02">comment</th>
        				<th class="th02">Dlt</th>
        		      </tr>
        		       		 
        			  <%for(int i=0; i < sCtl.length; i++){%>
        				<tr class="trDtl06">
        				  <td id="tdCtl<%=i%>" class="td12"><a href="javascript: showRtvLst('<%=sCtl[i]%>')"><%=sCtl[i]%></a></td>
        				  <td id="tdVen<%=i%>" class="td11"><%=sCStr[i]%></td>
        				  <td id="tdVen<%=i%>" class="td11" nowrap><%=sVen[i]%> - <%=sVenNm[i]%></td>
        				  <td id="tdSts<%=i%>" class="td11" nowrap><%=sSts[i]%></td>
        				  <td id="tdUsr<%=i%>" class="td11" nowrap><%=sRecUsr[i]%> <%=sRecDt[i]%> <%=sRecTm[i]%></td>
        				  <td id="tdName<%=i%>" class="td11"  nowrap><%=sName[i]%></td>        	
        				  <td class="td12"><a href="javascript: dltCtl('<%=i%>','<%=sCtl[i]%>', '<%=sRecUsr[i]%>')">D</a></td>			  
        				</tr>  
        			  <%}%>
        			</table>
        		</div>
        		</div>  
        	</td>
        </tr>
        <TR>
         </TBODY>
        </TABLE>
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
<%} %>