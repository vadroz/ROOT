<%@ page import=" itemtransfer.ItemTrfBachList, java.util.*"%>
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
     response.sendRedirect("SignOn1.jsp?TARGET=ItmBatchApproveSel.jsp&APPL=ALL&" + request.getQueryString());
   }
   else
   {
     String sUser = session.getAttribute("USER").toString();
     ItemTrfBachList itrfbatch = new ItemTrfBachList(sSts, "Batch",  sUser);

     int iNumOfBch = itrfbatch.getNumOfBch();
     String sBatch = itrfbatch.getBatchJsa();
     String sBComment = itrfbatch.getBCommentJsa();

     sStrAllowed = session.getAttribute("STORE").toString().trim();
     if (!sStrAllowed.startsWith("ALL") || session.getAttribute("TRANSFER")==null)
     {
        response.sendRedirect("index.jsp");
     }

%>


<script name="javascript">
var Sts = "<%=sSts%>";
var Batch = [<%=sBatch%>];
var BComment = [<%=sBComment%>];

function bodyLoad()
{
   showBatch(Batch, BComment);

   if(Sts == "O") document.forms[0].Sts[0].checked = true;
   else if(Sts == "A") document.forms[0].Sts[1].checked = true;
   else if(Sts == "S") document.forms[0].Sts[2].checked = true;
}
//--------------------------------------------------------------------
// populate division drop down menu
//--------------------------------------------------------------------
function showBatch(batch, bComment) {
    var df = document.forms[0];
    for (var i = 0; i < batch.length; i++)
    {
       df.Batch.options[i] = new Option(batch[i] + " - " + bComment[i], batch[i]);
    }
    if (Batch.length == 0) df.Batch.options[i] = new Option("--- No Items to Transfer ---", 0);
}
//--------------------------------------------------------------------
// populate hidden input with division name
//--------------------------------------------------------------------
function getBatchName()
{
  var idx = document.forms[0].Batch.selectedIndex;
  document.forms[0].BComment.value = Batch[idx] + " - " + BComment[idx]
}
//--------------------------------------------------------------------
// redisplay this page with division list for different status
//--------------------------------------------------------------------
function getBatchBySts(Sts)
{
  var url="ItmBatchApproveSel.jsp?Sts=" + Sts
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

      <FORM  method="GET" action="ItmBatchApprove.jsp" onSubmit="getBatchName()">
      <TABLE>
        <TBODY>
        <TR>
          <TD align=right>Batch:</TD>
          <TD align=left>
             <SELECT name="Batch"></SELECT>
             <input name="BComment" type="hidden">
          </TD>
        </TR>

        <TR>
          <TD align=right>Status:</TD>
          <TD align=left>
             <input name="Sts" type="radio" value="O" onClick="getBatchBySts(this.value)">Pending &nbsp;&nbsp;&nbsp;
             <input name="Sts" type="radio" value="A" onClick="getBatchBySts(this.value)">Approved &nbsp;&nbsp;&nbsp;
             <input name="Sts" type="radio" value="S" onClick="getBatchBySts(this.value)">Sent
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