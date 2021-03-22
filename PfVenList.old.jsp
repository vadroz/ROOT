<!DOCTYPE html>	
<%@ page import="rciutility.RunSQLStmt, java.text.SimpleDateFormat, java.sql.*, java.util.*, java.text.*"%>
<%
   
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=EcProdSum.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	
	int iNumOfItm = 0;   
	   
	boolean bKiosk = session.getAttribute("USER") == null;
	String sUser = "KIOSK";
	if(!bKiosk) { sUser = session.getAttribute("USER").toString(); }

	ResultSet rslset = null;
	RunSQLStmt runsql = new RunSQLStmt();


    String sPrepStmt = "select VPVEN,VPNAME,VPACCT,VPCLAIM,VPEMAIL,VPCFORM"
      + ", VPMAIN1, VPMEMAIL"
      + ",VPCONT,VPCPHON1,VPCPHON2,VPCEMAIL" 
      + ",VPREP,VPRPHON1,VPRPHON2,VPREMAIL" 
      + ",VPRUSER,VPRDATE,VPRTIME"
      + " from rci.PatVenP"      
      + " order by VpName";

    //System.out.println(sPrepStmt);

    SimpleDateFormat sdfISO = new SimpleDateFormat("yyyy-MM-dd");
    SimpleDateFormat sdfUSA = new SimpleDateFormat("MM/dd/yyyy");

    
    runsql.setPrepStmt(sPrepStmt);
    runsql.runQuery();
    
    Vector vVen = new Vector();
    Vector vName = new Vector();
    Vector vAcct = new Vector();
    Vector vClaim = new Vector();
    Vector vClmEMail = new Vector();
    Vector vClmForm = new Vector();
    Vector vMainPhn = new Vector();    
    Vector vMainEMail = new Vector();
    Vector vContNm = new Vector();
    Vector vContPhn1 = new Vector();
    Vector vContPhn2 = new Vector();
    Vector vContEMail = new Vector();
    Vector vRepNm = new Vector();
    Vector vRepPhn1 = new Vector();
    Vector vRepPhn2 = new Vector();
    Vector vRepEMail = new Vector();
    Vector vRecUser = new Vector();
    
    Vector vRcdDt = new Vector();
    
    while(runsql.readNextRecord())
    {       
       vVen.add(runsql.getData("VPVEN").trim());
       vName.add(runsql.getData("VPNAME").trim());
       vAcct.add(runsql.getData("VPACCT").trim());
       vClaim.add(runsql.getData("VPCLAIM").trim());
       vClmEMail.add(runsql.getData("VPEMAIL").trim());
       vClmForm.add(runsql.getData("VPCFORM").trim());
       vMainPhn.add(runsql.getData("VPMAIN1").trim());
       vMainEMail.add(runsql.getData("VPMEMAIL").trim());
       vContNm.add(runsql.getData("VPCONT").trim());
       vContPhn1.add(runsql.getData("VPCPHON1").trim());
       vContPhn2.add(runsql.getData("VPCPHON2").trim());
       vContEMail.add(runsql.getData("VPCEMAIL").trim());
       vRepNm.add(runsql.getData("VPREP").trim());
       vRepPhn1.add(runsql.getData("VPRPHON1").trim());
       vRepPhn2.add(runsql.getData("VPRPHON2").trim());
       vRepEMail.add(runsql.getData("VPREMAIL").trim());
       vRecUser.add(runsql.getData("VPRUSER").trim());
       java.util.Date dWkend = sdfISO.parse(runsql.getData("VPRDATE"));
       vRcdDt.add(sdfUSA.format(dWkend));
    }
	    
	    runsql.disconnect();
	    runsql = null;
%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10" />
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">

<title>Patio Vendor</title>
<!-- script src="String_Trim_function.js"></script -->
<SCRIPT>

//--------------- Global variables -----------------------
var Vendor = null;
var VenName = null;
var LastTr = -1;
var LastVen = "";

var ArrVen = new Array();
//--------------- End of Global variables ----------------
//==============================================================================
// initial process
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);    
}

