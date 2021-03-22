<%@ page import="rciutility.StoreSelect, payrollreports.SetScoring, java.util.*"%>
<% String sStore = request.getParameter("STORE");
   String sThisStrName = request.getParameter("STRNAME");
   String sWeekend = request.getParameter("WEEKEND");
  //-------------- Security ---------------------
  String sStrAllowed = null;
  String sAccess = null;
  String sAppl = "PAYROLL";

  if (session.getAttribute("USER")==null
    || session.getAttribute("APPLICATION") !=null
    && !session.getAttribute("APPLICATION").equals(sAppl))
  {
     Enumeration  en = request.getParameterNames();
     String sParam =null;
     String sPrmValue = null;
     String sTarget = "PayrollSignOn.jsp?TARGET=Scoring.jsp&APPL=" +sAppl;
     StringBuffer sbQuery = new StringBuffer() ;

     while (en.hasMoreElements())
      {
        sParam = en.nextElement().toString();
        sPrmValue = request.getParameter(sParam);
          sbQuery.append("&" + sParam + "=" + sPrmValue);
      }
     response.sendRedirect(sTarget + sbQuery.toString());
   }
   else {
     sAccess = session.getAttribute("ACCESS").toString();
     sStrAllowed = session.getAttribute("STORE").toString();

     if (sAccess != null && !sAccess.equals("1")
         || !sStrAllowed.startsWith("ALL")
         && !sStore.equals(sStrAllowed.substring(0,sStore.length())))
     {
       response.sendRedirect("StrScheduling.html");
     }
   }
  // -------------- End Security -----------------

  StoreSelect StrSelect = null;
  SetScoring setScr = null;
  String sStr = null;
  String sStrName = null;
  String [] sPlans = null;
  String [] sPlnPrc = null;
  String [] sHours = null;
  String [] sHrsPrc = null;
  String [] sProd = null;

  String [] sWkDays = new String[]{"Monday", "Tuesday", "Wednesday", "Thursday",
                                "Friday", "Saturday", "Sunday", "Total"};



   if (sStrAllowed != null && sStrAllowed.startsWith("ALL"))
   {
      StrSelect = new StoreSelect();
   }
   else
   {
      StrSelect = new StoreSelect(sStrAllowed);
   }
   sStr = StrSelect.getStrNum();
   sStrName = StrSelect.getStrName();

   setScr = new SetScoring(sStore, sWeekend);
   sPlans = setScr.getPlans();
   sPlnPrc = setScr.getPlnPrc();
   sHours = setScr.getHours();
   sHrsPrc = setScr.getHrsPrc();
   sProd = setScr.getProd();

   setScr.disconnect();

%>

<html>
<head>

<style>body {background:ivory;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:#FFE4C4;text-align:center;}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }
        td.DataTable { background:lightgrey; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:right; font-family:Arial; font-size:10px }
	td.DataTable1 { background:lightgrey; padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:right; font-family:Arial; font-size:10px }

</style>
<SCRIPT language="JavaScript">
var CurStore = <%=sStore%>;
var CurStrName = "<%=sThisStrName%>";

function bodyLoad(){
    doStrSelect();
}

// Load Stores
function doStrSelect(id) {
    var df = document.forms[0];
    var stores = [<%=sStr%>];
    var storeNames = [<%=sStrName%>];

    for (idx = 1; idx < stores.length; idx++){
        df.STORE.options[idx-1] = new Option(storeNames[idx],stores[idx]);
    }
}

function submitForm()
{
   var SbmString = "Scoring.jsp";
       SbmString = SbmString + "?STORE="
              + document.getStore.STORE.options[document.getStore.STORE.selectedIndex].value
              + "&STRNAME="
              + document.getStore.STORE.options[document.getStore.STORE.selectedIndex].text;
   // alert(SbmString);
    window.location.href=SbmString;
}

</SCRIPT>
</head>
<body  onload="bodyLoad();">

         <div id="tooltip2" style="position:absolute;visibility:hidden; background-attachment: scroll;
              border: black solid 1px; width:150px;background-color:LemonChiffon; z-index:10"></div>
         <div align="CENTER" name="divTest" onMouseover="showtip2(this,event,' ');" onMouseout="hidetip2();" STYLE="cursor: hand">
         </div>

   <table border="0" width="100%" height="100%" cellPadding="0" cellSpacing="0">
     <tr bgColor="moccasin">
       <td ALIGN="center" VALIGN="TOP">
      <b>Retail Concepts, Inc
      <br>Scoring
      <br>Weekending: <%=sWeekend%></b><br>
<!------------- store selector ----------------------------->
      <form name="getStore" action="javascript:submitForm();">
      Select Store <SELECT name="STORE"></SELECT>
      <input type="submit" value="GO">
      </form>
<!------------- end of store selector ---------------------->
        <font size="+1" ><b>Store:&nbsp;
        <script>document.write(CurStrName);</script>
        </b></font>
        <p><a href="../"><font color="red">Home</font></a>&#62;
        <a href="StrScheduling.html"><font color="red">Payroll</font></a>&#62;
        <a href="ScoreSel.jsp"><font color="red">Store Selector</font></a>&#62;
        This page<br>
<!------------- start table ------------------------>
      <table class="DataTable"align="center" >
             <tr>
                <th class="DataTable">Scoring</th>
                <%for(int i=0; i < 8; i++){%>
                  <th class="DataTable"><%=sWkDays[i]%></th>
                <%}%>
             </tr>
      <!--------------------------- Details ---------------------------------->
              <!----------------------- Plans ------------------------>
               <tr>
               <td class="DataTable">Planed Sales (85%)</td>
                <%for(int i = 0; i < 8; i++){ %>
                   <td class="DataTable">$<%=sPlans[i]%></td>
                <%}%>
               </tr>
              <!----------------------- Plans % ---------------------->
               <tr>
               <td class="DataTable1">% to total</td>
                <%for(int i = 0; i < 8; i++){ %>
                   <td class="DataTable1"><%=sPlnPrc[i]%>%</td>
                <%}%>
               </tr>
              <!----------------------- Hours ------------------------>
               <tr>
               <td class="DataTable"># Of Selling Hours</td>
                <%for(int i = 0; i < 8; i++){ %>
                   <td class="DataTable"><%=sHours[i]%></td>
                <%}%>
               </tr>
               <!---------------------- Hours % ---------------------->
               <tr>
               <td class="DataTable1">% to total</td>
                <%for(int i = 0; i < 8; i++){ %>
                   <td class="DataTable1"><%=sHrsPrc[i]%>%</td>
                <%}%>
               <!------------------ Productivity -------------------->
               <tr>
               <td class="DataTable1">Sales Productivity</td>
                <%for(int i = 0; i < 8; i++){ %>
                   <td class="DataTable1">$<%=sProd[i]%></td>
                <%}%>
               </tr>
       </table>

<!------------- end of data table ------------------------>

       </td>
    </tr>
  </table>

</body>
</html>
