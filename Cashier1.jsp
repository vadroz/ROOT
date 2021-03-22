<%@ page import="tomcatsecurity.Signon, java.util.*"%>
<%
String sUser = request.getParameter("USER");
String sPassword = " ";
String sAppl = "ALL";
String sSbmString = "index.jsp";
String sErrorMsg= null;

Enumeration  en = request.getParameterNames();
String [] sPrmValue = null;
String sParam = null;
String sTarget = "index.jsp";
StringBuffer sbQuery = new StringBuffer() ;
String sQstMrk = "?";

if(sUser!=null)
{
  Signon signon = new Signon(sUser, sPassword);
  int iNumOfApp = signon.getNumOfApp();
  String [] sUserApp = signon.getApplication();
  String sAccess = signon.getAccess();
  int iNumOfStr = signon.getNumOfStr();
  String [] sStore = signon.getStore();
  boolean bFound = false;

  if(sAccess.equals("E"))
  {
    sErrorMsg = "User Id is not valid, please enter again.";
  }
  else
  {
    session.setMaxInactiveInterval(-1);

    session.setAttribute("USER", sUser);
    session.setAttribute("ACCESS", sAccess);
    session.setAttribute("STORE", sStore[0]);
    // store list
    Vector vStore = new Vector(iNumOfStr);
    for(int i=0; i < iNumOfStr; i++) { vStore.add(sStore[i]); }
    session.setAttribute("STRLST", vStore);

    //System.out.println(sUser + "|" + sAccess + "|" + sStore);

    for(int i=0; i < iNumOfApp; i++)
    {
      session.setAttribute(sUserApp[i], sUserApp[i]);
      if(sUserApp[i].equals(sAppl)) bFound = true;
    }

    if  (bFound || sAppl.equals("ALL") || sAppl.equals("NONE"))
    {
      response.sendRedirect(sSbmString);
    }
    else
    {
      sErrorMsg = "User is not authorized for application";
    }

  }
  signon.disconnect();
}

%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10" />
<meta http-equiv="refresh">

<style>
       body{
            background-image: url(Sun_ski_logo3.png);
            background-size: cover;
            background-repeat: no-repeat;
            
            
            font-family:Arial;
       }  
       a:link { color:blue; font-family:Arial;} a:visited { color:blue; font-family:Arial;}  a:hover { color:blue; font-family:Arial;}
       table.DataTable { border: darkred solid 1px;text-align:center;}
       th.DataTable { padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Arial; font-size:10px }
       td.DataTable {   padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:left; font-family:Arial; font-size:10px }
       td.DataTable1 {   padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:left; font-family:Arial; font-size:10px }
       td.DataTable2 {border-top:1px #8ab7f9 solid;border-bottom:1px #8ab7f9 solid; text-align:center;
                      padding-top:5px; padding-bottom:5px;}
       td.DataTable3 {border-top:1px #8ab7f9 solid; text-align:center;
                      padding-top:5px; padding-bottom:5px;}
       td.DataTable4 {border-bottom:1px #8ab7f9 solid; text-align:center;
                      padding-top:5px; padding-bottom:5px;}               
       div.Prompt { position:absolute; visibility:hidden; background-attachment: scroll;
              border:ridge; width:250; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}
       .txtoutl {color: white; text-shadow:-1px -1px 0 black,1px -1px 0 black,-1px 1px 0 black,}       
</style>
<SCRIPT language="JavaScript1.2">
function bodyLoad()
{
  document.oncontextmenu = function()
  {
    alert("Right Click is disable on this page")
    return false
  }
  document.forms[0].USER.focus()
}