//==============================================================================
//retreive vendors
//==============================================================================
function rtvVendors()
{
	if (Vendor==null){
		var url = "RetreiveVendorList.jsp"
		window.frame1.location = url;
    }
	else { document.all.dvVendor.style.visibility = "visible"; }
}
//==============================================================================
//popilate division selection
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

	html += "<div id='dvInt' class='dvInternal'>"
      + "<table border=0 width='100%' cellPadding=0 cellSpacing=0 style='font-size:10px;'>"
	for(var i=0; i < ven.length; i++)
	{
  		html += "<tr id='trVen'><td style='cursor:default;' onclick='javascript: addNewVen(&#34;" + ven[i] + "&#34;, &#34;" + venName[i] + "&#34;)'>" + venName[i] + "</td></tr>"
	}
	html += "</table></div>"

	document.all.dvVendor.innerHTML = html;
	document.all.dvVendor.style.pixelLeft= 200;
	document.all.dvVendor.style.pixelTop= 100;
	document.all.dvVendor.style.visibility = "visible";
}
//==============================================================================
//find selected vendor
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
  		if(ven != "" && ven != " " && ven == Vendor[i]) { fnd = true; LastTr=i; break}
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
// add new vendor to vendor object
//==============================================================================
function addNewVen(ven, vennm)
{
	var arg = ArrVen.length;
	ArrVen[ArrVen.length] = { ven: ven, venNm:vennm, acct:"", claim:"", claimEMail:"" 
  	  , claimForm:"", mainPhn:"", mainEMail:"", contNm:"", contPhn1:"", contPhn2:""
  	  , contEMail:"", repNm:"", repPhn1:"", repPhn2:"", repEMail:"" }
	 
	showVenSelect(arg, false, "ADD"); 
}
//==============================================================================
//show selected Department Selected  
//==============================================================================
function showVenSelect(arg, exists, action)
{
	document.all.dvVendor.style.visibility = "hidden";
	
	var hdr = "Vendor: " + ArrVen[arg].venNm;
    var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
	     + "<tr>"
	       + "<td class='BoxName' nowrap>" + hdr + "</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
	       + "</td></tr>"
	     + "<tr><td class='Prompt' colspan=2>" + popVendor(action)
	       + "</td></tr>"
	     + "</table>"

	  document.all.dvItem.style.width=600;
	  document.all.dvItem.innerHTML = html;
	  document.all.dvItem.style.pixelLeft=document.documentElement.scrollLeft + 200;
	  document.all.dvItem.style.pixelTop=document.documentElement.scrollTop + 20;
	  document.all.dvItem.style.visibility = "visible";
	  
	  document.all.Ven.value = ArrVen[arg].ven;
	  document.all.VenNm.value = ArrVen[arg].venNm;	 
	  document.all.Acct.value = ArrVen[arg].acct;
	  
	  document.all.Claim.value = ArrVen[arg].claim;
	  document.all.ClaimEMail.value = ArrVen[arg].claimEMail;
	  document.all.ClaimForm.value = ArrVen[arg].claimForm;
	  
	  document.all.MainPhn.value = ArrVen[arg].mainPhn;
	  document.all.MainEMail.value = ArrVen[arg].mainEMail;
	  
	  document.all.Cont.value = ArrVen[arg].contNm;
	  document.all.ContPhn1.value = ArrVen[arg].contPhn1;
	  document.all.ContPhn2.value = ArrVen[arg].contPhn2;
	  document.all.ContEMail.value = ArrVen[arg].contEMail;
	  
	  document.all.RepNm.value = ArrVen[arg].repNm;
	  document.all.RepPhn1.value = ArrVen[arg].repPhn1;
	  document.all.RepPhn2.value = ArrVen[arg].repPhn2;
	  document.all.RepEMail.value = ArrVen[arg].repEMail;
	}
