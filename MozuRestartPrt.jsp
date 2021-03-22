<%@ page import="rciutility.StoreSelect, rciutility.RunSQLStmt, java.text.SimpleDateFormat
, java.sql.*, java.util.*"%>
<%
   StoreSelect strlst = null;

   String sStrAllowed = null;
   String sUser = null;

   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=MozuRestartPrt.jsp&APPL=ALL");
   }
   else
   {
     sStrAllowed = session.getAttribute("STORE").toString();
     sUser = session.getAttribute("USER").toString();
     

     if (sStrAllowed != null && sStrAllowed.startsWith("ALL"))
     {
       strlst = new StoreSelect();
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

    String [] sStrRegLst = strlst.getStrRegLst();
    String sStrRegJsa = strlst.getStrReg();

    String [] sStrDistLst = strlst.getStrDistLst();
    String sStrDistJsa = strlst.getStrDist();
    String [] sStrDistNmLst = strlst.getStrDistNmLst();
    String sStrDistNmJsa = strlst.getStrDistNm();

    String [] sStrMallLst = strlst.getStrMallLst();
    String sStrMallJsa = strlst.getStrMall();    
%>

<title>ECOM-Restart Printer</title>

<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">
<script LANGUAGE="JavaScript1.2" src="Calendar.js">
</script>


<script name="javascript">
var ArrStr = [<%=sStrJsa%>];
var ArrStrNm = [<%=sStrNameJsa%>];
var ArrStrReg = [<%=sStrRegJsa%>];
var ArrStrDist = [<%=sStrDistJsa%>];
var ArrStrDistNm = [<%=sStrDistNmJsa%>];
var ArrStrMall = [<%=sStrMallJsa%>];

var StrAllowed = "<%=sStrAllowed%>";
var User = "<%=sUser%>";

var progressIntFunc = null;
var progressTime = 0;
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   
}
 
//==============================================================================
// Submit Store recap list
//==============================================================================
function restartPrt(str)
{	
	progressIntFunc = setInterval(function() {showWaitBanner() }, 1000);
	
	var url = "MozuRestartPrtUpd.jsp?"
      + "&Str=" + str;
  
  	if(isIE || isSafari){ window.frame1.location.href = url; }
  	else if(isChrome || isEdge) { window.frame1.src = url; }
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
//submit control
//==============================================================================
function showMsg(success)
{
	clearInterval( progressIntFunc );
	document.all.dvWait.style.visibility = "hidden";
	
	if(success)
	{
		alert("Printer is restarted");
	}
	else
	{
		alert("Error occured!\nPrinter is not restarted\nPlease contact IT.");
	}
}
 
</script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>


<HTML><HEAD><meta http-equiv="refresh">

</HEAD>
<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<div id="dvWait" class="dvItem"></div>
<!-- div id="dvHelp" class="dvHelp"><a href="Intranet Reference Documents/2.0 MOS Approval Recap.pdf" class="helpLink" target="_blank">&nbsp;</a></div -->
<!-------------------------------------------------------------------->
<iframe id="frame1" src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR>
    <TD align=center height="20%"><IMG
    src="Sun_ski_logo4.png"></TD></TR>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Restart ECOM Printer</B>
        <br><a href="index.jsp"><font color="red" size="-1">Home</font></a>

      <TABLE>
        <TBODY>        
     
        <!-- ============== Multiple Store selection ======================= -->
        <tr id="trMult">
         <td colspan="5" class="Small" nowrap>
         
         <%for(int i=0; i < iNumOfStr; i++){%>
             <button class="btn01" id="Str" onclick="restartPrt('<%=sStr[i]%>')" value="<%=sStr[i]%>"><%=sStr[i]%></button>
             &nbsp;&nbsp;&nbsp;             
             <%if(i > 0 && i % 14 == 0){%><br><br><%}%>
         <%}%>

         </td>
        </tr>
		  

         </TBODY>
        </TABLE>
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
<%}%>