<%@ page import="tomcatsecurity.Signon, java.util.*, java.text.*"%>
<%
   String sUser = request.getParameter("USER");
   String sPassword = request.getParameter("PASSWORD");
   String sAppl = request.getParameter("APPL");
   String sSbmString = request.getParameter("SbmString");
   String sErrorMsg= null;

   Enumeration en = request.getParameterNames();
   String [] sPrmValue = null;
   String sParam = null;
   String sTarget = null;
   StringBuffer sbQuery = new StringBuffer() ;
   String sQstMrk = "?";

   if(sUser == null && sSbmString == null)
   {	   
	  while (en.hasMoreElements())
      {
        sParam = en.nextElement().toString();
        //sPrmValue = request.getParameter(sParam);
        sPrmValue = request.getParameterValues(sParam);

        if(sParam.equals("TARGET"))
        {
          sTarget = sPrmValue[0];
        }
        else if(!sParam.equals("APPL"))
        {
          for(int i=0; i < sPrmValue.length; i++)
          {
             sbQuery.append(sQstMrk + sParam + "=" + sPrmValue[i]);
             sQstMrk = "&";
          }
        }
      }
      sSbmString = sTarget + sbQuery.toString();
      System.out.println(sSbmString);
   }

   if(sUser!=null)
   {
     Signon signon = new Signon(sUser, sPassword);
     int iNumOfApp = signon.getNumOfApp();
     String [] sUserApp = signon.getApplication();
     String sAccess = signon.getAccess();
     int iNumOfStr = signon.getNumOfStr();
     String [] sStore = signon.getStore();
     boolean bFound = false;

     en = session.getAttributeNames();
     Vector vAttr = new Vector();
     while(en.hasMoreElements()) { vAttr.add((String) en.nextElement()); }
     Iterator it = vAttr.iterator();
     while(it.hasNext()) { session.removeAttribute(it.next().toString());}

     if(sAccess.equals("E"))
     {
       sErrorMsg = "User Id or password is not valid, please enter again.";
     }
     else
     {
       // change interval to never expired for homeoffice       
       if(sStore[0].trim().equals("ALL"))  { session.setMaxInactiveInterval(-1);  }
       else if( sUser.startsWith("dsimpson") ){ session.setMaxInactiveInterval(-1); }
       else if( sUser.startsWith("w7") ){ session.setMaxInactiveInterval(-1); }
       else if( sUser.startsWith("cash") ){ session.setMaxInactiveInterval(3600); }
       else{ session.setMaxInactiveInterval(1800);  }
        

       session.setAttribute("USER", sUser);
       session.setAttribute("ACCESS", sAccess);
       session.setAttribute("STORE", sStore[0]);
       session.setAttribute("DATE", new Date());

       Vector vStore = new Vector(iNumOfStr);
       for(int i=0; i < iNumOfStr; i++) { vStore.add(sStore[i]); }

       session.setAttribute("STRLST", vStore);

       System.out.println(sUser + "|" + sAccess + "|" + sStore);

       for(int i=0; i < iNumOfApp; i++)
       {
         session.setAttribute(sUserApp[i], sUserApp[i]);
         //System.out.println(sUserApp[i]);
         
         if(sUserApp[i].equals(sAppl)) bFound = true;
       }

       System.out.println(sSbmString);
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
   // new logo
   String sLogo1 = "Sun_ski_logo3.png";
   String sLogo2 = "Sun_ski_logo4.png";
   String sTxtClr = "black";
   String sLnkClr = "blue";
   
   Date date = new Date(); // your date
   Calendar cal = Calendar.getInstance();
   cal.setTime(date);
   int year = cal.get(Calendar.YEAR);
   int month = cal.get(Calendar.MONTH);
   int day = cal.get(Calendar.DAY_OF_MONTH);

   
   if (month > 2 && month < 9) 
   {
	   sLogo1 = "Sun_ski_logo6.png";
	   sLogo2 = "Sun_ski_logo7.png";
	   sTxtClr = "white";
	   sLnkClr = "white";
   } 
   
%>  
<html>
<head>
<!--  meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10" / -->
<meta http-equiv="refresh">

<style>
       body{
            background-image: url(<%=sLogo1%>);
            background-size: cover;
            background-repeat: no-repeat;
            
            
            font-family:Arial;
       }  
       a:link { color: <%=sLnkClr%>; font-family:Arial;} a:visited { color:  <%=sLnkClr%>; font-family:Arial;}  a:hover { color: blue; font-family:Arial;}
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
       td.DataTable5 { color: <%=sTxtClr%>; text-align: center; vertical-align: top;}                             
       div.Prompt { position:absolute; visibility:hidden; background-attachment: scroll;
              border:ridge; width:250; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}
       .txtoutl {color: white; text-shadow:-1px -1px 0 black,1px -1px 0 black,-1px 1px 0 black,}       
</style>
<SCRIPT language="JavaScript1.2">
var Query = "<%=request.getQueryString()%>";


function bodyLoad()
{
  document.oncontextmenu = function()
  {
    alert("Right Click is disable on this page")
    return false
  }
  //document.forms[0].USER.focus()
}

//==============================================================================
// validate
//==============================================================================
function Validate()
{
   if (document.forms[0].PASSWORD.value == "")
   {
     alert("Please, enter password.")
     return false
   }
   else {
	   
	   var msg = "<span><b><u>* * * * * * * * * * W A R N I N G * * * * * * * * * *</u></b></span>"
		   + "<br><div style='text-align:left;'>"
+ "This computer system is the property of Sun and Ski Sports and is for authorized use only." 
+ "  By using this system, all users acknowledge notice of and agree to comply with the company's" 
+ " Acknowledgment of Computer Usage, Internet, and E-mail Access policy. Unauthorized or improper" 
+ " use of this system may result in disciplinary action, civil charges/criminal penalties, and" 
+ " termination of employment. By continuing to use this system you indicate your awareness of and" 
+ " consent to these terms and conditions of use.</div>"
       ;
		   
	   
	   msg += "<br><button onclick='sbmSignOn();'>Continue</button>"
	   
	   document.all.dvInfo.innerHTML = msg;
	   document.all.dvInfo.style.width = 600;
	   document.all.dvInfo.style.fontSize = "14px";	    
	   document.all.dvInfo.style.pixelLeft= 400;
	   document.all.dvInfo.style.pixelTop= 300;
	   document.all.dvInfo.style.visibility = "visible";
	   
	   
	   //alert(msg);
	   
	   return false;
   }
}
//==============================================================================
//show Productivity Ranking report
//==============================================================================
function sbmSignOn()
{
	var act = document.all.getStore.action;
	act = act + "&SbmString=<%=sSbmString%>";
	document.all.getStore.action = act;
	document.all.getStore.submit();
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
/* remove fro security reason
<a class="blue" href="https://balance.worldpay.us/GLCardBalance.aspx" target="_blank">
  <img alt="Ride" src="MainMenu/S&S Gift Card.jpg" style="width:42px;height:22px; border:0;vertical-align:middle;">
    Sun & Ski Gift Card Balance Inquiry</a>
*/
</SCRIPT>

<title>Sign On</title>
          </head>
 <body  onload="bodyLoad();">
 <div id="dvInfo" class="Prompt" ></div>
 
  <table border="0" width="100%" height="100%">
     <tr>
      <td align=center>
        <img src="<%=sLogo2%>"/>
      </td>
     </tr>
     <tr>
     
      <td ALIGN="center" VALIGN="TOP">       
       

       <!-- Dispaly Error Message -->
       <%if(sErrorMsg!=null){%>
       <p align=center><font color=red><b><u><%=sErrorMsg%></u></b></font>
       <%}%>

      <span style="font-size:24px; font-family:Arial; text-decoration: underline; font-weght:bold">Intranet Login</span>
      
      <form name="getStore" action="SignOn1.jsp?<%=request.getQueryString()%>" method="POST" onSubmit="return Validate();">
      <table>
      <tr>
         <td>User:</td>
         <td><input name="USER" type="TEXT" size="10" maxlength="10" autocomplete="off"></td>
      <tr>
        <td>Password:</td>
        <td><input name="PASSWORD" type="PASSWORD"  size="10" maxlength="10"  autocomplete="off"></td>

      </tr>
      <tr>
         <td colspan="2" align="center"><button onclick="Validate()">Continue</button></td>
      </tr>
      </table>

      </form>
            
      
      <br><br><br><br><br><br><br><br>
      <table border=0  width="70%"  cellPadding=0 cellSpacing=0>
      	<tr><td class="DataTable5" colspan=5>Quick Links<br>&nbsp;</td>      	  
      	</tr>
      	<tr>
      	  <td  class="DataTable5"    colspan=5>Internal</td>      	  
      	</tr>
      	<tr>
      		<td class="DataTable2" ><a class="blue" href="javascript: showITContactInfo()">IT Support Info</a></td>      	
      		<td class="DataTable2"><a href="MainMenu/holidayschedule.pdf">Company Holidays</a></td>
      		<td class="DataTable2"><a class="blue" href="MainMenu/Store Listing.pdf" target="_blank">Store List</a></td>
      		<td class="DataTable2"><a class="blue" href="MainMenu/Extension Listing.pdf" target="_blank">H.O. Extensions</a></td>
      		<td class="DataTable2">&nbsp;</td>      		
        </tr>
        <tr>
            <td class="DataTable2"><a class="blue" href="http://www.sunandski.com" target="_blank">sunandski.com</a></td>
      		<td class="DataTable2"><a class="blue" href="http://www.sunandskipatio.com" target="_blank">sunandskipatio.com</a></td>
      		<td class="DataTable2" colspan=3>      		
      		   
      		</td>      		
      	</tr>
      	<tr>
      	  <td  class="DataTable5" colspan=5><br>External</td>      	  
      	</tr>
      	<tr>
      		<td class="DataTable2" nowrap><a class="blue" href="https://ops-center.opterus.net/?customer=sunskispo">
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
      	  <td  class="DataTable5" colspan=5><br>HR</td>      	  
      	</tr>
      	<tr>      	    
      		<td class="DataTable3" nowrap><a href="https://www.dayforcehcm.com" target="_blank">Ceridian Dayforce</a></td>      		
      		<td class="DataTable3" nowrap><a href="https://www.sunlife.com" target="_blank">Sun Life (supplemental)</a></td>
      		<td class="DataTable3" ><a href="https://www.sunlife.com/FindADentist" target="_blank">Sun Life (Dental)</a></td>  
      		<td class="DataTable3" ><a href="https://www.VSP.com" target="_blank">Sun Life (Vision)</a></td>
      		<td class="DataTable3" ><a href="https://myaccount.ascensus.com/rplink" target="_blank">Ascensus 401k</a></td>      
      	</tr>
      	<tr>
      		<!-- td class="DataTable4" nowrap><a class="blue" href="http://www.guardiananytime.com" target="_blank">
      		     <img alt="Dental/Vesion" src="MainMenu/Guardian-Life-Insurance-Logo.jpg" style="width:42px;height:22px; border:0;vertical-align:middle;">Guardian Dental and Vision</a>
      		   </td-->
      		<td class="DataTable4" nowrap><a class="blue" href="http://www.tasconline.com" target="_blank">
      	   	   <img alt="Flex" src="MainMenu/TASC logo 4c -TM.jpg" style="width:42px;height:22px; border:0;vertical-align:middle;">Flex Spending</a>
      		<td class="DataTable4" nowrap><a class="blue" href="http://www.petinsurance.com" target="_blank">
      	  	   <img alt="Pet Ins" src="MainMenu/Nationwide_2014_new.png" style="width:42px;height:22px; border:0;vertical-align:middle;">Pet Insurance</a>
      		<td class="DataTable4" nowrap><a class="blue" href="https://www.bcbstx.com" target="_blank"> 
      		  	<img alt="Blue Cross, Blue Shield" src="MainMenu/blue_cross.jpg"   style="width:80px;height:50px; border:0;vertical-align:middle;">
      		  </a></td>
      		<td class="DataTable4" ><a href="https://www.myprime.com">Walgreens Prime (Rx)</a></td>      		 
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
