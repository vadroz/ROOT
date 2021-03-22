<%@ page import="ecommerce.EcomMrkInvGrpVol, java.util.*"%>
<%
String sSelMrk = request.getParameter("Mrk");
String sSelDiv = request.getParameter("Div");

if(sSelMrk == null){ sSelMrk = "ALL";}  
if(sSelDiv == null){ sSelDiv = "ALL";}

//-------------- Security ---------------------
if (session.getAttribute("USER")==null)
{
    response.sendRedirect("SignOn1.jsp?TARGET=EcomMrkInvGrpVol.jsp");
}
else
{
    String sMrkAllowed = session.getAttribute("STORE").toString();
    String sUser = session.getAttribute("USER").toString();
    EcomMrkInvGrpVol strinvl = new EcomMrkInvGrpVol(sSelMrk, sSelDiv, sUser);

    int iNumOfGrp = strinvl.getNumOfGrp();

    int iNumOfMrk = strinvl.getNumOfMrk();
    String [] sMrkLst = strinvl.getMrkLst();
    String [] sMrkNmLst = strinvl.getMrkNmLst();
    String sMrkLstJsa = strinvl.getMrkLstJsa();    
    
    int iNumOfPrf = strinvl.getNumOfPrf();
    String [] sProfLst = strinvl.getProfLst();
    String [] sMinQtyLst = strinvl.getMinQtyLst();
    String [] sMinAmtLst = strinvl.getMinAmtLst();
    String [] sFflPrcLst = strinvl.getFflPrcLst();

    String sProfLstJsa = strinvl.getProfLstJsa();
    String sMinQtyLstJsa = strinvl.getMinQtyLstJsa();
    String sMinAmtLstJsa = strinvl.getMinAmtLstJsa();
    String sFflPrcLstJsa = strinvl.getFflPrcLstJsa();
%>

<html>
<head>
<title>EC-Inclusion Tool</title>

<style>body {background:ivory;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { text-align:center;}
        th.DataTable { background:#FFCC99;padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px; 
                       text-align:center; font-family:Verdanda; font-size:12px }

        th.InvData { background:#FFCC99;padding-top:3px; padding-bottom:3px;text-align:center; font-family:Verdanda; font-size:12px }
        td.InvData { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:right;}


        tr.DataTable { background:#ececec; font-family:Arial; font-size:12px }
        tr.DataTable0 { color: red; font-size:12px }
        tr.DataTable1 { background:Seashell; font-family:Arial; font-size:12px }
        tr.DataTable2 { background:Honeydew; font-family:Arial; font-size:12px }
        tr.DataTable3 { background:CornSilk; font-family:Arial; font-size:12px }
        tr.DataTable4 { background:darkred;}
        tr.DataTable5 { background:Azure; font-family:Arial; font-size:12px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px;text-align:center;}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px;text-align:left;}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px;text-align:right;}

        div.dvItem { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:250; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
        td.Prompt3 { text-align:left; vertical-align:midle; font-family:Arial; font-size:10px; }

        .Small {font-size:10px }
        span.spnSup{ color:green; vertical-align: super; font-size: 8px}

</style>
<script>
//--------------- Global variables -----------------------
var StrLst = [<%=sMrkLstJsa%>];
var ProfLst = [<%=sProfLstJsa%>];
var MinQtyLst = [<%=sMinQtyLstJsa%>];
var MinAmtLst = [<%=sMinAmtLstJsa%>];
var FflPrcLst = [<%=sFflPrcLstJsa%>];
//--------------- End of Global variables ----------------

function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
}
//==============================================================================
//submit single Item
//==============================================================================
function chgMrkGrp(div, mrk, exists, profile, qty, amt, prc, action)
{
	var hdr = "Add/Update Profile or Qty/Amt";
   	
   	var html = "<table border=1 width='100%' cellPadding=0 cellSpacing=0>"
  	   + "<tr>"
	       + "<td class='BoxName' nowrap>" + hdr + "</td>"
  	     + "<td class='BoxClose' valign=top>"
 	         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel(&#34;dvItem&#34;); hidePanel(&#34;dvItem&#34;);' alt='Close'>"
 	      + "</td></tr>"
	   html += "<tr><td class='Prompt' colspan=2>"

	   html += popStrGrpPanel(div, mrk, exists, profile, qty, amt, prc, action)

		html += "</td></tr></table>"

	document.all.dvItem.innerHTML = html;
	document.all.dvItem.style.width = 150;
	document.all.dvItem.style.pixelLeft= document.documentElement.scrollLeft + 200;
	document.all.dvItem.style.pixelTop= document.documentElement.scrollTop + 100;
	document.all.dvItem.style.visibility = "visible";
    
	if(action != "STR_UPD")
	{	
	    document.all.Profile.value = profile;
	    if(exists=="1" && profile == "")
	    {
	       document.all.MinQty.value = qty;
	       document.all.MinAmt.value = amt;
	       document.all.Prc.value = prc;
	    }
	}
	setProfSelList();
}
//==============================================================================
// set Profile Selection 
//==============================================================================
function setProfSelList()
{
	document.all.selProfLst.options[0] = new Option("--- select Profile ---"," ");
	for(var i=0, j=1; i < ProfLst.length; i++, j++)
	{
		document.all.selProfLst.options[j] = new Option(ProfLst[i] + " ==> " + MinQtyLst[i] + "/" + MinAmtLst[i],ProfLst[i]); 
	}
}
//==============================================================================
// set selected profile in profile 
//==============================================================================
function setSelProf(sel)
{
	document.all.Profile.value = sel.options[sel.selectedIndex].value;	
}
//==============================================================================
//populate Marked Item Panel
//==============================================================================
function popStrGrpPanel(div, mrk, exists, profile, qty, amt, prc, action)
{	
	var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>";
	panel += "<tr class='DataTable1'>"	
	   if(div != '0'){ panel += "<td class='DataTable1'>Division:</td><td class='DataTable1'>"+ div + "</td>"}	
	panel += "</tr>"
	
    panel += "<tr class='DataTable2'>"
    	 + "<td class='DataTable1' nowrap>Profile</td>"
         + "<td class='DataTable1' nowrap><input name='Profile' maxlength=1 size=1></td>"
         + "<td class='DataTable1' nowrap rowspan='3'>" 
            + " &nbsp; <select name='selProfLst' onchange='setSelProf(this)' size=3></select>"
      + "</td>"
       + "</tr>"  
       + "<tr class='DataTable2'>"   
         + "<td class='DataTable1' nowrap>Minimum Quantity: </td>"
         + "<td class='DataTable1' nowrap><input name='MinQty' maxlength=9 size=9></td>"
       + "</tr>"
       + "<tr class='DataTable2'>"  
         + "<td class='DataTable1' nowrap>Minimum Amount: </td>"
         + "<td class='DataTable1' nowrap><input name='MinAmt' maxlength=10 size=10></td>"         
       + "</tr>"
       + "<tr class='DataTable2'>"  
         + "<td class='DataTable1' nowrap>Percent: </td>"
         + "<td class='DataTable1' nowrap><input name='Prc' maxlength=3 size=3></td>"         
     + "</tr>"
       
    panel += "<tr class='DataTable0'>"
      	 + "<td class='DTError' nowrap id='tdError' colspan=2></td>"
      	+ "</tr>"  
       
    panel += "<tr class='DataTable1'><td class='Prompt1' colspan=7>"
       + "<button onClick='vldStrGrp(&#34;" + div + "&#34;,&#34;" + mrk 
            + "&#34;,&#34;" + action + "&#34;)' class='Small'>Submit</button> &nbsp; &nbsp;"
    if(exists=='1')
    {
    	panel += "<button onClick='vldStrGrp(&#34;" + div + "&#34;,&#34;" + mrk + "&#34;,&#34;Remove&#34;)' class='Small'>Remove</button> &nbsp; &nbsp;"
    }
    panel += "<button onClick='hidePanel(&#34;dvItem&#34;); hidePanel(&#34;dvItem&#34;);' class='Small'>Close</button> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;"
       + "</td>"
     + "</tr>"

panel += "</table>";

return panel;
}
//==============================================================================
//validate Store/group inventory entry
//==============================================================================
function vldStrGrp(div, mrk, action)
{
	var error=false;
	var msg = "";
	document.all.tdError.innerHTML = "";
	var br = "";
	var prof = "";
	var qty = "";
	var amt = "";
	var prc = "";
	    
	if(action != "Remove")
	{	
		prof = document.all.Profile.value.trim();
		
		qty = document.all.MinQty.value.trim();
		if(isNaN(qty)){error=true; msg += br + "The Minimum Quantity must be numeric."; br="<br>";}
		else if(eval(qty) < 0){error=true; msg += br + "The Minimum Quantity cannot be negative."; br="<br>";}
	
		amt = document.all.MinAmt.value.trim();	
		if(isNaN(amt)){error=true; msg += br + "The Minimum Amount must be numeric."; br="<br>";}
		else if(eval(amt) < 0){error=true; msg += br + "The Minimum Amount cannot be negative."; br="<br>";}
		else if(eval(amt) > 9999999.99){ amt = 9999999.99 }
		
		prc = document.all.Prc.value.trim();	
		if(isNaN(prc)){error=true; msg += br + "The percent must be numeric."; br="<br>";}
		else if(eval(prc) < 0){error=true; msg += br + "The percent cannot be negative."; br="<br>";}		
	
		if(prof=="" && qty=="" && amt==""){error=true; msg += br + "Profile or Qty/Amt must be populated."; br="<br>";}
		else if(prof!="" && (qty!="" || amt!="")){error=true; msg += br + "Profile and Qty/Amt cannot be populated together."; br="<br>";}
		else if(prof=="" && qty=="" && amt!=""){error=true; msg += br + "Minimum Quantity cannot be blank."; br="<br>";}
		if(prof=="" && qty!="" && amt==""){error=true; msg += br + "Minimum Amount cannot be blank."; br="<br>";}
	}
	
	if(error){ document.all.tdError.innerHTML = msg; }
	else{ sbmStrGrp(div, mrk, prof, qty, amt, prc, action); }
}
//==============================================================================
// submit single Item
//==============================================================================
function sbmStrGrp(div, mrk, prof, qty, amt, prc, action)
{
   var url = "EcomMrkInvGrpVolSv.jsp?"
       + "Div=" + div
       + "&Mrk=" + mrk
       + "&Prof=" + prof
       + "&Qty=" + qty       
       + "&Amt=" + amt
       + "&Prc=" + prc
       + "&Action=" + action;

   //alert(url);
   //window.location.href = url;
   window.frame1.location.href = url;
}
//==============================================================================
//Hide selection screen
//==============================================================================
function hidePanel(obj)
{
	document.all[obj].innerHTML = " ";
	document.all[obj].style.visibility = "hidden";
}
//==============================================================================
// display entry error
//==============================================================================
function dispError(err){document.all.tdError.innerHTML = msg;}
//==============================================================================
// reload page
//==============================================================================
function restart(){ window.location.reload(); }
//==============================================================================
// change color for updated lines
//==============================================================================
function chgColor(obj)
{
   obj.style.background = "yellow"

   // position menu on the screen
   while (obj.offsetParent)
   {
       if (obj.tagName.toLowerCase() == "td"){ break; }
       obj = obj.offsetParent;
    }

    var trName = "trSku" + obj.id.substring(5);
    document.all[trName].style.background = "pink"
}

//==============================================================================
// hilight line
//==============================================================================
function hiliLine(obj)
{
   var color = "#ececec";
   if(obj.style.background != "yellow")
   {
      color = "yellow";
   }
   obj.style.background = color;
}

</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>

</head>
<body onload="bodyLoad()">

<!----------------------------------------------------------------------------->
<div id="dvItem" class="dvItem"></div>
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!----------------------------------------------------------------------------->

<form action="mailto:vrozen@retailconcepts.cc" method="post" enctype="application/vnd.ms-excel" >
    <table border="0" width="100%" height="100%" cellPadding="0" cellSpacing="0">
     <tr bgColor="moccasin">
<!-------------------------------------------------------------------->
      <td ALIGN="center" VALIGN="TOP" nowrap>
      <b>Retail Concepts, Inc
      <br>Included Market Inventory (Stock/Price)
      <br></b>
      <a href="/"><font color="red" size="-1">Home</font></a>&#62;
      <a href="EcomMrkInvGrpVol.jsp"><font color="red" size="-1">All Divisions</font></a>&#62;
          <font size="-1">This Page.</font> &nbsp; &nbsp; &nbsp;
<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table border=1 class="DataTable" id="tbSku" cellPadding="0" cellSpacing="0">
        <tr>
          <th class="DataTable" rowspan=3>Div</th>
          <th class="DataTable" colspan="<%=iNumOfMrk%>">Store</th>          
        </tr>
        <tr>
          <%for(int i=0; i < iNumOfMrk; i++){%>
             <th class="DataTable">
               <%if(!sMrkLst[i].equals("0")){%><%=sMrkLst[i]%><br><%=sMrkNmLst[i]%><%}
               else {%>Company<br>Level<%}%>
             </th>
          <%}%>
        </tr>
        <tr>
          <%for(int i=0; i < iNumOfMrk; i++){%>
               <th class="DataTable"><a href="javascript: 
               chgMrkGrp('<%=sSelDiv%>', '<%=sMrkLst[i]%>', '0', null,null,null,null,'STR_UPD')">Chg</a></th>           
          <%}%>   
        </tr>
<!------------------------------- Data Detail --------------------------------->
           <%for(int i=0; i < iNumOfGrp; i++){
        	   strinvl.setSkuFromStore();
               String sDiv = strinvl.getDiv();
               String [] sProfile = strinvl.getProfile();
               String [] sQty = strinvl.getQty();
               String [] sAmt = strinvl.getAmt();
               String [] sPrc = strinvl.getPrc();
               String [] sMrk = strinvl.getMrk();
           %>
              <tr class="DataTable" id="trSku<%=i%>" onclick="hiliLine(this)">
                <td class="DataTable2" nowrap>&nbsp;<%=sDiv%></td>
                
                <%for(int j=0; j < iNumOfMrk; j++){%>
                   <td class="DataTable" id="tdSku<%=i%>" nowrap>
                       <a href="javascript: chgMrkGrp('<%=sDiv%>', '<%=sMrkLst[j]%>','<%=sMrk[j]%>', '<%=sProfile[j]%>','<%=sQty[j]%>','<%=sAmt[j]%>','<%=sPrc[j]%>','Add_Upd')">
                         <%if(sMrk[j].equals("1")){%>
                            <%if(!sProfile[j].equals("")){%><%=sProfile[j]%><%} 
                            else {%><%=sQty[j]%>/$<%=sAmt[j]%>/<%=sPrc[j]%>%<%}%>
                         <%} else {%>none<%}%>
                     </a>
                   </td>                   
                <%}%>                
              </tr>
           <%}%>
      </table>
     </td>
    </tr>
  <!----------------------- end of table ------------------------>
  </table>
 </form>
 </body>
</html>


<%
strinvl.disconnect();
strinvl = null;
}%>