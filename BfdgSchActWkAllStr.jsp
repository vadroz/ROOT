<%@ page import="java.util.*, java.text.*, payrollreports.BfdgSchActWkAllStr"%>
<%
   String sWkend = request.getParameter("Wkend");

   long lStartTime = (new java.util.Date()).getTime();  

   String sUser = session.getAttribute("USER").toString();
   String sAppl = "PRLAB";
if (session.getAttribute("USER")==null || session.getAttribute(sAppl)==null
 && !session.getAttribute("APPLICATION").equals(sAppl))
{
   response.sendRedirect("SignOn1.jsp?TARGET=BfdgSchActWkAllStr.jsp&APPL=" + sAppl + "&" + request.getQueryString());
}
else
{
    BfdgSchActWkAllStr bdgwkall = new BfdgSchActWkAllStr(sWkend, sUser);
    int iNumOfReg = bdgwkall.getNumOfReg();
    String [] sReg = bdgwkall.getReg();
    String [] sRegNm = bdgwkall.getRegNm();
    int [] iRegStr = bdgwkall.getRegStr();


    int iNumOfStr = bdgwkall.getNumOfStr();
    String [] sStr = bdgwkall.getStr();
    String [] sStrNm = bdgwkall.getStrNm();  
    int iStrNum = 0;
    int iGrpNum = 0;
    String [] sLineCell = null;
    String sWarnLine20 = null;
    String sWarnLine21 = null;
    String sWarnLine23 = null;
    
    String Str55ActProcPy = null;    
%>

<style>body {background:ivory;font-family: Verdanda}
        a:link { color:blue; font-size:12px} a:visited { color:blue; font-size:12px}
                 a:hover { color:red; font-size:12px}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}
                       a:hover.small { color:red; font-size:10px}
        th.DataTable { border: #efefef solid 1px; background:#FFCC99; padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:top ;font-size:12px }
        th.DataTable1 { border: #efefef solid 1px; background:#FFCC99;padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px;
                       text-align:left; vertical-align:top ;font-size:12px }
        th.DataTable2 { border: #efefef solid 1px; background:#FFCC99; white-space: nowrap; padding-top:3px; padding-bottom:3px;
                       writing-mode: tb-rl;   text-align:left;  font-size:12px;
        	filter: flipv fliph;
        }
        
        
        th.rotate { border: #efefef solid 1px; background:#FFCC99; white-space: nowrap; font-size:12px;}
		th.rotate > div { transform: translate( 0px, 140px) rotate(270deg); width: 40px;}
		th.rotate > div > span { padding: 0px 0px; }
		
		th.rotate1 { border: #efefef solid 1px; height: 390px; background:#FFCC99; white-space: nowrap; font-size:12px;}
		th.rotate1 > div { transform: translate( 0px, 160px) rotate(270deg); width: 25px;}
		th.rotate1 > div > span { padding: 0px 0px; }
		
		th.rotate2 { border: #efefef solid 1px; height: 390px; background:#ccffcc; white-space: nowrap; font-size:12px;}
		th.rotate2 > div { transform: translate( 0px, 160px) rotate(270deg); width: 25px;}
		th.rotate2 > div > span { padding: 0px 0px; }
                       
        th.DataTable3 { border: #efefef solid 1px; background:#ccffcc; padding-top:3px; padding-bottom:3px; font-size:12px }
        th.DataTable4 { border: #efefef solid 1px;  background:#ccccff; padding-top:3px; padding-bottom:3px; font-size:12px }
        th.DataTable5 { border: #efefef solid 1px; background:#ccffcc; writing-mode: tb-rl;  
                        padding-left:1px; padding-right:1px; padding-top:10px;
                        font-size:12px; text-align:left;filter: flipv fliph;
                      }

        th.DataTable6 { background:#FFCC99; text-align:center; vertical-align:top ;font-size:10px }

        tr.DataTable { background: white; font-size:10px }
        tr.Divdr1 { background: darkred; font-size:1px }
        tr.DataTable2 { background: #ccccff; font-size:10px }
        tr.DataTable3 { background: #ccffcc; font-size:10px }
        tr.DataTable31 { background: #ffff99; font-size:10px }
        tr.DataTable32 { background: gold; font-size:10px }
        tr.DataTable33 { background: white; font-size:10px }
        tr.DataTable4 { color:Maroon; background: Khaki; font-size:10px }
        tr.DataTable5 { background: cornsilk; font-size:10px }


        td.DataTable { border: #efefef solid 1px; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; }

        td.DataTable01 { border: #efefef solid 1px; background: yellow; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; }

        td.DataTable02 { border: #efefef solid 1px; background: Khaki; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; }

        td.DataTable1 { border: #efefef solid 1px; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left;}
        td.DataTable2 { border: #efefef solid 1px; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;}
        td.DataTable21 { border: #efefef solid 1px; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;  font-weight: bold}
        td.DataTable22 { border: #efefef solid 1px; background: azure; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;  font-weight: bold}

        td.DataTable2p { border: #efefef solid 1px; background: #d0d0d0; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;}
        td.DataTable2g { border: #efefef solid 1px; background:lightgreen; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;}
        td.DataTable2r { border: #efefef solid 1px; background:red; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;}

        td.DataTable210 { border: #efefef solid 1px; background: lightgreen; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;  font-weight: bold}
        td.DataTable211 { border: #efefef solid 1px; background: pink; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;  font-weight: bold}

        td.DataTable3 { background: black; font-size:12px }

        select.Small {font-size:10px }
        input.Small {margin-top:3px;  font-size:10px }
        button.Small {margin-top:3px; font-size:10px }
        textarea.Small { font-size:10px }

        div.dvEmpList { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:500; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        div.dvColHdr { position:absolute; visibility:hidden; background-attachment: scroll;
              width:50; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        div.dvSlsGoal { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:150px; background-color:LemonChiffon;
              text-align:center; font-size:10px}

        div.dvHelp { position:absolute; visibility:hidden; background-attachment: scroll;
               width:150; background-color:LemonChiffon; z-index:10;
              text-align:left; font-size:12px}

        td.BoxName {cursor:move; background: #396aba;
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background: #396aba;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
        td.Prompt3 { text-align:left; vertical-align:midle; font-family:Arial; font-size:10px; }

</style>
<html>
<head><Meta http-equiv="refresh"></head>

<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

<SCRIPT language="JavaScript">
//==============================================================================
// Global variables
//==============================================================================
var SelWkend = "<%=sWkend%>";

var GrpBdg = new Array();
var GrpBdgName = new Array();
var GrpBdgHrs = new Array();
var GrpBdgPayReg = new Array();
var GrpBdgPayCom = new Array();
var GrpBdgPayLSpiff = new Array();
var GrpBdgPayMSpiff = new Array();
var GrpBdgPayOther = new Array();
var GrpBdgPay = new Array();
var GrpBdgAvgPay = new Array();
var GrpBdgAvgCom = new Array();
var GrpBdgAvgLSpiff = new Array();
var GrpBdgAvgMSpiff = new Array();
var GrpBdgAvgOther = new Array();
var GrpBdgAvg = new Array();
var NumOfGrp = 0;

var ActEmpGrpName = new Array();
var ActEmpGrpHrs = new Array();
var ActEmpGrpPay = new Array();
var ActEmpGrpCom = new Array();
var ActEmpGrpLSpiff = new Array();
var ActEmpGrpMSpiff = new Array();
var ActEmpGrpTot = new Array();
var ActEmpGrpAvgPay = new Array();
var ActEmpGrpAvgCom = new Array();
var ActEmpGrpAvgLSpiff = new Array();
var ActEmpGrpAvgMSpiff = new Array();
var ActEmpGrpAvgTot = new Array();
var ActEmpGrpSlsRet = new Array();
var ActEmpGrpIncPay = new Array();
var ActEmpGrpAvgIncPay = new Array();

var SchGrpName = new Array();
var SchGrpHrs = new Array();
var SchGrpPay = new Array();
var SchGrpCom = new Array();
var SchGrpLSpiff = new Array();
var SchGrpMSpiff = new Array();
var SchGrpTot = new Array();
var SchGrpAvgPay = new Array();
var SchGrpAvgCom = new Array();
var SchGrpAvgLSpiff = new Array();
var SchGrpAvgMSpiff = new Array();
var SchGrpAvgTot = new Array();
var SchGrpSlsRet = new Array();
var SchGrpIncPay = new Array();
var SchGrpAvgIncPay = new Array();

var TotGrpName = new Array();
var TotGrpHrs = new Array();
var TotGrpPay = new Array();
var TotGrpCom = new Array();
var TotGrpLSpiff = new Array();
var TotGrpMSpiff = new Array();
var TotGrpTot = new Array();
var TotGrpAvgPay = new Array();
var TotGrpAvgCom = new Array();
var TotGrpAvgLSpiff = new Array();
var TotGrpAvgMSpiff = new Array();
var TotGrpAvgTot = new Array();
var TotGrpSlsRet = new Array();
var TotGrpIncPay = new Array();
var TotGrpAvgIncPay = new Array();

var VarGrpName = new Array();
var VarGrpHrs = new Array();
var VarGrpPay = new Array();
var VarGrpCom = new Array();
var VarGrpLSpiff = new Array();
var VarGrpMSpiff = new Array();
var VarGrpTot = new Array();
var VarGrpAvgPay = new Array();
var VarGrpAvgCom = new Array();
var VarGrpAvgLSpiff = new Array();
var VarGrpAvgMSpiff = new Array();
var VarGrpAvgTot = new Array();
var VarGrpSlsRet = new Array();
var VarGrpIncPay = new Array();
var VarGrpAvgIncPay = new Array();

var LyGrpName = new Array();
var LyGrpHrs = new Array();
var LyGrpPay = new Array();
var LyGrpCom = new Array();
var LyGrpLSpiff = new Array();
var LyGrpMSpiff = new Array();
var LyGrpTot = new Array();
var LyGrpAvgPay = new Array();
var LyGrpAvgCom = new Array();
var LyGrpAvgLSpiff = new Array();
var LyGrpAvgMSpiff = new Array();
var LyGrpAvgTot = new Array();
var LyGrpSlsRet = new Array();
var LyGrpIncPay = new Array();
var LyGrpAvgIncPay = new Array();

var StrArr = new Array();

var ColHdg = ["Original Sales Plan"
          ,"Sales Forecast Trend Rate"
          ,"Sales Forecast"
          ,"Sales Forecast Dollars +/-"
          ,"Sales Actual / Forecast"
          ,"Sales Actual / Forecast Dollars +/-"
          ,"Original Budget Hours"
          ,"Hours Earned <sup>1)</sup>"
          ,"Hours Earned (Based on Salaried Employees on V or H)"
          ,"Allowable Budget Hours"
          ,"Actual Hrs. / Adjusted Hrs. To Reach Allowable Budget"
          ,"Actual Hrs. / Adjusted Hrs. To Reach Allowable Budget"
          ,"Hours Actual / Scheduled"
          ,"Original Payroll Budget Dollars"
          ,"Allowable Budget Dollars"
          ,"Hourly Payroll $ Actual / Scheduled"
          ,"Original Budgeted Average Hourly Rate"
          ,"Allowable Budgeted Average Hourly Rate"
          ,"Actual / Scheduled Average Hourly Rate"
          ,"Actual / Scheduled Hours vs. Allowable Budget"
          ,"Actual / Scheduled Dollars +/- Allowable Budget"
          ,"Original Budget Payroll % To Original Sales Plan"
          ,"Actual / Scheduled Payroll % To Actual / Forecast Sales"
          ,"Allowable Budget Payroll % To Actual / Forecast Sales"
          ,"Budget Hours - Training/Meeting/Clinics"
          ,"Hours Scheduled - TMC"
          ,"Hours Actual - TMC"
          ,"Payroll Budget $'s - TMC"
          ,"Hours Payroll $'s/Scheduled - TMC"
          ,"Hours Payroll $'s/Actual - TMC"
          ,"Hours"
          ,"Hourly Payroll (Daily/Cumulative)"
          ,"Average Hourly Rate"
          ,"Memo: Challenge"
          ,"Actual Calculated & Processed +/-"
          ,"Allowable Dollars Earned by Sales"
          ,"Allowable Dollars Earned Based on H,S,V"
          ,"$'s earned(lost) based on change in allowable budgeted avg. hourly rate"
]

 
//==============================================================================
// initializing process
//==============================================================================
function bodyLoad()
{
   	setBoxclasses(["BoxName",  "BoxClose"], ["dvEmpList"]);
   
 	//set IE compatable classes on table headers
    setIEComaptable();   
}
//==============================================================================
//set IE compatable classes on table headers
//==============================================================================
function setIEComaptable()
{
	if(isIE && ua.indexOf("MSIE 7.0") >= 0)
	{		
		var th = document.all.thVert;
		for(var i=0; i < th.length; i++)
		{
			th[i].className = "DataTable2";
		}
		
		var th1 = document.all.thVert1;
		for(var i=0; i < th1.length; i++)
		{
			th1[i].className = "DataTable5";
		}
	} 
}
//==============================================================================
// show column headings
//==============================================================================
function showColHdr(cell, id)
{
   var html = "<table border=1 width='100%' cellPadding=0 cellSpacing=0><tr><td style='font-size:10px;' nowrap>";
   html += ColHdg[id];
   html += "</tr></td></table>";

   var pos = getObjPosition(cell);

   document.all.dvColHdr.innerHTML = html;
   document.all.dvColHdr.style.left= pos[0] + 5;
   document.all.dvColHdr.style.top= pos[1] + 10;
   document.all.dvColHdr.style.visibility = "visible";
}


//==============================================================================
// show Employee actual hours and payments
//==============================================================================
function showGrpBdg(arg, str)
{
  var hdr = "Payroll Dollars<br>Store: " + str;
  if (str == "REG"){ hdr = "Payroll Dollars<br>Region Total"}
  else if (str == "COMP"){ hdr = "Payroll Dollars<br>Company Total"}

  var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
   html += "<tr><td class='Prompt' colspan=2>"

   html += popGrpBdgPanel(arg)

   html += "</td></tr></table>"

   document.all.dvEmpList.innerHTML = html;
   
   if(isIE && ua.indexOf("MSIE 7.0") >= 0)
   {
	   document.all.dvEmpList.style.width = "250";
   }
   else 
   {
	   document.all.dvEmpList.style.width = "auto";
   }
   document.all.dvEmpList.style.left= getLeftScreenPos() + 100;
   document.all.dvEmpList.style.top= getTopScreenPos() + 10;
   document.all.dvEmpList.style.visibility = "visible";

   switchCol("tdBdgPay", "thAllBdg", "thBdgPay", 5);
   switchCol("tdActPay", "thAllAct", "thActPay", 5);
   switchCol("tdSchPay", "thAllSch", "thSchPay", 5);
   switchCol("tdTotPay", "thAllTot", "thTotPay", 5);
   switchCol("tdVarPay", "thAllVar", "thVarPay", 5);
}
//==============================================================================
// populate Column Panel
//==============================================================================
function popGrpBdgPanel(arg)
{
  var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>";
  panel += "<tr class='DataTable2'>"
             + "<th class='DataTable3' rowspan=2 nowrap>Group</th>"
             + "<th class='DataTable3' id='thAllBdg' colspan=7 nowrap><a href='javascript: switchCol(&#34;tdBdgPay&#34;, &#34;thAllBdg&#34;, &#34;thBdgPay&#34;, 5)'>Budget</a></th>"
             + "<th class='DataTable3' rowspan=2 nowrap>&nbsp</th>"
             + "<th class='DataTable3' id='thAllAct' colspan=7 nowrap><a href='javascript: switchCol(&#34;tdActPay&#34;, &#34;thAllAct&#34;, &#34;thActPay&#34;, 5)'>Actual</a></th>"
             + "<th class='DataTable3' rowspan=2 nowrap>&nbsp</th>"
             + "<th class='DataTable3' id='thAllSch' colspan=7 nowrap><a href='javascript: switchCol(&#34;tdSchPay&#34;, &#34;thAllSch&#34;, &#34;thSchPay&#34;, 5)'>Schedule</a></th>"
             + "<th class='DataTable3' rowspan=2 nowrap>&nbsp</th>"
             + "<th class='DataTable3' id='thAllTot' colspan=7 nowrap><a href='javascript: switchCol(&#34;tdTotPay&#34;, &#34;thAllTot&#34;, &#34;thTotPay&#34;, 5)'>Total</a></th>"
             + "<th class='DataTable3' rowspan=2 nowrap>&nbsp</th>"
             + "<th class='DataTable3' id='thAllVar' colspan=7 nowrap><a href='javascript: switchCol(&#34;tdVarPay&#34;, &#34;thAllVar&#34;, &#34;thVarPay&#34;, 5)'>Variance</a></th>"
         + "</tr>"
         + "<tr class='DataTable2'>"
             + "<th class='DataTable3' nowrap>Hrs</th>"
             + "<th class='DataTable3' id='tdBdgPay' nowrap>Reg<br>Earn</th>"
             + "<th class='DataTable3' id='tdBdgPay' nowrap>Sls<br>Comm</th>"
             + "<th class='DataTable3' id='tdBdgPay' nowrap>Labor<br>Spiff</th>"
             + "<th class='DataTable3' id='tdBdgPay' nowrap>Paid<br> Spiff</th>"
             + "<th class='DataTable3' id='tdBdgPay' nowrap>Other</th>"
             + "<th class='DataTable3' nowrap>Tot</th>"

             + "<th class='DataTable3' nowrap>Hrs</th>"
             + "<th class='DataTable3' id='tdActPay' nowrap>Reg<br>Earn</th>"
             + "<th class='DataTable3' id='tdActPay' nowrap>Sls<br>Comm</th>"
             + "<th class='DataTable3' id='tdActPay' nowrap>Labor<br>Spiff</th>"
             + "<th class='DataTable3' id='tdActPay' nowrap>Paid<br> Spiff</th>"
             + "<th class='DataTable3' id='tdActPay' nowrap>Other</th>"
             + "<th class='DataTable3' nowrap>Tot</th>"

             + "<th class='DataTable3' nowrap>Hrs</th>"
             + "<th class='DataTable3' id='tdSchPay' nowrap>Reg<br>Earn</th>"
             + "<th class='DataTable3' id='tdSchPay' nowrap>Sls<br>Comm</th>"
             + "<th class='DataTable3' id='tdSchPay' nowrap>Labor<br>Spiff</th>"
             + "<th class='DataTable3' id='tdSchPay' nowrap>Paid<br> Spiff</th>"
             + "<th class='DataTable3' id='tdSchPay' nowrap>Other</th>"
             + "<th class='DataTable3' nowrap>Tot</th>"

             + "<th class='DataTable3' nowrap>Hrs</th>"
             + "<th class='DataTable3' id='tdTotPay' nowrap>Reg<br>Earn</th>"
             + "<th class='DataTable3' id='tdTotPay' nowrap>Sls<br>Comm</th>"
             + "<th class='DataTable3' id='tdTotPay' nowrap>Labor<br>Spiff</th>"
             + "<th class='DataTable3' id='tdTotPay' nowrap>Paid<br> Spiff</th>"
             + "<th class='DataTable3' id='tdTotPay' nowrap>Other</th>"
             + "<th class='DataTable3' nowrap>Tot</th>"

             + "<th class='DataTable3' nowrap>Hrs</th>"
             + "<th class='DataTable3' id='tdVarPay' nowrap>Reg<br>Earn</th>"
             + "<th class='DataTable3' id='tdVarPay' nowrap>Sls<br>Comm</th>"
             + "<th class='DataTable3' id='tdVarPay' nowrap>Labor<br>Spiff</th>"
             + "<th class='DataTable3' id='tdVarPay' nowrap>Paid<br> Spiff</th>"
             + "<th class='DataTable3' id='tdVarPay' nowrap>Other</th>"
             + "<th class='DataTable3' nowrap>Tot</th>"
         + "</tr>"

  for(var  i=0, j=0; i < GrpBdg[arg].length; i++)
  {
       if (GrpBdgName[arg][i].indexOf("Total") >= 0) {  panel += "<tr class='DataTable32'>" }
       else {  panel += "<tr class='DataTable3'>" }

       j = getActEmpGrpArg(arg, GrpBdgName[arg][i]);

       panel += "<td class='DataTable1' nowrap>" + GrpBdgName[arg][i] + "</td>"
             + "<td class='DataTable2' nowrap>" + GrpBdgHrs[arg][i] + "</td>"
             + "<td class='DataTable2' id='tdBdgPay' nowrap>$" + GrpBdgPayReg[arg][i] + "</td>"
             + "<td class='DataTable2' id='tdBdgPay' nowrap>$" + GrpBdgPayCom[arg][i] + "</td>"
             + "<td class='DataTable2' id='tdBdgPay' nowrap>$" + GrpBdgPayLSpiff[arg][i] + "</td>"
             + "<td class='DataTable2' id='tdBdgPay' nowrap>$" + GrpBdgPayMSpiff[arg][i] + "</td>"
             + "<td class='DataTable2' id='tdBdgPay' nowrap>$" + GrpBdgPayOther[arg][i] + "</td>"
             + "<td class='DataTable2' nowrap>$" + GrpBdgPay[arg][i] + "</td>"

             + "<th class='DataTable3' nowrap>&nbsp</th>"
             + "<td class='DataTable2' nowrap>" + ActEmpGrpHrs[arg][j] + "</td>"
             + "<td class='DataTable2' id='tdActPay' nowrap>$" + ActEmpGrpPay[arg][j] + "</td>"
             + "<td class='DataTable2' id='tdActPay' nowrap>$" + ActEmpGrpCom[arg][j] + "</td>"
             + "<td class='DataTable2' id='tdActPay' nowrap>$" + ActEmpGrpLSpiff[arg][j] + "</td>"
             + "<td class='DataTable2' id='tdActPay' nowrap>$" + ActEmpGrpMSpiff[arg][j] + "</td>"
             + "<td class='DataTable2' id='tdActPay' nowrap>$" + ActEmpGrpIncPay[arg][j] + "</td>"
             + "<td class='DataTable2' nowrap>$" + ActEmpGrpTot[arg][j] + "</td>"

             + "<th class='DataTable3' nowrap>&nbsp</th>"
             + "<td class='DataTable2' nowrap>" + SchGrpHrs[arg][j] + "</td>"
             + "<td class='DataTable2' id='tdSchPay' nowrap>$" + SchGrpPay[arg][j] + "</td>"
             + "<td class='DataTable2' id='tdSchPay' nowrap>$" + SchGrpCom[arg][j] + "</td>"
             + "<td class='DataTable2' id='tdSchPay' nowrap>$" + SchGrpLSpiff[arg][j] + "</td>"
             + "<td class='DataTable2' id='tdSchPay' nowrap>$" + SchGrpMSpiff[arg][j] + "</td>"
             + "<td class='DataTable2' id='tdSchPay' nowrap>$" + SchGrpIncPay[arg][j] + "</td>"
             + "<td class='DataTable2' nowrap>$" + SchGrpTot[arg][j] + "</td>"

             + "<th class='DataTable3' nowrap>&nbsp</th>"
             + "<td class='DataTable2' nowrap>" + TotGrpHrs[arg][j] + "</td>"
             + "<td class='DataTable2' id='tdTotPay' nowrap>$" + TotGrpPay[arg][j] + "</td>"
             + "<td class='DataTable2' id='tdTotPay' nowrap>$" + TotGrpCom[arg][j] + "</td>"
             + "<td class='DataTable2' id='tdTotPay' nowrap>$" + TotGrpLSpiff[arg][j] + "</td>"
             + "<td class='DataTable2' id='tdTotPay' nowrap>$" + TotGrpMSpiff[arg][j] + "</td>"
             + "<td class='DataTable2' id='tdTotPay' nowrap>$" + TotGrpIncPay[arg][j] + "</td>"
             + "<td class='DataTable2' nowrap>$" + TotGrpTot[arg][j] + "</td>"

             + "<th class='DataTable3' nowrap>&nbsp</th>"
             + "<td class='DataTable2' nowrap>" + VarGrpHrs[arg][j] + "</td>"
             + "<td class='DataTable2' id='tdVarPay' nowrap>$" + VarGrpPay[arg][j] + "</td>"
             + "<td class='DataTable2' id='tdVarPay' nowrap>$" + VarGrpCom[arg][j] + "</td>"
             + "<td class='DataTable2' id='tdVarPay' nowrap>$" + VarGrpLSpiff[arg][j] + "</td>"
             + "<td class='DataTable2' id='tdVarPay' nowrap>$" + VarGrpMSpiff[arg][j] + "</td>"
             + "<td class='DataTable2' id='tdVarPay' nowrap>$" + VarGrpIncPay[arg][j] + "</td>"
             + "<td class='DataTable2' nowrap>$" + VarGrpTot[arg][j] + "</td>"
         + "</tr>"

  }

  panel += "<tr><td class='Prompt1' colspan=55>"
        + "<button onClick='hidePanel();' class='Small'>Close</button> &nbsp; &nbsp;"
        + "<button onClick='printTblContent(&#34;dvEmpList&#34;);' class='Small'>Print</button>"
        + "</td></tr>"

  panel += "</table>";

  return panel;
}

//==============================================================================
// show Employee actual hours and payments
//==============================================================================
function showGrpBdgAvg(arg, str)
{
  var hdr = "Average Rate<br>Store: " + str;
  if (str == "REG"){ hdr = "Average Rate<br>Region Total"}
  else if (str == "COMP"){ hdr = "Average Rate<br>Company Total"}

  var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
   html += "<tr><td class='Prompt' colspan=2>"

   html += popGrpBdgAvgPanel(arg)  

   html += "</td></tr></table>"

   document.all.dvEmpList.innerHTML = html;if(isIE && ua.indexOf("MSIE 7.0") >= 0)
   {
	   document.all.dvEmpList.style.width = "250";
   }
   else 
   {
	   document.all.dvEmpList.style.width = "auto";
   }
   document.all.dvEmpList.style.left= getLeftScreenPos() + 100;
   document.all.dvEmpList.style.top= getTopScreenPos() + 10;
   document.all.dvEmpList.style.visibility = "visible";

   switchCol("tdBdgAvg", "thAllBdg", "thBdgAvg", 5);
   switchCol("tdActAvg", "thAllAct", "thActAvg", 5);
   switchCol("tdSchAvg", "thAllSch", "thSchAvg", 5);
   switchCol("tdTotAvg", "thAllTot", "thTotAvg", 5);
   switchCol("tdVarAvg", "thAllVar", "thVarAvg", 5);
}
//--------------------------------------------------------
// populate Column Panel
//--------------------------------------------------------
function popGrpBdgAvgPanel(arg)
{
  var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>";
  panel += "<tr class='DataTable2'>"
             + "<th class='DataTable3' rowspan=2 nowrap>Group</th>"
             + "<th class='DataTable3' id='thAllBdg' colspan=7 nowrap><a href='javascript: switchCol(&#34;tdBdgAvg&#34;, &#34;thAllBdg&#34;, &#34;thBdgAvg&#34;, 5)'>Budget</a></th>"
             + "<th class='DataTable3' rowspan=2 nowrap>&nbsp</th>"
             + "<th class='DataTable3' id='thAllAct' colspan=7 nowrap><a href='javascript: switchCol(&#34;tdActAvg&#34;, &#34;thAllAct&#34;, &#34;thActAvg&#34;, 5)'>Actual</a></th>"
             + "<th class='DataTable3' rowspan=2 nowrap>&nbsp</th>"
             + "<th class='DataTable3' id='thAllSch' colspan=7 nowrap><a href='javascript: switchCol(&#34;tdSchAvg&#34;, &#34;thAllSch&#34;, &#34;thSchAvg&#34;, 5)'>Schedule</a></th>"
             + "<th class='DataTable3' rowspan=2 nowrap>&nbsp</th>"
             + "<th class='DataTable3' id='thAllTot' colspan=7 nowrap><a href='javascript: switchCol(&#34;tdTotAvg&#34;, &#34;thAllTot&#34;, &#34;thTotAvg&#34;, 5)'>Total</a></th>"
             + "<th class='DataTable3' rowspan=2 nowrap>&nbsp</th>"
             + "<th class='DataTable3' id='thAllVar' colspan=7 nowrap><a href='javascript: switchCol(&#34;tdVarAvg&#34;, &#34;thAllVar&#34;, &#34;thVarAvg&#34;, 5)'>Variance</a></th>"
         + "</tr>"
         + "<tr class='DataTable2'>"
             + "<th class='DataTable3' nowrap>Hrs</th>"
             + "<th class='DataTable3' id='tdBdgAvg' nowrap>Reg<br>Earn</th>"
             + "<th class='DataTable3' id='tdBdgAvg' nowrap>Sls<br>Comm</th>"
             + "<th class='DataTable3' id='tdBdgAvg' nowrap>Labor<br>Spiff</th>"
             + "<th class='DataTable3' id='tdBdgAvg' nowrap>Paid<br> Spiff</th>"
             + "<th class='DataTable3' id='tdBdgAvg' nowrap>Other</th>"
             + "<th class='DataTable3' nowrap>Tot</th>"

             + "<th class='DataTable3' nowrap>Hrs</th>"
             + "<th class='DataTable3' id='tdActAvg' nowrap>Reg<br>Earn</th>"
             + "<th class='DataTable3' id='tdActAvg' nowrap>Sls<br>Comm</th>"
             + "<th class='DataTable3' id='tdActAvg' nowrap>Labor<br>Spiff</th>"
             + "<th class='DataTable3' id='tdActAvg' nowrap>Paid<br> Spiff</th>"
             + "<th class='DataTable3' id='tdActAvg' nowrap>Other</th>"
             + "<th class='DataTable3' nowrap>Tot</th>"

             + "<th class='DataTable3' nowrap>Hrs</th>"
             + "<th class='DataTable3' id='tdSchAvg' nowrap>Reg<br>Earn</th>"
             + "<th class='DataTable3' id='tdSchAvg' nowrap>Sls<br>Comm</th>"
             + "<th class='DataTable3' id='tdSchAvg' nowrap>Labor<br>Spiff</th>"
             + "<th class='DataTable3' id='tdSchAvg' nowrap>Paid<br> Spiff</th>"
             + "<th class='DataTable3' id='tdSchAvg' nowrap>Other</th>"
             + "<th class='DataTable3' nowrap>Tot</th>"

             + "<th class='DataTable3' nowrap>Hrs</th>"
             + "<th class='DataTable3' id='tdTotAvg' nowrap>Reg<br>Earn</th>"
             + "<th class='DataTable3' id='tdTotAvg' nowrap>Sls<br>Comm</th>"
             + "<th class='DataTable3' id='tdTotAvg' nowrap>Labor<br>Spiff</th>"
             + "<th class='DataTable3' id='tdTotAvg' nowrap>Paid<br> Spiff</th>"
             + "<th class='DataTable3' id='tdTotAvg' nowrap>Other</th>"
             + "<th class='DataTable3' nowrap>Tot</th>"

             + "<th class='DataTable3' nowrap>Hrs</th>"
             + "<th class='DataTable3' id='tdVarAvg' nowrap>Reg<br>Earn</th>"
             + "<th class='DataTable3' id='tdVarAvg' nowrap>Sls<br>Comm</th>"
             + "<th class='DataTable3' id='tdVarAvg' nowrap>Labor<br>Spiff</th>"
             + "<th class='DataTable3' id='tdVarAvg' nowrap>Paid<br> Spiff</th>"
             + "<th class='DataTable3' id='tdVarAvg' nowrap>Other</th>"
             + "<th class='DataTable3' nowrap>Tot</th>"
         + "</tr>"

  //alert(ActEmpGrpName[arg] + "\n" + GrpBdgName[arg] )

  for(var  i=0, j=0; i < GrpBdg[arg].length; i++)
  {
       if (GrpBdgName[arg][i].indexOf("Total") >= 0) {  panel += "<tr class='DataTable32'>" }
       else {  panel += "<tr class='DataTable3'>" }

       j = getActEmpGrpArg(arg, GrpBdgName[arg][i]);

       panel += "<td class='DataTable1' nowrap>" + GrpBdgName[arg][i] + "</td>"
             + "<td class='DataTable2' nowrap>" + GrpBdgHrs[arg][i] + "</td>"
             + "<td class='DataTable2' id='tdBdgAvg' nowrap>$" + GrpBdgAvgPay[arg][i] + "</td>"
             + "<td class='DataTable2' id='tdBdgAvg' nowrap>$" + GrpBdgAvgCom[arg][i] + "</td>"
             + "<td class='DataTable2' id='tdBdgAvg' nowrap>$" + GrpBdgAvgLSpiff[arg][i] + "</td>"
             + "<td class='DataTable2' id='tdBdgAvg' nowrap>$" + GrpBdgAvgMSpiff[arg][i] + "</td>"
             + "<td class='DataTable2' id='tdBdgAvg' nowrap>$" + GrpBdgAvgOther[arg][i] + "</td>"
             + "<td class='DataTable2' nowrap>$" + GrpBdgAvg[arg][i] + "</td>"

             + "<th class='DataTable3' nowrap>&nbsp</th>"
             + "<td class='DataTable2' nowrap>" + ActEmpGrpHrs[arg][j] + "</td>"
             + "<td class='DataTable2' id='tdActAvg' nowrap>$" + ActEmpGrpAvgPay[arg][j] + "</td>"
             + "<td class='DataTable2' id='tdActAvg' nowrap>$" + ActEmpGrpAvgCom[arg][j] + "</td>"
             + "<td class='DataTable2' id='tdActAvg' nowrap>$" + ActEmpGrpAvgLSpiff[arg][j] + "</td>"
             + "<td class='DataTable2' id='tdActAvg' nowrap>$" + ActEmpGrpAvgMSpiff[arg][j] + "</td>"
             + "<td class='DataTable2' id='tdActAvg' nowrap>$" + ActEmpGrpAvgIncPay[arg][j] + "</td>"
             + "<td class='DataTable2' nowrap>$" + ActEmpGrpAvgTot[arg][j] + "</td>"

             + "<th class='DataTable3' nowrap>&nbsp</th>"
             + "<td class='DataTable2' nowrap>" + SchGrpHrs[arg][j] + "</td>"
             + "<td class='DataTable2' id='tdSchAvg' nowrap>$" + SchGrpAvgPay[arg][j] + "</td>"
             + "<td class='DataTable2' id='tdSchAvg' nowrap>$" + SchGrpAvgCom[arg][j] + "</td>"
             + "<td class='DataTable2' id='tdSchAvg' nowrap>$" + SchGrpAvgLSpiff[arg][j] + "</td>"
             + "<td class='DataTable2' id='tdSchAvg' nowrap>$" + SchGrpAvgMSpiff[arg][j] + "</td>"
             + "<td class='DataTable2' id='tdSchAvg' nowrap>$0</td>"
             + "<td class='DataTable2' nowrap>$" + SchGrpAvgTot[arg][j] + "</td>"

             + "<th class='DataTable3' nowrap>&nbsp</th>"
             + "<td class='DataTable2' nowrap>" + TotGrpHrs[arg][j] + "</td>"
             + "<td class='DataTable2' id='tdTotAvg' nowrap>$" + TotGrpAvgPay[arg][j] + "</td>"
             + "<td class='DataTable2' id='tdTotAvg' nowrap>$" + TotGrpAvgCom[arg][j] + "</td>"
             + "<td class='DataTable2' id='tdTotAvg' nowrap>$" + TotGrpAvgLSpiff[arg][j] + "</td>"
             + "<td class='DataTable2' id='tdTotAvg' nowrap>$" + TotGrpAvgMSpiff[arg][j] + "</td>"
             + "<td class='DataTable2' id='tdTotAvg' nowrap>$0</td>"
             + "<td class='DataTable2' nowrap>$" + TotGrpAvgTot[arg][j] + "</td>"

             + "<th class='DataTable3' nowrap>&nbsp</th>"
             + "<td class='DataTable2' nowrap>" + VarGrpHrs[arg][j] + "</td>"
             + "<td class='DataTable2' id='tdVarAvg' nowrap>$" + VarGrpAvgPay[arg][j] + "</td>"
             + "<td class='DataTable2' id='tdVarAvg' nowrap>$" + VarGrpAvgCom[arg][j] + "</td>"
             + "<td class='DataTable2' id='tdVarAvg' nowrap>$" + VarGrpAvgLSpiff[arg][j] + "</td>"
             + "<td class='DataTable2' id='tdVarAvg' nowrap>$" + VarGrpAvgMSpiff[arg][j] + "</td>"
             + "<td class='DataTable2' id='tdVarAvg' nowrap>$0</td>"
             + "<td class='DataTable2' nowrap>$" + VarGrpAvgTot[arg][j] + "</td>"
         + "</tr>"

  }

  panel += "<tr><td class='Prompt1' colspan=55>"
        + "<button onClick='hidePanel();' class='Small'>Close</button> &nbsp; &nbsp;"
        + "<button onClick='printTblContent(&#34;dvEmpList&#34;);' class='Small'>Print</button>"
        + "</td></tr>"

  panel += "</table>";

  return panel;
}
//--------------------------------------------------------
// get actual employee group argument
//--------------------------------------------------------
function getActEmpGrpArg(str, grp)
{
   var arg = 0;
   var found = false;
   var max = ActEmpGrpName.length;

   for(var  i=0; i < max; i++)
   {
      if(grp == ActEmpGrpName[str][i]){ arg = i; found = true;}
   }
   if(!found)
   {
      ActEmpGrpName[str][max] = grp;
      ActEmpGrpHrs[str][max] = 0;
      ActEmpGrpPay[str][max] = 0;
      ActEmpGrpCom[str][max] = 0;
      ActEmpGrpLSpiff[str][max] = 0;
      ActEmpGrpMSpiff[str][max] = 0;
      ActEmpGrpTot[str][max] = 0;
      ActEmpGrpAvgPay[str][max] = 0;
      ActEmpGrpAvgCom[str][max] = 0;
      ActEmpGrpAvgLSpiff[str][max] = 0;
      ActEmpGrpAvgMSpiff[str][max] = 0;
      ActEmpGrpAvgTot[str][max] = 0;
      ActEmpGrpSlsRet[str][max] = 0;
      ActEmpGrpIncPay[str][max] = 0;
      ActEmpGrpAvgIncPay[str][max] = 0;
      arg = max;
   }

   return arg;
}

//==============================================================================
// fold/unfold columns
//==============================================================================
function switchCol(cellId, hdrId1, hdrId2, numcol)
{
   var status = null;
   var cell = document.all[cellId];
   var hdr1 = document.all[hdrId1];
   var hdr2 = document.all[hdrId2];

   if(cell[0].style.display != "none")
   {
      status = "none";
      if(hdr1 != null) { hdr1.colSpan = hdr1.colSpan - numcol; }
      if(hdr2 != null) { hdr2.colSpan = hdr2.colSpan - numcol; }
   }
   else
   {
      status = "table-cell";
      if(hdr1 != null) { hdr1.colSpan = hdr1.colSpan + numcol; }
      if(hdr2 != null) { hdr2.colSpan = hdr2.colSpan + numcol; }
   }

   for(var i=0; i < cell.length; i++) { cell[i].style.display = status; }
}
//==============================================================================
// Hide selection screen
//==============================================================================
function hidePanel()
{
   document.all.dvEmpList.innerHTML = " ";
   document.all.dvEmpList.style.visibility = "hidden";
}

//==============================================================================
// start excel
//==============================================================================
function startExcel()
{
  var xls = new ActiveXObject ( "Excel.Application" );
 xls.visible = true;
 var newBook = xls.Workbooks.Add;
 newBook.Worksheets.Add;
 newBook.Worksheets(1).Activate;

 popExcelHdr(newBook);
 //popExcelDtl(newBook);
 popExcelDtl2(newBook);

 newBook.Worksheets(1).Name="Budget vs. Actual Average Rates";
}
//==============================================================================
// populate excel header
//==============================================================================
function popExcelHdr(newBook)
{
   newBook.Worksheets(1).Cells(1,1).value="Str";
   newBook.Worksheets(1).Cells(1,2).value="Group";
   newBook.Worksheets(1).Cells(1,3).value="Hrs";
   newBook.Worksheets(1).Cells(1,4).value="Reg Earn";
   newBook.Worksheets(1).Cells(1,5).value="Sls Comm";
   newBook.Worksheets(1).Cells(1,6).value="Labor Spiff";
   newBook.Worksheets(1).Cells(1,7).value="Paid Spiff";
   newBook.Worksheets(1).Cells(1,8).value="Other";
   newBook.Worksheets(1).Cells(1,9).value="Total";

   newBook.Worksheets(1).Rows(1).Font.Bold = true;
   newBook.Worksheets(1).Rows(1).WrapText = true;
   newBook.Worksheets(1).Cells(1,2).columnwidth=18;
}
//==============================================================================
// populate excel details
//==============================================================================
function popExcelDtl(newBook)
{
   // store loop
   for(var i=0, k=2; i < GrpBdg.length; i++)
   {
      // budget loop
      for(var j=0; j < GrpBdg[i].length; j++, k++)
      {
         newBook.Worksheets(1).Cells(k,1).value=StrArr[i];
         newBook.Worksheets(1).Cells(k,2).value=GrpBdgName[i][j];
         newBook.Worksheets(1).Cells(k,3).value=ActEmpGrpHrs[i][j];
         newBook.Worksheets(1).Cells(k,4).value=ActEmpGrpAvgPay[i][j];
         newBook.Worksheets(1).Cells(k,5).value=ActEmpGrpAvgCom[i][j];
         newBook.Worksheets(1).Cells(k,6).value=ActEmpGrpAvgLSpiff[i][j];
         newBook.Worksheets(1).Cells(k,7).value=ActEmpGrpAvgMSpiff[i][j];
         newBook.Worksheets(1).Cells(k,8).value=ActEmpGrpAvgIncPay[i][j];
         newBook.Worksheets(1).Cells(k,9).value=ActEmpGrpAvgTot[i][j];
      }
   }
}
//==============================================================================
// populate excel details
//==============================================================================
function popExcelDtl2(newBook)
{
   var cells = newBook.Worksheets(1).Cells;
   // store loop
   for(var i=0, k=2; i < GrpBdg[0].length; i++)
   {
      // budget loop
      for(var j=0; j < StrArr.length; j++, k++)
      {
         cells(k,1).value=StrArr[j];
         cells(k,2).value=GrpBdgName[j][i];
         cells(k,3).value=ActEmpGrpHrs[j][i];
         cells(k,4).value=ActEmpGrpAvgPay[j][i];
         cells(k,5).value=ActEmpGrpAvgCom[j][i];
         cells(k,6).value=ActEmpGrpAvgLSpiff[j][i];
         cells(k,7).value=ActEmpGrpAvgMSpiff[j][i];
         cells(k,8).value=ActEmpGrpAvgIncPay[j][i];
         cells(k,9).value=ActEmpGrpAvgTot[j][i];
      }
   }
}
//==============================================================================
// get another week
//==============================================================================
function getAnotherWeek(increment)
{
   var nDate = new Date(SelWkend);
   nDate.setHours(18)
   nDate = new Date(nDate.getTime() + increment * 7 * 24 * 60 * 60 * 1000);
   var nWeek = (nDate.getMonth()+1) + "/" + nDate.getDate() + "/" + nDate.getFullYear();

   var url = "BfdgSchActWkAllStr.jsp?&Wkend=" + nWeek;
   window.location.href = url;
}
//==============================================================================
// print table content
//==============================================================================
function printTblContent(obj)
{
   var r1 = document.getElementById(obj);

   var MyWindowName = "Payroll_Budget_ByEmployee_Grp";
   var MyWindowOptions =
    "left=20, top=20, width=800,height=600, toolbar=yes, location=yes, directories=yes, status=yes, scrollbars=yes, menubar=yes, scrollbars=1, resizable=yes";

   var html = r1.outerHTML
   window_tbl = window.open("", MyWindowName, MyWindowOptions);
     window_tbl.document.write('<style>'
       + 'tr.DataTable3 { background: #ccffcc; font-size:10px }'
       + ' tr.DataTable31 { background: #ffff99; font-size:10px }'
       + ' tr.DataTable32 { background: gold; font-size:10px }'
       + ' th.Divdr2t { border-top: black solid 3px; background:#ccccff;  font-size:1px}'
       + ' th.Divdr2r { border-right: black solid 3px; background:#ccccff;  font-size:1px}'
       + ' th.Divdr2l { border-left: black solid 3px; background:#ccccff;  font-size:1px}'
       + ' th.Divdr2b { border-bottom: black solid 3px; background:#ccccff;  font-size:1px}'
       + ' th.DataTable3 { background:#ccccff; padding-top:3px; padding-bottom:3px; font-size:12px }'
       + ' th.DataTable31 { border-top: black solid 3px;  background:#ccccff; padding-top:3px; padding-bottom:3px; font-size:12px; text-align:left;}'
       + ' td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:center; }'
       + ' td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:right;}'
       + ' td.DataTable2d { border-bottom: black solid 3px; padding-top:3px; padding-bottom:3px; padding-left:3px;'
       + ' padding-right:3px; text-align:right;}'
       + ' td.DataTable3 { background: black; font-size:12px }'
      + '</style>');
   window_tbl.document.write('<BODY onload="window.print();window.close();">\n'
      + '<div width=500>' + html + '</div>'
      + '</BODY">\n')
   window_tbl.document.close();
}
</script>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Get_Object_Position.js"></script>



<body onload="bodyLoad();">
<!-------------------------------------------------------------------->
<div id="dvEmpList" class="dvEmpList"></div>
<div id="dvColHdr" class="dvColHdr"></div>
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
    <table border="0" width="100%" cellPadding="0" cellSpacing="0">
     <tr bgColor="ivory">
      <td ALIGN="center" VALIGN="TOP" colspan=3>
      <b>Retail Concepts Inc.
      <br>Weekly Budget vs. Schedule and Actual Payroll
      <br>Weekending date: <button onclick="getAnotherWeek('-1')">&#60;</button><%=sWkend%><button onclick="getAnotherWeek('1')">&#62;</button>
      </b>

      <br><br><a href="../" class="small"><font color="red">Home</font></a>&#62;
      <a href="BfdgSchActWkSel.jsp" class="small"><font color="red">Selection</font></a>&#62;
      <font size="-1">This Page.</font>&nbsp;&nbsp;&nbsp;&nbsp;
      <a href="javascript: displayAllHelp()">Help</a>
<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table border=0 cellPadding="0" cellSpacing="0" >
        <tr>
          <th colspan=12></th>
          <th class="DataTable3" colspan=23>Hourly Employee Only (Excludes Holiday, Sick, Vacation and TMC.)</th>
        </tr>
        <tr>
          <th colspan=3></th>
          <th class="DataTable4" colspan=6>Sales</th>
          <th colspan=3></th>
          <th class="DataTable4" colspan=7>P/R Hours</th>
          <th></th>
          <th class="DataTable4" colspan=6>P/R $'s</th>
          <th class="DataTable4" colspan=3>Hourly Rate</th>
          <th></th>
          <th class="DataTable4" colspan=5>Variance</th>
          <th></th>
          <th class="DataTable4" colspan=6>T/M/C</th>
          <th></th>
          <th class="DataTable4" colspan=5>Actual Processed Payroll</th>
          <th>&nbsp;</th>
          <th class="DataTable4" colspan=4>P/R $'s - No Commissions</th>
        </tr>
        <tr>
          <th class="DataTable" rowspan=2>Reg</th>
          <th class="rotate" id="thVert" rowspan=2>
               <div><span>
               		Store<br>Link on store number shows Allowable Budget Review<br>for selected store
               	</span></div>
          </th>
          <th class="DataTable" rowspan=2>S<br>c<br>h<br>e<br>d<br>u<br>l<br>e</th>
          <th class="rotate1" id="thVert" nowrap><div><span>Original Sales Plan</span></div></th>
          <th class="rotate1" id="thVert"><div><span>Sales Forecast Trend Rate</span></div></th>
          <th class="rotate1" id="thVert"><div><span>Sales Forecast</span></div></th>
          <th class="rotate1" id="thVert"><div><span>Sales Forecast Dollars +/-</span></div></th>
          <th class="rotate1" id="thVert"><div><span>Sales Actual / Forecast</span></div></th>
          <th class="rotate1" id="thVert"><div><span>Sales Actual / Forecast Dollars +/-</span></div></th>
          <th class="DataTable" rowspan=2>&nbsp;</th>
          <th class="rotate2" id="thVert1" rowspan=2><div><span>Bdg vs Act $'s</span></div></th>
          <th class="rotate2" id="thVert1" rowspan=2><div><span>Bdg vs Act Avg Rate</span></div></th>
          <th class="rotate1" id="thVert"><div><span>Original Budget Hours</span></div></th>
          <th class="rotate1" id="thVert"><div><span>Hours Earned <sup>1)</sup></span></div></th>
          <th class="rotate1" id="thVert"><div><span>Hours Earned (Based on Salaried Employees on V or H)</span></div></th>
          <th class="rotate1" id="thVert"><div><span>Allowable Budget Hours</span></div></th>
          <th class="rotate1" id="thVert"><div><span>Actual Hrs. / Adjusted Hrs. To Reach Allowable Budget</span></div></th>
          <th class="rotate1" id="thVert"><div><span>Actual Hrs. / Adjusted Hrs. To Reach Allowable Budget</span></div></th>

          <th class="rotate1" id="thVert"><div><span>Hours Actual / Scheduled</span></div></th>
          <th class="DataTable" rowspan=2>&nbsp;</th>
          <th class="rotate1" id="thVert"><div><span>Original Payroll Budget Dollars</span></div></th>
          <th class="rotate1" id="thVert"><div><span>Allowable Dollars Earned by Sales</span></div></th>
          <th class="rotate1" id="thVert"><div><span>Allowable Dollars Earned Based on H,S,V</span></div></th>
          <th class="rotate1" id="thVert"><div><span>$'s earned(lost) based on change in allowable budgeted avg. hourly rate</span></div></th>
          <th class="rotate1" id="thVert"><div><span>Allowable Budget Dollars</span></div></th>
          <th class="rotate1" id="thVert"><div><span>Hourly Payroll $ Actual / Scheduled</span></div></th>
          <th class="rotate1" id="thVert"><div><span>Original Budgeted Average Hourly Rate</span></div></th>
          <th class="rotate1" id="thVert"><div><span>Allowable Budgeted Average Hourly Rate</span></div></th>
          <th class="rotate1" id="thVert"><div><span>Actual / Scheduled Average Hourly Rate</span></div></th>
          <th class="DataTable" rowspan=2>&nbsp;</th>
          <th class="rotate1" id="thVert"><div><span>Actual / Scheduled Hours vs. Allowable Budget</span></div></th>
          <th class="rotate1" id="thVert"><div><span>Actual / Scheduled Dollars +/- Allowable Budget</span></div></th>
          <th class="rotate1" id="thVert"><div><span>Original Budget Payroll % To Original Sales Plan</span></div></th>
          <th class="rotate1" id="thVert"><div><span>Actual / Scheduled Payroll % To Actual / Forecast Sales</span></div></th>
          <th class="rotate1" id="thVert"><div><span>Allowable Budget Payroll % To Actual / Forecast Sales</span></div></th>

          <th class="DataTable" rowspan=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>

          <th class="rotate1" id="thVert"><div><span>Budget Hours - Training/Meeting/Clinics</th>
          <th class="rotate1" id="thVert"><div><span>Hours Scheduled - TMC</th>
          <th class="rotate1" id="thVert"><div><span>Hours Actual - TMC</th>
          <th class="rotate1" id="thVert"><div><span>Payroll Budget $'s - TMC</th>
          <th class="rotate1" id="thVert"><div><span>Hours Payroll $'s/Scheduled - TMC</th>
          <th class="rotate1" id="thVert"><div><span>Hours Payroll $'s/Actual - TMC</th>

          <th class="DataTable" rowspan=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>

          <th class="rotate1" id="thVert"><div><span>Hours</span></div></th>
          <th class="rotate1" id="thVert"><div><span>Hourly Payroll (Daily/Cumulative)</span></div></th>
          <th class="rotate1" id="thVert"><div><span>Average Hourly Rate</span></div></th>
          <th class="rotate1" id="thVert"><div><span>Memo: Challenge</span></div></th>
          <th class="rotate1" id="thVert"><div><span>Actual Calculated & Processed +/-</span></div></th>
          
          <th class="DataTable" rowspan=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
          
          <th class="rotate1" id="thVert"><div><span>Original Payroll Budget Dollars - No Comm.</span></div></th>
          <th class="rotate1" id="thVert"><div><span>Allowable Budget Dollars - No Comm.</span></div></th>
          <th class="rotate1" id="thVert"><div><span>Hourly Payroll $ Actual / Scheduled - No Comm.</span></div></th>
          <th class="rotate1" id="thVert"><div><span>Actual / Scheduled Dollars +/- Allowable Budget - No Comm.</span></div></th>
        </tr>
        <tr>
            <th class="DataTable">2</th>
            <th class="DataTable">3</th>
            <th class="DataTable">4</th>
            <th class="DataTable">5</th>
            <th class="DataTable">6</th>
            <th class="DataTable">7</th>

            <th class="DataTable">9</th>
            <th class="DataTable">10a</th>
            <th class="DataTable">10b</th>
            <th class="DataTable">11</th>
            <th class="DataTable">12</th>
            <th class="DataTable">13</th>
            <th class="DataTable">14</th>

            <th class="DataTable">15</th>
            <th class="DataTable">16a</th>
            <th class="DataTable">16b</th>
            <th class="DataTable">16c</th>
            <th class="DataTable">16</th>
            <th class="DataTable">17</th>
            <th class="DataTable">18</th>
            <th class="DataTable">19</th>

            <th class="DataTable">20</th>
            <th class="DataTable">21</th>
            <th class="DataTable">22</th>
            <th class="DataTable">23</th>
            <th class="DataTable">24</th>
            <th class="DataTable">25</th>

            <th class="DataTable">1</th>
            <th class="DataTable">2a</th>
            <th class="DataTable">2b</th>
            <th class="DataTable">3</th>
            <th class="DataTable">4a</th>
            <th class="DataTable">4b</th>

            <th class="DataTable">14</th>
            <th class="DataTable">17</th>
            <th class="DataTable">19</th>
            <th class="DataTable">&nbsp;</th>
            <th class="DataTable">&nbsp;</th>
            
            <th class="DataTable">15n</th>
            <th class="DataTable">16n</th>
            <th class="DataTable">17n</th>
            <th class="DataTable">22n</th>
        </tr>

     <tr class="Divdr1"></td><td colspan=53>&nbsp;</td></tr>
     <!------------------------- Region --------------------------------------->
     <%for(int i=0; i < iNumOfReg; i++){%>
        <tr class="DataTable">
           <th class="DataTable3" rowspan="<%=iRegStr[i] + 1%>"><%=sReg[i]%></th>

        <!-- ------------------- Stores --------------------------------------->
        <%for(int j=0; j < iRegStr[i]; j++, iStrNum++)
          {
             bdgwkall.setStrBdgInfo();
             sLineCell = bdgwkall.getLineCell();
             sWarnLine20 = bdgwkall.getWarnLine20();
             sWarnLine21 = bdgwkall.getWarnLine21();
             sWarnLine23 = bdgwkall.getWarnLine23();

             // List of budget groups
             bdgwkall.setGrpBdg("S");
             int iNumOfGrpBdg = bdgwkall.getNumOfGrpBdg();
             String sGrpBdg = bdgwkall.getGrpBdgJsa();
             String sGrpBdgName = bdgwkall.getGrpBdgNameJsa();
             String sGrpBdgHrs = bdgwkall.getGrpBdgHrsJsa();

             String sGrpBdgPayReg = bdgwkall.getGrpBdgPayRegJsa();
             String sGrpBdgPayCom = bdgwkall.getGrpBdgPayComJsa();
             String sGrpBdgPayLSpiff = bdgwkall.getGrpBdgPayLSpiffJsa();
             String sGrpBdgPayMSpiff = bdgwkall.getGrpBdgPayMSpiffJsa();
             String sGrpBdgPayOther = bdgwkall.getGrpBdgPayOtherJsa();
             String sGrpBdgPay = bdgwkall.getGrpBdgPayJsa();

             String sGrpBdgAvgPay = bdgwkall.getGrpBdgAvgPayJsa();
             String sGrpBdgAvgCom = bdgwkall.getGrpBdgAvgComJsa();
             String sGrpBdgAvgLSpiff = bdgwkall.getGrpBdgAvgLSpiffJsa();
             String sGrpBdgAvgMSpiff = bdgwkall.getGrpBdgAvgMSpiffJsa();
             String sGrpBdgAvgOther = bdgwkall.getGrpBdgAvgOtherJsa();
             String sGrpBdgAvg = bdgwkall.getGrpBdgAvgJsa();

             // Actual Employee Budget Group totals
             bdgwkall.setActEmpGrp("S");
             String sActEmpGrpName = bdgwkall.getActEmpGrpNameJsa();
             String sActEmpGrpHrs = bdgwkall.getActEmpGrpHrsJsa();
             String sActEmpGrpPay = bdgwkall.getActEmpGrpPayJsa();
             String sActEmpGrpCom = bdgwkall.getActEmpGrpComJsa();
             String sActEmpGrpLSpiff = bdgwkall.getActEmpGrpLSpiffJsa();
             String sActEmpGrpMSpiff = bdgwkall.getActEmpGrpMSpiffJsa();
             String sActEmpGrpTot = bdgwkall.getActEmpGrpTotJsa();
             String sActEmpGrpAvgPay = bdgwkall.getActEmpGrpAvgPayJsa();
             String sActEmpGrpAvgCom = bdgwkall.getActEmpGrpAvgComJsa();
             String sActEmpGrpAvgLSpiff = bdgwkall.getActEmpGrpAvgLSpiffJsa();
             String sActEmpGrpAvgMSpiff = bdgwkall.getActEmpGrpAvgMSpiffJsa();
             String sActEmpGrpAvgTot = bdgwkall.getActEmpGrpAvgTotJsa();
             String sActEmpGrpSlsRet = bdgwkall.getActEmpGrpSlsRetJsa();
             String sActEmpGrpIncPay = bdgwkall.getActEmpGrpIncPayJsa();
             String sActEmpGrpAvgIncPay = bdgwkall.getActEmpGrpAvgIncPayJsa();

             // Scheduled Employee by Budget Group
             bdgwkall.setSchGrp("S");
             String sSchGrpName = bdgwkall.getSchGrpNameJsa();
             String sSchGrpHrs = bdgwkall.getSchGrpHrsJsa();
             String sSchGrpPay = bdgwkall.getSchGrpPayJsa();
             String sSchGrpCom = bdgwkall.getSchGrpComJsa();
             String sSchGrpLSpiff = bdgwkall.getSchGrpLSpiffJsa();
             String sSchGrpMSpiff = bdgwkall.getSchGrpMSpiffJsa();
             String sSchGrpTot = bdgwkall.getSchGrpTotJsa();
             String sSchGrpAvgPay = bdgwkall.getSchGrpAvgPayJsa();
             String sSchGrpAvgCom = bdgwkall.getSchGrpAvgComJsa();
             String sSchGrpAvgLSpiff = bdgwkall.getSchGrpAvgLSpiffJsa();
             String sSchGrpAvgMSpiff = bdgwkall.getSchGrpAvgMSpiffJsa();
             String sSchGrpAvgTot = bdgwkall.getSchGrpAvgTotJsa();
             String sSchGrpSlsRet = bdgwkall.getSchGrpSlsRetJsa();
             String sSchGrpIncPay = bdgwkall.getSchGrpIncPayJsa();
             String sSchGrpAvgIncPay = bdgwkall.getSchGrpAvgIncPayJsa();

             // Total Employee by Budget Group
             bdgwkall.setTotGrp("S");
             String sTotGrpName = bdgwkall.getTotGrpNameJsa();
             String sTotGrpHrs = bdgwkall.getTotGrpHrsJsa();
             String sTotGrpPay = bdgwkall.getTotGrpPayJsa();
             String sTotGrpCom = bdgwkall.getTotGrpComJsa();
             String sTotGrpLSpiff = bdgwkall.getTotGrpLSpiffJsa();
             String sTotGrpMSpiff = bdgwkall.getTotGrpMSpiffJsa();
             String sTotGrpTot = bdgwkall.getTotGrpTotJsa();
             String sTotGrpAvgPay = bdgwkall.getTotGrpAvgPayJsa();
             String sTotGrpAvgCom = bdgwkall.getTotGrpAvgComJsa();
             String sTotGrpAvgLSpiff = bdgwkall.getTotGrpAvgLSpiffJsa();
             String sTotGrpAvgMSpiff = bdgwkall.getTotGrpAvgMSpiffJsa();
             String sTotGrpAvgTot = bdgwkall.getTotGrpAvgTotJsa();
             String sTotGrpSlsRet = bdgwkall.getTotGrpSlsRetJsa();
             String sTotGrpIncPay = bdgwkall.getTotGrpIncPayJsa();
             String sTotGrpAvgIncPay = bdgwkall.getTotGrpAvgIncPayJsa();

             // Budget and Total Variances by Budget Group
             bdgwkall.setVarGrp("S");
             String sVarGrpName = bdgwkall.getVarGrpNameJsa();
             String sVarGrpHrs = bdgwkall.getVarGrpHrsJsa();
             String sVarGrpPay = bdgwkall.getVarGrpPayJsa();
             String sVarGrpCom = bdgwkall.getVarGrpComJsa();
             String sVarGrpLSpiff = bdgwkall.getVarGrpLSpiffJsa();
             String sVarGrpMSpiff = bdgwkall.getVarGrpMSpiffJsa();
             String sVarGrpTot = bdgwkall.getVarGrpTotJsa();
             String sVarGrpAvgPay = bdgwkall.getVarGrpAvgPayJsa();
             String sVarGrpAvgCom = bdgwkall.getVarGrpAvgComJsa();
             String sVarGrpAvgLSpiff = bdgwkall.getVarGrpAvgLSpiffJsa();
             String sVarGrpAvgMSpiff = bdgwkall.getVarGrpAvgMSpiffJsa();
             String sVarGrpAvgTot = bdgwkall.getVarGrpAvgTotJsa();
             String sVarGrpSlsRet = bdgwkall.getVarGrpSlsRetJsa();
             String sVarGrpIncPay = bdgwkall.getVarGrpIncPayJsa();
             String sVarGrpAvgIncPay = bdgwkall.getVarGrpAvgIncPayJsa();

             // Last Year Processed Payroll by Budget Group totals
             bdgwkall.setActEmpGrp("S");
             String sLyGrpName = bdgwkall.getLyGrpNameJsa();
             String sLyGrpHrs = bdgwkall.getLyGrpHrsJsa();
             String sLyGrpPay = bdgwkall.getLyGrpPayJsa();
             String sLyGrpCom = bdgwkall.getLyGrpComJsa();
             String sLyGrpLSpiff = bdgwkall.getLyGrpLSpiffJsa();
             String sLyGrpMSpiff = bdgwkall.getLyGrpMSpiffJsa();
             String sLyGrpTot = bdgwkall.getLyGrpTotJsa();
             String sLyGrpAvgPay = bdgwkall.getLyGrpAvgPayJsa();
             String sLyGrpAvgCom = bdgwkall.getLyGrpAvgComJsa();
             String sLyGrpAvgLSpiff = bdgwkall.getLyGrpAvgLSpiffJsa();
             String sLyGrpAvgMSpiff = bdgwkall.getLyGrpAvgMSpiffJsa();
             String sLyGrpAvgTot = bdgwkall.getLyGrpAvgTotJsa();
             String sLyGrpSlsRet = bdgwkall.getLyGrpSlsRetJsa();
             String sLyGrpIncPay = bdgwkall.getLyGrpIncPayJsa();
             String sLyGrpAvgIncPay = bdgwkall.getLyGrpAvgIncPayJsa();
             if(sStr[iStrNum].equals("55"))
             {
            	 Str55ActProcPy = sLineCell[28];
             }
             
             boolean b22n = sLineCell[46].indexOf("-") >= 0;
        %>
            <%if(j > 0){%><tr class="DataTable"><%}%>

            <td class="DataTable"><a href="BfdgSchActWk.jsp?Store=<%=sStr[iStrNum]%>&StrName=<%=sStrNm[iStrNum]%>&Wkend=<%=sWkend%>" target="_blank"><%=sStr[iStrNum]%></a></td>

            <th class="DataTable"><a href="PsWkSched.jsp?STORE=<%=sStr[iStrNum]%>&STRNAME=<%=sStrNm[iStrNum]%>&WEEKEND=<%=sWkend%>" target="_blank">S</a></th>

            <!-- Sales -->
            <td class="DataTable">$<%=sLineCell[0]%></td>
            <td class="DataTable" nowrap><%=sLineCell[1]%>%</td>
            <td class="DataTable" nowrap>$<%=sLineCell[2]%></td>
            <td class="DataTable" nowrap>$<%=sLineCell[3]%></td>
            <td class="DataTable" nowrap>$<%=sLineCell[4]%></td>
            <td class="DataTable" nowrap>$<%=sLineCell[5]%></td>

            <th class="DataTable">&nbsp;</th>
            <th class="DataTable3"><a href="javascript: showGrpBdg('<%=iGrpNum%>', '<%=sStr[iStrNum]%>')">B</a></th>
            <th class="DataTable3"><a href="javascript: showGrpBdgAvg('<%=iGrpNum++%>', '<%=sStr[iStrNum]%>')">A</a></th>

            <!-- Hourly Employee Only (Excludes Holiday, Sick, Vacation and TMC.) -->
            <!-- P/R Hours -->
            <td class="DataTable01" nowrap><%=sLineCell[6]%></td>
            <td class="DataTable" nowrap><%=sLineCell[7]%></td>
            <td class="DataTable" nowrap><%=sLineCell[36]%></td>
            <td class="DataTable"><%=sLineCell[8]%></td>
            <td class="DataTable02" nowrap><%=sLineCell[9]%></td>
            <td class="DataTable02" nowrap><%=sLineCell[10]%></td>
            <td class="DataTable"><%=sLineCell[11]%></td>

            <th class="DataTable">&nbsp;</th>

            <!-- P/R $'s -->
            <td class="DataTable" nowrap>$<%=sLineCell[12]%></td>
            <td class="DataTable" nowrap>$<%=sLineCell[40]%></td>
            <td class="DataTable" nowrap>$<%=sLineCell[41]%></td>
            <td class="DataTable" nowrap>$<%=sLineCell[42]%></td>
            <td class="DataTable" nowrap>$<%=sLineCell[13]%></td>
            <td class="DataTable" nowrap>$<%=sLineCell[14]%></td>

            <!-- Hourly Rate -->
            <td class="DataTable">$<%=sLineCell[15]%></td>
            <td class="DataTable">$<%=sLineCell[16]%></td>
            <td class="DataTable">$<%=sLineCell[17]%></td>

            <th class="DataTable">&nbsp;</th>

            <!-- Variance -->
            <td class="DataTable2<%if(sWarnLine20.equals("1")){%>r<%} else {%>g<%}%>" nowrap><%=sLineCell[18]%></td>
            <td class="DataTable2<%if(sWarnLine21.equals("1")){%>r<%} else {%>g<%}%>" nowrap>$<%=sLineCell[19]%></td>
            <td class="DataTable"><%=sLineCell[20]%></td>
            <td class="DataTable2<%if(sWarnLine23.equals("1")){%>r<%} else {%>g<%}%>" nowrap><%=sLineCell[21]%></td>
            <td class="DataTable"><%=sLineCell[22]%></td>

            <th class="DataTable">&nbsp;</th>

            <!-- T/M/C -->
            <td class="DataTable"><%=sLineCell[23]%></td>
            <!-- td class="DataTable"><%=sLineCell[24]%></td -->
            <td class="DataTable"><%=sLineCell[32]%></td>
            <td class="DataTable"><%=sLineCell[34]%></td>
            <td class="DataTable">$<%=sLineCell[25]%></td>
            <!-- td class="DataTable"><%=sLineCell[26]%></td -->
            <td class="DataTable">$<%=sLineCell[33]%></td>
            <td class="DataTable">$<%=sLineCell[35]%></td>

            <th class="DataTable">&nbsp;</th>

            <!-- Actual Processed Payroll -->
            <td class="DataTable"><%=sLineCell[27]%></td>
            <td class="DataTable"><%=sLineCell[28]%></td>
            <td class="DataTable"><%=sLineCell[29]%></td>
            <td class="DataTable"><%=sLineCell[30]%></td>
            <td class="DataTable" nowrap><%=sLineCell[31]%></td>
            
            <th class="DataTable">&nbsp;</th>
            
            <!-- P/R $'s - No Commission -->
            <td class="DataTable">$<%=sLineCell[43]%></td>
            <td class="DataTable">$<%=sLineCell[44]%></td>
            <td class="DataTable">$<%=sLineCell[45]%></td>
            <td class="DataTable2<%if(b22n){%>g<%} else {%>r<%}%>">$<%=sLineCell[46]%></td>

            <script>
               GrpBdg[NumOfGrp] = [<%=sGrpBdg%>]; GrpBdgName[NumOfGrp] = [<%=sGrpBdgName%>]; GrpBdgHrs[NumOfGrp] = [<%=sGrpBdgHrs%>];
               GrpBdgPayReg[NumOfGrp] = [<%=sGrpBdgPayReg%>]; GrpBdgPayCom[NumOfGrp] = [<%=sGrpBdgPayCom%>];
               GrpBdgPayLSpiff[NumOfGrp] = [<%=sGrpBdgPayLSpiff%>]; GrpBdgPayMSpiff[NumOfGrp] = [<%=sGrpBdgPayMSpiff%>];
               GrpBdgPayOther[NumOfGrp] = [<%=sGrpBdgPayOther%>]; GrpBdgPay[NumOfGrp] = [<%=sGrpBdgPay%>];
               GrpBdgAvgPay[NumOfGrp] = [<%=sGrpBdgAvgPay%>]; GrpBdgAvgCom[NumOfGrp] = [<%=sGrpBdgAvgCom%>];
               GrpBdgAvgLSpiff[NumOfGrp] = [<%=sGrpBdgAvgLSpiff%>]; GrpBdgAvgMSpiff[NumOfGrp] = [<%=sGrpBdgAvgMSpiff%>];
               GrpBdgAvgOther[NumOfGrp] = [<%=sGrpBdgAvgOther%>]; GrpBdgAvg[NumOfGrp] = [<%=sGrpBdgAvg%>];

               ActEmpGrpName[NumOfGrp] = [<%=sActEmpGrpName%>]; ActEmpGrpHrs[NumOfGrp] = [<%=sActEmpGrpHrs%>];
               ActEmpGrpPay[NumOfGrp] = [<%=sActEmpGrpPay%>]; ActEmpGrpCom[NumOfGrp] = [<%=sActEmpGrpCom%>];
               ActEmpGrpLSpiff[NumOfGrp] = [<%=sActEmpGrpLSpiff%>]; ActEmpGrpMSpiff[NumOfGrp] = [<%=sActEmpGrpMSpiff%>];
               ActEmpGrpTot[NumOfGrp] = [<%=sActEmpGrpTot%>]; ActEmpGrpAvgPay[NumOfGrp] = [<%=sActEmpGrpAvgPay%>];
               ActEmpGrpAvgCom[NumOfGrp] = [<%=sActEmpGrpAvgCom%>]; ActEmpGrpAvgLSpiff[NumOfGrp] = [<%=sActEmpGrpAvgLSpiff%>];
               ActEmpGrpAvgMSpiff[NumOfGrp] = [<%=sActEmpGrpAvgMSpiff%>]; ActEmpGrpAvgTot[NumOfGrp] = [<%=sActEmpGrpAvgTot%>];
               ActEmpGrpSlsRet[NumOfGrp] = [<%=sActEmpGrpSlsRet%>]; ActEmpGrpIncPay[NumOfGrp] = [<%=sActEmpGrpIncPay%>];
               ActEmpGrpAvgIncPay[NumOfGrp] = [<%=sActEmpGrpAvgIncPay%>];

               SchGrpName[NumOfGrp] = [<%=sSchGrpName%>]; SchGrpHrs[NumOfGrp] = [<%=sSchGrpHrs%>];
               SchGrpPay[NumOfGrp] = [<%=sSchGrpPay%>]; SchGrpCom[NumOfGrp] = [<%=sSchGrpCom%>];
               SchGrpLSpiff[NumOfGrp] = [<%=sSchGrpLSpiff%>]; SchGrpMSpiff[NumOfGrp] = [<%=sSchGrpMSpiff%>];
               SchGrpTot[NumOfGrp] = [<%=sSchGrpTot%>]; SchGrpAvgPay[NumOfGrp] = [<%=sSchGrpAvgPay%>];
               SchGrpAvgCom[NumOfGrp] = [<%=sSchGrpAvgCom%>]; SchGrpAvgLSpiff[NumOfGrp] = [<%=sSchGrpAvgLSpiff%>];
               SchGrpAvgMSpiff[NumOfGrp] = [<%=sSchGrpAvgMSpiff%>]; SchGrpAvgTot[NumOfGrp] = [<%=sSchGrpAvgTot%>];
               SchGrpSlsRet[NumOfGrp] = [<%=sSchGrpSlsRet%>]; SchGrpIncPay[NumOfGrp] = [<%=sSchGrpIncPay%>];
               SchGrpAvgIncPay[NumOfGrp] = [<%=sSchGrpAvgIncPay%>];

               TotGrpName[NumOfGrp] = [<%=sTotGrpName%>]; TotGrpHrs[NumOfGrp] = [<%=sTotGrpHrs%>];
               TotGrpPay[NumOfGrp] = [<%=sTotGrpPay%>]; TotGrpCom[NumOfGrp] = [<%=sTotGrpCom%>];
               TotGrpLSpiff[NumOfGrp] = [<%=sTotGrpLSpiff%>]; TotGrpMSpiff[NumOfGrp] = [<%=sTotGrpMSpiff%>];
               TotGrpTot[NumOfGrp] = [<%=sTotGrpTot%>]; TotGrpAvgPay[NumOfGrp] = [<%=sTotGrpAvgPay%>];
               TotGrpAvgCom[NumOfGrp] = [<%=sTotGrpAvgCom%>]; TotGrpAvgLSpiff[NumOfGrp] = [<%=sTotGrpAvgLSpiff%>];
               TotGrpAvgMSpiff[NumOfGrp] = [<%=sTotGrpAvgMSpiff%>]; TotGrpAvgTot[NumOfGrp] = [<%=sTotGrpAvgTot%>];
               TotGrpSlsRet[NumOfGrp] = [<%=sTotGrpSlsRet%>]; TotGrpIncPay[NumOfGrp] = [<%=sTotGrpIncPay%>];
               TotGrpAvgIncPay[NumOfGrp] = [<%=sTotGrpAvgIncPay%>];

               VarGrpName[NumOfGrp] = [<%=sVarGrpName%>]; VarGrpHrs[NumOfGrp] = [<%=sVarGrpHrs%>];
               VarGrpPay[NumOfGrp] = [<%=sVarGrpPay%>]; VarGrpCom[NumOfGrp] = [<%=sVarGrpCom%>];
               VarGrpLSpiff[NumOfGrp] = [<%=sVarGrpLSpiff%>]; VarGrpMSpiff[NumOfGrp] = [<%=sVarGrpMSpiff%>];
               VarGrpTot[NumOfGrp] = [<%=sVarGrpTot%>]; VarGrpAvgPay[NumOfGrp] = [<%=sVarGrpAvgPay%>];
               VarGrpAvgCom[NumOfGrp] = [<%=sVarGrpAvgCom%>]; VarGrpAvgLSpiff[NumOfGrp] = [<%=sVarGrpAvgLSpiff%>];
               VarGrpAvgMSpiff[NumOfGrp] = [<%=sVarGrpAvgMSpiff%>]; VarGrpAvgTot[NumOfGrp] = [<%=sVarGrpAvgTot%>];
               VarGrpSlsRet[NumOfGrp] = [<%=sVarGrpSlsRet%>]; VarGrpIncPay[NumOfGrp] = [<%=sVarGrpIncPay%>];
               VarGrpAvgIncPay[NumOfGrp] = [<%=sVarGrpAvgIncPay%>];

               LyGrpName[NumOfGrp] = [<%=sLyGrpName%>]; LyGrpHrs[NumOfGrp] = [<%=sLyGrpHrs%>];
               LyGrpPay[NumOfGrp] = [<%=sLyGrpPay%>]; LyGrpCom[NumOfGrp] = [<%=sLyGrpCom%>];
               LyGrpLSpiff[NumOfGrp] = [<%=sLyGrpLSpiff%>]; LyGrpMSpiff[NumOfGrp] = [<%=sLyGrpMSpiff%>];
               LyGrpTot[NumOfGrp] = [<%=sLyGrpTot%>]; LyGrpAvgPay[NumOfGrp] = [<%=sLyGrpAvgPay%>];
               LyGrpAvgCom[NumOfGrp] = [<%=sLyGrpAvgCom%>]; LyGrpAvgLSpiff[NumOfGrp] = [<%=sLyGrpAvgLSpiff%>];
               LyGrpAvgMSpiff[NumOfGrp] = [<%=sLyGrpAvgMSpiff%>]; LyGrpAvgTot[NumOfGrp] = [<%=sLyGrpAvgTot%>];
               LyGrpSlsRet[NumOfGrp] = [<%=sLyGrpSlsRet%>]; LyGrpIncPay[NumOfGrp] = [<%=sLyGrpIncPay%>];
               LyGrpAvgIncPay[NumOfGrp] = [<%=sLyGrpAvgIncPay%>];

               StrArr[NumOfGrp] = "<%=sStr[iStrNum]%>";

               NumOfGrp++;
            </script>
           </tr>
        <%}%>

        <!-- ======== Region totals ========== -->
        <%
          bdgwkall.setRegBdgInfo();
          sLineCell = bdgwkall.getLineCell();
          sWarnLine20 = bdgwkall.getWarnLine20();
          sWarnLine21 = bdgwkall.getWarnLine21();
          sWarnLine23 = bdgwkall.getWarnLine23();

          // List of budget groups
          bdgwkall.setGrpBdg("R");
          int iNumOfGrpBdg = bdgwkall.getNumOfGrpBdg();
          String sGrpBdg = bdgwkall.getGrpBdgJsa();
          String sGrpBdgName = bdgwkall.getGrpBdgNameJsa();
          String sGrpBdgHrs = bdgwkall.getGrpBdgHrsJsa();

          String sGrpBdgPayReg = bdgwkall.getGrpBdgPayRegJsa();
          String sGrpBdgPayCom = bdgwkall.getGrpBdgPayComJsa();
          String sGrpBdgPayLSpiff = bdgwkall.getGrpBdgPayLSpiffJsa();
          String sGrpBdgPayMSpiff = bdgwkall.getGrpBdgPayMSpiffJsa();
          String sGrpBdgPayOther = bdgwkall.getGrpBdgPayOtherJsa();
          String sGrpBdgPay = bdgwkall.getGrpBdgPayJsa();

          String sGrpBdgAvgPay = bdgwkall.getGrpBdgAvgPayJsa();
          String sGrpBdgAvgCom = bdgwkall.getGrpBdgAvgComJsa();
          String sGrpBdgAvgLSpiff = bdgwkall.getGrpBdgAvgLSpiffJsa();
          String sGrpBdgAvgMSpiff = bdgwkall.getGrpBdgAvgMSpiffJsa();
          String sGrpBdgAvgOther = bdgwkall.getGrpBdgAvgOtherJsa();
          String sGrpBdgAvg = bdgwkall.getGrpBdgAvgJsa();

          // Actual Employee Budget Group totals
          bdgwkall.setActEmpGrp("R");
          String sActEmpGrpName = bdgwkall.getActEmpGrpNameJsa();
          String sActEmpGrpHrs = bdgwkall.getActEmpGrpHrsJsa();
          String sActEmpGrpPay = bdgwkall.getActEmpGrpPayJsa();
          String sActEmpGrpCom = bdgwkall.getActEmpGrpComJsa();
          String sActEmpGrpLSpiff = bdgwkall.getActEmpGrpLSpiffJsa();
          String sActEmpGrpMSpiff = bdgwkall.getActEmpGrpMSpiffJsa();
          String sActEmpGrpTot = bdgwkall.getActEmpGrpTotJsa();
          String sActEmpGrpAvgPay = bdgwkall.getActEmpGrpAvgPayJsa();
          String sActEmpGrpAvgCom = bdgwkall.getActEmpGrpAvgComJsa();
          String sActEmpGrpAvgLSpiff = bdgwkall.getActEmpGrpAvgLSpiffJsa();
          String sActEmpGrpAvgMSpiff = bdgwkall.getActEmpGrpAvgMSpiffJsa();
          String sActEmpGrpAvgTot = bdgwkall.getActEmpGrpAvgTotJsa();
          String sActEmpGrpSlsRet = bdgwkall.getActEmpGrpSlsRetJsa();
          String sActEmpGrpIncPay = bdgwkall.getActEmpGrpIncPayJsa();
          String sActEmpGrpAvgIncPay = bdgwkall.getActEmpGrpAvgIncPayJsa();

          // Scheduled Employee by Budget Group
          bdgwkall.setSchGrp("R");
          String sSchGrpName = bdgwkall.getSchGrpNameJsa();
          String sSchGrpHrs = bdgwkall.getSchGrpHrsJsa();
          String sSchGrpPay = bdgwkall.getSchGrpPayJsa();
          String sSchGrpCom = bdgwkall.getSchGrpComJsa();
          String sSchGrpLSpiff = bdgwkall.getSchGrpLSpiffJsa();
          String sSchGrpMSpiff = bdgwkall.getSchGrpMSpiffJsa();
          String sSchGrpTot = bdgwkall.getSchGrpTotJsa();
          String sSchGrpAvgPay = bdgwkall.getSchGrpAvgPayJsa();
          String sSchGrpAvgCom = bdgwkall.getSchGrpAvgComJsa();
          String sSchGrpAvgLSpiff = bdgwkall.getSchGrpAvgLSpiffJsa();
          String sSchGrpAvgMSpiff = bdgwkall.getSchGrpAvgMSpiffJsa();
          String sSchGrpAvgTot = bdgwkall.getSchGrpAvgTotJsa();
          String sSchGrpSlsRet = bdgwkall.getSchGrpSlsRetJsa();
          String sSchGrpIncPay = bdgwkall.getSchGrpIncPayJsa();
          String sSchGrpAvgIncPay = bdgwkall.getSchGrpAvgIncPayJsa();

          // Total Employee by Budget Group
          bdgwkall.setTotGrp("R");
          String sTotGrpName = bdgwkall.getTotGrpNameJsa();
          String sTotGrpHrs = bdgwkall.getTotGrpHrsJsa();
          String sTotGrpPay = bdgwkall.getTotGrpPayJsa();
          String sTotGrpCom = bdgwkall.getTotGrpComJsa();
          String sTotGrpLSpiff = bdgwkall.getTotGrpLSpiffJsa();
          String sTotGrpMSpiff = bdgwkall.getTotGrpMSpiffJsa();
          String sTotGrpTot = bdgwkall.getTotGrpTotJsa();
          String sTotGrpAvgPay = bdgwkall.getTotGrpAvgPayJsa();
          String sTotGrpAvgCom = bdgwkall.getTotGrpAvgComJsa();
          String sTotGrpAvgLSpiff = bdgwkall.getTotGrpAvgLSpiffJsa();
          String sTotGrpAvgMSpiff = bdgwkall.getTotGrpAvgMSpiffJsa();
          String sTotGrpAvgTot = bdgwkall.getTotGrpAvgTotJsa();
          String sTotGrpSlsRet = bdgwkall.getTotGrpSlsRetJsa();
          String sTotGrpIncPay = bdgwkall.getTotGrpIncPayJsa();
          String sTotGrpAvgIncPay = bdgwkall.getTotGrpAvgIncPayJsa();

          // Budget and Total Variances by Budget Group
          bdgwkall.setVarGrp("R");
          String sVarGrpName = bdgwkall.getVarGrpNameJsa();
          String sVarGrpHrs = bdgwkall.getVarGrpHrsJsa();
          String sVarGrpPay = bdgwkall.getVarGrpPayJsa();
          String sVarGrpCom = bdgwkall.getVarGrpComJsa();
          String sVarGrpLSpiff = bdgwkall.getVarGrpLSpiffJsa();
          String sVarGrpMSpiff = bdgwkall.getVarGrpMSpiffJsa();
          String sVarGrpTot = bdgwkall.getVarGrpTotJsa();
          String sVarGrpAvgPay = bdgwkall.getVarGrpAvgPayJsa();
          String sVarGrpAvgCom = bdgwkall.getVarGrpAvgComJsa();
          String sVarGrpAvgLSpiff = bdgwkall.getVarGrpAvgLSpiffJsa();
          String sVarGrpAvgMSpiff = bdgwkall.getVarGrpAvgMSpiffJsa();
          String sVarGrpAvgTot = bdgwkall.getVarGrpAvgTotJsa();
          String sVarGrpSlsRet = bdgwkall.getVarGrpSlsRetJsa();
          String sVarGrpIncPay = bdgwkall.getVarGrpIncPayJsa();
          String sVarGrpAvgIncPay = bdgwkall.getVarGrpAvgIncPayJsa();

         // Last Year Processed Payroll by Budget Group totals
         bdgwkall.setActEmpGrp("R");
         String sLyGrpName = bdgwkall.getLyGrpNameJsa();
         String sLyGrpHrs = bdgwkall.getLyGrpHrsJsa();
         String sLyGrpPay = bdgwkall.getLyGrpPayJsa();
         String sLyGrpCom = bdgwkall.getLyGrpComJsa();
         String sLyGrpLSpiff = bdgwkall.getLyGrpLSpiffJsa();
         String sLyGrpMSpiff = bdgwkall.getLyGrpMSpiffJsa();
         String sLyGrpTot = bdgwkall.getLyGrpTotJsa();
         String sLyGrpAvgPay = bdgwkall.getLyGrpAvgPayJsa();
         String sLyGrpAvgCom = bdgwkall.getLyGrpAvgComJsa();
         String sLyGrpAvgLSpiff = bdgwkall.getLyGrpAvgLSpiffJsa();
         String sLyGrpAvgMSpiff = bdgwkall.getLyGrpAvgMSpiffJsa();
         String sLyGrpAvgTot = bdgwkall.getLyGrpAvgTotJsa();
         String sLyGrpSlsRet = bdgwkall.getLyGrpSlsRetJsa();
         String sLyGrpIncPay = bdgwkall.getLyGrpIncPayJsa();
         String sLyGrpAvgIncPay = bdgwkall.getLyGrpAvgIncPayJsa();
         
         boolean b22n = sLineCell[46].indexOf("-") >= 0;
        %>

        <tr class="DataTable5">
        <td class="DataTable">Region Totals</td>
            <th class="DataTable">&nbsp;</th>

            <!-- Sales -->
            <td class="DataTable">$<%=sLineCell[0]%></td>
            <td class="DataTable" nowrap><%=sLineCell[1]%>%</td>
            <td class="DataTable" nowrap>$<%=sLineCell[2]%></td>
            <td class="DataTable" nowrap>$<%=sLineCell[3]%></td>
            <td class="DataTable" nowrap>$<%=sLineCell[4]%></td>
            <td class="DataTable" nowrap>$<%=sLineCell[5]%></td>

            <th class="DataTable">&nbsp;</th>
            <th class="DataTable3"><a href="javascript: showGrpBdg('<%=iGrpNum%>', 'REG')">B</a></th>
            <th class="DataTable3"><a href="javascript: showGrpBdgAvg('<%=iGrpNum++%>', 'REG')">A</a></th>

            <!-- Hourly Employee Only (Excludes Holiday, Sick, Vacation and TMC.) -->
            <!-- P/R Hours -->
            <td class="DataTable01" nowrap><%=sLineCell[6]%></td>
            <td class="DataTable"><%=sLineCell[7]%></td>
            <td class="DataTable" nowrap><%=sLineCell[36]%></td>
            <td class="DataTable"><%=sLineCell[8]%></td>
            <td class="DataTable02" nowrap><%=sLineCell[9]%></td>
            <td class="DataTable02" nowrap><%=sLineCell[10]%></td>
            <td class="DataTable"><%=sLineCell[11]%></td>

            <th class="DataTable">&nbsp;</th>

            <!-- P/R $'s -->
            <td class="DataTable" nowrap>$<%=sLineCell[12]%></td>
            <td class="DataTable" nowrap>$<%=sLineCell[40]%></td>
            <td class="DataTable" nowrap>$<%=sLineCell[41]%></td>
            <td class="DataTable" nowrap>$<%=sLineCell[42]%></td>
            <td class="DataTable" nowrap>$<%=sLineCell[13]%></td>
            <td class="DataTable" nowrap>$<%=sLineCell[14]%></td>

            <!-- Hourly Rate -->
            <td class="DataTable">$<%=sLineCell[15]%></td>
            <td class="DataTable">$<%=sLineCell[16]%></td>
            <td class="DataTable">$<%=sLineCell[17]%></td>

            <th class="DataTable">&nbsp;</th>

            <!-- Variance -->
            <td class="DataTable2<%if(sWarnLine20.equals("1")){%>r<%} else {%>g<%}%>" nowrap><%=sLineCell[18]%></td>
            <td class="DataTable2<%if(sWarnLine21.equals("1")){%>r<%} else {%>g<%}%>" nowrap>$<%=sLineCell[19]%></td>
            <td class="DataTable"><%=sLineCell[20]%></td>
            <td class="DataTable2<%if(sWarnLine23.equals("1")){%>r<%} else {%>g<%}%>" nowrap><%=sLineCell[21]%></td>
            <td class="DataTable"><%=sLineCell[22]%></td>

            <th class="DataTable">&nbsp;</th>

            <!-- T/M/C -->
            <td class="DataTable"><%=sLineCell[23]%></td>
            <!-- td class="DataTable"><%=sLineCell[24]%></td -->
            <td class="DataTable"><%=sLineCell[32]%></td>
            <td class="DataTable"><%=sLineCell[34]%></td>
            <td class="DataTable">$<%=sLineCell[25]%></td>
            <!-- td class="DataTable"><%=sLineCell[26]%></td -->
            <td class="DataTable">$<%=sLineCell[33]%></td>
            <td class="DataTable">$<%=sLineCell[35]%></td>

            <th class="DataTable">&nbsp;</th>

            <!-- Actual Processed Payroll -->
            <td class="DataTable"><%=sLineCell[27]%></td>
            <td class="DataTable"><%=sLineCell[28]%></td>
            <td class="DataTable"><%=sLineCell[29]%></td>
            <td class="DataTable"><%=sLineCell[30]%></td>
            <td class="DataTable" nowrap><%=sLineCell[31]%></td>
            
            <th class="DataTable">&nbsp;</th>
            
            <!-- P/R $'s - No Commission -->
            <td class="DataTable" nowrap>$<%=sLineCell[43]%></td>
            <td class="DataTable" nowrap>$<%=sLineCell[44]%></td>
            <td class="DataTable" nowrap>$<%=sLineCell[45]%></td>
            <td class="DataTable2<%if(b22n){%>g<%} else {%>r<%}%>" nowrap>$<%=sLineCell[46]%></td>
        </tr>
        <tr class="Divdr1"></td><td colspan=53 onmouseover="document.all.dvColHdr.style.visibility='hidden';">&nbsp;</td></tr>
        <tr>
            <th class="DataTable6" colspan=3>&nbsp;</th>
            <th class="DataTable6" onmouseover="showColHdr(this, 0)" onmouseout="document.all.dvColHdr.style.visibility='hidden';"> 2 </th>
            <th class="DataTable6" onmouseover="showColHdr(this, 1)" onmouseout="document.all.dvColHdr.style.visibility='hidden';"> 3 </th>
            <th class="DataTable6" onmouseover="showColHdr(this, 2)" onmouseout="document.all.dvColHdr.style.visibility='hidden';"> 4 </th>
            <th class="DataTable6" onmouseover="showColHdr(this, 3)" onmouseout="document.all.dvColHdr.style.visibility='hidden';"> 5 </th>
            <th class="DataTable6" onmouseover="showColHdr(this, 4)" onmouseout="document.all.dvColHdr.style.visibility='hidden';"> 6 </th>
            <th class="DataTable6" onmouseover="showColHdr(this, 5)" onmouseout="document.all.dvColHdr.style.visibility='hidden';"> 7 </th>

            <th class="DataTable6" colspan=3 onmouseover="document.all.dvColHdr.style.visibility='hidden';">&nbsp;</th>

            <th class="DataTable6" onmouseover="showColHdr(this, 6)" onmouseout="document.all.dvColHdr.style.visibility='hidden';"> 9 </th>
            <th class="DataTable6" onmouseover="showColHdr(this, 7)" onmouseout="document.all.dvColHdr.style.visibility='hidden';">10a</th>
            <th class="DataTable6" onmouseover="showColHdr(this, 8)" onmouseout="document.all.dvColHdr.style.visibility='hidden';">10b</th>
            <th class="DataTable6" onmouseover="showColHdr(this, 9)" onmouseout="document.all.dvColHdr.style.visibility='hidden';"> 11 </th>
            <th class="DataTable6" onmouseover="showColHdr(this, 10)" onmouseout="document.all.dvColHdr.style.visibility='hidden';"> 12 </th>
            <th class="DataTable6" onmouseover="showColHdr(this, 11)" onmouseout="document.all.dvColHdr.style.visibility='hidden';"> 13 </th>
            <th class="DataTable6" onmouseover="showColHdr(this, 12)" onmouseout="document.all.dvColHdr.style.visibility='hidden';"> 14 </th>

            <th class="DataTable6" onmouseover="document.all.dvColHdr.style.visibility='hidden';">&nbsp;</th>

            <th class="DataTable6" onmouseover="showColHdr(this, 13)"> 15 </th>
            <th class="DataTable6" onmouseover="showColHdr(this, 35)"> 16a </th>
            <th class="DataTable6" onmouseover="showColHdr(this, 36)"> 16b </th>
            <th class="DataTable6" onmouseover="showColHdr(this, 37)"> 16c </th>
            <th class="DataTable6" onmouseover="showColHdr(this, 14)"> 16 </th>
            <th class="DataTable6" onmouseover="showColHdr(this, 15)"> 17 </th>
            <th class="DataTable6" onmouseover="showColHdr(this, 16)"> 18 </th>
            <th class="DataTable6" onmouseover="showColHdr(this, 17)"> 19 </th>
            <th class="DataTable6" onmouseover="showColHdr(this, 18)"> 20 </th>

            <th class="DataTable6" onmouseover="document.all.dvColHdr.style.visibility='hidden';">&nbsp;</th>

            <th class="DataTable6" onmouseover="showColHdr(this, 19)" onmouseout="document.all.dvColHdr.style.visibility='hidden';">21</th>
            <th class="DataTable6" onmouseover="showColHdr(this, 20)" onmouseout="document.all.dvColHdr.style.visibility='hidden';">22</th>
            <th class="DataTable6" onmouseover="showColHdr(this, 21)" onmouseout="document.all.dvColHdr.style.visibility='hidden';">23</th>
            <th class="DataTable6" onmouseover="showColHdr(this, 22)" onmouseout="document.all.dvColHdr.style.visibility='hidden';">24</th>
            <th class="DataTable6" onmouseover="showColHdr(this, 23)" onmouseout="document.all.dvColHdr.style.visibility='hidden';">25</th>

            <th class="DataTable6" onmouseover="document.all.dvColHdr.style.visibility='hidden';">&nbsp;</th>

            <th class="DataTable6" onmouseover="showColHdr(this, 24)" onmouseout="document.all.dvColHdr.style.visibility='hidden';"> 1 </th>
            <th class="DataTable6" onmouseover="showColHdr(this, 25)" onmouseout="document.all.dvColHdr.style.visibility='hidden';">2a</th>
            <th class="DataTable6" onmouseover="showColHdr(this, 26)" onmouseout="document.all.dvColHdr.style.visibility='hidden';">2b</th>
            <th class="DataTable6" onmouseover="showColHdr(this, 27)" onmouseout="document.all.dvColHdr.style.visibility='hidden';"> 3 </th>
            <th class="DataTable6" onmouseover="showColHdr(this, 28)" onmouseout="document.all.dvColHdr.style.visibility='hidden';"> 4a </th>
            <th class="DataTable6" onmouseover="showColHdr(this, 29)" onmouseout="document.all.dvColHdr.style.visibility='hidden';"> 4b </th>

            <th class="DataTable6" onmouseover="document.all.dvColHdr.style.visibility='hidden';">&nbsp;</th>

            <th class="DataTable6" onmouseover="showColHdr(this, 30)" onmouseout="document.all.dvColHdr.style.visibility='hidden';">14</th>
            <th class="DataTable6" onmouseover="showColHdr(this, 31)" onmouseout="document.all.dvColHdr.style.visibility='hidden';">17</th>
            <th class="DataTable6" onmouseover="showColHdr(this, 32)" onmouseout="document.all.dvColHdr.style.visibility='hidden';">19</th>
            <th class="DataTable6" onmouseover="showColHdr(this, 33)" onmouseout="document.all.dvColHdr.style.visibility='hidden';">&nbsp;</th>
            <th class="DataTable6" onmouseover="showColHdr(this, 34)" onmouseout="document.all.dvColHdr.style.visibility='hidden';">&nbsp;</th>
            
            <th class="DataTable6" onmouseover="document.all.dvColHdr.style.visibility='hidden';">&nbsp;</th>

            <th class="DataTable6" onmouseover="showColHdr(this, 30)" onmouseout="document.all.dvColHdr.style.visibility='hidden';">15n</th>
            <th class="DataTable6" onmouseover="showColHdr(this, 30)" onmouseout="document.all.dvColHdr.style.visibility='hidden';">16n</th>
            <th class="DataTable6" onmouseover="showColHdr(this, 30)" onmouseout="document.all.dvColHdr.style.visibility='hidden';">17n</th>
            <th class="DataTable6" onmouseover="showColHdr(this, 30)" onmouseout="document.all.dvColHdr.style.visibility='hidden';">22n</th>
        </tr>
        <tr class="Divdr1"></td><td colspan=53 onmouseover="document.all.dvColHdr.style.visibility='hidden';">&nbsp;</td></tr>
        <script>
               GrpBdg[NumOfGrp] = [<%=sGrpBdg%>]; GrpBdgName[NumOfGrp] = [<%=sGrpBdgName%>]; GrpBdgHrs[NumOfGrp] = [<%=sGrpBdgHrs%>];
               GrpBdgPayReg[NumOfGrp] = [<%=sGrpBdgPayReg%>]; GrpBdgPayCom[NumOfGrp] = [<%=sGrpBdgPayCom%>];
               GrpBdgPayLSpiff[NumOfGrp] = [<%=sGrpBdgPayLSpiff%>]; GrpBdgPayMSpiff[NumOfGrp] = [<%=sGrpBdgPayMSpiff%>];
               GrpBdgPayOther[NumOfGrp] = [<%=sGrpBdgPayOther%>]; GrpBdgPay[NumOfGrp] = [<%=sGrpBdgPay%>];
               GrpBdgAvgPay[NumOfGrp] = [<%=sGrpBdgAvgPay%>]; GrpBdgAvgCom[NumOfGrp] = [<%=sGrpBdgAvgCom%>];
               GrpBdgAvgLSpiff[NumOfGrp] = [<%=sGrpBdgAvgLSpiff%>]; GrpBdgAvgMSpiff[NumOfGrp] = [<%=sGrpBdgAvgMSpiff%>];
               GrpBdgAvgOther[NumOfGrp] = [<%=sGrpBdgAvgOther%>]; GrpBdgAvg[NumOfGrp] = [<%=sGrpBdgAvg%>];

               ActEmpGrpName[NumOfGrp] = [<%=sActEmpGrpName%>]; ActEmpGrpHrs[NumOfGrp] = [<%=sActEmpGrpHrs%>];
               ActEmpGrpPay[NumOfGrp] = [<%=sActEmpGrpPay%>]; ActEmpGrpCom[NumOfGrp] = [<%=sActEmpGrpCom%>];
               ActEmpGrpLSpiff[NumOfGrp] = [<%=sActEmpGrpLSpiff%>]; ActEmpGrpMSpiff[NumOfGrp] = [<%=sActEmpGrpMSpiff%>];
               ActEmpGrpTot[NumOfGrp] = [<%=sActEmpGrpTot%>]; ActEmpGrpAvgPay[NumOfGrp] = [<%=sActEmpGrpAvgPay%>];
               ActEmpGrpAvgCom[NumOfGrp] = [<%=sActEmpGrpAvgCom%>]; ActEmpGrpAvgLSpiff[NumOfGrp] = [<%=sActEmpGrpAvgLSpiff%>];
               ActEmpGrpAvgMSpiff[NumOfGrp] = [<%=sActEmpGrpAvgMSpiff%>]; ActEmpGrpAvgTot[NumOfGrp] = [<%=sActEmpGrpAvgTot%>];
               ActEmpGrpSlsRet[NumOfGrp] = [<%=sActEmpGrpSlsRet%>]; ActEmpGrpIncPay[NumOfGrp] = [<%=sActEmpGrpIncPay%>];
               ActEmpGrpAvgIncPay[NumOfGrp] = [<%=sActEmpGrpAvgIncPay%>];

               SchGrpName[NumOfGrp] = [<%=sSchGrpName%>]; SchGrpHrs[NumOfGrp] = [<%=sSchGrpHrs%>];
               SchGrpPay[NumOfGrp] = [<%=sSchGrpPay%>]; SchGrpCom[NumOfGrp] = [<%=sSchGrpCom%>];
               SchGrpLSpiff[NumOfGrp] = [<%=sSchGrpLSpiff%>]; SchGrpMSpiff[NumOfGrp] = [<%=sSchGrpMSpiff%>];
               SchGrpTot[NumOfGrp] = [<%=sSchGrpTot%>]; SchGrpAvgPay[NumOfGrp] = [<%=sSchGrpAvgPay%>];
               SchGrpAvgCom[NumOfGrp] = [<%=sSchGrpAvgCom%>]; SchGrpAvgLSpiff[NumOfGrp] = [<%=sSchGrpAvgLSpiff%>];
               SchGrpAvgMSpiff[NumOfGrp] = [<%=sSchGrpAvgMSpiff%>]; SchGrpAvgTot[NumOfGrp] = [<%=sSchGrpAvgTot%>];
               SchGrpSlsRet[NumOfGrp] = [<%=sSchGrpSlsRet%>]; SchGrpIncPay[NumOfGrp] = [<%=sSchGrpIncPay%>];
               SchGrpAvgIncPay[NumOfGrp] = [<%=sSchGrpAvgIncPay%>];

               TotGrpName[NumOfGrp] = [<%=sTotGrpName%>]; TotGrpHrs[NumOfGrp] = [<%=sTotGrpHrs%>];
               TotGrpPay[NumOfGrp] = [<%=sTotGrpPay%>]; TotGrpCom[NumOfGrp] = [<%=sTotGrpCom%>];
               TotGrpLSpiff[NumOfGrp] = [<%=sTotGrpLSpiff%>]; TotGrpMSpiff[NumOfGrp] = [<%=sTotGrpMSpiff%>];
               TotGrpTot[NumOfGrp] = [<%=sTotGrpTot%>]; TotGrpAvgPay[NumOfGrp] = [<%=sTotGrpAvgPay%>];
               TotGrpAvgCom[NumOfGrp] = [<%=sTotGrpAvgCom%>]; TotGrpAvgLSpiff[NumOfGrp] = [<%=sTotGrpAvgLSpiff%>];
               TotGrpAvgMSpiff[NumOfGrp] = [<%=sTotGrpAvgMSpiff%>]; TotGrpAvgTot[NumOfGrp] = [<%=sTotGrpAvgTot%>];
               TotGrpSlsRet[NumOfGrp] = [<%=sTotGrpSlsRet%>]; TotGrpIncPay[NumOfGrp] = [<%=sTotGrpIncPay%>];
               TotGrpAvgIncPay[NumOfGrp] = [<%=sTotGrpAvgIncPay%>];

               VarGrpName[NumOfGrp] = [<%=sVarGrpName%>]; VarGrpHrs[NumOfGrp] = [<%=sVarGrpHrs%>];
               VarGrpPay[NumOfGrp] = [<%=sVarGrpPay%>]; VarGrpCom[NumOfGrp] = [<%=sVarGrpCom%>];
               VarGrpLSpiff[NumOfGrp] = [<%=sVarGrpLSpiff%>]; VarGrpMSpiff[NumOfGrp] = [<%=sVarGrpMSpiff%>];
               VarGrpTot[NumOfGrp] = [<%=sVarGrpTot%>]; VarGrpAvgPay[NumOfGrp] = [<%=sVarGrpAvgPay%>];
               VarGrpAvgCom[NumOfGrp] = [<%=sVarGrpAvgCom%>]; VarGrpAvgLSpiff[NumOfGrp] = [<%=sVarGrpAvgLSpiff%>];
               VarGrpAvgMSpiff[NumOfGrp] = [<%=sVarGrpAvgMSpiff%>]; VarGrpAvgTot[NumOfGrp] = [<%=sVarGrpAvgTot%>];
               VarGrpSlsRet[NumOfGrp] = [<%=sVarGrpSlsRet%>]; VarGrpIncPay[NumOfGrp] = [<%=sVarGrpIncPay%>];
               VarGrpAvgIncPay[NumOfGrp] = [<%=sVarGrpAvgIncPay%>];

               LyGrpName[NumOfGrp] = [<%=sLyGrpName%>]; LyGrpHrs[NumOfGrp] = [<%=sLyGrpHrs%>];
               LyGrpPay[NumOfGrp] = [<%=sLyGrpPay%>]; LyGrpCom[NumOfGrp] = [<%=sLyGrpCom%>];
               LyGrpLSpiff[NumOfGrp] = [<%=sLyGrpLSpiff%>]; LyGrpMSpiff[NumOfGrp] = [<%=sLyGrpMSpiff%>];
               LyGrpTot[NumOfGrp] = [<%=sLyGrpTot%>]; LyGrpAvgPay[NumOfGrp] = [<%=sLyGrpAvgPay%>];
               LyGrpAvgCom[NumOfGrp] = [<%=sLyGrpAvgCom%>]; LyGrpAvgLSpiff[NumOfGrp] = [<%=sLyGrpAvgLSpiff%>];
               LyGrpAvgMSpiff[NumOfGrp] = [<%=sLyGrpAvgMSpiff%>]; LyGrpAvgTot[NumOfGrp] = [<%=sLyGrpAvgTot%>];
               LyGrpSlsRet[NumOfGrp] = [<%=sLyGrpSlsRet%>]; LyGrpIncPay[NumOfGrp] = [<%=sLyGrpIncPay%>];
               LyGrpAvgIncPay[NumOfGrp] = [<%=sLyGrpAvgIncPay%>];

               StrArr[NumOfGrp] = "Reg<%=sReg[i]%>";

               NumOfGrp++;
        </script>
     <%}%>

     <tr class="Divdr1"></td><td colspan=53>&nbsp;</td></tr>
     <tr class="Divdr1"></td><td colspan=53>&nbsp;</td></tr>

     <!-- ======== Report totals ========== -->
     <%
          bdgwkall.setRepBdgInfo();
          sLineCell = bdgwkall.getLineCell();
          sWarnLine20 = bdgwkall.getWarnLine20();
          sWarnLine21 = bdgwkall.getWarnLine21();
          sWarnLine23 = bdgwkall.getWarnLine23();

          // List of budget groups
          bdgwkall.setGrpBdg("T");
          int iNumOfGrpBdg = bdgwkall.getNumOfGrpBdg();
          String sGrpBdg = bdgwkall.getGrpBdgJsa();
          String sGrpBdgName = bdgwkall.getGrpBdgNameJsa();
          String sGrpBdgHrs = bdgwkall.getGrpBdgHrsJsa();

          String sGrpBdgPayReg = bdgwkall.getGrpBdgPayRegJsa();
          String sGrpBdgPayCom = bdgwkall.getGrpBdgPayComJsa();
          String sGrpBdgPayLSpiff = bdgwkall.getGrpBdgPayLSpiffJsa();
          String sGrpBdgPayMSpiff = bdgwkall.getGrpBdgPayMSpiffJsa();
          String sGrpBdgPayOther = bdgwkall.getGrpBdgPayOtherJsa();
          String sGrpBdgPay = bdgwkall.getGrpBdgPayJsa();

          String sGrpBdgAvgPay = bdgwkall.getGrpBdgAvgPayJsa();
          String sGrpBdgAvgCom = bdgwkall.getGrpBdgAvgComJsa();
          String sGrpBdgAvgLSpiff = bdgwkall.getGrpBdgAvgLSpiffJsa();
          String sGrpBdgAvgMSpiff = bdgwkall.getGrpBdgAvgMSpiffJsa();
          String sGrpBdgAvgOther = bdgwkall.getGrpBdgAvgOtherJsa();
          String sGrpBdgAvg = bdgwkall.getGrpBdgAvgJsa();

          // Actual Employee Budget Group totals
          bdgwkall.setActEmpGrp("T");
          String sActEmpGrpName = bdgwkall.getActEmpGrpNameJsa();
          String sActEmpGrpHrs = bdgwkall.getActEmpGrpHrsJsa();
          String sActEmpGrpPay = bdgwkall.getActEmpGrpPayJsa();
          String sActEmpGrpCom = bdgwkall.getActEmpGrpComJsa();
          String sActEmpGrpLSpiff = bdgwkall.getActEmpGrpLSpiffJsa();
          String sActEmpGrpMSpiff = bdgwkall.getActEmpGrpMSpiffJsa();
          String sActEmpGrpTot = bdgwkall.getActEmpGrpTotJsa();
          String sActEmpGrpAvgPay = bdgwkall.getActEmpGrpAvgPayJsa();
          String sActEmpGrpAvgCom = bdgwkall.getActEmpGrpAvgComJsa();
          String sActEmpGrpAvgLSpiff = bdgwkall.getActEmpGrpAvgLSpiffJsa();
          String sActEmpGrpAvgMSpiff = bdgwkall.getActEmpGrpAvgMSpiffJsa();
          String sActEmpGrpAvgTot = bdgwkall.getActEmpGrpAvgTotJsa();
          String sActEmpGrpSlsRet = bdgwkall.getActEmpGrpSlsRetJsa();
          String sActEmpGrpIncPay = bdgwkall.getActEmpGrpIncPayJsa();
          String sActEmpGrpAvgIncPay = bdgwkall.getActEmpGrpAvgIncPayJsa();

                    // Scheduled Employee by Budget Group
          bdgwkall.setSchGrp("T");
          String sSchGrpName = bdgwkall.getSchGrpNameJsa();
          String sSchGrpHrs = bdgwkall.getSchGrpHrsJsa();
          String sSchGrpPay = bdgwkall.getSchGrpPayJsa();
          String sSchGrpCom = bdgwkall.getSchGrpComJsa();
          String sSchGrpLSpiff = bdgwkall.getSchGrpLSpiffJsa();
          String sSchGrpMSpiff = bdgwkall.getSchGrpMSpiffJsa();
          String sSchGrpTot = bdgwkall.getSchGrpTotJsa();
          String sSchGrpAvgPay = bdgwkall.getSchGrpAvgPayJsa();
          String sSchGrpAvgCom = bdgwkall.getSchGrpAvgComJsa();
          String sSchGrpAvgLSpiff = bdgwkall.getSchGrpAvgLSpiffJsa();
          String sSchGrpAvgMSpiff = bdgwkall.getSchGrpAvgMSpiffJsa();
          String sSchGrpAvgTot = bdgwkall.getSchGrpAvgTotJsa();
          String sSchGrpSlsRet = bdgwkall.getSchGrpSlsRetJsa();
          String sSchGrpIncPay = bdgwkall.getSchGrpIncPayJsa();
          String sSchGrpAvgIncPay = bdgwkall.getSchGrpAvgIncPayJsa();

          // Total Employee by Budget Group
          bdgwkall.setTotGrp("T");
          String sTotGrpName = bdgwkall.getTotGrpNameJsa();
          String sTotGrpHrs = bdgwkall.getTotGrpHrsJsa();
          String sTotGrpPay = bdgwkall.getTotGrpPayJsa();
          String sTotGrpCom = bdgwkall.getTotGrpComJsa();
          String sTotGrpLSpiff = bdgwkall.getTotGrpLSpiffJsa();
          String sTotGrpMSpiff = bdgwkall.getTotGrpMSpiffJsa();
          String sTotGrpTot = bdgwkall.getTotGrpTotJsa();
          String sTotGrpAvgPay = bdgwkall.getTotGrpAvgPayJsa();
          String sTotGrpAvgCom = bdgwkall.getTotGrpAvgComJsa();
          String sTotGrpAvgLSpiff = bdgwkall.getTotGrpAvgLSpiffJsa();
          String sTotGrpAvgMSpiff = bdgwkall.getTotGrpAvgMSpiffJsa();
          String sTotGrpAvgTot = bdgwkall.getTotGrpAvgTotJsa();
          String sTotGrpSlsRet = bdgwkall.getTotGrpSlsRetJsa();
          String sTotGrpIncPay = bdgwkall.getTotGrpIncPayJsa();
          String sTotGrpAvgIncPay = bdgwkall.getTotGrpAvgIncPayJsa();

          // Budget and Total Variances by Budget Group
          bdgwkall.setVarGrp("T");
          String sVarGrpName = bdgwkall.getVarGrpNameJsa();
          String sVarGrpHrs = bdgwkall.getVarGrpHrsJsa();
          String sVarGrpPay = bdgwkall.getVarGrpPayJsa();
          String sVarGrpCom = bdgwkall.getVarGrpComJsa();
          String sVarGrpLSpiff = bdgwkall.getVarGrpLSpiffJsa();
          String sVarGrpMSpiff = bdgwkall.getVarGrpMSpiffJsa();
          String sVarGrpTot = bdgwkall.getVarGrpTotJsa();
          String sVarGrpAvgPay = bdgwkall.getVarGrpAvgPayJsa();
          String sVarGrpAvgCom = bdgwkall.getVarGrpAvgComJsa();
          String sVarGrpAvgLSpiff = bdgwkall.getVarGrpAvgLSpiffJsa();
          String sVarGrpAvgMSpiff = bdgwkall.getVarGrpAvgMSpiffJsa();
          String sVarGrpAvgTot = bdgwkall.getVarGrpAvgTotJsa();
          String sVarGrpSlsRet = bdgwkall.getVarGrpSlsRetJsa();
          String sVarGrpIncPay = bdgwkall.getVarGrpIncPayJsa();
          String sVarGrpAvgIncPay = bdgwkall.getVarGrpAvgIncPayJsa();

         // Last Year Processed Payroll by Budget Group totals
         bdgwkall.setActEmpGrp("T");
         String sLyGrpName = bdgwkall.getLyGrpNameJsa();
         String sLyGrpHrs = bdgwkall.getLyGrpHrsJsa();
         String sLyGrpPay = bdgwkall.getLyGrpPayJsa();
         String sLyGrpCom = bdgwkall.getLyGrpComJsa();
         String sLyGrpLSpiff = bdgwkall.getLyGrpLSpiffJsa();
         String sLyGrpMSpiff = bdgwkall.getLyGrpMSpiffJsa();
         String sLyGrpTot = bdgwkall.getLyGrpTotJsa();
         String sLyGrpAvgPay = bdgwkall.getLyGrpAvgPayJsa();
         String sLyGrpAvgCom = bdgwkall.getLyGrpAvgComJsa();
         String sLyGrpAvgLSpiff = bdgwkall.getLyGrpAvgLSpiffJsa();
         String sLyGrpAvgMSpiff = bdgwkall.getLyGrpAvgMSpiffJsa();
         String sLyGrpAvgTot = bdgwkall.getLyGrpAvgTotJsa();
         String sLyGrpSlsRet = bdgwkall.getLyGrpSlsRetJsa();
         String sLyGrpIncPay = bdgwkall.getLyGrpIncPayJsa();
         String sLyGrpAvgIncPay = bdgwkall.getLyGrpAvgIncPayJsa();
         
         boolean b22n = sLineCell[46].indexOf("-") >= 0;
     %>
     <tr class="DataTable5">
      <td class="DataTable" colspan=2>Company Totals</td>
          <th class="DataTable">&nbsp;</th>
          <!-- Sales -->
            <td class="DataTable" onmouseover="showColHdr(this, 0)" onmouseout="document.all.dvColHdr.style.visibility='hidden';">$<%=sLineCell[0]%></td>
            <td class="DataTable" onmouseover="showColHdr(this, 1)" onmouseout="document.all.dvColHdr.style.visibility='hidden';" nowrap><%=sLineCell[1]%>%</td>
            <td class="DataTable" onmouseover="showColHdr(this, 2)" onmouseout="document.all.dvColHdr.style.visibility='hidden';" nowrap>$<%=sLineCell[2]%></td>
            <td class="DataTable" onmouseover="showColHdr(this, 3)" onmouseout="document.all.dvColHdr.style.visibility='hidden';" nowrap>$<%=sLineCell[3]%></td>
            <td class="DataTable" onmouseover="showColHdr(this, 4)" onmouseout="document.all.dvColHdr.style.visibility='hidden';" nowrap>$<%=sLineCell[4]%></td>
            <td class="DataTable" onmouseover="showColHdr(this, 5)" onmouseout="document.all.dvColHdr.style.visibility='hidden';" nowrap>$<%=sLineCell[5]%></td>

            <th class="DataTable">&nbsp;</th>
            <th class="DataTable3"><a href="javascript: showGrpBdg('<%=iGrpNum%>', 'COMP')">B</a></th>
            <th class="DataTable3"><a href="javascript: showGrpBdgAvg('<%=iGrpNum++%>', 'COMP')">A</a></th>

            <!-- Hourly Employee Only (Excludes Holiday, Sick, Vacation and TMC.) -->
            <!-- P/R Hours -->
            <td class="DataTable01" onmouseover="showColHdr(this, 6)" onmouseout="document.all.dvColHdr.style.visibility='hidden';" nowrap><%=sLineCell[6]%></td>
            <td class="DataTable" onmouseover="showColHdr(this, 7)" onmouseout="document.all.dvColHdr.style.visibility='hidden';" nowrap><%=sLineCell[7]%></td>
            <td class="DataTable" onmouseover="showColHdr(this, 8)" onmouseout="document.all.dvColHdr.style.visibility='hidden';" nowrap><%=sLineCell[36]%></td>
            <td class="DataTable" onmouseover="showColHdr(this, 9)" onmouseout="document.all.dvColHdr.style.visibility='hidden';"><%=sLineCell[8]%></td>
            <td class="DataTable02" onmouseover="showColHdr(this, 10)" onmouseout="document.all.dvColHdr.style.visibility='hidden';" nowrap><%=sLineCell[9]%></td>
            <td class="DataTable02" onmouseover="showColHdr(this, 11)" onmouseout="document.all.dvColHdr.style.visibility='hidden';" nowrap><%=sLineCell[10]%></td>
            <td class="DataTable" onmouseover="showColHdr(this, 12)" onmouseout="document.all.dvColHdr.style.visibility='hidden';"><%=sLineCell[11]%></td>

            <th class="DataTable">&nbsp;</th>

            <!-- P/R $'s -->
            <td class="DataTable" onmouseover="showColHdr(this, 13)" onmouseout="document.all.dvColHdr.style.visibility='hidden';">$<%=sLineCell[12]%></td>
            <td class="DataTable" onmouseover="showColHdr(this, 35)" onmouseout="document.all.dvColHdr.style.visibility='hidden';">$<%=sLineCell[40]%></td>
            <td class="DataTable" onmouseover="showColHdr(this, 36)" onmouseout="document.all.dvColHdr.style.visibility='hidden';">$<%=sLineCell[41]%></td>
            <td class="DataTable" onmouseover="showColHdr(this, 37)" onmouseout="document.all.dvColHdr.style.visibility='hidden';">$<%=sLineCell[42]%></td>
            <td class="DataTable" onmouseover="showColHdr(this, 14)" onmouseout="document.all.dvColHdr.style.visibility='hidden';">$<%=sLineCell[13]%></td>
            <td class="DataTable" onmouseover="showColHdr(this, 15)" onmouseout="document.all.dvColHdr.style.visibility='hidden';">$<%=sLineCell[14]%></td>

            <!-- Hourly Rate -->
            <td class="DataTable" onmouseover="showColHdr(this, 16)" onmouseout="document.all.dvColHdr.style.visibility='hidden';">$<%=sLineCell[15]%></td>
            <td class="DataTable" onmouseover="showColHdr(this, 17)" onmouseout="document.all.dvColHdr.style.visibility='hidden';">$<%=sLineCell[16]%></td>
            <td class="DataTable" onmouseover="showColHdr(this, 18)" onmouseout="document.all.dvColHdr.style.visibility='hidden';">$<%=sLineCell[17]%></td>

            <th class="DataTable">&nbsp;</th>

            <!-- Variance -->
            <td class="DataTable2<%if(sWarnLine20.equals("1")){%>r<%} else {%>g<%}%>" onmouseover="showColHdr(this, 19)" onmouseout="document.all.dvColHdr.style.visibility='hidden';" nowrap><%=sLineCell[18]%></td>
            <td class="DataTable2<%if(sWarnLine21.equals("1")){%>r<%} else {%>g<%}%>" onmouseover="showColHdr(this, 20)" onmouseout="document.all.dvColHdr.style.visibility='hidden';" nowrap>$<%=sLineCell[19]%></td>
            <td class="DataTable" onmouseover="showColHdr(this, 21)" onmouseout="document.all.dvColHdr.style.visibility='hidden';"><%=sLineCell[20]%></td>
            <td class="DataTable2<%if(sWarnLine23.equals("1")){%>r<%} else {%>g<%}%>" onmouseover="showColHdr(this, 22)" onmouseout="document.all.dvColHdr.style.visibility='hidden';" nowrap><%=sLineCell[21]%></td>
            <td class="DataTable" onmouseover="showColHdr(this, 23)" onmouseout="document.all.dvColHdr.style.visibility='hidden';"><%=sLineCell[22]%></td>

            <th class="DataTable">&nbsp;</th>

            <!-- T/M/C -->
            <td class="DataTable" onmouseover="showColHdr(this, 24)" onmouseout="document.all.dvColHdr.style.visibility='hidden';"><%=sLineCell[23]%></td>
            <!-- td class="DataTable"><%=sLineCell[24]%></td -->
            <td class="DataTable" onmouseover="showColHdr(this, 25)" onmouseout="document.all.dvColHdr.style.visibility='hidden';"><%=sLineCell[32]%></td>
            <td class="DataTable" onmouseover="showColHdr(this, 26)" onmouseout="document.all.dvColHdr.style.visibility='hidden';"><%=sLineCell[34]%></td>
            <td class="DataTable" onmouseover="showColHdr(this, 27)" onmouseout="document.all.dvColHdr.style.visibility='hidden';">$<%=sLineCell[25]%></td>
            <!-- td class="DataTable"><%=sLineCell[26]%></td -->
            <td class="DataTable" onmouseover="showColHdr(this, 28)" onmouseout="document.all.dvColHdr.style.visibility='hidden';">$<%=sLineCell[33]%></td>
            <td class="DataTable" onmouseover="showColHdr(this, 29)" onmouseout="document.all.dvColHdr.style.visibility='hidden';">$<%=sLineCell[35]%></td>

            <th class="DataTable">&nbsp;</th>

            <!-- Actual Processed Payroll -->
            <td class="DataTable" onmouseover="showColHdr(this, 30)" onmouseout="document.all.dvColHdr.style.visibility='hidden';"><%=sLineCell[27]%></td>
            <td class="DataTable" onmouseover="showColHdr(this, 31)" onmouseout="document.all.dvColHdr.style.visibility='hidden';"><%=sLineCell[28]%></td>
            <td class="DataTable" onmouseover="showColHdr(this, 32)" onmouseout="document.all.dvColHdr.style.visibility='hidden';"><%=sLineCell[29]%></td>
            <td class="DataTable" onmouseover="showColHdr(this, 34)" onmouseout="document.all.dvColHdr.style.visibility='hidden';"><%=sLineCell[30]%></td>
            <td class="DataTable" onmouseover="showColHdr(this, 35)" onmouseout="document.all.dvColHdr.style.visibility='hidden';" nowrap><%=sLineCell[31]%></td>
            
            <th class="DataTable">&nbsp;</th>
            
            <!-- P/R $'s - No Commission -->
            <td class="DataTable">$<%=sLineCell[43]%></td>
            <td class="DataTable">$<%=sLineCell[44]%></td>
            <td class="DataTable">$<%=sLineCell[45]%></td>
            <td class="DataTable2<%if(b22n){%>g<%} else {%>r<%}%>" nowrap>$<%=sLineCell[46]%></td>
            
          <script>
               GrpBdg[NumOfGrp] = [<%=sGrpBdg%>]; GrpBdgName[NumOfGrp] = [<%=sGrpBdgName%>]; GrpBdgHrs[NumOfGrp] = [<%=sGrpBdgHrs%>];
               GrpBdgPayReg[NumOfGrp] = [<%=sGrpBdgPayReg%>]; GrpBdgPayCom[NumOfGrp] = [<%=sGrpBdgPayCom%>];
               GrpBdgPayLSpiff[NumOfGrp] = [<%=sGrpBdgPayLSpiff%>]; GrpBdgPayMSpiff[NumOfGrp] = [<%=sGrpBdgPayMSpiff%>];
               GrpBdgPayOther[NumOfGrp] = [<%=sGrpBdgPayOther%>]; GrpBdgPay[NumOfGrp] = [<%=sGrpBdgPay%>];
               GrpBdgAvgPay[NumOfGrp] = [<%=sGrpBdgAvgPay%>]; GrpBdgAvgCom[NumOfGrp] = [<%=sGrpBdgAvgCom%>];
               GrpBdgAvgLSpiff[NumOfGrp] = [<%=sGrpBdgAvgLSpiff%>]; GrpBdgAvgMSpiff[NumOfGrp] = [<%=sGrpBdgAvgMSpiff%>];
               GrpBdgAvgOther[NumOfGrp] = [<%=sGrpBdgAvgOther%>]; GrpBdgAvg[NumOfGrp] = [<%=sGrpBdgAvg%>];

               ActEmpGrpName[NumOfGrp] = [<%=sActEmpGrpName%>]; ActEmpGrpHrs[NumOfGrp] = [<%=sActEmpGrpHrs%>];
               ActEmpGrpPay[NumOfGrp] = [<%=sActEmpGrpPay%>]; ActEmpGrpCom[NumOfGrp] = [<%=sActEmpGrpCom%>];
               ActEmpGrpLSpiff[NumOfGrp] = [<%=sActEmpGrpLSpiff%>]; ActEmpGrpMSpiff[NumOfGrp] = [<%=sActEmpGrpMSpiff%>];
               ActEmpGrpTot[NumOfGrp] = [<%=sActEmpGrpTot%>]; ActEmpGrpAvgPay[NumOfGrp] = [<%=sActEmpGrpAvgPay%>];
               ActEmpGrpAvgCom[NumOfGrp] = [<%=sActEmpGrpAvgCom%>]; ActEmpGrpAvgLSpiff[NumOfGrp] = [<%=sActEmpGrpAvgLSpiff%>];
               ActEmpGrpAvgMSpiff[NumOfGrp] = [<%=sActEmpGrpAvgMSpiff%>]; ActEmpGrpAvgTot[NumOfGrp] = [<%=sActEmpGrpAvgTot%>];
               ActEmpGrpSlsRet[NumOfGrp] = [<%=sActEmpGrpSlsRet%>]; ActEmpGrpIncPay[NumOfGrp] = [<%=sActEmpGrpIncPay%>];
               ActEmpGrpAvgIncPay[NumOfGrp] = [<%=sActEmpGrpAvgIncPay%>];

               SchGrpName[NumOfGrp] = [<%=sSchGrpName%>]; SchGrpHrs[NumOfGrp] = [<%=sSchGrpHrs%>];
               SchGrpPay[NumOfGrp] = [<%=sSchGrpPay%>]; SchGrpCom[NumOfGrp] = [<%=sSchGrpCom%>];
               SchGrpLSpiff[NumOfGrp] = [<%=sSchGrpLSpiff%>]; SchGrpMSpiff[NumOfGrp] = [<%=sSchGrpMSpiff%>];
               SchGrpTot[NumOfGrp] = [<%=sSchGrpTot%>]; SchGrpAvgPay[NumOfGrp] = [<%=sSchGrpAvgPay%>];
               SchGrpAvgCom[NumOfGrp] = [<%=sSchGrpAvgCom%>]; SchGrpAvgLSpiff[NumOfGrp] = [<%=sSchGrpAvgLSpiff%>];
               SchGrpAvgMSpiff[NumOfGrp] = [<%=sSchGrpAvgMSpiff%>]; SchGrpAvgTot[NumOfGrp] = [<%=sSchGrpAvgTot%>];
               SchGrpSlsRet[NumOfGrp] = [<%=sSchGrpSlsRet%>]; SchGrpIncPay[NumOfGrp] = [<%=sSchGrpIncPay%>];
               SchGrpAvgIncPay[NumOfGrp] = [<%=sSchGrpAvgIncPay%>];

               TotGrpName[NumOfGrp] = [<%=sTotGrpName%>]; TotGrpHrs[NumOfGrp] = [<%=sTotGrpHrs%>];
               TotGrpPay[NumOfGrp] = [<%=sTotGrpPay%>]; TotGrpCom[NumOfGrp] = [<%=sTotGrpCom%>];
               TotGrpLSpiff[NumOfGrp] = [<%=sTotGrpLSpiff%>]; TotGrpMSpiff[NumOfGrp] = [<%=sTotGrpMSpiff%>];
               TotGrpTot[NumOfGrp] = [<%=sTotGrpTot%>]; TotGrpAvgPay[NumOfGrp] = [<%=sTotGrpAvgPay%>];
               TotGrpAvgCom[NumOfGrp] = [<%=sTotGrpAvgCom%>]; TotGrpAvgLSpiff[NumOfGrp] = [<%=sTotGrpAvgLSpiff%>];
               TotGrpAvgMSpiff[NumOfGrp] = [<%=sTotGrpAvgMSpiff%>]; TotGrpAvgTot[NumOfGrp] = [<%=sTotGrpAvgTot%>];
               TotGrpSlsRet[NumOfGrp] = [<%=sTotGrpSlsRet%>]; TotGrpAvgIncPay[NumOfGrp] = [<%=sTotGrpAvgIncPay%>];
               TotGrpIncPay[NumOfGrp] = [<%=sTotGrpIncPay%>];

               VarGrpName[NumOfGrp] = [<%=sVarGrpName%>]; VarGrpHrs[NumOfGrp] = [<%=sVarGrpHrs%>];
               VarGrpPay[NumOfGrp] = [<%=sVarGrpPay%>]; VarGrpCom[NumOfGrp] = [<%=sVarGrpCom%>];
               VarGrpLSpiff[NumOfGrp] = [<%=sVarGrpLSpiff%>]; VarGrpMSpiff[NumOfGrp] = [<%=sVarGrpMSpiff%>];
               VarGrpTot[NumOfGrp] = [<%=sVarGrpTot%>]; VarGrpAvgPay[NumOfGrp] = [<%=sVarGrpAvgPay%>];
               VarGrpAvgCom[NumOfGrp] = [<%=sVarGrpAvgCom%>]; VarGrpAvgLSpiff[NumOfGrp] = [<%=sVarGrpAvgLSpiff%>];
               VarGrpAvgMSpiff[NumOfGrp] = [<%=sVarGrpAvgMSpiff%>]; VarGrpAvgTot[NumOfGrp] = [<%=sVarGrpAvgTot%>];
               VarGrpSlsRet[NumOfGrp] = [<%=sVarGrpSlsRet%>]; VarGrpIncPay[NumOfGrp] = [<%=sVarGrpIncPay%>];
               VarGrpAvgIncPay[NumOfGrp] = [<%=sVarGrpAvgIncPay%>];

               LyGrpName[NumOfGrp] = [<%=sLyGrpName%>]; LyGrpHrs[NumOfGrp] = [<%=sLyGrpHrs%>];
               LyGrpPay[NumOfGrp] = [<%=sLyGrpPay%>]; LyGrpCom[NumOfGrp] = [<%=sLyGrpCom%>];
               LyGrpLSpiff[NumOfGrp] = [<%=sLyGrpLSpiff%>]; LyGrpMSpiff[NumOfGrp] = [<%=sLyGrpMSpiff%>];
               LyGrpTot[NumOfGrp] = [<%=sLyGrpTot%>]; LyGrpAvgPay[NumOfGrp] = [<%=sLyGrpAvgPay%>];
               LyGrpAvgCom[NumOfGrp] = [<%=sLyGrpAvgCom%>]; LyGrpAvgLSpiff[NumOfGrp] = [<%=sLyGrpAvgLSpiff%>];
               LyGrpAvgMSpiff[NumOfGrp] = [<%=sLyGrpAvgMSpiff%>]; LyGrpAvgTot[NumOfGrp] = [<%=sLyGrpAvgTot%>];
               LyGrpSlsRet[NumOfGrp] = [<%=sLyGrpSlsRet%>]; LyGrpIncPay[NumOfGrp] = [<%=sLyGrpIncPay%>];
               LyGrpAvgIncPay[NumOfGrp] = [<%=sLyGrpAvgIncPay%>];

               StrArr[NumOfGrp] = "Total";

               NumOfGrp++;
        </script>
      </tr>
   </table>
    <!----------------------- end of table ---------------------------------->
  </table>
  <br><br>

  <%
     bdgwkall.setABTotal();
     String sAbtTmc = bdgwkall.getAbtTmc();
     String sAbtProcAmt = bdgwkall.getAbtProcAmt();
     String sAbtRes1 = bdgwkall.getAbtRes1();
     String sAbtCalcAmt = bdgwkall.getAbtCalcAmt();
     String sAbtRes2 = bdgwkall.getAbtRes2();
     String sAbtIncPay = bdgwkall.getAbtIncPay();
     String sAbtAlwAmt = bdgwkall.getAbtAlwAmt();
     String sAbtVarOvr = bdgwkall.getAbtVarOvr();
     String sAbtActPrc = bdgwkall.getAbtActPrc();
     String sAbtAlwPrc = bdgwkall.getAbtAlwPrc();
     String sAbtCoorInc = bdgwkall.getAbtCoorInc();
     
     long lAb = Long.parseLong(sAbtAlwAmt.replaceAll(",", ""));
     long lTmc = Long.parseLong(sAbtTmc.replaceAll(",", ""));
     long lChall = Long.parseLong(sAbtIncPay.replaceAll(",", ""));
     long lStr55 = Long.parseLong(Str55ActProcPy.replaceAll(",", ""));
     long lCoor = Long.parseLong(sAbtCoorInc.replaceAll(",", ""));     
     long lAdjAlwBdg = lAb + lTmc + lChall + lStr55 + lCoor;     
     String sAdjAlwBdg = String.format("%,d", lAdjAlwBdg); 
     
     long lAbtProcAmt = Long.parseLong(sAbtProcAmt.replaceAll(",", ""));
     long lVarFav = lAdjAlwBdg - lAbtProcAmt;
     sAbtVarOvr = String.format("%,d", lVarFav);
     String sColor = "g";
     if(lVarFav < 0 ){  sColor = "r"; }
     String sSpace = "&nbsp;";
     for(int i=0; i < 5; i++){ sSpace += "&nbsp;"; }
  %>
  <table border=0 cellPadding="0" cellSpacing="0">
    <tr>
      <td style="text-align:left; font-size:10px;">
         <sup>1)</sup> - Hours can be earned or lost based on:<br>
          &nbsp; &nbsp; 1) Actual/forecast sales compared to Original Sales Plan<br>
          &nbsp; &nbsp; 2) Salaried employees on Vacation or Holiday

          <br><br><input type="button" value="Avg Rates to Excel (IE only)" onclick="startExcel();">
      </td>
      <td width="30%">&nbsp;</td>
      <td>
         <table border=0 cellPadding="0" cellSpacing="0" style="text-align:left; font-size:14px;">
           <tr>
                <td nowrap>Allowed Budget</td>  <td nowrap><%=sSpace%></td>
                <td class="DataTable">$<%=sAbtAlwAmt%></td> <td nowrap><%=sSpace%></td> <td align=left nowrap>(16)</td>
           </tr>           
           <tr>
                <td nowrap>Add Exclusions to Allowable Budget:</td>
           </tr>
           <tr>
                <td nowrap><%=sSpace%>TMC (Actual) </td><td><%=sSpace%></td>
                <td class="DataTable"><%=sSpace%>$<%=sAbtTmc%></td> <td nowrap><%=sSpace%></td><td align=left nowrap>(4T)</td>
           </tr>
           <tr>
                <td nowrap><%=sSpace%>Challenge (Actual)</td> <td nowrap><%=sSpace%></td>
                <td class="DataTable"><%=sSpace%>$<%=sAbtIncPay%></td> <td nowrap><%=sSpace%></td><td align=left nowrap>Memo:Challenge</td>
           </tr>
           <tr>
                <td nowrap><%=sSpace%>Store 55 (Actual)</td><td nowrap><%=sSpace%></td>
                <td class="DataTable"><%=sSpace%>$<%=Str55ActProcPy%></td> <td nowrap><%=sSpace%></td><td align=left nowrap>(17P)</td>
           </tr>
           <tr>
                <td nowrap><u><%=sSpace%>Coordinator GM Incentive</u></td><td nowrap><%=sSpace%></td>
                <td class="DataTable"><u><%=sSpace%>$<%=sAbtCoorInc%></u></td> <td nowrap><%=sSpace%></td><td align=left nowrap>&nbsp;</td>
           </tr>                                 
           <tr>
                <td nowrap><b>Adjusted Allowed Budget</b></td><td nowrap><%=sSpace%></td>
                <td class="DataTable"><b>$<%=sAdjAlwBdg%></b></td> <td nowrap><%=sSpace%></td><td align=left nowrap>Calculated</td>
           </tr>
           <tr>
                <td nowrap>Actual Processed Payroll</td><td nowrap><%=sSpace%></td>
                <td class="DataTable">$<%=sAbtProcAmt%></td> <td nowrap><%=sSpace%></td><td align=left nowrap>(17P)</td>
           </tr>           
           <tr>
                <td nowrap>Variance-Fav(Unfav)</td><td nowrap><%=sSpace%></td>
                <td class="DataTable2<%=sColor%>">$<%=sAbtVarOvr%></td> <td nowrap><%=sSpace%></td><td align=left nowrap>Adjusted Bdg - Actual Bdg</td>
           </tr>
         </table>
     </td>
    </tr>
   </table>
   
   <%
long lEndTime = (new java.util.Date()).getTime();
long lElapse = (lEndTime - lStartTime) / 1000;
if (lElapse==0) {lElapse = 1;}
//System.out.println("B/Item X-fer loading Elapse time=" + lElapse + " second(s)");
%>
<p  style="text-align: left; font-size:10px; font-weigth:bold;">Elapse: <%=lElapse%> sec.</td>
  
            
 </body>

</html>

<%bdgwkall.disconnect();%>

<%}%>
