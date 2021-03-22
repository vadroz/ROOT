<%@ page import="payrollreports.PayEntry, java.util.*, java.text.*"%>
<%
   String sStore = request.getParameter("Store");
   String sStrName = request.getParameter("StrName");
   String sWeekend = request.getParameter("Week");
   String sCurrwk = request.getParameter("Currwk");
   boolean bCurWk = sCurrwk.equals("true");
   String sType = request.getParameter("Type");
      
   //if(sStore.equals("82")){ bCurWk = true; }
   if(sType==null){ sType = "Labor";}

//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=PayEntry.jsp&APPL=ALL");
}
else
{

   String sStrAllowed = session.getAttribute("STORE").toString();
   String sUser = session.getAttribute("USER").toString();

   boolean bStrAlwed = false;
   if (sStrAllowed != null && (sStrAllowed.startsWith("ALL") || sStrAllowed.equals(sStore)))
   {
     bStrAlwed = true;
   }
   else
   {
     Vector vStr = (Vector) session.getAttribute("STRLST");
     Iterator iter = vStr.iterator();
     while (iter.hasNext())
     {
        if (((String)iter.next()).equals(sStore)){ bStrAlwed = true; }
     }
   }
   if(!bStrAlwed){ response.sendRedirect("PayEntrySel.jsp"); }


   SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
   Date date = sdf.parse(sWeekend);
   date = new Date(date.getTime() - 86400000 * 7);
   String [] sDateOfWk = new String[7];

   for(int i=0; i < 7; i++)
   {
      date = new Date(date.getTime() + 86400000);
      sDateOfWk[i] = sdf.format(date);
   }

    sUser = session.getAttribute("USER").toString();

    PayEntry payent = new PayEntry(sStore, sType, sWeekend, sUser);

    // payment type headings
    int iNumOfPyTy = payent.getNumOfPyTy();
    String [] sPyTy = payent.getPyTy();
    String [] sPyTyNm = payent.getPyTyNm();
    String [] sHrsOrAmt = payent.getHrsOrAmt();
    String [] sSubTy = payent.getSubTy();

    // payment type headings in forms to Javascript arrays
    String sPyTyJsa = payent.getPyTyJsa();
    String sPyTyNmJsa = payent.getPyTyNmJsa();
    String sHrsOrAmtJsa = payent.getHrsOrAmtJsa();
    String sSubTyJsa = payent.getSubTyJsa();

    // employee with entered labor payments
    int iNumOfEmp = payent.getNumOfEmp();

    // store employees
    int iNumOfStrEmp = payent.getNumOfStrEmp();
    String [] sStrEmp = payent.getStrEmp();
    String [] sStrEmpName = payent.getStrEmpName();

    String [] sDayOfWk = new String[]{"Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"};
%>

<html>
<head>

<style>
  body {background:ivory;}
  a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
  table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}
  th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                 border-bottom: darkred solid 1px; border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }

  tr.DataTable { background:#e7e7e7; font-family:Arial; font-size:12px }
  tr.DataTable1 { background:white; font-family:Arial; font-size:10px }
  tr.Divider { font-size:3px }


  td.DataTable { background: cornsilk; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                 border-bottom: darkred solid 1px;
                 border-right: darkred solid 1px; text-align:left;}
  td.DataTable01 { background: cornsilk; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                 border-bottom: darkred solid 1px;
                 border-right: darkred solid 1px; text-align:right;}

  td.DataTable1{ cursor: hand; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                 border-bottom: darkred solid 1px;
                 border-right: darkred solid 1px; text-align:right;}
  td.DataTable2{ background: seashell;  padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                 border-bottom: darkred solid 1px;
                 border-right: darkred solid 1px; text-align:center;}
  td.DataTable3 { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                 border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:left;}

  table.Help { background:white;text-align:center; font-size:12px;}

  div.Prompt { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:250; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move; background-color: blue; color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand; background-color: blue; color:white; border-bottom: black solid 1px; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left;font-family:Arial; font-size:12px; }
        td.Prompt1 { text-align:center;font-family:Arial; font-size:12px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:12px; }
   .Small {font-family: times; font-size:10px }
</style>

<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------

var Stores = "<%=sStore%>"
var StoreNames = "<%=sStrName%>"

var PyType = [<%=sPyTyJsa%>];
var PyTypeNm = [<%=sPyTyNmJsa%>];
var HrsOrAmt = [<%=sHrsOrAmtJsa%>];
var SubType = [<%=sSubTyJsa%>];
var Type = "<%=sType%>";

//--------------- End of Global variables ----------------
//---------------------------------------------
// initialize value on load
//---------------------------------------------
function  bodyload()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvPrompt"]);
   //showError();
}
//==============================================================================
// show Item change panel
//==============================================================================
function addPay(emp, empnm, day, pyty, subty, amt)
{
	var hdr = "Payment/Time Entry";   
	if(Type=="Bike"){ hdr = "Bike Build Entry"; }
	
	var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popPayPanel()+ "</td></tr>"
   + "</table>"

   document.all.dvPrompt.innerHTML = html;
   document.all.dvPrompt.style.pixelLeft= document.documentElement.scrollLeft + 100;
   document.all.dvPrompt.style.pixelTop= document.documentElement.scrollTop + 65;
   document.all.dvPrompt.style.visibility = "visible";

   if(emp != null)
   {
      document.all.Emp.value = emp;
      document.all.Emp.readOnly = true;
      document.all.spEmpNm.innerHTML = empnm;
   }
   // lock the day
   if(day != null)
   {
      var dayfld = document.all.Day;
      for(var i=0; i < 7; i++)
      {
         if(i == day){ dayfld[i].checked = true; }
         else{ dayfld[i].checked = false; dayfld[i].style.display = "none";}
      }
   }

   // lock pay type
   var subfld = document.all.SubType;
   for(var i=0; i < subfld.length; i++ )
   {
      if(subfld[i].value == subty)
      {
         document.all.inpPyType[i].checked = true;
         break;
      }
   }

   if(amt != null)
   {
      document.all.Amt.value = amt;
   }
   
   if(Type == "Bike")
   {
     document.all.inpPyType[0].checked=true;
     document.all.inpPyType[1].style.display="none";
     document.all.spnPyTy[1].style.display="none";
     chkPayType();
   }
   else
   {
	   document.all.inpPyType[2].style.display="none";	     
	   document.all.spnPyTy[2].style.display="none";	    
   } 
}
//--------------------------------------------------------
// populate Entry Panel
//--------------------------------------------------------
function popPayPanel()
{
  var panel = "<table border=0 width='100%' cellPadding='0' cellSpacing='0'>"

  // Employee number
  panel += "<tr><td class='Prompt2' nowrap>Employee:&nbsp;&nbsp;</td>"
         + "<td class='Prompt' nowrap><input class='Small' name='Emp' size=4 maxlength=4> &nbsp;"
         + "<span id='spEmpNm'></span>"
         + "</td></tr>";

  // Day
  panel += "<tr><td class='Prompt2' nowrap>Day:&nbsp;&nbsp;</td>"
         + "<td class='Prompt' nowrap>"
           + "<input type='radio' class='Small' name='Day' value='0'>Mon &nbsp; "
           + "<input type='radio' class='Small' name='Day' value='1'>Tue &nbsp; "
           + "<input type='radio' class='Small' name='Day' value='2'>Wed &nbsp; "
           + "<input type='radio' class='Small' name='Day' value='3'>Thu &nbsp; "
           + "<input type='radio' class='Small' name='Day' value='4'>Fri &nbsp; "
           + "<input type='radio' class='Small' name='Day' value='5'>Sat &nbsp; "
           + "<input type='radio' class='Small' name='Day' value='6'>Sun&nbsp;"
         + "</td></tr>";

  // Payment type
  panel += "<tr><td class='Prompt2' nowrap>" 
  if(Type!="Bike"){ panel += "Payment Type:&nbsp;&nbsp;" } 	  
	  
  panel += "</td>"
         + "<td class='Prompt' nowrap>"
           + popEntryType()
         + "</td></tr>";

  // Payment/Time Amount
  panel += "<tr><td class='Prompt2' nowrap><span id='spnAmtName'>Dollars:&nbsp;&nbsp;</span></td>"
         + "<td class='Prompt' nowrap><input class='Small' name='Amt' size=7 maxlength=7 onblur='clcTotal()'>"
         + "<span id='spnBikeBld'></span>"
         + "</td></tr>";
  panel += "<tr><td class='Prompt' nowrap colspan=2><span id='spnNote' style='color:darkred;'></span></td></tr>"


  // buttons
  panel += "<tr><td class='Prompt1' colspan='2'>"
        + "<button id='Submit' onClick='ValidatePayEnt()' class='Small'>Submit</button>&nbsp;"
        + "<button onClick='hidePanel();' class='Small'>Close</button>&nbsp;&nbsp;&nbsp;"
  panel += "</td></tr></table>";

  return panel;
}
//--------------------------------------------------------
// create Entry Types radio button fields
//--------------------------------------------------------
function popEntryType()
{
   var panel = "";
   for(var i=0; i < PyType.length; i++)
   {	   
      panel += "<input type='radio' class='Small' name='inpPyType' onclick='chkPayType()' value='"
          + PyType[i] + "'><span id='spnPyTy'>" + PyTypeNm[i] + "</span>"
        + " <input  type='hidden' name='SubType' value='" + SubType[i] + "'>"
        + "&nbsp; &nbsp;"
   }
   
   return panel;
}
//==============================================================================
// check and switch entry boxes for pay types
//==============================================================================
function chkPayType()
{
   var ptsel = document.all.inpPyType;
   var subsel = document.all.SubType;
   var subty = 0;

   for(var i=0; i < ptsel.length; i++)
   {
     if(ptsel[i].checked) { subty = subsel[i].value; break; }
   }

   if(subty != "4")
   {
      document.all.spnAmtName.innerHTML = "Dollars:&nbsp;&nbsp;";
      document.all.spnBikeBld.innerHTML = "";
      document.all.spnNote.innerHTML = ""
   }
   else
   {
      document.all.spnAmtName.innerHTML = "Number of Bikes Built:&nbsp;&nbsp;";
      //document.all.spnBikeBld.innerHTML = "&nbsp;&nbsp; x $3.00";
      //document.all.spnNote.innerHTML = "As of 6/25/12 bike builds no longer are paid $7 per bike built.  New rate is hourly rate + $3 per bike built.  <br>Please enter only the <u>number of bikes built</u> for the day you are entering build sheets."

      var error = false;
      var amt = document.all.Amt.value.trim();
      if(amt == "" || isNaN(amt)) { error = true; }
      if(!error)
      {
         var tot = eval(amt) * 3;
         //document.all.spnBikeBld.innerHTML = "&nbsp;&nbsp; * $3.00 = &nbsp; $" + tot;
      }
   }
}
//==============================================================================
// calculate labor total
//==============================================================================
function clcTotal()
{
   var ptsel = document.all.inpPyType;
   var subsel = document.all.SubType;
   var subty = 0;

   for(var i=0; i < ptsel.length; i++)
   {
     if(ptsel[i].checked) { subty = subsel[i].value; break; }
   }

   if(subty == "4")
   {
      var error = false;
      var amt = document.all.Amt.value.trim();
      if(amt == "" || isNaN(amt)) { error = true; }
      if(!error)
      {
         var tot = eval(amt) * 3;
         //document.all.spnBikeBld.innerHTML = "&nbsp;&nbsp; * $3.00 = &nbsp; $" + tot;
      }
   }
}
//--------------------------------------------------------
// populate Entry Panel
//--------------------------------------------------------
function hidePanel()
{
   document.all.dvPrompt.style.visibility = "hidden";
   SelItem = null;
   NewQty = null;
}
//==============================================================================
// validate payemnt entry screen
//==============================================================================
function ValidatePayEnt()
{
   var msg ="";
   var error = false;

   // check employee number
   var emp = document.all.Emp.value.trim();
   if(emp == ""){ error = true; msg += "Enter employee number.\n" }
   else if( isNaN(emp) || eval(emp) == 0) { error = true; msg += "Employee number is 0 or contained non-numeric characters.\n" }

   // checked if day selected
   var dayfld = document.all.Day;
   var day = null;
   for(var i=0; i < dayfld.length; i++)
   {
      if(dayfld[i].checked){ day = dayfld[i].value; break}
   }
   if(day == null){ error = true; msg += "Select day of week.\n" }

   // checked if payment type selected
   var payfld = document.all.inpPyType;
   var pay = null;
   var subfld = document.all.SubType;
   var sub = null;
   for(var i=0; i < payfld.length-1; i++)
   {
      if(payfld[i].checked)
      {
         pay = payfld[i].value;
         sub = subfld[i].value;
         break;
      }
   }
   if(pay == null){ error = true; msg += "Select pay type.\n" }

   // check entered amount
   var amt = document.all.Amt.value.trim();
   if(amt == ""){ error = true; msg += "Enter amount.\n" }
   else if( isNaN(amt)) { error = true; msg += "Amount is contained non-numeric characters.\n" }
   // calculate bike builder labor cost
   //if(!error && sub == "4") { amt = eval(amt) * 3;  }

   if(error){ alert(msg) }
   else { sbmPayEnt(emp, day, pay, sub, amt)  }
}
//==============================================================================
// show Carton details
//==============================================================================
function sbmPayEnt(emp, day, pytype, subtype, amt)
{
   var url = "PayEntrySav.jsp?Store=<%=sStore%>"
           + "&Week=<%=sWeekend%>"
           + "&Emp=" + emp
           + "&Day=" + day
           + "&PyType=" + pytype
           + "&SubType=" + subtype
           + "&Amt=" + amt
   //alert(url)
   //window.location.href = url
   window.frame1.location.href = url
}
//==============================================================================
// restart after item entry
//==============================================================================
function reStart(err)
{
   msg = "";
   if(err != null && err.length > 0 )
   {
      for(var i=0; i < err.length; i++) { msg += err[i] + "\n"}
      alert(msg)
   }
   else { window.location.reload() }
}
</SCRIPT>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>

