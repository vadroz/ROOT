<%

   String sMenu = "'SALES', 'INVENTORY', 'SIGNAGE AND PRICING', 'SCHEDULING AND BUDGETING', 'OTHER', 'FUTURE USE'";

   String [] sContent = new String[6];

   String [] sLink = new String[6];



   // Sales

   sContent[0] = "'Historical Customer and Employee Sales..', 'Weekly Sales Reports/GM/Analysis...', 'Salesperson/Store Productivity...'";

   sLink[0] = "'SalesHistory.jsp', 'rciWeeklyReports.html', 'StrProdReports.html'";



   // Inventory

   sContent[1] = "'Aged Inventory Analysis(by week)', 'Stock Ledger', 'Open to Buy','Planning','Item Transfers...', 'Lookups/Searches for Items...',  'On-Hand/BSR/PI Listings...', 'DC Receipts' , 'DC Daily Freight Bill Report (shipments to Stores)', 'Distribution Status Inquiry'";

   sLink[1] = "'AgedAnalysisSel.jsp?mode=1', 'StockLedgerInqSel.jsp', 'OpenToBuySel.jsp','PlanningSel.jsp', 'TransferReq.html', 'LookupSearch.html', 'OnHandReps.html', 'DcReceiptSel.jsp', 'DcFrtBill.jsp', 'DstStsInqSel.jsp' ";



   // SIGNAGE AND PRICING

   sContent[2] = "'Signs... (store)', 'Sign Listings and Inquiry...(HO)', 'Unauthorized Markdown Report', 'Permanent Markdown Recap Report', 'Permanent Markdown Recap Report(Archive)'";

   sLink[2] = "'SignSelector.html', 'SignInquires.html', 'UnautMDRepSel.jsp', 'servlet/salesreport3.Salesreport03?ReportId=8', 'servlet/formgenerator.FormGenerator?FormGrp=ARCHIVE&Form=RC106C'";



   // SCHEDULING AND BUDGETING

   sContent[3] = "'Store Scheduling...'";

   sLink[3] = "'StrScheduling.html'";



   // OTHER

   sContent[4] = "'Event Calendar', 'Training', 'Merchandise','Performance Appraisal', 'Policy and Procedures - Manual', 'Policy and Procedures - Forms'";

   sLink[4] = "'EventCalendar.jsp', 'MemoSel.jsp?Type=TRAINING', 'MemoSel.jsp?Type=MERCH', 'servlet/policy.GetList?Table=Form&Form=SPAPP', 'servlet/policy.GetList?Table=Policy&Section=*ALL', 'servlet/policy.GetList?Table=Form&Form=GENERAL'";



   // FUTURE USE

     sContent[5] = "'Item Sales Report','Special Orders...', 'Ads', 'Advertising Expense by Month', 'Advertising Expense by Market'";

     sLink[5] = "'ItmSlsRepSel.jsp','SpecialOrder.jsp', 'AdCalSel.jsp', 'AdExpense.jsp?Market=ALL&MktName=All Markets', 'AdExpByMkt.jsp?Month=Y-T-D'";

%>





<HTML>

<TITLE>RCI Intranet Home Page</TITLE>

<HEAD>

     <style type="text/css">
       body {background:ivory;}
       a.blue:visited {  font-weight: bold; color: #663399}
       a.blue:link {  font-weight: bold; color: #0000FF}
       th.sep1 { border: 1px; border-style: outset; background: #6699CF;
                 text-align:center; font-family:Verdanda; font-size:18px }
       td.sep1 { padding-left:95px; padding-bottom:5px; text-align:left; font-family:Verdanda; font-size:12px }
       td.sep2 { border-bottom: black solid 1px; padding-left:5px; text-align:left; font-family:Verdanda; font-size:12px }
       td.sep4 { padding-left:5px; text-align:center;}



       table.msg { border:2px; border-style: outset;  background:LightSteelBlue;}
       td.msg { text-align:left; font-size:10px }
       td.msg1 { border:2px; border-style: ridge; text-align:center; font-size:10px }
       td.msg2 { text-align:center; font-size:10px }
       td.misc { border:2px; border-style: ridge; text-align:left; font-size:10px }
       td.misc1{ color: darkblue; text-align:center; font-size:12px; font-weight:bold }
       td.img { border:ivory 2px; border-style: outset;text-align:left;}

       img.skier {border:0px;}

       div.dvBar  {border: #6699CF 1px; border-style: outset; cursor:hand; background-attachment: scroll;
                    background-color:#6699CF; width=100%; text-align:left; font-size:18px}

       div.dvContent  {position:absolute; border-style: ridge; cursor:hand; visibility:hidden;
                       background-attachment: scroll; background-color:#FFEFC7;
                       width=300; 200; text-align:left; font-size:18px}

       div.dvHol  {border: #6699CF 1px; border-style: outset; cursor:hand; background-attachment: scroll;
                    background-color:#6699CF; width=100; text-align:left; font-size:18px}

     </style>

</HEAD>

<body onLoad="">
<span id="spMenu">Test</span>
</body>
</HTML>

<script language="JavaScript1.2">
var Menu = [<%=sMenu%>];
var Content = new Array(Menu.length);
var Link = new Array(Menu.length);

<%for(int i = 0; i < sContent.length; i++){%>
  Content[<%=i%>] = [<%=sContent[i]%>];
  Link[<%=i%>] = [<%=sLink[i]%>];
<%}%>
bodyLoad();
// ------------------------------------------------------
// run for body on load
// ------------------------------------------------------
function bodyLoad()
{
  alert(document.all)
  var html = ' ';
  var  m = 1;
  for(var i=0; i < Content[m].length; i++)
  {
     html += "<a href='" + Link[m][i] + "'>" + Content[m][i] + "</a><br>";
  }
  document.all.spMenu.innerHTML = html;
}
</script>




