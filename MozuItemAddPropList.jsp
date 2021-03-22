<!DOCTYPE html>	
<%@ page import="mozu_com.MozuItemAddPropList, java.util.*, java.text.*"%>
<%
String sSite = request.getParameter("Site");
String sCls = request.getParameter("Cls");
String sVen = request.getParameter("Ven");
String sSty = request.getParameter("Sty");
   
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=MozuItemAddPropList.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	
	boolean bAllowSendToKibo = session.getAttribute("ECSNDATR")!=null;
	String sUser = session.getAttribute("USER").toString();
	
	MozuItemAddPropList proplst = new MozuItemAddPropList();
	proplst.setImageByCVS(sSite, sCls,  sVen,  sSty, sUser);
	
	int iNumOfProp = proplst.getNumOfProp();
	
	String sDesc = proplst.getDesc();
	String sVenNm = proplst.getVenNm();
	int iNumOfClr = proplst.getNumOfClr();
	String [] sClr = proplst.getClr();
	String [] sClrNm = proplst.getClrNm();
	String sProdTy = proplst.getProdTy();
%>
<html>
<head>
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">

<title>Parent Properties</title>

<script type="text/javascript" src="http://code.jquery.com/jquery-1.4.4.min.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

<SCRIPT>

//--------------- Global variables -----------------------
var Cls = "<%=sCls%>";
var Ven = "<%=sVen%>";
var Sty = "<%=sSty%>";