//==============================================================================
//show Productivity Ranking report
//==============================================================================
function showITContactInfo()
{

var html = "<table style='background:#e7e7e7;font-size=12px' border='0' width='100%' cellPadding='0' cellSpacing='0'>"
   + "<tr>"
    + "<td class='BoxName' nowrap>IT Help Desk Contact Info</td>"
    + "<td class='BoxClose' valign=top>"
      +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
    + "</td>"
   + "</tr>"
// Comment line
html += "<tr>"
       + "<td nowrap colspan='2'>"
       + "For process/Procedural issues, check with your Manager or contact your "
       + "District Manager for assistance.<br><br>"
       + "For urgent IT issues, call:<br><br>"
       + "Home office <b><font color=red size=+1>x3606</font></b><br>"
       + "Or<br>"
       + "<b><font color=red size=+1>281-207-3606</font></b><br>"
       + "Or<br>"
       + "<b><font color=red size=+1>832-435-3669</font></b> (direct dial to after-hours cell phone)<br><br>"
       + "If your problem can wait until the next business day, please email"
       + " IT Support help desk at <br><b><font color=red size=+1>support@retailconcepts.cc</font></b>"
       + "</td>"
     + "</tr>"
// buttons
html += "<tr>"
       + "<td nowrap colspan='2' align=center>"
       + "<button class='Small' onClick='hidePanel();'>Cancel</button>"
       + "</td>"
     + "</tr>"

html += "</table>"

document.all.dvInfo.innerHTML = html;
document.all.dvInfo.style.pixelLeft= 200;
document.all.dvInfo.style.pixelTop= 200;
document.all.dvInfo.style.visibility = "visible";
}
//--------------------------------------------------------
//Hide selection screen
//--------------------------------------------------------
function hidePanel()
{
document.all.dvInfo.innerHTML = " ";
document.all.dvInfo.style.visibility = "hidden";
}
</SCRIPT>
<title>Sign On</title>
          </head>
 <body  onload="bodyLoad();">
 <div id="dvInfo" class="Prompt" ></div>

  <table border="0" width="100%" height="100%">
     <tr>
      <td align=center>
        <img src="Sun_ski_logo4.png"/>
      </td>
     </tr>
     <tr>
     
      <td ALIGN="center" VALIGN="TOP">       
       

       <!-- Dispaly Error Message -->
       <%if(sErrorMsg!=null){%>
       <p align=center><font color=red><b><u><%=sErrorMsg%></u></b></font>
       <%}%>

      <span style="font-size:24px; font-family:Arial; text-decoration: underline; font-weght:bold">Intranet Login</span>
      
      <form name="getStore" action="Cashier1.jsp?<%=request.getQueryString()%>" method="POST">
      <table>
      <tr>
         <td>User:</td>
         <td><input name="USER" type="TEXT" size="10" maxlength="10" autocomplete="off"></td>
      <tr>
         <td colspan="2" align="center"><input type="submit" value="Continue"></td>
      </tr>
      </table>

      <input name="SbmString" type="hidden" value="<%=sSbmString  %>">

      </form>
            
      
      <br><br>
      <table border=0  width="70%"  cellPadding=0 cellSpacing=0>
      	<tr><td valign="top" colspan=5 align=center>Quick Links<br>&nbsp;</td>      	  
      	</tr>
      	<tr>
      	  <td valign="top" colspan=5 align=center>Internal</td>      	  
      	</tr>
      	<tr>
      		<td class="DataTable2" ><a class="blue" href="javascript: showITContactInfo()">IT Support Info</a></td>      	
      		<td class="DataTable2"><a href="MainMenu/holidayschedule.pdf">Company Holidays</a></td>
      		<td class="DataTable2"><a class="blue" href="MainMenu/Store Listing.pdf" target="_blank">Store List</a></td>
      		<td class="DataTable2"><a class="blue" href="MainMenu/Extension Listing.pdf" target="_blank">H.O. Extensions</a></td>
      		<td class="DataTable2">&nbsp;</td>      		
        </tr>
        <tr>
            <td class="DataTable2">&nbsp;</td>
            <td class="DataTable2"><a class="blue" href="http://www.sunandski.com" target="_blank">sunandski.com</a></td>
      		<td class="DataTable2"><a class="blue" href="http://www.sunandskipatio.com" target="_blank">sunandskipatio.com</a></td>
      		<td class="DataTable2">&nbsp;</td>
      		<td class="DataTable2">&nbsp;</td>      		
      	</tr>
      	<tr>
      	  <td valign="top" colspan=5 align=center><br><br>External</td>      	  
      	</tr>
      	<tr>
      		<td class="DataTable2" nowrap><a class="blue" href="https://ops-center.opterus.net/?customer=retcon&store=0000&locale=en">
      		  <img alt="Ride" src="MainMenu/ride_logo.jpg" style="width:42px;height:22px; border:0;vertical-align:middle;">RIDE</a></td>
      		<td class="DataTable2" nowrap><a class="blue" href="https://sunandskisf.mobi/storeforce/" target="_blank">
      	      <img alt="StoreForce" src="MainMenu/storeforce-solutions-squarelogo-1430852281844.png" style="width:42px;height:22px; border:0;vertical-align:middle;">StoreForce Schedule</a></td>
      	  	<td class="DataTable2" nowrap><a class="blue" href="https://sunandskisf.mobi/ess/" target="_blank">
      	  	  <img alt="StoreForce" src="MainMenu/storeforce-solutions-squarelogo-1430852281844.png" style="width:42px;height:22px; border:0;vertical-align:middle;">StoreForce ESS</a></td>
      	  	<td class="DataTable2" nowrap><a class="blue" href="https://myagi.com/accounts/login/" target="_blank">
      	  	  <img alt="Myagi" src="MainMenu/Myagi.png" style="width:42px;height:22px; border:0;vertical-align:middle;">Myagi</a></td>
      	    <td class="DataTable2" nowrap><a class="blue" href="http://www.3point5.com/action/login" target="_blank">
      	      <img alt="3Point5" src="MainMenu/3point5-logo.jpg" style="width:42px;height:32px; border:0;vertical-align:middle;">3Point5</a></td>
      	</tr>
      	
      	<tr>
      	  <td valign="top" colspan=5 align=center><br><br>HR</td>      	  
      	</tr>
      	<tr>
      	    <td class="DataTable3" >&nbsp;</td>
      		<td class="DataTable3" nowrap><a class="blue" href="https://portal.adp.com" target="_blank">
      		   <img alt="ADP" src="MainMenu/adp-logo1.png" style="width:42px;height:22px; border:0;vertical-align:middle;">ADP Portal</a></td>      		
      		<td class="DataTable3" nowrap><a class="blue" href="http://www.mykplan.com" target="_blank">
      		    <img alt="ADP" src="MainMenu/adp-logo1.png" style="width:42px;height:22px; border:0;vertical-align:middle;">ADP 401K</a></td>
      		<td class="DataTable3" nowrap><a class="blue" href="http://www.bcbstx.com" target="_blank">
      		<img alt="BCBS" src="MainMenu/bcbs.jpeg" style="width:42px;height:22px; border:0;vertical-align:middle;">Blue Cross Blue shield</a></td>
      		
      		<td class="DataTable3" >&nbsp;</td>      
      	</tr>
      	<tr>
      		<td class="DataTable4" nowrap><a class="blue" href="http://www.guardiananytime.com" target="_blank">
      		   <img alt="Dental/Vesion" src="MainMenu/Guardian-Life-Insurance-Logo.jpg" style="width:42px;height:22px; border:0;vertical-align:middle;">Guardian Dental and Vision</a></td>
      		<td class="DataTable4" nowrap><a class="blue" href="http://www.tasconline.com" target="_blank">
      	   	   <img alt="Flex" src="MainMenu/TASC logo 4c -TM.jpg" style="width:42px;height:22px; border:0;vertical-align:middle;">Flex Spending</a>
      		<td class="DataTable4" nowrap><a class="blue" href="http://www.petinsurance.com" target="_blank">
      	  	   <img alt="Pet Ins" src="MainMenu/Nationwide_2014_new.png" style="width:42px;height:22px; border:0;vertical-align:middle;">Pet Insurance</a>
      		<td class="DataTable4" nowrap><a class="blue" href="https://www.lfg.com/public/individual" target="_blank">
      		   <img alt="Lincoln Ins" src="MainMenu/lfg-logo-2x.png" style="width:42px;height:22px; border:0;vertical-align:middle;">Lincoln: Life Insurance/STD/LTD</a>
      		<td class="DataTable4" >&nbsp;</td>      		 
      	</tr>	
      </table>
     </td>
    </tr>      
   </table>
    </td>
   </tr>
  </table>
 </body>
</html>
