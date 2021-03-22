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
   response.sendRedirect("SignOn1.jsp?TARGET=GrootStrListSel.jsp&APPL=ALL");
}
else {

     sStrAllowed = session.getAttribute("STORE").toString();
     sUser = session.getAttribute("USER").toString();

     if (sStrAllowed != null && sStrAllowed.startsWith("ALL"))
     {
       strlst = new StoreSelect(17);
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
    
    // get week or year
   	java.util.Date dCurDate = new java.util.Date();
   	SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
   	String sCurDate = sdf.format(dCurDate);

   	String sPrepStmt = "select pyr#, pmo#, pime from rci.fsyper"
     + " where pida='" + sCurDate + "'";
   	//System.out.println(sPrepStmt);
   	ResultSet rslset = null;
   	RunSQLStmt runsql = new RunSQLStmt();
   	runsql.setPrepStmt(sPrepStmt);
   	runsql.runQuery();
   	runsql.readNextRecord();
   	String sYear = runsql.getData("pyr#");
   	String sMonth = runsql.getData("pmo#");
   	String sMnend = runsql.getData("pime");
   	runsql.disconnect();
   	runsql = null;
%>

<html>
<head>
<title>Grassroots Exp Sum</title>
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

var CurYear = "<%=sYear%>";
var CurMonth = eval("<%=sMonth%>") - 1;
//==============================================================================
// initial processes
//==============================================================================
function bodyLoad()
{  
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)) { isSafari = true; }
	
  	doFiscalYear();
  	
}
 

//==============================================================================
// Weeks Stores
//==============================================================================
function doFiscalYear(id)
{
  var year = CurYear - 1;
  for (var i=0; i < 3; i++)
  {
     document.all.Year.options[i] = new Option(year, year);
     if (year == CurYear ){ document.all.Year.selectedIndex = i; }
     year++;
  }  
}
 
 
//==============================================================================
// populate date with yesterdate
//==============================================================================
function  setDate(direction, id)
{
  var button = document.all[id];
  var date = new Date(button.value);
  date.setHours(18);

  if(direction == "DOWN") date = new Date(new Date(date) - 86400000 * 7);
  else if(direction == "UP") date = new Date(new Date(date) - -86400000 * 7);
  button.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}
