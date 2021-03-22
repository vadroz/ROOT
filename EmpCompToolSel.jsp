<%@ page import="rciutility.StoreSelect, rciutility.RunSQLStmt, java.text.SimpleDateFormat, java.sql.*, java.util.*"%>
<%
   	String sStrAllowed = null;

	StoreSelect strlst = null;
   	
   	String sUser = null;

   //----------------------------------
   // Application Authorization
   //----------------------------------   
if (session.getAttribute("USER")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=EmpCompToolSel.jsp&APPL=ALL");
}
else {

     sStrAllowed = session.getAttribute("STORE").toString();
     sUser = session.getAttribute("USER").toString();

     if (sStrAllowed != null && sStrAllowed.startsWith("ALL"))
     {
       strlst = new StoreSelect(29);
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

    int iNumOfStr = strlst.getNumOfStr();
    String [] sStr = strlst.getStrLst();
    String [] sStrNm = strlst.getStrNameLst();

    String [] sStrRegLst = strlst.getStrRegLst();
    String sStrRegJsa = strlst.getStrReg();

    String [] sStrDistLst = strlst.getStrDistLst();
    String sStrDistJsa = strlst.getStrDist();
    String [] sStrDistNmLst = strlst.getStrDistNmLst();
    String sStrDistNmJsa = strlst.getStrDistNm();

    String [] sStrMallLst = strlst.getStrMallLst();
    String sStrMallJsa = strlst.getStrMall();
    
%>

<html>
<head>
<title>Compensation Tool</title>
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>

<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

<SCRIPT language="JavaScript">
var ArrStr = [<%=sStrJsa%>];
var ArrStrNm = [<%=sStrNameJsa%>];
var ArrStrReg = [<%=sStrRegJsa%>];
var ArrStrDist = [<%=sStrDistJsa%>];
var ArrStrDistNm = [<%=sStrDistNmJsa%>];
var ArrStrMall = [<%=sStrMallJsa%>];

var StrAllowed = "<%=sStrAllowed%>";
var User = "<%=sUser%>";
//==============================================================================
// initial processes
//==============================================================================
function bodyLoad()
{  
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)) { isSafari = true; }
}
//==============================================================================
// change action on submit
//==============================================================================
function validate()
{
   	var error =false;
   	var msg = "";

   	var str = document.all.Str[document.all.Str.selectedIndex].value;   
	   
   	if (error) {alert(msg); }
   	else { submit(str); }
}
//==============================================================================
// change action on submit
//==============================================================================
function submit(str)
{
	url = "EmpCompTool.jsp?Str=" + str;
	
    //alert(url);
    window.location.href=url;
}
</SCRIPT>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>

</head>
<body  onload="bodyLoad();">

 <!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="menu" class="Menu"></div>
<!-------------------------------------------------------------------->

  <table border="0" width="100%" height="100%">
     <tr>
      <td height="20%" COLSPAN="2" align="center">
        <img src="Sun_ski_logo4.png" /></td>
     </tr>
     <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP">
       <b>Retail Concepts, Inc
       <br>Salesperson Compensation Tool - Selection   
       </b><br><br>
       <a href="index.jsp">Home</a>
       
      <table border=0>
      
      <!-- ============== Multiple Store selection ======================= -->
        <tr id="trMult">
         <td class="Small" nowrap>
         	<select class="Small" name="Str">
         		<%for(int i=0; i < iNumOfStr; i++){%>
         		    <option value="<%=sStr[i]%>"><%=sStr[i]%> - <%=sStrNm[i]%></option>             
         		<%}%>
         	</select>
         </td>
        </tr>
        
      <!-- =============================================================== -->
      <tr><td style="border-top: darkred solid 1px;">&nbsp;</td></tr>
      <tr>
         <td style="text-align:center;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
         <button name="submit" onClick="validate()">Submit</button>
      </tr>
      </table>
                </td>
    </tr>
   </table>
 </body>
</html>
<%}%>
