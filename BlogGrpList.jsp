<%@ page import="miniblog.BlogGrpList, java.sql.* ,java.util.*, java.text.*, java.math.*"%>
<%
   String sBlogGrp = request.getParameter("BlogGrp");
   String sBlogGrpNm = request.getParameter("BlogGrpNm");
   String [] sPrevGrp = request.getParameterValues("PrevGrp");
   String [] sPrevGrpNm = request.getParameterValues("PrevGrpNm");

   if(sBlogGrp == null){ sBlogGrp = "0"; }
   if(sBlogGrpNm == null){ sBlogGrpNm = "Main"; }
   if(sPrevGrp == null)
   {
      sPrevGrp = new String[]{"0"};
      sPrevGrpNm = new String[]{"Main"};
   }

  //-------------- Security ---------------------
  String sAppl = "MINIBLOG";

  if (session.getAttribute("USER")==null || session.getAttribute(sAppl)==null)
  {
     response.sendRedirect("SignOn1.jsp?TARGET=BlogGrpList.jsp&APPL=" + sAppl + "&" + request.getQueryString());
  }
  else
  {
     BlogGrpList bloglist = new BlogGrpList(sBlogGrp);

     int iNumOfGrp = bloglist.getNumOfGrp();
     BigDecimal [] bdGrpNum = bloglist.getGrpNum();
     String [] sGrpName = bloglist.getGrpName();
     BigDecimal [] bdGrpPrtNum = bloglist.getGrpPrtNum();
     int [] iNumOfTopic = bloglist.getNumOfTopic();
     int [] iNumOfMsg = bloglist.getNumOfMsg();
     Timestamp [] tsLastMsg = bloglist.getLastMsg();
     String [] sLastUser = bloglist.getLastUser();
     boolean [] bTopicLvl = bloglist.getTopicLvl();

     // reforamt timestamp
     SimpleDateFormat formatter = new SimpleDateFormat("MM/dd/yyyy 'at' hh:mm");
%>

<html>
<head>

<style>body {background:#F0FFF0;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}

        a.tdlnk:link { color:#2b7ebb; font-weight:bold}
        a.tdlnk:visited { color:#2b7ebb; font-weight:bold}
        a.tdlnk:hover { color: #ff6600; font-weight:bold}

        table.DataTable { border:#2b7ebb 2px solid; background:white; text-align:center;}

        th.HdrTable{ filter:progid:DXImageTransform.Microsoft.Gradient(startColorStr=#2b7ebb, endColorStr=#1b9cc5,
                 gradientType=0);
                 padding-top:3px; padding-bottom:3px; border:white 1px solid;
                 color: #fbb117; vertical-align:top; text-align:center; font-size:16px; font-weight:bold }

        tr.DataTable  { background:#f2f2f2; font-family:Arial; font-size:18px }

        td.DataTable  { padding-top:3px; padding-bottom:3px; text-align:left }
        td.DataTable1 { padding-top:3px; padding-bottom:3px; text-align:center; font-size:12px }
        td.DataTable2 { padding-top:3px; padding-bottom:3px; text-align:left; font-size:12px}

        input.small{ padding-left:0px; padding-right:0px; padding-top:0px; padding-bottom:0px; text-align:left; font-family:Arial; font-size:10px;}
        select.small{ padding-left:0px; padding-right:0px; padding-top:0px; padding-bottom:0px; text-align:left; font-family:Arial; font-size:10px;}
        button.small{ padding-left:0px; padding-right:0px; padding-top:0px; padding-bottom:0px; text-align:center; font-family:Arial; font-size:10px;}
        textarea.small{ text-align:left; font-family:Arial; font-size:10px;}

        td.Grid  { background:darkblue; color:white; text-align:center; font-family:Arial; font-size:11px; font-weight:bolder}
        tr.Grid1 { text-align:center; font-family:Arial; font-size:10px;}
        td.Grid2  { background:darkblue; color:white; text-align:right; font-family:Arial; font-size:11px; font-weight:bolder}
</style>

<SCRIPT language="JavaScript">
PrevGrp = [<%=bloglist.cvtToJavaScriptArray(sPrevGrp)%>];
PrevGrpNm = [<%=bloglist.cvtToJavaScriptArray(sPrevGrpNm)%>];

//==============================================================================
// populate selection fields on page load
//==============================================================================
function bodyLoad()
{
}
//==============================================================================
// show selected group
//==============================================================================
function showGrpLst(grpnum,  grpnm)
{
   var url = "BlogGrpList.jsp?BlogGrp=" + grpnum
           + "&BlogGrpNm=" + grpnm

   if(PrevGrp.length > 1)
   {
     PrevGrp[PrevGrp.length] = "<%=sBlogGrp%>";
     PrevGrpNm[PrevGrpNm.length] = "<%=sBlogGrpNm%>";
   }

   for(var i=0; i < PrevGrp.length; i++)
   {
      url += "&PrevGrp=" + PrevGrp[i]
      url += "&PrevGrpNm=" + PrevGrpNm[i]
   }
   //alert(url)
   window.location.href=url
}

//==============================================================================
// show selected group
//==============================================================================
function showTopicLst(grpnum,  grpnm)
{
   var url = "BlogTopicList.jsp?BlogGrp=" + grpnum
           + "&BlogGrpNm=" + grpnm

   if(eval(<%=sBlogGrp%>) > 0)
   {
     PrevGrp[PrevGrp.length] = "<%=sBlogGrp%>";
     PrevGrpNm[PrevGrpNm.length] = "<%=sBlogGrpNm%>";
   }

   // add current group to hierarchy of topics
   for(var i=0; i < PrevGrp.length; i++)
   {
      url += "&PrevGrp=" + PrevGrp[i]
      url += "&PrevGrpNm=" + PrevGrpNm[i]
   }

   //alert(url)
   window.location.href=url
}
//==============================================================================
// go to prior group
//==============================================================================
function goPriorGrp(arg)
{
  var url = "BlogGrpList.jsp?BlogGrp=" + PrevGrp[arg]
           + "&BlogGrpNm=" + PrevGrpNm[arg]
  if(PrevGrp[arg] > 0)
  {
     for(var i=0; i < PrevGrp.length; i++)
     {
        url += "&PrevGrp=" + PrevGrp[i]
        url += "&PrevGrpNm=" + PrevGrpNm[i]
     }
   }
   //alert(url)
   window.location.href=url
}
</SCRIPT>


</head>
<body  onload="bodyLoad();">
<!-- ======================================================================= -->
<div id="MsgMenu" style="position:absolute;visibility:hidden; background-attachment: scroll;
              border: black solid 1px; width:150px;background-color:LemonChiffon; z-index:10"></div>
<!-- ======================================================================= -->

   <table border="0" width="100%" height="100%" cellPadding="0" cellSpacing="0">
     <tr>
       <td ALIGN="center" VALIGN="TOP">
      <b>Retail Concepts, Inc
      <br>RCI Forum List</font>
      <br><font size="+2" color="#2b7ebb"><%=sBlogGrpNm%></font>
      </b>

      <br><a href="../"><font color="red">Home</font></a>
      <!-- Show prior group list -->
      <%if(!sBlogGrp.equals("0")){%>
        <%for(int i=0; i < sPrevGrp.length; i++){%>
          &#62; <a href="javascript: goPriorGrp(<%=i%>)"><%=sPrevGrpNm[i]%></a>
        <%}%>
      <%}%>
      &#62;This page
<!------------- start of dollars table ------------------------>
      <table class="DataTable" width="100%">
             <tr>
                <th class="HdrTable">Forum</th>
                <th class="HdrTable" width=10%>Topics</th>
                <th class="HdrTable" width=10%>Messages</th>
                <th class="HdrTable" width=30%>Last Message</th>
             </tr>

             <%for(int i=0; i < iNumOfGrp; i++){%>
                <tr class="DataTable">
                   <td class="DataTable">
                      <%if(!bTopicLvl[i]){%>
                          <a class="tdlnk" href="javascript: showGrpLst('<%=bdGrpNum[i]%>', '<%=sGrpName[i]%>')"><%=sGrpName[i]%></a>
                      <%}
                      else {%>
                        <a class="tdlnk" href="javascript: showTopicLst('<%=bdGrpNum[i]%>', '<%=sGrpName[i]%>')"><%=sGrpName[i]%></a>
                      <%}%>
                   </td>
                   <td class="DataTable1"><%=iNumOfTopic[i]%></td>
                   <td class="DataTable1"><%=iNumOfMsg[i]%></td>
                   <td class="DataTable2">
                     <%if(tsLastMsg[i] != null){%><%=formatter.format(tsLastMsg[i]) + " &nbsp;  modified by " + sLastUser[i]%>
                     <%} else {%>no messages<%}%>
                   </td>
               </tr>
             <%}%>
       </table>

       </td>
    </tr>
  </table>

</body>
</html>
<%}%>