//==============================================================================
// populate panel
//==============================================================================
function popVendor(action)
{		   
   var panel = "<table class='tbl01' id='tblLog'>"
    + "<tr>"   
       + "<th class='th07'>Vendor: </th>"
       + "<td class='td08'>&nbsp;<input name='Ven' class='Small' size='5' maxlength='5'></td>"
       + "<th class='th07'> &nbsp; &nbsp; </th>"
       + "<th class='th07'>Name: </th>"
       + "<td class='td08'>&nbsp;<input name='VenNm' class='Small' size='50' maxlength='50'></td>"       
    + "</tr>"
    + "<tr>"
    	+ "<th class='th07'>Account: </th>"
    	+ "<td class='td08'>&nbsp;<input name='Acct' class='Small' size='20' maxlength='20'></td>"
    	+ "<th class='th07'> &nbsp; &nbsp; </th>"
    	+ "<th class='th07'>&nbsp;</th>"
    	+ "<td class='td08'>&nbsp;</td>"
    + "</tr>"
    
    + "<tr><td  class='Separator04' colspan='6'>&nbsp;</td></tr>"
    
    + "<tr>"       
    	+ "<th class='th07'>Claim: </th>"
    	+ "<td class='td08'>&nbsp;<input name='Claim' class='Small' size='50' maxlength='50'></td>"
    	+ "<th class='th07'> &nbsp; &nbsp; </th>"
    	+ "<th class='th07'>Claim EMail: </th>"
    	+ "<td class='td08'>&nbsp;<input name='ClaimEMail' class='Small' size='50' maxlength='50'></td>"
    + "</tr>"
    
    + "<tr>"       
		+ "<th class='th07'>Claim Form: </th>"
		+ "<td class='td08'>&nbsp;<input name='ClaimForm' class='Small' size='30' maxlength='30'></td>"
		+ "<th class='th07'> &nbsp; &nbsp; </th>"	
	+ "</tr>"
    
    + "<tr><td  class='Separator04' colspan='6'>&nbsp;</td></tr>"
    
    + "<tr>"       
		+ "<th class='th07'>Main: </th>"
		+ "<td class='td08'>&nbsp;<input name='MainPhn' class='Small' size='50' maxlength='50'></td>"
		+ "<th class='th07'> &nbsp; &nbsp; </th>"
		+ "<th class='th07'>Main Email: </th>"
    	+ "<td class='td08'>&nbsp;<input name='MainEMail' class='Small' size='50' maxlength='50'></td>"    
 	+ "</tr>"
 	
 	+ "<tr><td  class='Separator04' colspan='6'>&nbsp;</td></tr>"
 	
 	+ "<tr>"       
		+ "<th class='th07'>Contact: </th>"
		+ "<td class='td08'>&nbsp;<input name='Cont' class='Small' size='50' maxlength='50'></td>"
		+ "<th class='th07'> &nbsp; &nbsp; </th>"
		+ "<th class='th07'>Contact Phone 1: </th>"
		+ "<td class='td08'>&nbsp;<input name='ContPhn1' class='Small' size='15' maxlength='15'></td>"
	+ "</tr>"
	+ "<tr>"
		+ "<th class='th07'>Contact Phone 2: </th>"
		+ "<td class='td08'>&nbsp;<input name='ContPhn2' class='Small' size='15' maxlength='15'></td>"
		+ "<th class='th07'> &nbsp; &nbsp; </th>"
		+ "<th class='th07'>Contact EMail: </th>"
		+ "<td class='td08'>&nbsp;<input name='ContEMail' class='Small' size='50' maxlength='50'></td>"		
	+ "</tr>"
	
	+ "<tr><td  class='Separator04' colspan='6'>&nbsp;</td></tr>"
	
	+ "<tr>"       
		+ "<th class='th07'>Representative: </th>"
		+ "<td class='td08'>&nbsp;<input name='RepNm' class='Small' size='30' maxlength='30'></td>"
		+ "<th class='th07'> &nbsp; &nbsp; </th>"
		+ "<th class='th07'>Rep. Phone 1: </th>"
		+ "<td class='td08'>&nbsp;<input name='RepPhn1' class='Small' size='15' maxlength='15'></td>"
	+ "</tr>"
	+ "<tr>"
		+ "<th class='th07'>Rep Phone 2: </th>"
		+ "<td class='td08'>&nbsp;<input name='RepPhn2' class='Small' size='15' maxlength='15'></td>"
		+ "<th class='th07'> &nbsp; &nbsp; </th>"
		+ "<th class='th07'>Rep. EMail: </th>"
		+ "<td class='td08'>&nbsp;<input name='RepEMail' class='Small' size='50' maxlength='50'></td>"		
	+ "</tr>"
		
   panel += "</table> <br/>"
    

   panel += "<tr>"
	  + "<td id='tdError' class='Small' colspan=2 style='color:red;font-size:12px;'></td>"
   + "</tr>";
		   
   panel += "</table>"
        + "<button onClick='vldVendor(&#34;" + action + "&#34;);' class='Small'>Submit</button>&nbsp; &nbsp;"
        + "<button onClick='hidePanel();' class='Small'>Close</button>&nbsp;";
	        
	return panel;
}
//==============================================================================
// valid vendor
//==============================================================================
function vldVendor(action)
{
	var error=false;
	var msg = "";
	document.all.tdError.value="";
	var br = "";
	
	var ven = document.all.Ven.value.trim();
	if(ven == ""){ error = true; msg += br + "Vendor cannot be blank"; }
	else if(isNaN(ven)){ error = true; msg += br + "Vendor is not a numeric"; br += "<br>";}
	
	var vennm = document.all.VenNm.value.trim();
	if(vennm == ""){ error = true; msg += br + "Vendor Name cannot be blank"; br += "<br>"; }		

	var acct = document.all.Acct.value.trim();
	
	var claim = document.all.Claim.value.trim();
	var claimemail = document.all.ClaimEMail.value.trim();
	var claimform = document.all.ClaimForm.value.trim();
	
	var mainphn = document.all.MainPhn.value.trim();
	var mainemail = document.all.MainEMail.value.trim();
	
	var cont = document.all.Cont.value.trim();
	var contphn1 = document.all.ContPhn1.value.trim();
	var contphn2 = document.all.ContPhn2.value.trim();
	var contemail = document.all.ContEMail.value.trim();
	
	var repnm = document.all.RepNm.value.trim();
	var repphn1 = document.all.RepPhn1.value.trim();
	var repphn2 = document.all.RepPhn2.value.trim();
	var repemail = document.all.RepEMail.value.trim();
	
	if(error){ document.all.tdError.value += msg;}
	else { sbmVendor(ven, vennm, acct, claim, claimemail, claimform, mainphn, mainemail
			, cont, contphn1, contphn2, contemail, repnm, repphn1, repphn2, repemail, action ); } 
}


