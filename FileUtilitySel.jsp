<%@ page import="java.util.*"%>
<%
%>

<script name="javascript">

function bodyLoad()
{
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
    <TD vAlign=top align=center>
        <B>Retail Concepts Inc.
        <BR>File Utility - Selection</B>

      <FORM  method="GET" action="FileUtility.jsp">
      <TABLE>
        <TBODY>
        <TR>
          <TD align=right>File:</TD>
          <TD align=left>
             <input name="File" type="text" maxlength="10" size="10">
          </TD>
        </TR>

        <TR>
          <TD align=right>Library:</TD>
          <TD align=left>
             <input name="Lib" type="text" maxlength="10" size="10" value="*LIBL">
          </td>
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