//==============================================================================
// change action on submit
//==============================================================================
function validate()
{
   	var error =false;
   	var msg = "";

   	var year = document.all.Year[document.all.Year.selectedIndex].value
   	   
	// store
   	var selstr = new Array();
   	var numstr = 0
   	
   	if (ArrStr.length < 3){ selstr[0] = document.all.Str.value; }
   	else
   	{
    	var str = document.all.Str;
      	selstr = new Array();
      	
      	for(var i=0; i < str.length; i++)
      	{
        	if(str[i].checked){ selstr[numstr] = str[i].value; numstr++; }
      	}
      	if (numstr == 0){ error=true; msg+="At least 1 store must be selected.";}
   	}
   	
   	var half = "1";
   	if(document.all.Qtr[1].checked){ half = "2"; }
   
   	if (error) {alert(msg); }
   	else { submit(selstr, year, half); }
}
//==============================================================================
// change action on submit
//==============================================================================
function submit(str, year, half)
{
	url = "GrootStrList.jsp?Year=" + year
	 + "&Half=" + half
	;
	for(var i=0; i < str.length; i++)
	{
		url += "&Str=" + str[i];
	}
	
    //alert(url);
    window.location.href=url;
}
//==============================================================================
//set all store or unmark
//==============================================================================
function setAll(on)
{
	var str = document.all.Str;
	for(var i=0; i < str.length; i++) { str[i].checked = on; }	
}
//==============================================================================
//check by regions
//==============================================================================
function checkReg(dist)
{
	var str = document.all.Str
	var chk1 = false;
	var chk2 = false;

	// check 1st selected group check status and save it
	var find = false;
	for(var i=0; i < str.length; i++)
	{
  		for(var j=0; j < ArrStr.length; j++)
  		{
     		if(dist != "PATIO" && str[i].value == ArrStr[j] && ArrStrReg[j] == dist
       		|| (dist == "PATIO" && (str[i].value == "35" || str[i].value == "46"
       		|| str[i].value == "50" || str[i].value == "63" || str[i].value == "64"
       		|| str[i].value == "68" || str[i].value == "86")))
     		{
       			chk1 = !str[i].checked;
       			find = true;
       			break;
     		};
  		}
  		if (find){ break;}
	}
	chk2 = !chk1;

	for(var i=0; i < str.length; i++)
	{
  		str[i].checked = chk2;
  		for(var j=0; j < ArrStr.length; j++)
  		{
     		if(dist != "PATIO" && str[i].value == ArrStr[j] && ArrStrReg[j] == dist
       		|| (dist == "PATIO" && (str[i].value == "35" || str[i].value == "46"
       		|| str[i].value == "50" || str[i].value == "63" || str[i].value == "64"
       		|| str[i].value == "68" || str[i].value == "86")))
     		{
        		str[i].checked = chk1;
     		};
  		}
	} 
}
//==============================================================================
//check by districts
//==============================================================================
function checkDist(dist)
{
	var str = document.all.Str
	var chk1 = false;
	var chk2 = false;

	// check 1st selected group check status and save it
	var find = false;
	for(var i=0; i < str.length; i++)
	{
  		for(var j=0; j < ArrStr.length; j++)
  		{
     		if(str[i].value == ArrStr[j] && ArrStrDist[j] == dist)
     		{
       			chk1 = !str[i].checked;
       			find = true;
       			break;
     		}
  		}
  		if (find){ break;}
	}
	chk2 = !chk1;

	for(var i=0; i < str.length; i++)
	{
  		str[i].checked = chk2;
  		for(var j=0; j < ArrStr.length; j++)
  		{
     		if(str[i].value == ArrStr[j] && ArrStrDist[j] == dist)
     		{
        		str[i].checked = chk1;
     		}
  		}
	}
}
//==============================================================================
//check mall
//==============================================================================
function checkMall(type)
{
	var str = document.all.Str
	var chk1 = true;
	var chk2 = false;

	for(var i=0; i < str.length; i++)
	{
  		str[i].checked = chk2;
  		for(var j=0; j < ArrStr.length; j++)
  		{
     		if(str[i].value == ArrStr[j] && ArrStrMall[j] == type)
     		{
        		str[i].checked = chk1;
     		}
  		}
	} 
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
       <br>Grassroots Expense Summary - Selection   
       </b><br><br>

       <a href="index.jsp">Home</a>
       
      <table border=0>
       
      
      <!-- ============== Multiple Store selection ======================= -->
        <tr id="trMult">
         <td class="Small" nowrap>

         <%for(int i=0; i < iNumOfStr; i++){%>
                  <input class="Small" name="Str" type="checkbox" value="<%=sStr[i]%>"><%=sStr[i]%>&nbsp;
                  <%if(i > 0 && i % 14 == 0){%><br><%}%>
              <%}%>
              <%if(iNumOfStr > 1) {%>
              <br><button class="Small" onClick="setAll(true);">All Store</button> &nbsp;

              <button onclick='checkReg(&#34;1&#34;)' class='Small'>Dist 1</button> &nbsp; &nbsp;
              <button onclick='checkReg(&#34;2&#34;)' class='Small'>Dist 2</button> &nbsp; &nbsp;
              <button onclick='checkReg(&#34;3&#34;)' class='Small'>Dist 3</button> &nbsp; &nbsp;
              <button onclick='checkReg(&#34;99&#34;)' class='Small'>Dist 99</button> &nbsp; &nbsp;
              <button onclick='checkReg(&#34;PATIO&#34;)' class='Small'>Patio</button> &nbsp; &nbsp;
              <br>
              <button onclick='checkDist(&#34;9&#34;)' class='Small'>Houston</button> &nbsp; &nbsp;
              <button onclick='checkDist(&#34;20&#34;)' class='Small'>Dallas/FtW</button> &nbsp; &nbsp;
              <button onclick='checkDist(&#34;35&#34;)' class='Small'>Ski Chalet</button> &nbsp; &nbsp;
              <button onclick='checkDist(&#34;38&#34;)' class='Small'>Boston</button> &nbsp; &nbsp;
              <button onclick='checkDist(&#34;41&#34;)' class='Small'>OKC</button> &nbsp; &nbsp;
              <button onclick='checkDist(&#34;52&#34;)' class='Small'>Charl</button> &nbsp; &nbsp;
              <button onclick='checkDist(&#34;53&#34;)' class='Small'>Nash</button> &nbsp; &nbsp;
              <br>
              <button onclick='checkMall(&#34;&#34;)' class='Small'>Mall</button> &nbsp; &nbsp;
              <button onclick='checkMall(&#34;NOT&#34;)' class='Small'>Non-Mall</button> &nbsp; &nbsp;

              <button class="Small" onClick="setAll(false)">Reset</button><br><br>
              <%}%>
            <%}%>
         </td>
        </tr>
      
      
       
      <!-- ============================== Weekly ================================= -->
      <tr><td style="border-top: darkred solid 1px;">&nbsp;</td></tr>
      
      <!-- ===================== Monthly and Quarterly ===================== -->
      <TR id="trYrSel">
          <TD style="text-align:center;">
          		Fiscal Year: <SELECT name="Year"></SELECT>
          		 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          		Qtr1-Qtr2: <input type="radio" name="Qtr" value=="1" checked>
          			 &nbsp; &nbsp; 
          		Qtr3-Qtr4: <input type="radio" name="Qtr" value=="2">
          </TD>
          
      </TR>      
      <TR><td>&nbsp;</td></TR>
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
