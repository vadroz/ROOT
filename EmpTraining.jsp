<%@ page import="java.util.*, emptraining.TrnStrEmpLst"%>
<%
    String sStore = request.getParameter("Store");
    String sStrName = request.getParameter("StrName");
    String sTrnPgm = request.getParameter("TrnPgm");
    String sTrnPgmName = request.getParameter("TrnPgmName");
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=EmpTraining.jsp&APPL=ALL&" + request.getQueryString());
}
else
{
      boolean bAppl = false;
      if(session.getAttribute("TRAINING")!=null) bAppl = true;
      String sUser = session.getAttribute("USER").toString();

      TrnStrEmpLst trnstr = new TrnStrEmpLst(sStore, sTrnPgm);

      int iNumOfEmp = trnstr.getNumOfEmp();
      String [] sEmp = trnstr.getEmp();
      String [] sEmpName = trnstr.getEmpName();
      String [] sHireDt = trnstr.getHireDt();
      String [] sTrainer = trnstr.getTrainer();
      String [] sTrainerName = trnstr.getTrainerName();
      String [] sInTraining = trnstr.getInTraining();
      String [][] sTestRes = trnstr.getTestRes();

      // check list
      int iNumOfOpt = trnstr.getNumOfOpt();
      String [] sOpt = trnstr.getOpt();
      String [] sColHdr = trnstr.getColHdr();
      String [] sOptSeq = trnstr.getOptSeq();

      String sEmpJsa = trnstr.getEmpJsa();
      String sEmpNameJsa = trnstr.getEmpNameJsa();
      String sOptJsa = trnstr.getOptJsa();
      String sColHdrJsa = trnstr.getColHdrJsa();
      String sOptSeqJsa = trnstr.getOptSeqJsa();
      String sTestResJsa = trnstr.getTestResJsa();
      String sTrainerJsa = trnstr.getTrainerJsa();
      String sTrainerNameJsa = trnstr.getTrainerNameJsa();

      trnstr.disconnect();
%>

<html>
<head>

<style>
  body {background:ivory;}
  a:link { color:blue;  font-size:12px;} a:visited { color:blue; font-size:12px;}  a:hover { color:blue; font-size:12px;}

  table.DataTable { border: darkred solid 1px; background:#e7e7e7; text-align:center;}
  tr.DataTable { background:#FFCC99; font-family:Verdanda; text-align:center;
                 font-size:12px; font-weight:bold}
  th.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                 border-bottom: darkred solid 1px; border-right: darkred solid 1px;}

  tr.DataTable1 { background:#e7e7e7; font-family:Verdanda; text-align:left; font-size:12px;}
  tr.DataTable2 { background:white; font-family:Verdanda; text-align:left; font-size:12px;}
  tr.DataTable3 { background:cornsilk; font-family:Verdanda; text-align:left; font-size:12px; font-weight:bold}

  td.DataTable { border-bottom: darkred solid 1px; border-right: darkred solid 1px;text-align:left;
                 padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;}
  td.DataTable1 { border-bottom: darkred solid 1px;text-align:center;
                  padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;
                  border-right: darkred solid 1px;}
  td.DataTable3 { border-bottom: darkred solid 1px; border-right: darkred solid 1px;text-align:left;
                 padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;
                 font-size:11px; font-weight:bold}

  div.dvPrompt { position:absolute; visibility:hidden; background-attachment: scroll;
              border:ridge; width:300; background-color:LemonChiffon; z-index:100;
              text-align:center; font-size:10px }


  .Small{ text-align:left; font-family:Arial; font-size:10px;}
  td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
  td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
  td.Prompt { text-align:left;font-family:Arial; font-size:10px; }
  td.Prompt1 { text-align:center;font-family:Arial; font-size:10px; }
  td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
  td.option { text-align:left; font-size:10px}
</style>

<SCRIPT language="JavaScript">
//==============================================================================
// Global variable
//==============================================================================
var EmpNum = [<%=sEmpJsa%>]
var EmpName = [<%=sEmpNameJsa%>];
var Trainer = [<%=sTrainerJsa%>]
var TrainerName = [<%=sTrainerNameJsa%>]
var Option = [<%=sOptJsa%>];
var ColHdr = [<%=sColHdrJsa%>];
var OptSeq = [<%=sOptSeqJsa%>];
var TestRes = [<%=sTestResJsa%>];
//==============================================================================
// Load initial value on page
//==============================================================================
function bodyLoad()
{
  setBoxclasses(["BoxName",  "BoxClose"], ["dvPrompt"]);
  window.document.focus();
}

//==============================================================================
// Load initial value on page
//==============================================================================
function chgEmpTrain(arg)
{
   var hdr = EmpNum[arg] + " - " + EmpName[arg];

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>"
         + popPanel(arg)
    + "</td>"
    + "</tr>"
   + "</table>"

   document.all.dvPrompt.innerHTML = html;
   document.all.dvPrompt.style.pixelLeft= document.documentElement.scrollLeft + 200;
   document.all.dvPrompt.style.pixelTop= document.documentElement.scrollTop + 130;
   document.all.dvPrompt.style.visibility = "visible";


}
//--------------------------------------------------------
// populate Entry Panel
//--------------------------------------------------------
function popPanel(arg)
{
  var dummy ="<table>";

  var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>"
      + "<tr><td class='Prompt' nowrap width='50%'>Trainer:</td>"

  panel += "<td class='Prompt' nowrap width='50%'><input name='Trainer' class='Small'"
       + "size=4 maxlength=4 value='" + Trainer[arg] + "'> - "
       + TrainerName[arg] + "</td></tr>"

  for(var i=0; i < Option.length; i++)
  {
      panel += "<tr><td class='Prompt' nowrap width='50%'>" + Option[i] + ": &nbsp;</td>"
          + "<td class='Prompt'><input name='Opt' class='Small' type='checkbox'"
          + "value='" + OptSeq[i] + "' "
      if(TestRes[arg][i] == "Yes") panel += "checked";
      panel += "></td>"
      + "</tr>"
  }

  panel += "<tr><td class='Prompt1' colspan=4><button onClick='Validate(" + arg + ")' class='Small'>Submit</button>&nbsp;"
        + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"
     + "</table>";
  return panel;
}


//--------------------------------------------------------
// Validate entry values
//--------------------------------------------------------
function Validate(arg)
{
   var msg="";
   var error=false

   var trn =  document.all.Trainer.value.trim();

   if(trn=="") { msg +="\nPlease Enter trainer employee number"; error=true; }
   else if(isNaN(trn)) { msg +="\nTrainer employee number is not numeric"; error=true; }

   if(error) alert(msg)
   else
   {
      var url = "EmpTrnEnt.jsp?TrnPgm=<%=sTrnPgm%>&Emp=" + EmpNum[arg]
       + "&Trn=" + trn
      for(var i=0; i < Option.length; i++)
      {
         url += "&OptSeq=" + OptSeq[i] + "&Chk="
         if(document.all.Opt[i].checked) url += "Y";
         else url += "N";
      }
      //alert(url)
      //window.location.href = url;
      window.frame1.location = url;
   }
}

//--------------------------------------------------------
// Hide selection screen
//--------------------------------------------------------
function hidePanel()
{
   document.all.dvPrompt.innerHTML = " ";
   document.all.dvPrompt.style.visibility = "hidden";
   hidePanelSel();
}
//--------------------------------------------------------
// Hide selection screen
//--------------------------------------------------------
function hidePanelSel()
{
   document.all.dvSelect.innerHTML = " ";
   document.all.dvSelect.style.visibility = "hidden";
}
//--------------------------------------------------------
// display error for entry
//--------------------------------------------------------
function displayError(Error)
{
   alert(Error)
}
//--------------------------------------------------------
// restart page after entry done
//--------------------------------------------------------
function reStart()
{
  window.location.reload();
}
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>

</head>

<body  onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvPrompt" class="dvPrompt"></div>
<div id="dvSelect" class="dvSelect"></div>
<!-------------------------------------------------------------------->
<!-------------------------------------------------------------------->

  <table border="0" width="100%" height="100%">
     <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP">
       <b>Retail Concepts, Inc
       <br><%=sTrnPgmName%> Employee Training
       <br>Store: <%=sStore%> - <%=sStrName%>
       <br>
       </b>

        <a href="../"><font color="red" size="-1">Home</font></a>;
        <!----------------- start of ad table ------------------------>
         <table class="DataTable" cellPadding="0" cellSpacing="0">
           <thead style="overflow: visible;">
             <tr class="DataTable">
               <th class="DataTable">Emp#</th>
               <th class="DataTable">Emploee Name</th>
               <th class="DataTable">Hired<br>Date</th>
               <th class="DataTable">Trainer</th>
               <%for(int i=0; i < iNumOfOpt; i++){%>
                   <th class="DataTable"><%=sColHdr[i]%></th>
               <%}%>
             </tr>
           </thead>

        <!--------------------- Event Detail ----------------------------->
        <tbody>
        <%for(int i=0; i < iNumOfEmp; i++){%>
              <!-- ------------ Division line ------------------------- -->
              <tr class="DataTable1">
                <td class="DataTable" ><%=sEmp[i]%></td>
                <%if(bAppl){%>
                    <td class="DataTable" ><a href="javascript:chgEmpTrain(<%=i%>)"><%=sEmpName[i]%></a></td>
                <%} else {%><td class="DataTable" ><%=sEmpName[i]%></td><%}%>

                <td class="DataTable1" ><%=sHireDt[i]%></td>
                <td class="DataTable"><%if(!sInTraining[i].equals(" ")){%><%=sTrainer[i] + " - " + sTrainerName[i]%><%} else {%>&nbsp;<%}%></td>
                <%for(int j=0; j < iNumOfOpt; j++){%>
                   <td class="DataTable1">&nbsp;<%=sTestRes[i][j]%>&nbsp;</td>
               <%}%>
              </tr>
          <%}%>
         </tbody>
       </table>
       <!----------------- start of ad table ------------------------>
      </td>
     </tr>
    </table>
  </body>
</html>
<%}%>