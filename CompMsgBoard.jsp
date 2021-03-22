<%@ page import="menu.AlertClient, java.text.*, java.util.*"%>
<%
     AlertClient alClient = new AlertClient();

     int iNumOfMsg = alClient.getNumOfMsg();
     String [] sDate = alClient.getDate();
     String [] sTime = alClient.getTime();
     String [] sText = alClient.getText();
     String [] sFont = alClient.getFont();
     String [] sColor = alClient.getColor();
     String [] sBgClr = alClient.getBgClr();
%>
<HTML>
<HEAD>
<title>RCI Message Board</title>
<META content="RCI, Inc." name="RCI_Message_Board">
<meta http-equiv="refresh" content="60">
</HEAD>

<style>body {background:ivory;}
        a:link { color:blue; font-size:12px} a:visited { color:blue; font-size:12px}  a:hover { color:red; font-size:12px}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}  a:hover.small { color:red; font-size:10px}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px; text-align:center; font-family:Verdanda; font-size:12px }
        td.DataTable { padding-top:3px; padding-bottom:3px; text-align:left; font-family:Verdanda; font-size:12px }
        td.DataTable1 { padding-top:3px; padding-bottom:3px; text-align:right; font-family:Verdanda; font-size:12px; font-weight:bold; }

   div.dvSbmSts { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:500; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}
</style>


<script name="javascript1.2">
var NumOfMsg = <%=iNumOfMsg%>;
//==============================================================================
// on loading
//==============================================================================
function bodyload()
{
    if(NumOfMsg > 0)
    {
      try{
           parent.document.all.frmAlarm.style.display="block";
      } catch(err){  }
      setInterval('blinkIt()',500);
    }
    else
    {
       try{
          parent.document.all.frmAlarm.style.display="none";
       } catch(err){  }
    }
}
//==============================================================================
// blink it
//==============================================================================
function blinkIt() {
 if (!document.all) return;
 else {
   for(i=0;i<document.all.tags('blink').length;i++){
      s=document.all.tags('blink')[i];
      s.style.visibility=(s.style.visibility=='visible')  ?'hidden':'visible';
   }
 }
}
</script>

<BODY onload="bodyload()">

    <%for(int i=0; i < iNumOfMsg; i++){%>
        <div style="font-size:<%=sFont[i]%>px;color:<%=sColor[i]%>; background:<%=sBgClr[i]%>">
             <blink><%=sText[i]%></blink> &nbsp; &nbsp;
             <span style="font-size:12px">Started: <%=sDate[i] + " " + sTime[i]%></span>
          </div>
    <%}%>

    <%if(iNumOfMsg==0){%><blink>None</blink><%}%>


</BODY>
</HTML>