</head>
<body onload="bodyload()">
<!-------------------------------------------------------------------->
  <div id="dvPrompt" class="Prompt"></div>
<!-------------------------------------------------------------------->
<iframe id="frame1" src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->

 <table border="0" width="100%" cellPadding="0" cellSpacing="0">
   <tr>
      <td ALIGN="center" VALIGN="TOP" nowrap>
      <b>Retail Concepts, Inc
      
      <br><%if(sType.equals("Labor")){%>Employee Labor Entry<%}
             else {%>Employee Bike Builds Entry<%}%>
             
      <br>Store: <%=sStrName%> &nbsp;  &nbsp; &nbsp; &nbsp; Week: <%=sWeekend%>
      </b>
     <tr>
      <td ALIGN="center" VALIGN="TOP">

      <a href="/"><font color="red" size="-1">Home</font></a>&#62;
      <a href="PayEntrySel.jsp?Type=<%=sType%>"><font color="red" size="-1">Select Store/Week</font></a>&#62;
      <font size="-1">This Page.</font>&nbsp;&nbsp&nbsp;&nbsp&nbsp;&nbsp<br><br>

      </td>
   </tr>

   <tr>
      <td ALIGN="center" VALIGN="TOP">

  <!----------------- beginning of table ------------------------>
  <table class="DataTable" cellPadding="0" cellSpacing="0">
    <tr>
      <th class="DataTable" rowspan=3>Employee <!-- %if(bCurWk){% ><br><a href="javascript: addPay(null, null, null, 0, 0, null)">New Entry</a>< %}% --></th>
      <th class="DataTable" rowspan=3>Pay Type</th>
      <th class="DataTable" colspan=7>Days of Week</th>
      <th class="DataTable" rowspan=3>&nbsp;</th>
      <th class="DataTable" rowspan=3>Total</th>
    </tr>

    <tr>
      <%for(int i=0; i < 7; i++){%>
         <th class="DataTable"><%=sDayOfWk[i]%></th>
      <%}%>
    </tr>
    <tr>
      <%for(int i=0; i < 7; i++){%>
         <th class="DataTable"><%=sDateOfWk[i]%></th>
      <%}%>
    </tr>
