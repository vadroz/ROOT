<%@ page import=" operatorpanel.GetJobLog"%>
<% GetJobLog joblog = new GetJobLog();
   String sJobName = request.getParameter("job");
   String sUser = request.getParameter("user");
   String sJobNum = request.getParameter("num");
   joblog.getJLog(sJobName, sUser, sJobNum);
%>
<html>
 <head>
           <SCRIPT language="JavaScript">
		document.write("<style>body {background:ivory;}");
                document.write("a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}" );
                document.write("table.DataTable { color:MediumSpringGreen; background:black; border: darkred solid 1px;text-align:left; font-family:Courier; font-size:10px}");
                document.write("th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }");
                document.write("td.DataTable { padding-top:3px; padding-bottom:3px; text-align:left; font-family:Arial; font-size:10px; }");
		document.write("td.DataTable1 { background:lightgrey; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:left; font-family:Arial; font-size:10px }");
                document.write("td.DataTable2 { background:cornsilk; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:left; font-family:Arial; font-size:10px }");
		document.write("</style>");
           </SCRIPT>
 </head>
 <body>

         <div id="tooltip2" style="position:absolute;visibility:hidden;
              border: black solid 1px; width:150px;background-color:LemonChiffon; z-index:10"></div>
         <div align="CENTER" name="divTest" onMouseover="showtip2(this,event,' ');" onMouseout="hidetip2();" STYLE="cursor: hand">
         </div>

   <table border="0" width="100%" height="100%">
            <tr>
            <td height="20%" COLSPAN="2">
              <img src="Sun_ski_logo4.png" /></td>
             </tr>
             <tr bgColor="moccasin">
             <td  VALIGN="TOP" WIDTH="15%" bgColor="A7B5E8">
    <font color="#445193" size="2" face="Arial">
    &#160;&#160;<a class="blue" href="../">Home</a>
    </font>
    <font color="#445193" size="1" face="Arial">
    <h5>&#160;&#160;Miscellaneous</h5>
    &#160;&#160;<a class="blue" href="MAILTO:helpdesk@retailconcepts.cc">Mail to IT</a>
    <br/>&#160;&#160;<a class="blue" href="http://sunandski.com/">Our Internet</a>
    <br/>
    </font></td>
      <td ALIGN="center" VALIGN="TOP">
      <b>"Retail Concepts, Inc"
      <br>Operator's Panel
      <br>Display Job Information</b>

      <table class="DataTable" wide="100%">
       <tr>
        <th colspan="2" align="center">Job Name: <%=sJobName%>&#160;&#160;&#160;&#160;&#160;&#160;
                      User: <%=sUser%>&#160;&#160;&#160;&#160;&#160;&#160;
                      Number: <%=sJobNum%></th></tr>
   <% if (joblog.hasMessages()) {
      String sMsg = joblog.getMsg();
      do {%>
        <tr><td><%=sMsg%></td></tr>
      <% sMsg = joblog.getMsg();
       } while(sMsg != null);
     }
    else{ System.out.println("No message found for selected job"); }
    joblog.disconnect();
  %>

      </table>

        <form name="CONTINUE" method="POST" ACTION="searchcust.SrchCustPurchase">
           <p align="center"><input type="BUTTON" name="Back" value="Back" onClick="javascript:history.back()"></input>
           <input type="HIDDEN" name="NXTRRN"></input>
        </form>
       </td>
     </tr>
  </table>

 </body>
<SCRIPT>
function hidetip2(){
    document.all.tooltip2.style.visibility="hidden"
}
        </SCRIPT>
      </html>
