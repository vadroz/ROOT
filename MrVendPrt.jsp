<%
      String sVen = request.getParameter("Ven");
      String sVenName = request.getParameter("VenName");
      String sCont = request.getParameter("Cont");
      String sPhone = request.getParameter("Phone");
      String sWeb = request.getParameter("Web");
      String sEMail = request.getParameter("EMail");
      String [] sAddr = request.getParameterValues("Addr");
      String [] sIns = request.getParameterValues("Ins");

      if (sAddr==null) sAddr = new String[0];
      if (sIns==null) sIns = new String[0];
%>

<style>body {background:white;}
        a:link { color:blue; font-size:12px} a:visited { color:blue; font-size:12px}  a:hover { color:red; font-size:12px}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable1 { cursor:hand; color: blue; background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       text-align:center; font-family:Verdanda; font-size:12px; text-decoration: underline;}

        tr.DataTable { background: white; font-family:Arial; font-size:12px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left;  font-weight:bold}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;  font-weight:bold}

        .Small {font-family:Arial; font-size:10px }
</style>


<script name="javascript1.2">
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
}
//==============================================================================
//---------------------------------------------------------
//create String method Trim
//---------------------------------------------------------
function String.prototype.trim()
{ //trim leading and trailing spaces
    var s = this;
    var obj = /^(\s*)([\W\w]*)(\b\s*$)/;
    if (obj.test(s)) { s = s.replace(obj, '$2'); }
    var obj = /  /g;
    while (s.match(obj)) { s = s.replace(obj, ""); }
    return s;
}

</script>
<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>


<HTML><HEAD>

<META content="Microsoft FrontPage 4.0" name=GENERATOR></HEAD>
<BODY onload="bodyLoad();">
<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor=white>
    <TD vAlign=top align=middle><B>Sun and Ski Sports
        <BR>Customer Vendor Return Address</B><br><br><br>

<!-- ======================================================================= -->
       <table border=0 cellPadding="0" cellSpacing="0" id="tbRtvEnt">
          <tr class="DataTable">
            <td class="DataTable">Vendor:</td>
            <td class="DataTable"><%=sVenName%></td>
          </tr>
          <tr class="DataTable">
            <td class="DataTable">Contact Name:
               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            </td>
            <td class="DataTable"><%=sCont%></td>
          </tr>
          <tr class="DataTable">
            <td class="DataTable">Address:</td>
            <td class="DataTable">
                <%for(int i=0; i < sAddr.length; i++ ){%><%=sAddr[i]%><br><%}%>
            </td>
          </tr>
          <tr class="DataTable">
            <td class="DataTable">Phone:</td>
            <td class="DataTable"><%=sPhone%>
            </td>
          </tr>

          <tr class="DataTable">
            <td class="DataTable">Web Site:</td>
            <td class="DataTable"><a target="_blank" href="http://<%=sWeb%>"><%=sWeb%></a>
            </td>
          </tr>

          <tr class="DataTable">
            <td class="DataTable">e-mail:</td>
            <td class="DataTable"><a href="mailto:<%=sEMail%>"><%=sEMail%></a>
            </td>
          </tr>

          <tr class="DataTable">
            <td class="DataTable">Instruction:</td>
            <td class="DataTable">
                <%for(int i=0; i < sIns.length; i++ ){%><%=sIns[i]%><br><%}%>
            </td>
          </tr>
       </table>
<!-- ======================================================================= -->
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>