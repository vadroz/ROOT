<%@ page import="rciutility.RunSQLStmt, java.sql.*, java.text.*,java.util.*, diary.DiarySecLst, diary.Diarypad"%>
<%
   String sDiaryDate = request.getParameter("date");
   SimpleDateFormat smpMDY = new SimpleDateFormat("MM/dd/yyyy");

   if(sDiaryDate == null)
   {

      java.util.Date d = new java.util.Date();
      sDiaryDate =  smpMDY.format(d);
   }

//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null || session.getAttribute("DIARY") == null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=Diarypad.jsp&APPL=ALL&" + request.getQueryString());
}
else
{
    String sUser = session.getAttribute("USER").toString();

    //=========== get existing diary date entires =====================
   String sStmt = "select ent_dt"
     + " From Rci.DryLog "
     + " where ent_us='" + sUser + "'";

   //System.out.println("\n" + sStmt);
   RunSQLStmt runsql = new RunSQLStmt();
   runsql.setPrepStmt(sStmt);
   ResultSet rs = runsql.runQuery();

   Vector vDate = new Vector();
   SimpleDateFormat smpYMD = new SimpleDateFormat("yyyy-MM-dd");

   while(runsql.readNextRecord())
   {
      String sDate = smpMDY.format(smpYMD.parse(runsql.getData("ent_dt").trim()));
      vDate.add(sDate);
   }

   String [] sList = new String[vDate.size()];
   for(int i=0; i < sList.length; i++)
   {
       sList[i] = (String)vDate.get(i);
   }

   boolean bExists = false;
   for(int l=0; l < sList.length; l++)
   {
      if(sList[l].equals(sDiaryDate)){ bExists = true;}
   }

   int iCell = 0;
%>
<html>
<head>

<style>
  body {background:ivory;}
  a:link { color:blue;  font-size:12px;} a:visited { color:blue; font-size:12px;}  a:hover { color:blue; font-size:12px;}

  table.DataTable { background:lightgray; text-align:center; width:100%; vertical-align:text-top;}
  table.DataTable1 { background:#eeffee; text-align:center; vertical-align:text-top; font-size:10px;}
  table.DataTable2 { background:white; text-align:center; width:100%; vertical-align:text-top;}

  tr.DataTable { font-family:Verdanda; text-align:center; font-size:14px; font-weight:bold}
  th.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; }

  td.DataTable2 {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=cornsilk, endColorStr=salmon);
              color:darkblue; text-align:center; font-family:Arial; font-size:14px; font-weight:bold}

  td.DataTable {  text-align:left; padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;  vertical-align:text-top;}
  td.DataTable1 {  text-align:center; padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;  vertical-align:text-top;}

  div.dvQuest { position:absolute; visibility:hidden; background-attachment: scroll;
              border:ridge; width:600; background-color:LemonChiffon; z-index:100;
              text-align:left; font-size:16px }


  .Small{ text-align:left; font-family:Arial; font-size:10px;}
  td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
  td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
  td.Prompt { text-align:left; font-family:Arial; font-size:10px; }
  td.Prompt1 { text-align:center;font-family:Arial; font-size:10px; }
  td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
  td.option { text-align:left; font-size:10px}

</style>

<SCRIPT language="JavaScript">
//==============================================================================
// Global variable
//==============================================================================
var aSec = new Array();
var aScore = new Array();
//==============================================================================
// Load initial value on page
//==============================================================================
function bodyLoad(){ }
//==============================================================================
// get another day from diary
//==============================================================================
function getDiary(date)
{
   var url = "Diarynotepad.jsp?date=" + date
   window.location.href=url;
}
//==============================================================================
// submit diary
//==============================================================================
function sbmDiary()
{
    var nwelem = window.frame1.document.createElement("div");
    nwelem.id = "dvSbmDiary"

    var html = "<form name='formDiary'"
       + " METHOD=Post ACTION='DiarySave.jsp'>"
       + "<input name='Date'>"
       + "<input name='User'>"
       + "<input name='Action'>"

    var txanm = new Array()
    var selansw = new Array()
    for(var i=0; i < aSec.length; i++)
    {
       txanm[i] = "txa" + aSec[i];
       html += "<input name='Sec'></textarea>"
       html += "<textarea name='" + txanm[i] + "'></textarea>"
       selansw[i] = "selAnsw" + aSec[i];
       html += "<input name='" + selansw[i] + "'></input>"
    }
    html += "</form>"

   nwelem.innerHTML = html;
   window.frame1.document.appendChild(nwelem);

   for(var i=0; i < aSec.length; i++)
   {
      window.frame1.document.all.Sec[i].value = aSec[i];
      window.frame1.document.all[txanm[i]].value = window.document.all[txanm[i]].value;
      if(aScore[i]){ window.frame1.document.all[selansw[i]].value = window.document.all[selansw[i]].value; }
      else{ window.frame1.document.all[selansw[i]].value = "NONE"; }
   }

   window.frame1.document.all.Date.value = "<%=sDiaryDate%>";
   window.frame1.document.all.User.value = "<%=sUser%>";
   window.frame1.document.all.Action.value = "ADD";

   window.frame1.document.formDiary.submit();
}
//==============================================================================
// show editing pads
//==============================================================================
function showEdit()
{
   document.all.trEdit.style.display="block";
}
</SCRIPT>

