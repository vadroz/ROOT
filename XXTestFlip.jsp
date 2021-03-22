<%@ page import="java.util.*, java.text.*"%>
<%
   String sWkend = request.getParameter("Wkend");

   String sUser = session.getAttribute("USER").toString();
   String sAppl = "PRLAB";
if (session.getAttribute("USER")==null || session.getAttribute(sAppl)==null
 && !session.getAttribute("APPLICATION").equals(sAppl))
{
   response.sendRedirect("SignOn1.jsp?TARGET=BfdgSchActWkAllStr.jsp&APPL=" + sAppl + "&" + request.getQueryString());
}
else
{
%>
 

<style>body {background:ivory;font-family: Verdanda}
        a:link { color:blue; font-size:12px} a:visited { color:blue; font-size:12px}
                 a:hover { color:red; font-size:12px}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}
                       a:hover.small { color:red; font-size:10px}
        th.DataTable { border: #efefef groove 1px; background:#FFCC99; padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:top ;font-size:12px }
        th.DataTable1 { border: #efefef groove 1px; background:#FFCC99;padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px;
                       text-align:left; vertical-align:top ;font-size:12px }
        th.DataTable2 { border: #efefef groove 1px; background:#FFCC99; white-space: nowrap; padding-top:3px; padding-bottom:3px;
                       writing-mode: tb-rl;   text-align:left;  font-size:12px;
        	filter: flipv fliph;
        }
        
        
        th.rotate { border: #efefef groove 1px; background:#FFCC99; white-space: nowrap; font-size:12px;}
		th.rotate > div { transform: translate( 0px, 140px) rotate(270deg); width: 40px;}
		th.rotate > div > span { padding: 0px 0px; }
		
		th.rotate1 { border: #efefef groove 1px; height: 390px; background:#FFCC99; white-space: nowrap; font-size:12px;}
		th.rotate1 > div { transform: translate( 0px, 160px) rotate(270deg); width: 25px;}
		th.rotate1 > div > span { padding: 0px 0px; }
		
		th.rotate2 { border: #efefef groove 1px; height: 390px; background:#ccffcc; white-space: nowrap; font-size:12px;}
		th.rotate2 > div { transform: translate( 0px, 160px) rotate(270deg); width: 25px;}
		th.rotate2 > div > span { padding: 0px 0px; }
                       
        th.DataTable3 { border: #efefef groove 1px; background:#ccffcc; padding-top:3px; padding-bottom:3px; font-size:12px }
        th.DataTable4 { border: #efefef groove 1px;  background:#ccccff; padding-top:3px; padding-bottom:3px; font-size:12px }
        th.DataTable5 { border: #efefef groove 1px; background:#ccffcc; writing-mode: tb-rl;  
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


        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; }

        td.DataTable01 { background: yellow; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; }

        td.DataTable02 { background: Khaki; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; }

        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left;}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;}
        td.DataTable21 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;  font-weight: bold}
        td.DataTable22 {  background: azure; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;  font-weight: bold}

        td.DataTable2p { background: #d0d0d0; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;}
        td.DataTable2g { background:lightgreen; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;}
        td.DataTable2r { background:red; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;}

        td.DataTable210 { background: lightgreen; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;  font-weight: bold}
        td.DataTable211 { background: pink; padding-top:3px; padding-bottom:3px; padding-left:3px;
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

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
        td.Prompt3 { text-align:left; vertical-align:midle; font-family:Arial; font-size:10px; }

</style>
<html>
<head><Meta http-equiv="refresh"></head>

<SCRIPT language="JavaScript">
var isOpera = (!!window.opr && !!opr.addons) || !!window.opera || navigator.userAgent.indexOf(' OPR/') >= 0;
//Firefox 1.0+
var isFirefox = typeof InstallTrigger !== 'undefined';
//Safari 3.0+ "[object HTMLElementConstructor]" 
var isSafari = /constructor/i.test(window.HTMLElement) || (function (p) { return p.toString() === "[object SafariRemoteNotification]"; })(!window['safari'] || safari.pushNotification);
//Internet Explorer 6-11
var isIE = /*@cc_on!@*/false || !!document.documentMode;
//Edge 20+
var isEdge = !isIE && !!window.StyleMedia;
//Chrome 1+
var isChrome = !!window.chrome && !!window.chrome.webstore;
//Blink engine detection
var isBlink = (isChrome || isOpera) && !!window.CSS;
//==============================================================================
// initializing process
//==============================================================================
function bodyLoad()
{
	/*"Mozilla/5.0 (Windows NT 6.1; WOW64; Trident/7.0; SLCC2; .NET CLR 2.0.50727;
	   .NET CLR 3.5.30729; .NET CLR 3.0.30729; .NET4.0C; .NET4.0E; 
	   Media Center PC 6.0; CMNTDFJS; F9J; rv:11.0) like Gecko" IE11 */ 
	
	/*"Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.1; WOW64; Trident/7.0; SLCC2; 
	   .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; .NET4.0C; .NET4.0E; 
	   Media Center PC 6.0; CMNTDFJS; F9J)" IE9*/
	
	/* Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) 
	   Chrome/57.0.2987.133 Safari/537.36
	*/   
	var ua = window.navigator.userAgent;
	 
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

        </tr>

     <tr class="Divdr1"></td><td colspan=48>&nbsp;</td></tr>
            </table>
     </td>
    </tr>
   </table>         
 </body>

</html>
 

<%}%>
