<%@ page import=" rciutility.StoreSelect ,java.util.*, java.text.*"%>
<%
if (session.getAttribute("USER")==null || session.getAttribute("SRCHTRAN") == null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=StrTranSearchSel.jsp&APPL=ALL");
}
else
{
   // Get allowed Store List
   StoreSelect strsel = new StoreSelect();
   int iNumOfStr = strsel.getNumOfStr();
   String sStr = strsel.getStrNum();
   String sStrName = strsel.getStrName();
%>

<script LANGUAGE="JavaScript1.2" src="Calendar.js">
</script>

<script name="javascript">
var Store = [<%=sStr%>];
var StrName = [<%=sStrName%>];
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   popStoreSelect();
}

//==============================================================================
// populate class selection
//==============================================================================
function popStoreSelect() {
   var str = document.all.Store;

   //  clear current classes
        for (var i = str.length; i >= 0; i--) { str.options[i] = null; }
   //  populate the class list
        for (var i=0; i < Store.length; i++)
        {
          str.options[i] = new Option(Store[i] + " - " + StrName[i], Store[i]);
        }
        str.focus();
}

//==============================================================================
// Validate form
//==============================================================================
function Validate()
{
   var error = false;
   var msg ="";

   var store = document.all.Store.options[ document.all.Store.selectedIndex ].value;
   var storenm = document.all.Store.options[ document.all.Store.selectedIndex ].text;
   var trans = document.all.Tran.value

   if (isNaN(trans)){ error = true; msg += "Transaction number is not numeric." }
   else if( trans.trim() == "" ){ error = true; msg += "Pleas, type transaction number." }

   if (error) { alert(msg); }
   else { sbmReport(store, storenm, trans); }
}
//==============================================================================
// submit report
//==============================================================================
function sbmReport(str, storenm, tran)
{
   var url = "StrTranSearch.jsp?Store=" + str + "&StrName=" + storenm
           + "&Tran=" + tran

   window.location.href = url
}
</script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>

<HTML><HEAD>

<META content="Microsoft FrontPage 4.0" name=GENERATOR></HEAD>
<BODY onload="bodyLoad();">

<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR>
    <TD height="20%"><IMG
    src="Sun_ski_logo4.png"></TD></TR>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Search Store Transactions - Selection</B>

        <br><A class=blue href="/index.jsp">Home</A>

      <TABLE>
        <TBODY>
        <!-- ------------- Division  --------------------------------- -->
        <TR>
          <TD align=right>Store:</TD>
          <TD align=left>
             <SELECT name="Store"></SELECT>
             <INPUT type=hidden name=StrName>
          </TD>
        </TR>

        <!-- ------------- Hours or Salary  --------------------------------- -->
        <TR>
          <TD align=right>Transaction:</TD>
          <TD align=left><INPUT name="Tran" size=5 maxlength=5></TD>
        </TR>
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
        <TR>
            <TD></TD>
            <TD align=center colSpan=2>
               <button onClick="Validate()">Submit</button>
           </TD>
          </TR>
         </TBODY>
        </TABLE>
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
<%}%>