<script LANGUAGE="JavaScript" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript" src="String_Trim_function.js"></script>

</head>

<body  onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvQuest" class="dvQuest"></div>
<!-------------------------------------------------------------------->
  <table border="0" width="100%" height="100%">
     <tr>
      <td ALIGN="center" VALIGN="TOP" colspan=2 style="height:50px">
       <b>Retail Concepts, Inc
       <br>Diary Notepad: <%=sUser%> &nbsp; &nbsp; &nbsp; &nbsp;
           Date: <%=sDiaryDate%>,
           <%
           java.util.Date d = smpMDY.parse(sDiaryDate);
           Calendar curcal = Calendar.getInstance();
           curcal.setTime(d);
           String [] sWeekdays = new String[]{"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"};
           int iwkday = curcal.get(curcal.DAY_OF_WEEK);
           %>
           <%=sWeekdays[iwkday]%>
       <br>
       </b>

       <a href="../"><font color="red" size="-1">Home</font></a>;&#62
       <font size="-1">This page</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
       <a href="javascript: showEdit();" style="font-size:12px;">Edit Diary entry</a>
     </td>
    </tr>
    <!----------------- start of diary printing table ------------------------>
      <tr>
        <%if(bExists){%>
        <td ALIGN="center" VALIGN="TOP" id="tdPrint">
           <table class="DataTable2" cellPadding="0" cellSpacing="0" id="tblDiary">

            <%
            DiarySecLst seclst = new DiarySecLst();
            Diarypad diarypad = new Diarypad();
            int iSec = 0;
            while(seclst.getNext())
            {
               seclst.setSection();
               String sSec = seclst.getSec();
               String sSecNm = seclst.getSecNm();
               String sDesc = seclst.getDesc();
               int iNumOfAnsw = seclst.getNumOfAnsw();
               String [] sAnsw = seclst.getAnsw();
               String [] sAnswNm = seclst.getAnswNm();

               diarypad.setNote(sDiaryDate, sUser, sSec);
               String sAnswer = diarypad.getAnswer();
               String sLine = diarypad.getLine();
           %>
              <tr class="DataTable">
                <td class="DataTable2" style="font-size:14px" nowrap>
                   <u><%=sSecNm%></u> &nbsp; &nbsp; &nbsp;
                   <!-- Evaluation -->
                   <%if(iNumOfAnsw > 0){%>
                       Score:
                       <%for(int i=0; i < iNumOfAnsw; i++){%>
                          <%if(sAnsw[i].equals(sAnswer)){%><%=sAnswNm[i]%><%}%>
                       <%}%>
                   <%}%>
                   <br>
                </td>
              </tr>
              <tr>
                <td class="DataTable"><%=sLine%><br>&nbsp;</td>
              </tr>
           <%}%>
           <%
             seclst.disconnect();
             seclst = null;
             diarypad.disconnect();
             diarypad = null;
           %>
           </table>
        </td>
    <%}
      else {%>
      <td ALIGN="center" VALIGN="TOP" id="tdPrint">&nbsp;</td>
    <%}%>


    <!----------------- start calendar ------------------------>
      <td style="background:#eeffee;text-align:center; vertical-align:text-top;font-size:14px; font-weight:bold"
      rowspan=10 width="20%">
         Calendar
         <div style="height:600px; overflow:scroll;">
         <%
             smpMDY = new SimpleDateFormat("MM/dd/yyyy");
             Calendar cal = Calendar.getInstance();
             int iMnday = cal.get(Calendar.DAY_OF_MONTH);
             cal.add( Calendar.DATE, (-1) * iMnday + 1 );
             String sCal = null;
             String [] sMonth = new String[]{"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" };
             sWeekdays = new String[]{"Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"};
          %>


         <%for(int i=0; i < 24; i++){%>
             <%sCal = smpMDY.format(cal.getTime());%>
             <table class="DataTable1" border="1" cellPadding="0" cellSpacing="0" id="tblCal">
              <tr><td style="color:brown;font-weight:bold"><%=sMonth[cal.get(cal.MONTH)]%>, <%=cal.get(cal.YEAR)%>
                  <table class="DataTable1" border="0" cellPadding="0" cellSpacing="0" id="tblCal">
                    <tr>
                      <%for(int j=0; j < 7; j++){%><td style="color:blue;font-weight:bold">&nbsp;&nbsp;<%=sWeekdays[j]%>&nbsp;&nbsp;</td><%}%>
                    </tr>

                    <%int iMxMnDays = cal.getActualMaximum(cal.DAY_OF_MONTH);%>
                    <tr>
                    <%
                       Calendar mncal =  Calendar.getInstance();
                       mncal.setTime(cal.getTime());
                    %>

                    <%for(int j=0, wd=0; j < iMxMnDays; j++, wd++){%>
                       <!-- new week break-->
                       <%if(wd==8){%></tr></tr><%wd=0;}%>

                       <!-- skip  to current week day-->
                       <%if(wd==0){%>
                          <%wd = mncal.get(mncal.DAY_OF_WEEK);%>
                          <%for(int k=0; k < wd-1; k++){%><td>&nbsp;</td><%}%>
                       <%}%>

                       <%
                           // check if date already has an entry
                           boolean bFound = false;
                           String sCalDate = smpMDY.format(mncal.getTime());
                           for(int l=0; l < sList.length; l++)
                           {
                              if(sList[l].equals(sCalDate)){ bFound = true;}
                           }
                       %>

                       <td id="tdCell<%=iCell%>" style="cursor:hand;<%if(bFound){%>color:red;font-weight:bold;<%}%>" onclick="getDiary('<%=sCalDate%>')">
                          <%=mncal.get(mncal.DATE)%>
                       </td>
                       <%iCell++;%>
                       <!-- next date -->
                       <%mncal.add( Calendar.DATE, 1 );%>
                    <%}%>
                    </tr>
                  </table>
                  </td>
              </tr>
             </table>
             <%cal.add( Calendar.MONTH, -1 ); %>
         <%}%>
        </div>
      </td>


    <tr>
      <td style="font-size:1px;background:black" id="tdDiv">&nbsp;</td>
    </tr>
    <!----------------- start of diary editing table ------------------------>

    <tr id="trEdit" <%if(bExists){%>style="display:none;"<%}%>>
      <td ALIGN="center" VALIGN="TOP">
      <!-- a href="ProjectDocs/Diary Help text - HTML in 5 minutes.docx">Help document</a -->
         <table class="DataTable" cellPadding="0" cellSpacing="0" id="tblDiary">
         <%
            DiarySecLst seclst = new DiarySecLst();
            Diarypad diarypad = new Diarypad();
            int iSec = 0;
            while(seclst.getNext())
            {
               seclst.setSection();
               String sSec = seclst.getSec();
               String sSecNm = seclst.getSecNm();
               String sDesc = seclst.getDesc();
               int iNumOfAnsw = seclst.getNumOfAnsw();
               String [] sAnsw = seclst.getAnsw();
               String [] sAnswNm = seclst.getAnswNm();

               diarypad.setNote(sDiaryDate, sUser, sSec);
               String sAnswer = diarypad.getAnswer();
               String sLine = diarypad.getLine();
         %>
        <!--------------------- Group List ----------------------------->
            <tr class="DataTable">
              <td class="DataTable" nowrap><%=sSecNm%>
                <br><span style="font-size:12px;font-weight:normal;"><%=sDesc%></span>
              </td>
              <%if(iSec == 0){%>
                  <td rowspan=3><img src="DiaryIcon.bmp" style="filter:alpha(opacity=70);" width="200px" height="200px"></td>
                  <%iSec++;
              }%>
            </tr>
            <tr class="DataTable">
              <td class="DataTable1" nowrap>
                 <!-- Evaluation -->
                 <%if(iNumOfAnsw > 0){%>
                    <select class="Small" name="selAnsw<%=sSec%>">
                      <%for(int i=0; i < iNumOfAnsw; i++){%>
                         <option value="<%=sAnsw[i]%>" <%if(sAnsw[i].equals(sAnswer)){%>selected<%}%>><%=sAnswNm[i]%></option>
                      <%}%>
                    </select>
                 <%}%>
              </td>
             </tr>
             <tr class="DataTable">
              <td class="DataTable" nowrap>
                 <textArea type="text" name="txa<%=sSec%>" cols="80" rows="6"><%=sLine%></textArea>
                 <script language="javascript">
                    var iSec = aSec.length;
                    aSec[iSec] = "<%=sSec%>";
                    aScore[iSec] = <%if(iNumOfAnsw > 0){%>true<%} else{%>false<%}%>
                 </script>
              </td>
         <%}%>
         <%
           seclst.disconnect();
           seclst = null;
           diarypad.disconnect();
           diarypad = null;
        %>
           </td>
         </tr>
         <tr class="DataTable">
           <td class="DataTable1" nowrap>
              <button onclick="sbmDiary()">Save</button>
           </td>
         </tr>
       </table>
      </td>


     </tr>
    </table>
  </body>
</html>
<%}%>
