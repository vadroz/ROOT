<%@ page import="java.util.*, java.text.*"%>
<%
   String sCard = request.getParameter("Card");
   String sCode = request.getParameter("Code");
   String sName = request.getParameter("Name");
   String sAddr1 = request.getParameter("Addr1");
   String sAddr2 = request.getParameter("Addr2");
   String sCity = request.getParameter("City");
   String sState = request.getParameter("State");
   String sZip = request.getParameter("Zip");
   String sPhone = request.getParameter("Phone");
   String sEMail = request.getParameter("EMail");
   String sRide = request.getParameter("Ride");

   if(sCode==null) sCode = "";
   if(sName==null) sName = "";
   if(sAddr1==null) sAddr1 = "";
   if(sAddr2==null) sAddr2 = "";
   if(sCity==null) sCity = "";
   if(sState==null) sState = "";
   if(sZip==null) sZip = "";
   if(sPhone==null) sPhone = "";
   if(sEMail==null) sEMail = "";
   if(sRide==null) sRide = "";
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=DiscountCard.jsp&APPL=ALL");
   }
   else
   {
      int iCardId = 0;
      if(sCard.equals("5% Cash Back Program (MS 150)")) iCardId = 1;
      else if(sCard.equals("Team in Training (TNT)")) iCardId = 2;
      else if(sCard.equals("Official Bike Shop (OBS)")) iCardId = 3;
      else if(sCard.equals("Dallas Official Bike Shop (DOBS)")) iCardId = 6;
      else if(sCard.equals("TEAM SUN and SKI (SSS)")) iCardId = 4;
      else if(sCard.equals("Official Bike Shop MS150 2010")) iCardId = 7;
      else if(sCard.equals("Team in Training - Texas Gulf Coast")) iCardId = 8;
      else if(sCard.equals("Tour de Cure")) iCardId = 9;
      else if(sCard.equals("5% Cash Back Program (Generic)")) iCardId = 5;
      else if(sCard.equals("Dallas Team Sun and Ski MS150 2011")) iCardId = 10;
      else if(sCard.equals("Charlotte My Team Support MS150 2011")) iCardId = 11;
      else if(sCard.equals("Charlotte Team Sun and Ski MS150 2011")) iCardId = 12;

%>
<html>
<head>

<style>body {background:ivory; text-align:center;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}
        table.DataTable1 { border: darkred solid 1px;background:Cornsilk;text-align:center;}
        th.DataTable { background:#FFCC99;padding-top:3px; border-bottom: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }

        tr.DataTable { background:cornsilk; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:#e7e7e7; font-family:Arial; font-size:10px }
        tr.DataTable2 { background:cornsilk; font-family:Arial; font-size:12px }

        td.DataTable { border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:left;}
        td.DataTable1 { border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                        padding-top:3px; padding-bottom:3px; padding-left:3px;
                        padding-right:3px; text-align:right;}
        td.DataTable2 {border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center;}

        td.DataTable3 {background:#e7e7e7; border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                        padding-top:3px; padding-bottom:3px; padding-left:3px;
                        padding-right:3px; text-align:center;}
        td.DataTable31 {background:green; border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                        padding-top:3px; padding-bottom:3px; padding-left:3px;
                        padding-right:3px; text-align:center;}
        td.DataTable32 {background:red; border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                        padding-top:3px; padding-bottom:3px; padding-left:3px;
                        padding-right:3px; text-align:center;}
        <!--------------------------------------------------------------------->
        .Small {font-family:Arial; font-size:10px }
        input.Small {font-family:Arial; font-size:10px }
        button.Small {font-family:Arial; font-size:10px }
        select.Small {font-family:Arial; font-size:10px }

        div.dvStatus  { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:200; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
</style>

<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
var Card = "<%=sCard%>"
var CardId = <%=iCardId%>;
var Code = "<%=sCode%>";
var Name = "<%=sName%>";
var Addr1 = "<%=sAddr1%>";
var Addr2 = "<%=sAddr2%>";
var City = "<%=sCity%>";
var State = "<%=sState%>";
var Zip = "<%=sZip%>";
var Phone = "<%=sPhone%>";
var EMail = "<%=sEMail%>";
var Ride = "<%=sRide%>";

//--------------- End of Global variables ----------------
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{
   document.all.Cust.value = Name.toFirstCapitalLetter();
   document.all.TrackId.value = Code;
   if(CardId != 1)
   {
       var coma = "";
       var addr = document.all.Address;
       if(CardId != 3 && CardId != 6 && Addr1 != "") { addr.value = addr.value + Addr1.toFirstCapitalLetter(); coma = ", ";}
       if(CardId != 3 && CardId != 6 && Addr2 != "") { addr.value = addr.value + " " + Addr2.toFirstCapitalLetter(); coma = ", "; }
       if(CardId != 3 && CardId != 6 && City != "") { addr.value = addr.value + coma + City.toFirstCapitalLetter(); coma = ", "; }
       if(CardId != 3 && CardId != 6 && State != "") { addr.value = addr.value + coma + State.toFirstCapitalLetter(); coma = ", "; }
       if(CardId != 3 && CardId != 6 && CardId != 7 && Zip != "") { addr.value = addr.value + coma + Zip.toFirstCapitalLetter(); coma = ", "; }
   }
}
//==============================================================================
// submit send email propgram
//==============================================================================
function Validate()
{
   var msg =""
   var error = false;

   var cust = document.all.Cust.value.trim();
   if(cust == "" || cust ==" ") { error = true; msg += "Populate customer name\n";}

   var track = document.all.TrackId.value.trim();
   if(track == "" || track ==" ") { error = true; msg += "Populate Track Id\n";}


   var team1 = null;
   var team2 = null;
   var addr = null;
   var subj = null;
   var charity = "";
   var expdt = "";

   if(CardId == 1 || CardId == 3 || CardId == 6 ||  CardId == 7 ||  CardId == 9
      || CardId == 10 || CardId == 11  || CardId == 12)
   {
      team1 = document.all.Team1.value.trim();
      if(team1 == "") { error = true; msg += "Populate Team Name\n";}
   }


   if(CardId != 1 && CardId != 3 && CardId != 6 && CardId != 7 && CardId != 9 && CardId != 10)
   {
     addr = document.all.Address.value.trim();
   }
   if(CardId != 1 && CardId != 3 && CardId != 6 && CardId != 7 && CardId != 8 && CardId != 9 && CardId != 10
    && CardId != 11 && CardId != 12)
   {
        charity = document.all.Charity.value.trim();
   }

   subj = document.all.Subject.value.trim();
   if(CardId != 8) {   expdt = document.all.ExpDate.value.trim(); }

   if(expdt == "" && CardId != 8) {error = true; msg += "Populate Expiration Date\n";}

   if(error) alert(msg);
   else sbmSendEmail(cust, track, team1, team2, addr, subj, charity, expdt);
}
//==============================================================================
// submit send email propgram
//==============================================================================
function sbmSendEmail(cust, track, team1, team2, addr, subj, charity, expdt)
{
   var url = "DiscountCardSend.jsp?"
           + "Card=" + Card.replaceSpecChar();

   url += "&Cust=" + cust.replaceSpecChar();
   url += "&Track=" + track.replaceSpecChar();

   if(CardId == 1 || CardId == 3 || CardId == 6 || CardId == 7 || CardId == 9 || CardId == 10
      || CardId == 11 || CardId == 12)
   {
      team1 = team1.replaceSpecChar();
      if(team1.length > 17){url += "&Team1=" + team1.substring(0, 17); url += "&Team2=" + team1.substring(17); }
      if(team1.length <= 17){url += "&Team1=" + team1 }
   }

   if(CardId != 1 && CardId != 3 && CardId != 6 && CardId != 7 && CardId != 9 && CardId != 10) { url += "&Addr=" + addr.replaceSpecChar() }

   url += "&Subj=" + subj.replaceSpecChar()
        + "&Charity=" + charity.replaceSpecChar()
        + "&ExpDate=" + expdt

   //alert(url)
   //window.location.href=url;
   window.frame1.location.href=url;
}
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>

</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvStatus" class="dvStatus"></div>
<!-------------------------------------------------------------------->

    <table border="0" cellPadding="0"  cellSpacing="0">
     <tr>
      <td ALIGN="center" VALIGN="TOP"nowrap>
      <b>Retail Concepts, Inc
      <br><%=sCard%></b></td>
    </tr>

    <tr>
      <td ALIGN="center" VALIGN="TOP">
      <a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;<font size="-1">This Page</font>
  <!----------------------- Order List ------------------------------>
     <table class="DataTable" cellPadding="0" width="100%" cellSpacing="0" id="tbDetail">
      <TBODY>

      <!----------------------- Order List ------------------------>
        <tr  class="DataTable">
           <td class="DataTable">Customer Name</td>
           <td class="DataTable"><input name="Cust" maxlength=="50" size="50"></td>
        </tr>
        <tr  class="DataTable">
           <td class="DataTable">Track Id</td>
           <td class="DataTable"><input name="TrackId" maxlength=="5" size="5"></td>
        </tr>

        <%if(iCardId == 1){%>
           <tr  class="DataTable">
              <td class="DataTable">Team Name</td>
              <td class="DataTable">Line: <input name="Team1" maxlength=="34" size="34" readonly value="Team Sun and Ski">&nbsp;&nbsp;&nbsp;
           </tr>
        <%}%>
        <%if(iCardId == 3 || iCardId == 6 || iCardId == 7 || iCardId == 9 || iCardId == 10 || iCardId == 11){%>
           <tr  class="DataTable">
              <td class="DataTable">Team Name</td>
              <td class="DataTable">Line: <input name="Team1" maxlength=="34" size="34">&nbsp;&nbsp;&nbsp;
           </tr>
        <%}%>
        <%if(iCardId == 12){%>
           <tr  class="DataTable">
              <td class="DataTable">Team Name</td>
              <td class="DataTable">Line: <input name="Team1" maxlength=="34" size="34" value="Team Sun & Ski" readonly >&nbsp;&nbsp;&nbsp;
           </tr>
        <%}%>


        <%if(iCardId != 1 && iCardId != 3 && iCardId != 6 && iCardId != 7){%>
           <tr  class="DataTable">
             <td class="DataTable">Address</td>
             <td class="DataTable"><input name="Address" maxlength=="50" size="50"></td>
           </tr>
        <%}%>

        <tr  class="DataTable">
           <td class="DataTable">Message Subject</td>
           <td class="DataTable"><input name="Subject" maxlength=="80" size="80"></td>
        </tr>

        <%if(iCardId != 1 && iCardId != 3 && iCardId != 6 && iCardId != 7 && iCardId != 8
          && iCardId != 9 && iCardId != 10 && iCardId != 11 && iCardId != 12){%>
              <tr  class="DataTable">
                 <td class="DataTable">Charity</td>
                 <td class="DataTable"><input name="Charity" maxlength=="80" size="80"></td>
              </tr>
        <%}%>
        <%if(iCardId != 8){%>
           <tr  class="DataTable">
              <td class="DataTable">Expires</td>
              <td class="DataTable"><input name="ExpDate" maxlength=="8" size="8" value="5/31/2010"></td>
           </tr>
        <%}%>
           <tr class="DataTable2">
              <td class="DataTable">E-Mail Address:</td>
              <td class="DataTable"><%=sEMail.toLowerCase()%></td>
           </tr>
           <%if(iCardId != 5){%>
              <tr class="DataTable2">
                 <td class="DataTable">Ride:</td>
                 <td class="DataTable"><%=sRide%></td>
              </tr>
           <%}%>
      <!---------------------------------------------------------------------->
      </TBODY>
    </table>
  <!----------------------- end of table ------------------------>
     <br><button onClick="Validate()">Send E-MAil</button>
     </td>
   </tr>

  </table>
 </body>
</html>
<%}%>