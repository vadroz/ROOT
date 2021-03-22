<%@ page import=" itemtransfer.DivSel, java.util.*"%>
<%
   String sSts = request.getParameter("Sts");
   if (sSts == null) sSts = "O";

   //----------------------------------
   // Application Authorization
   //----------------------------------
   String sAppl = "TRANSFER";
   String sStrAllowed = "";

   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=DivTrfSel.jsp&APPL=ALL&" + request.getQueryString());
   }
   else
   {
     DivSel select = new DivSel(sSts);
     String sDiv = select.getDiv();
     String sDivName = select.getDivName();

     sStrAllowed = session.getAttribute("STORE").toString().trim();
     if (!sStrAllowed.startsWith("ALL") || session.getAttribute("TRANSFER")==null)
     {
        response.sendRedirect("TransferReq.html");
     }

%>


<script name="javascript">
var Sts = "<%=sSts%>";
var Div = <%=sDiv%>;
var DivName = <%=sDivName%>;

function bodyLoad()
{
   doDivSelect(null);

   if(Sts == "O") document.forms[0].STS[0].checked = true;
   else if(Sts == "A") document.forms[0].STS[1].checked = true;
   else if(Sts == "S") document.forms[0].STS[2].checked = true;
}
//--------------------------------------------------------------------
// populate division drop down menu
//--------------------------------------------------------------------
function doDivSelect(id) {
    var df = document.forms[0];
    for (var i = 0; i < Div.length; i++)
    {
       df.DIVISION.options[i] = new Option(Div[i] + " - " + DivName[i], Div[i]);
    }
    if (Div.length == 0) df.DIVISION.options[i] = new Option("--- No Items to Transfer ---", 0);
}
//--------------------------------------------------------------------
// populate hidden input with division name
//--------------------------------------------------------------------
function getDivName()
{
  var idx = document.forms[0].DIVISION.selectedIndex;
  document.forms[0].DIVNAME.value = Div[idx] + " - " + DivName[idx]
}
//--------------------------------------------------------------------
// redisplay this page with division list for different status
//--------------------------------------------------------------------
function getDivSts(sts)
{
  var url="DivTrfSel.jsp?Sts=" + sts
  window.location.href = url;
}
</script>


<HTML><HEAD>

<BODY onload="bodyLoad();">

<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR>
    <TD colSpan=2 height="20%"><IMG
    src="Sun_ski_logo4.png"></TD></TR>
  <TR bgColor=moccasin>
    <TD vAlign=top width="15%" bgColor=#a7b5e8><FONT face=Arial color=#445193
      size=2>&nbsp;&nbsp;<A class=blue
      href="/">Home</A></FONT><FONT
      face=Arial color=#445193 size=1>
      <H5>&nbsp;&nbsp;Miscellaneous</H5>&nbsp;&nbsp;<A class=blue
      href="mailto:">Send e-mail</A> <BR>&nbsp;&nbsp;<A
      class=blue href="http://sunandski.com/">Our Internet</A> <BR></FONT></TD>
    <TD vAlign=top align=center><B>Retail Concepts Inc.
        <BR>Transfer Request Approvals - Selection</B>

      <FORM  method="GET" action="DivTrfSum.jsp" onSubmit="getDivName()">
      <TABLE>
        <TBODY>
        <TR>
          <TD align=right>Division:</TD>
          <TD align=left>
             <SELECT name="DIVISION"></SELECT>
             <input name="DIVNAME" type="hidden">
          </TD>
        </TR>

        <TR>
          <TD align=right>Status:</TD>
          <TD align=left>
             <input name="STS" type="radio" value="O" onClick="getDivSts(this.value)">Pending &nbsp;&nbsp;&nbsp;
             <input name="STS" type="radio" value="A" onClick="getDivSts(this.value)">Approved &nbsp;&nbsp;&nbsp;
             <input name="STS" type="radio" value="S" onClick="getDivSts(this.value)">Sent
          </TD>
        </TR>

        <TR>
            <TD></TD>
            <TD align=left colSpan=5>
               <INPUT type=submit value=Submit name=SUBMIT>
               &nbsp;&nbsp;&nbsp;&nbsp;
           </TD>
          </TR>
         </TBODY>
        </TABLE>
       </FORM>
       <a href="/"><font color="red" size="-1">Home</font></a>&#62;
       <a href="TransferReq.html">
         <font color="red" size="-1">Item Transfers</font></a>&#62;
         <font size="-1">This Page.</font>
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
<%}%>