<!------------------------------- Detail Data --------------------------------->
    <%
      for(int i=0; i<iNumOfEmp; i++)
      {
         payent.getEmpPayInfo();
         String sEmp = payent.getEmp();
         String sEmpName = payent.getEmpName();

         int iEmpMax = payent.getEmpMax();
         String [][] sPayType = payent.getPayType();
         String [][] sHorA = payent.getHorA();
         String [][] sPaid = payent.getPaid();
         String [][] sSubType = payent.getSubType();

         String [] sEmpDayAmt = payent.getEmpDayAmt();
    %>
         <tr class="DataTable">
           <td class="DataTable" rowspan=<%=iNumOfPyTy%>>
           <%if(bCurWk){%>
              <a href="javascript: addPay('<%=sEmp%>', '<%=sEmpName%>', null, 0, 0, null)"><%=sEmp + " " + sEmpName%></a></td>
           <%} else {%><%=sEmp + " " + sEmpName%><%}%>


           <%for(int j=0; j < iNumOfPyTy; j++){%>
              <%if(j > 0){%><tr class="DataTable"><%}%>

                 <td class="DataTable"><%=sPyTyNm[j]%></td>
                 <%for(int k=0; k < 8; k++){%>
                    <%if(k==7){%><th class="DataTable">&nbsp;</th><%}%>
                    <%if(j < iNumOfPyTy - 1){%>
                        <td class="DataTable1" <%if(bCurWk){%>onClick="addPay('<%=sEmp%>', '<%=sEmpName%>', '<%=k%>', '<%=j%>', '<%=sSubTy[j]%>', '<%=sPaid[k][j]%>')"<%}%>>
                           <%if(!sPaid[k][j].equals(".00")){%><%if(!sType.equals("Bike")){%>$<%}%><%=sPaid[k][j]%><%} else {%>&nbsp;<%}%></td>
                    <%}%>
                    <!-- employee total-->
                    <%if(j == iNumOfPyTy - 1){%>
                       <td class="DataTable01"><%if(!sType.equals("Bike")){%>$<%}%><%=sEmpDayAmt[k]%></td>
                    <%}%>
                 <%}%>
           <%}%>

         </tr>
         <tr class="Divider"><th>&nbsp;<th></tr>
    <%}%>
<!---------------------------- end of Report Totals ------------------------------>
 </table>
 <!----------------------- end of table ------------------------>

 <!----------------- beginning of Store employee list ------------------------>
 <br>
  <table class="DataTable" width="40%" cellPadding="0" cellSpacing="0">
    <tr>
      <th class="DataTable">Store Employees</th>
    </tr>
    <tr>
      <th class="DataTable">Employee</th>
    </tr>
    <%for(int i=0; i<iNumOfStrEmp; i++){%>
       <tr class="DataTable1">
          <td class="DataTable3">
            <%if(bCurWk){%>
               <a href="javascript: addPay('<%=sStrEmp[i]%>', '<%=sStrEmpName[i]%>', null, 0, 0, null)">
                   <%=sStrEmp[i] + " " + sStrEmpName[i]%></a>
            <%} else {%><%=sStrEmp[i] + " " + sStrEmpName[i]%><%}%>
          </td>
       </tr>
    <%}%>
  </table>
  <!---------------------------- end store employee list ------------------------------>

  </table>
 </body>
</html>
<%
payent.disconnect();
payent = null;
}%>