<%@ page import="rciutility.RunSQLStmt, java.text.*, java.util.*"%>
<%

     String query = "select"
      + " case when Msg_Time + Start_Tm minutes > current Time then 1"
      + "  when Msg_Time + (Start_Tm + Stop_Tm) minutes > current Time then 2"
      + "  end as Type"
      + " ,(select MbText from rci.MsgBoard where MbName = Start_Nm) as StrMsg"
      + " ,(select MbText from rci.MsgBoard where MbName = Stop_Nm) as StpMsg"
      + " ,Msg_Date, Msg_Time, Start_Tm, Stop_Tm"
      + " ,(select MBFSIZE from rci.MsgBoard where MbName = Start_Nm) as StrSize"
      + " ,(select MBCOLOR from rci.MsgBoard where MbName = Start_Nm) as StrColor"
      + " ,(select MBBGCLR from rci.MsgBoard where MbName = Start_Nm) as StrBgClr"
      + " ,(select MBFSIZE from rci.MsgBoard where MbName = Stop_Nm) as StpSize"
      + " ,(select MBCOLOR from rci.MsgBoard where MbName = Stop_Nm) as StpColor"
      + " ,(select MBBGCLR from rci.MsgBoard where MbName = Stop_Nm) as StpBgClr"
      + " from rci.MSGBACT"
      + " where Msg_Date = current date"
      + " and (Msg_Time + Start_Tm minutes > current Time"
      + " or Msg_Time + (Start_Tm + Stop_Tm) minutes > current Time)";


     String [] sMsgCol = new String[]{
        "Type", "StrMsg", "StpMsg", "Msg_Date", "Msg_Time", "Start_Tm", "Stop_Tm",
        "StrSize", "StrColor", "StrBgClr", "StpSize", "StpColor", "StpBgClr"
      };

     Vector vData = new Vector();
     boolean bMessage = false;

     RunSQLStmt rsql = new RunSQLStmt();
     rsql.setPrepStmt(query);
     rsql.runQuery();
     while(rsql.readNextRecord())
     {
        String [] sMsgData = new String[sMsgCol.length];
        bMessage = true;
        for(int i=0; i < sMsgCol.length; i++)
        {
           sMsgData[i] = rsql.getData(sMsgCol[i]);
        }
        vData.add(sMsgData);
     }
     rsql.disconnect();
     rsql = null;
%>
<HTML>
<HEAD>
<title>RCI Message Board</title>
<META content="RCI, Inc." name="RCI_Message_Board">
<meta http-equiv="refresh" content="300">
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
var MsgCur = <%=bMessage%>;
//==============================================================================
// on loading
//==============================================================================
function bodyload()
{
    if(MsgCur)
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

<%
   if(bMessage){
     Iterator it = vData.iterator();
     while(it.hasNext())
     {
        String [] sMsgData = (String[]) it.next();
%>

        <%if(sMsgData[0].equals("1")){%>
           <div style="font-size:<%=sMsgData[7]%>px;color:<%=sMsgData[8]%>; background:<%=sMsgData[9]%>">
             <blink><%=sMsgData[1]%></blink> &nbsp; &nbsp;
             <span style="font-size:10px">Started: <%=sMsgData[3] + " " + sMsgData[4]%></span>
          </div>
        <%} else {%>
           <div style="font-size:<%=sMsgData[10]%>px;color:<%=sMsgData[11]%>; background:<%=sMsgData[12]%>">
              <blink><%=sMsgData[2]%></blink>
              <span style="font-size:10px">Started: <%=sMsgData[3] + " " + sMsgData[4]%></span>
           </div>
       <%}%>
     <%}%>
<%} else {%><blink>None</blink><%}%>


</BODY>
</HTML>