//--------------- End of Global variables ----------------
//==============================================================================
// initial process
//==============================================================================
function bodyLoad()
{
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)) { isSafari = true; }
	setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
}
//==============================================================================
//show fedex data
//==============================================================================
function setPropValue(id, type, prop, attr, arg, ip, ipnum )
{
	var hdr = "Update " + prop
	   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
	     + "<tr>"
	       + "<td class='BoxName' nowrap>" + hdr + "</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
	       + "</td></tr>"
	     + "<tr><td class='Prompt' colspan=2>" + popPropValue(id, type, prop, arg, ip, ipnum )
	       + "</td></tr>"
	     + "</table>"

	  
	  if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvItem.style.width = "700";}
	  else { document.all.dvItem.style.width = "auto";}   
	     
	  document.all.dvItem.innerHTML = html;
	  var posX = (eval(getLeftScreenPos()) + 300) + "px";
	  var posY = (eval(getTopScreenPos()) + 100) + "px";
	  document.all.dvItem.style.left = posX
	  document.all.dvItem.style.top= posY;
	  
	  document.all.dvItem.style.visibility = "visible";
	  
	  var value = document.getElementById("tdProp" + arg).innerHTML;
	  document.all.Prop.value = value.trim();
	  document.all.Id.value = id;
	  document.all.Ip.value = ip;
	  document.all.IpNum.value = ipnum;
	  
	  if(type=="List") { rtvAttrLst(attr); }
	}
	//==============================================================================
	// populate panel
	//==============================================================================
	function popPropValue(id, type, prop, arg, ip, ipnum )
	{		   
	   var panel = "<table class='tbl01' id='tblLog'>"
	    + "<tr>"
	       + "<td class='td08'>";
	    if(type=="List")  
	    { 
	    	panel += "<input name='Prop' maxlength=50 size=50 readOnly>"
	    	 + "<br><br>Select:<select name='selOpt' onchange='setSelProp(this)'></select>"
	    }	    
	    else if(type=="TextB" || type=="TextA" )
	    {
	    	panel += "<TextArea class='Small' name='Prop' cols=100 rows=10></TextArea>";
	    }
	    panel += "<input type='hidden' name='Id'>";
	    panel += "<input type='hidden' name='Ip'>";
	    panel += "<input type='hidden' name='IpNum'>";
	    panel += "</td>";	       
	    panel += "</tr>";  
	    
		panel += "</table> <br/>";
	    panel += "<tr>"
  		  + "<td id='tdError' class='Small' colspan=2 style='color:red;font-size:12px;'></td>"
		   + "</tr>";
		   
	    panel += "</table>"
	        + "<button onClick='vldPropValue();' class='Small'>Save Changes</button>&nbsp; &nbsp;"
	        + "<button onClick='hidePanel();' class='Small'>Close</button>&nbsp;"
	    ;
	        
		return panel;
}
//==============================================================================
//validate new value
//==============================================================================
function vldPropValue()
{
	var error = false;
  	var msg = "";
  	document.all.tdError.innerHTML="";

  	var id = document.all.Id.value.trim();
  	var prop = document.all.Prop.value;
  	var i = prop.indexOf("\n");  
  	prop = prop.replace(/\n/g, "\\n");
  	
  	if(error){ document.all.tdError.innerHTML=msg; }
  	else{ sbmPropValue(id, prop); }
}
//==============================================================================
//submit store status changes
//==============================================================================
function sbmPropValue(id, prop)
{
	
  	var nwelem = window.frame1.document.createElement("div");
  	nwelem.id = "dvSbmStrSts"
  	
  	var html = "<form name='frmItmProp'"
     + " METHOD=Post ACTION='MozuParentSave.jsp'>"
     + "<input name='Site'>"
     + "<input name='Cls'>"
     + "<input name='Ven'>"
     + "<input name='Sty'>"
     + "<input name='Id'>"
     + "<input name='Prop'>"       
     + "<input name='Action'>"

  	html += "</form>"
  	
  		
  	nwelem.innerHTML = html;
  	window.frame1.document.body.appendChild(nwelem);

  	window.frame1.document.all.Cls.value = Cls;
  	window.frame1.document.all.Ven.value = Ven;
  	window.frame1.document.all.Sty.value = Sty;
  	window.frame1.document.all.Id.value = id;
  	window.frame1.document.all.Prop.value = prop;
  	window.frame1.document.all.Site.value = "<%=sSite%>";
  	window.frame1.document.all.Action.value="SvItemProp";
  
  	window.frame1.document.frmItmProp.submit();
}
//==============================================================================
//retreive attribute list
//==============================================================================
function rtvAttrLst(attr)
{
	var parent = "NONE";
	//if(document.all.Ip.value.trim() != ""){ parent= Cls + Ven + Sty; }
	parent= Cls + Ven + Sty;
	var url = "MozuAttrList.jsp?Parent=" + parent
	  + "&Attr=" + attr
	  + "&Site=<%=sSite%>"
	;
	window.frame1.location.href = url;
}
//==============================================================================
//show otpion selection list
//==============================================================================
function showAttr(attr, opts, optnms, prodty, ptid)
{
    var sel = document.all.selOpt;
    sel.options[0] = new Option("----select option -----", " ");
    for(var i=0, j=1; i < opts.length;i++, j++)
    {
    	optnms[i] = optnms[i].replace(/&#39;/g, "'"); 
    	sel.options[j] = new Option(optnms[i], opts[i]);
    }
}
//==============================================================================
// set selected option in input fileds
//==============================================================================
function setSelProp(sel)
{
	//document.all.Prop.value = sel.options[sel.selectedIndex].value;
	document.all.Prop.value = sel.options[sel.selectedIndex].text;
}
//==============================================================================
//Hide selection screen
//==============================================================================
function hidePanel()
{
	document.all.dvItem.innerHTML = " ";
	document.all.dvItem.style.visibility = "hidden";
}
//==============================================================================
// send Item to Kibo 
//==============================================================================
function sendToKibo()
{
	url = "MozuParentSave.jsp?Site=<%=sSite%>" 
     + "&Cls=<%=sCls%>"
     + "&Ven=<%=sVen%>"
     + "&Sty=<%=sSty%>"
     + "&Action=SendAddPropKibo"
     ;
    window.frame1.location.href=url; 
}

//==============================================================================
//send Item to Kibo 
//==============================================================================
function moveTo(id, action)
{
	url = "MozuParentSave.jsp?Site=<%=sSite%>" 
	  + "&Cls=<%=sCls%>"
	  + "&Ven=<%=sVen%>"
	  + "&Sty=<%=sSty%>"
	  + "&Id=" + id
	  + "&Action=" + action
	;
	window.frame1.location.href=url; 
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
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->

<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table class="tbl01">
        <tr class="trHdr">
          <th colspan=45>
            Retail Concepts, Inc
            <br>Mozu - Item Parent Additional Properties
            <br>Item: <%=sCls%>-<%=sVen%>-<%=sSty%>            
            <br>
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;
              <font size="-1">This Page.</font>
              <%if(bAllowSendToKibo){%>
              	&nbsp; &nbsp; &nbsp; &nbsp;
              	<a href="javascript: sendToKibo()">Update Attributes</a>
              <%}%>            
          </th>
        </tr>
        <tr >
          <td align="center">>  
       <!-- ======================================================================= -->
       <table border=0 cellPadding="0" cellSpacing="0" >
         <tr class="trDtl33">
             <th>Description: &nbsp; &nbsp; &nbsp; </th>
             <td><%=sDesc%></td>
             <th> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</th>
			 <th>Vendor Name: &nbsp; &nbsp; &nbsp; </th>
             <td><%=sVenNm%></td>
             <th> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</th>
			 <th>Product Type: &nbsp; &nbsp; &nbsp; </th>
             <td><%=sProdTy%></td>
             
         </tr>         
         <tr class="trDtl33">
            <th align="left">Colors: &nbsp; &nbsp; &nbsp; </th>
         	<td colspan=7 align=left >
         	<table border=0 cellPadding="0" cellSpacing="0">         	
         	   <%for(int i=0; i < iNumOfClr; i++){%>
         	   		<tr class="DataTable1">
         	     		<td><%=sClrNm[i]%></td>
         	   		</tr>
         	   <%}%>
         	</table>
         	
         	</td>
         </tr>
        </table><br>
          
      <!-- ======================================================================= -->    
          
          
      <table class="tbl02">
<!------------------------------- Detail --------------------------------->
			
           <%boolean bIpAttr = false; %>
           <%boolean bEcPTAttr = false; %>
           <%for(int i=0; i < iNumOfProp; i++) {
        	    proplst.getProperty();
   				String sPropId  = proplst.getPropId ();
   				String sType = proplst.getType();
   				String sName = proplst.getName();	
   				String sAttr = proplst.getAttr();
   				String sIpAttr = proplst.getIpAttr();
   				String sIpAttrNum = proplst.getIpAttrNum();
   				String sIpAttrLvl = proplst.getIpAttrLvl();
   				
   				proplst.setItemProp(sPropId);
    			int iNumOfVal = proplst.getNumOfVal();
    			String [] sValue = proplst.getValue();
    			String sLine = "";
    			for(int j=0; j < iNumOfVal; j++) {sLine += sValue[j]; }
    			//sLine = sLine.replaceAll("'", "ft");    			
    			String sLine1 = sLine.replaceAll("(\\\\r\\\\n|\\\\n)", "<br>");
    			sLine = sLine.replaceAll("\"", "in");
    			
    			proplst.setIpAttValue();
    			String sIpAttrValue = proplst.getIpAttrValue();  
    			if(!sIpAttrValue.trim().equals("")){ sLine1 = sIpAttrValue; }
    			
    			String sIpCons01 = proplst.getIpCons01();
    			String sIpCons02 = proplst.getIpCons02();
    			String sClr01 = "style='background: #efefef;'";
    			if(sIpCons01.equals("Y")){ sClr01 = "style='background: pink'";}
    			String sClr02 = "";
    			if(sIpCons02.equals("Y")){ sClr02 = "style='background: pink'";}
    			
    			String sIpOrig = proplst.getIpOrig();
           %>
              <%if(i==0){%>
              	<tr id="trId" class="trDtl03">
                	<th colspan="10" class="th01" nowrap>&nbsp;<br>ECOM custom attributes to KIBO<br>Base</th>
                </tr>
                <tr id="trId" class="trDtl03">
              		<th class="th01">No.</th>
              		<th class="th01">Type</th>
              		<th class="th01">Chg</th>
              		<th class="th01">Attr<br>Name</th>
              		<th class="th01">ECOM<br>Value</th>
              		<th class="th01">&nbsp;</th>
              		<th class="th01">&nbsp;</th>
              		<th class="th01">&nbsp;</th>
              		<th class="th01">&nbsp;</th>
              		<th class="th01">Child<br>Level</th>              
            	</tr>    
              <%}%>
              <%if(!bEcPTAttr && sIpAttr.equals("P")){%>
              	<tr id="trId" class="trDtl03">
                	<th colspan="10" class="th01" nowrap>&nbsp;<br>ECOM custom attributes to KIBO<br>Product Specific</th>
                </tr>
              <%}%>
              
              <%if(!bIpAttr && sIpAttr.equals("Y")){%>
              	<tr id="trId" class="trDtl03">
                	<th colspan="10" class="th01" nowrap>&nbsp;<br>IP attributes to KIBO
                   	      <br>ECOM To IP <button class="Small" style="padding: 0px;" onclick="moveTo('ALL', 'MoveToIp')">>></button>
                   	          &nbsp; &nbsp; ALL &nbsp; &nbsp;
                   	          <button class="Small" style="padding: 0px;" onclick="moveTo('ALL', 'MoveToEcom')"><<</button>
                   	          IP to ECOM
                	</th>
                </tr>
                <tr id="trId" class="trDtl03">
                  	<th class="th01">No.</th>
              		<th class="th01">Type</th>
              		<th class="th01">Chg</th>
              		<th class="th01">Attr<br>Name</th>
              		<th class="th01">ECOM<br>Value</th>
              		<th class="th01">ECOM<br>to<br>IP</th>
              		<th class="th01">IP<br>to<br>ECOM</th>
              		<th class="th01">IP Value<br>(for IP only)</th>
              		<th class="th01">Conflicts</th>
              		<th class="th01">Child<br>Level</th>              
              </tr>    
              <%}%>
              <tr id="trId" class="trDtl04">
                <th class="th01" nowrap><%=i+1%></th>
                <th class="th01" nowrap><%=sType%></th>
                <th class="th01" nowrap>&nbsp;&nbsp;
                    <%if(!sIpAttrLvl.equals("C")){%>
                		<a href="javascript: setPropValue('<%=sPropId%>', '<%=sType%>','<%=sName%>', '<%=sAttr%>','<%=i%>', '<%=sIpAttr%>', '<%=sIpAttrNum%>')">Upd</a>&nbsp;&nbsp;
                	<%}%>
                </th>
                <th class="th30" nowrap><%=sName%></th>                          
                <td class="td02" id="tdProp<%=i%>" <%=sClr02%> ><%=sLine1%></td>
                
                <td class="td02" id="tdProp<%=i%>">&nbsp;
                	<%if(sIpAttr.equals("Y") && !sLine1.trim().equals("") && sIpCons02.equals("Y")){%>                	
                    	<button class="Small" style="padding: 0px;" onclick="moveTo('<%=sPropId%>', 'MoveToIp')">></button>
                  	<%}%>
                  	&nbsp;
                </td>
                
                <td class="td02" id="tdProp<%=i%>" style='background: #efefef;'>&nbsp;
                	<%if(!sIpOrig.equals("")){%>
                    	<button class="Small" style="padding: 0px;" onclick="moveTo('<%=sPropId%>', 'MoveToEcom')"><</button>
                  	<%}%>
                  	&nbsp;
                </td>
                
                <td class="td02" nowrap <%=sClr01%> ><%=sIpOrig%></td>
                <td class="td02" nowrap <%=sClr01%>>
                	<%if(sIpCons01.equals("Y") || sIpCons02.equals("Y")){%>Varies<%}%>
                	<%if(sIpCons01.equals("Y")){%>&nbsp;At Item Level<%}%>
                </td>
                <td class="td03" id="tdProp<%=i%>" style='background: #efefef;'><%if(sIpAttrLvl.equals("C")){%>Y<%}%></td>
              </tr>
              
              <%bIpAttr = sIpAttr.equals("Y");%>
              <%bEcPTAttr = sIpAttr.equals("P");%>
           <%}%>
             
           <tr id="trId" class="trDtl04">
           <td class="td02" colspan="10">  
             <br>Notes:<br>
				    Use <button class="Small"  style="padding: 0px;"><</button> or <button class="Small"  style="padding: 0px;">></button> arrows to populate attributes to/from ECOM (RCI) and IP to get attributes back in SYNC.
				<br><span style="background: pink">PINK</span> highlighted columns indicate inconsistencies between ECOM (RCI) and IP attributes.
				<br>Conflict column will display 'At Item level' - when CHILD level attributes exist in IP.
               </td>
             </tr>
         </table>
      <!----------------------- end of table ------------------------>
      </tr>
   </table>
   <br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;
 </body>
</html>
<%
proplst.disconnect();
proplst = null;
}
%>