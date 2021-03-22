<%@ page import="rciutility.StoreSelect,  customermgmt.CmSport"%>
<%
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null || session.getAttribute("ADVERTISES") == null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=CustListSel.jsp&APPL=ALL");
   }
   else
   {
      StoreSelect strsel = new StoreSelect(4);
      int iNumOfStr = strsel.getNumOfStr();
      String [] sStr = strsel.getStrLst();
      String [] sStrName = strsel.getStrNameLst();

      CmSport cmsport = new CmSport();
      int iNumOfCol = cmsport.getNumOfCol();
      String [] sCol = cmsport.getCol();
      String [] sColNm = cmsport.getColNm();
      String sColJsa = cmsport.getColJsa();
      String sColNmJsa = cmsport.getColNmJsa();
%>

<style>
  a.Small {font-family: times; font-size:10px; color:red; }
  .Small {font-family: times; font-size:10px }

  table.DataTable { background: #E7E7E7; font-size:10px }

  tr.Divider { font-size:5px;}

  tr.Total { background: cornSilk; font-size:10px }
  td.Sect { border: inset 2px; font-size:12px; text-align:center; vertical-align:top}

  td.Cell {font-size:10px; text-align:right; vertical-align:top}
  td.Cell1 {font-size:10px; text-align:left; vertical-align:top}
  td.Cell2 {font-size:10px; text-align:center; vertical-align:top}

  </style>

<script LANGUAGE="JavaScript1.2" src="Calendar.js">
</script>


<script name="javascript">
var Col = [<%=sColJsa%>];
var ColNm = [<%=sColNmJsa%>];

//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   checkStr(false)
   checkSport(false)
}
//==============================================================================
// check and uncheck Store boxes
//==============================================================================
function checkStr(chk)
{
   var str = document.all.Store
   for(var i=0; i < str.length; i++) {  str[i].checked = chk; }
}
//==============================================================================
// check and uncheck Sport types boxes
//==============================================================================
function checkSport(chk)
{
   var sport = document.all.Sport
   for(var i=0; i < sport.length; i++) {  sport[i].checked = chk; }
}
//==============================================================================
// Validate form
//==============================================================================
function Validate(downl)
{
  var error = false;
  var msg = " ";

  // retreive database
  var dbfld = document.all.Dbase
  var dbase = new Array();
  var dbsel = false;
  for(var i=0, j=0; i < dbfld.length; i++ )
  {
     if(dbfld[i].checked) { dbsel=true; dbase[j] = dbfld[i].value; j++; }
  }
  if(!dbsel) { msg += "\n Please, check at least 1 database";  error = true; }

  // retreive Sport types
  var sportfld = document.all.Sport
  var sport = new Array();
  var sportsel = false;
  for(var i=0, j=0; i < sportfld.length; i++ )
  {
     if(sportfld[i].checked) { sportsel=true; sport[j] = sportfld[i].value; j++; }
  }
  //if(!sportsel) { msg += "\n Please, check at least 1 sport";  error = true; }


  var stores = document.all.Store;
  var radius = document.all.Radius;
  var str = new Array();
  var rad = new Array();
  var action;

  // at least 1 store must be selected
  var strsel = false;
  var radNaNSel = false;
  var radMinSel = false;
  var radMaxSel = false;

  for(var i=0, j=0; i < stores.length; i++ )
  {
     var strcnt = "STR" + stores[i].value;
     document.all[strcnt].innerHTML = "";

     if(stores[i].checked)
     {
        strsel=true;  str[j] = stores[i].value;
        // Check selected Mile Radius
        if (isNaN(radius[i].value)){ radNaNSel = true; }
        else if (radius[i].value < 1){ radMinSel = true; }
        else if (radius[i].value > 500){ radMaxSel = true; }
        else { rad[j] = radius[i].value; }

        j++;
     }
  }

  document.all.Total.innerHTML = "";


  //if(!strsel) { msg += "\n Please, check at least 1 store";  error = true; }
  if (radNaNSel){ msg += "\n Miles radius must be numeric";  error = true; }
  if (radMinSel){ msg += "\n Miles radius is to small. Minimum radius is 1 mile";  error = true; }
  if (radMaxSel){ msg += "\n Miles radius is to big. Maximum radius is 100 miles";  error = true; }

  // retreive Result address
  var addrfld = document.all.Addr
  var addr = new Array();
  var addrsel = false;
  for(var i=0, j=0; i < addrfld.length; i++ )
  {
     if(addrfld[i].checked){ addrsel=true;  addr[j] = addrfld[i].value; j++; }
  }
  if(!addrsel) { msg += "\n Please, check at least 1 result address";  error = true; }

  var comment = document.all.Comment.value.trim()
  if(downl && comment.trim()=="") { msg += "\n Please, enter comment for download file";  error = true; }

  if (error) alert(msg);
  else{ sbmPlan(str, sport, dbase, rad, addr, comment, downl) }
  return error == false;
}
//==============================================================================
// Submit OTB Planning
//==============================================================================
function sbmPlan(str, sport, dbase, rad, addr, comment, downl)
{
  var url = "CustList.jsp?"

  // selected store
  for(var i=0; i < str.length; i++){  url += "&Store=" + str[i] }
  // selected database
  for(var i=0; i < sport.length; i++){  url += "&Sport=" + sport[i] }
  // selected database
  for(var i=0; i < dbase.length; i++){  url += "&Dbase=" + dbase[i] }
  // selected radius (different for each store)
  for(var i=0; i < str.length; i++){  url += "&Radius=" + rad[i] }

  // selected database
  for(var i=0; i < addr.length; i++){  url += "&Addr=" + addr[i] }

  url += "&Comment=" + comment

  if(downl) { url += "&Downl=Y"}
  else { url += "&Downl=N" }

  //alert(url)
  //window.location.href=url;
  window.frame1.location.href=url;
}
//==============================================================================
// Submit OTB Planning
//==============================================================================
function popStrCount(str, totNumOfCust, total)
{
   var stores = document.all.Store;
   for(var i=0; i < stores.length; i++ )
   {
      for(var j=0; j < str.length; j++ )
        {
         if(str[j] == stores[i].value)
         {
            var strcnt = "STR" + str[j];
            document.all[strcnt].innerHTML = totNumOfCust[j]
         }
      }
   }
   document.all.Total.innerHTML = total;
}

</script>

<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<HTML><HEAD><meta http-equiv="refresh">

<META content="Microsoft FrontPage 4.0" name=GENERATOR></HEAD>
<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe id="frame1" src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="tooltip2" style="position:absolute;visibility:hidden;background-color:LemonChiffon; z-index:10"></div>

<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Customer List - Selection</B>
        <br><a href="index.jsp" class="Small">Home</a>&nbsp; &nbsp; &nbsp;
            <a href="CmDownLst.jsp" target="_blank" class="Small">List of Downloads</a>

      <TABLE>
        <TBODY>

        <!-- =============================================================== -->
        <TR class="Divider"><TD>&nbsp</TD></tr>

        <TR>
          <TD class="Cell" nowrap><b><u>Database:</u></b></TD>
           <TD class="Sect">
              <input name="Dbase" type="checkbox" value="SASS" checked>Sun & Ski &nbsp;&nbsp;&nbsp;
              <input name="Dbase" type="checkbox" value="SKCH" checked>Ski Chalet &nbsp;&nbsp;&nbsp;
              <input name="Dbase" type="checkbox" value="SSTP" checked>Ski Stops &nbsp;&nbsp;&nbsp;
              <input name="Dbase" type="checkbox" value="ECOM" checked>E-Commerce &nbsp;&nbsp;&nbsp;
          </TD>
        </TR>
        <!-- =============================================================== -->
        <TR class="Divider"><TD>&nbsp</TD></tr>

        <TR>
          <TD class="Cell" nowrap><b><u>Sport:</u></b></TD>
           <TD class="Sect">
             <table>
                  <%for(int i=0, j=0; i < iNumOfCol; i++, j++){%>
                    <%if(j==0){%><tr><%}%>
                      <td class="Cell1" nowrap><input name="Sport" type="checkbox" value="<%=sCol[i]%>"><%=sColNm[i]%> &nbsp;&nbsp;&nbsp;
                    <%if(j==4){ j=-1; }%>
                  <%}%>

             </table>

             <button class="Small" onclick="checkSport(true)">All</button> &nbsp; &nbsp; &nbsp;
             <button class="Small" onclick="checkSport(false)">None</button>
          </TD>
        </TR>
        <!-- =============================================================== -->
        <TR>
          <TD class="Cell"><b><u>Store:</u></b></TD>
          <TD class="Sect">
          <table class="DataTable" border=1 width="100%" cellPadding="0" cellSpacing="0">
               <tr>
                  <td class="Cell2">Store</td>
                  <td class="Cell2">Radius</td>
                  <td class="Cell2">Count</td>
               </tr>
               <%for(int i=0; i<iNumOfStr; i++) {%>
                 <tr>
                   <td class="Cell1"><input name="Store" type="checkbox" class="Small" value="<%=sStr[i]%>"><%=sStr[i]%> - <%=sStrName[i]%></td>
                   <td class="Cell1"><input name="Radius" class="Small" value="10" maxlength=3 size=3></td>
                   <td class="Cell" id="STR<%=sStr[i].trim()%>">&nbsp;</td>
                 </tr>
             <%}%>
             <tr class="Total">
                <td class="Cell1">Total</td>
                <td class="Cell1">&nbsp;</td>
                <td class="Cell" id="Total">&nbsp;</td>
             </tr>
          </table>
             <br>
             <button class="Small" onclick="checkStr(true)">All</button> &nbsp; &nbsp; &nbsp;
             <button class="Small" onclick="checkStr(false)">None</button>
          </TD>
        </TR>
        <!-- =============================================================== -->
        <TR class="Divider"><TD>&nbsp</TD></tr>

        <TR>
          <TD class="Cell" nowrap><b><u>Result</u></b></TD>
           <TD class="Sect">
              <input name="Addr" type="checkbox" value="POST" checked>Post Address &nbsp;&nbsp;&nbsp;
              <input name="Addr" type="checkbox" value="EMAIL">E-Mail Address &nbsp;&nbsp;&nbsp;
          </TD>
        </TR>
        <!-- =============================================================== -->
        <TR>
            <TD></TD>
            <TD align=center colSpan=5>
               Comment: <input class="Small" name="Comment" maxlength=50 size=50><br>
               <button onClick="Validate(false)">Count</button>
               <button onClick="Validate(true)">Download</button>
           </TD>
          </TR>
         </TBODY>
        </TABLE>
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
<%}%>