//==============================================================================
// submit vendor
//==============================================================================
function sbmVendor(ven, vennm, acct, claim, claimemail, claimform, mainphn, mainemail
		, cont, contphn1, contphn2, contemail, repnm, repphn1, repphn2, repemail, action )
{
	//vennm = vennm.replace(/\n\r?/g, '<br />');
	//claim = claim.replace(/\n\r?/g, '<br />');	
	//repnm = repnm.replace(/\n\r?/g, '<br />');	
	
	var nwelem = window.frame1.document.createElement("div");
	nwelem.id = "dvSbmPostPackId"
	
	var html = "<form name='frmPatioVendor'"
	    + " METHOD=Post ACTION='PfVenSv.jsp'>"
	    + "<input name='Ven'>"
	    + "<input name='VenNm'>"
	    + "<input name='Acct'>"
	    + "<input name='Claim'>"
	    + "<input name='ClaimEMail'>"
	    + "<input name='ClaimForm'>"
	    + "<input name='MainPhn'>"
	    + "<input name='MainEMail'>"
        + "<input name='Cont'>"
        + "<input name='ContPhn1'>"
	    + "<input name='ContPhn2'>"
	    + "<input name='ContEMail'>"
	    + "<input name='RepNm'>"
	    + "<input name='RepPhn1'>"
	    + "<input name='RepPhn2'>"
	    + "<input name='RepEMail'>"
	    + "<input name='Action'>"	        
    html += "</form>"
     
    nwelem.innerHTML = html;
    window.frame1.document.appendChild(nwelem);

	window.frame1.document.all.Ven.value = ven;
	window.frame1.document.all.VenNm.value = vennm;
	window.frame1.document.all.Acct.value = acct;
	window.frame1.document.all.Claim.value = claim;
	window.frame1.document.all.ClaimEMail.value = claimemail;
	window.frame1.document.all.ClaimForm.value = claimform;
	window.frame1.document.all.MainPhn.value = mainphn;
	window.frame1.document.all.MainEMail.value = mainemail;
	window.frame1.document.all.Cont.value = cont;
	window.frame1.document.all.ContPhn1.value = contphn1;
	window.frame1.document.all.ContPhn2.value = contphn2;
	window.frame1.document.all.ContEMail.value = contemail;
	window.frame1.document.all.RepNm.value = repnm;
	window.frame1.document.all.RepPhn1.value = repphn1;
	window.frame1.document.all.RepPhn2.value = repphn2;
	window.frame1.document.all.RepEMail.value = repemail;	
	window.frame1.document.all.Action.value = action;	
	   
	//window.frame1.document.frmPatioVendor.submit();	
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
//reload page
//==============================================================================
function restart(){ window.location.reload(); }
</SCRIPT>

<script src="StrSelBox.js"></script>
<script src="MoveBox.js"></script>

<script src="Get_Object_Position.js"></script>
<script src="Calendar.js"></script>

</head>
<body onload="bodyLoad()">
<!-- ================================================================ -->
<iframe  id="frame1"  src="" height="0" width="0"></iframe>  
<!-- ================================================================ -->
<div id="dvItem" class="dvItem"></div>
<div id="dvVendor" class="dvVendor"></div>


      <!--  beginning of table  -->
      <table class="tbl01">
        <tr class="trHdr">
          <th colspan=45>
            <b>Retail Concepts, Inc
            <br>Patio Furniture Vendor List (Special Order Only)   
            </b>
            
            <br>
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;
              <a href="EcProdSumSel.jsp"><font color="red" size="-1">Selection</font></a>&#62;
              <font size="-1">This Page.</font> &nbsp; &nbsp; &nbsp; &nbsp;
              <a href="javascript: rtvVendors()">Add New</a>            
          </th>
        </tr>
        <tr>
          <td>  
      <table class="tbl02">
        <tr class="trHdr01">
          <th class="th02">#</th>
          <th class="th02">Name</th>
          <th class="th02">Account<br>#</th>
          <th class="th02">Claim</th>
          <th class="th02">Main</th>
          <th class="th02">Contact</th>          
          <th class="th02">Representative<br></th>
          <th class="th02">Last<br>Updated<br>User/Date</th>
          <th class="th02">Last<br>Updated<br>Delete</th>
        </tr>
       
       <!-- ======================== Details =============================== -->
           <%for(int i=0; i < vVen.size(); i++){%>
              <tr id="trId" class="trDtl04">
                <td class="td12" nowrap><a href="javascript: showVenSelect('<%=i%>', true, 'UPD')"><%=vVen.get(i)%></a></td>
                <td class="td11" nowrap><%=vName.get(i)%></td>
                <td class="td11" nowrap><%=vAcct.get(i)%></td>
                <td class="td22" nowrap><%=vClaim.get(i)%>
                      <br><%=vClmEMail.get(i)%>
                      <br><%=vClmForm.get(i)%>                      
                </td>
                <td class="td22" nowrap><%=vMainPhn.get(i)%><br><%=vMainEMail.get(i)%></td>
                <td class="td22" nowrap><%=vContNm.get(i)%>
                      <br><%=vContPhn1.get(i)%>
                      <br><%=vContPhn2.get(i)%>
                      <br><%=vContEMail.get(i)%>
                </td>
                <td class="td22" nowrap><%=vRepNm.get(i)%>
                	  <br><%=vRepPhn1.get(i)%>
                	  <br><%=vRepPhn2.get(i)%>
                	  <br><%=vRepEMail.get(i)%>
                </td>
                <td class="td22" nowrap><%=vRecUser.get(i)%><br><%=vRcdDt.get(i)%></td>
                <td class="td12" nowrap><a href="javascript: showVenSelect('<%=i%>', true, 'DLT')">Delete</a></td>
              </tr>
              <script>
                ArrVen[ArrVen.length] = { ven:"<%=vVen.get(i)%>", venNm:"<%=vName.get(i)%>"
            	  , acct:"<%=vAcct.get(i)%>", claim:"<%=vClaim.get(i)%>", claimEMail:"<%=vClmEMail.get(i)%>" 
            	  , claimForm:"<%=vClmForm.get(i)%>", mainPhn:"<%=vMainPhn.get(i)%>", mainEMail:"<%=vMainEMail.get(i)%>"
            	  , contNm:"<%=vContNm.get(i)%>", contPhn1:"<%=vContPhn1.get(i)%>", contPhn2:"<%=vContPhn2.get(i)%>"
            	  , contEMail:"<%=vContEMail.get(i)%>"
            	  , repNm:"<%=vRepNm.get(i)%>", repPhn1:"<%=vRepPhn1.get(i)%>", repPhn2:"<%=vRepPhn2.get(i)%>"
                  , repEMail:"<%=vRepEMail.get(i)%>"
            	}
              </script>
           <%}%>
         </table>
      <!-- ======================== end Table =============================== -->
      </tr>
   </table>
 </body>
</html>
<%
}
%>