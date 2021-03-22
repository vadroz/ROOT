<%@ page import="rciutility.SetDivList, rciutility.StoreSelect"%>
<%
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null )
   {
     response.sendRedirect("SignOn1.jsp?TARGET=ItemBSRMissingSel.jsp&APPL=ALL");
   }
   else
   {
      SetDivList divlst = new SetDivList();
      divlst.getDivFromAs400();
      int iNumOfDiv = divlst.getNumOfDiv();
      String [] sDiv = divlst.getDiv();
      String [] sDivName = divlst.getDivName();

      StoreSelect strsel = new StoreSelect(9);
      int iNumOfStr = strsel.getNumOfStr();
      String [] sStr = strsel.getStrLst();
%>

<style>
  .Small {font-family: times; font-size:10px }
  td.Cell {font-size:12px; text-align:right; vertical-align:top}
  td.Cell1 {font-size:12px; text-align:left; vertical-align:top}
  td.Cell2 {font-size:12px; text-align:center; vertical-align:top}
  div.dvVendor { position:absolute; visibility:hidden; border: gray solid 1px;
        width:300; height:250;background-color:white; z-index:10; text-align:left; font-size:10px}
  div.dvInternal { overflow: auto;border: none; width:300; height:220;
                   background-color:white; z-index:10; text-align:left; font-size:10px}
  .Small { text-align:center; font-size:10px }
  </style>

<script LANGUAGE="JavaScript1.2" src="Calendar.js">
</script>


<script name="javascript">
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
}
//==============================================================================
// Validate form
//==============================================================================
function Validate()
{
  var error = false;
  var msg = " ";

  var divisions = document.all.Div;
  var div = new Array();
  // at least 1 store must be selected
  var divsel = false;
  for(var i=0, j=0; i < divisions.length; i++ )
  {
     if(divisions[i].checked)
     {
        divsel=true;
        div[j] = divisions[i].value;
        j++;
     }
  }
  if(!divsel) {  msg += "\n Please, select at least 1 division";  error = true;  }


  var stores = document.all.ExpStr;
  var estr = null;
  // at least 1 store must be selected
  var strsel = false;
  for(var i=0; i < stores.length; i++ )
  {
     if(stores[i].checked)
     {
        strsel=true;
        estr = stores[i].value;
        break;
     }
  }
  if(!strsel) {  msg += "\n Please, select examplary store";  error = true;  }

  stores = document.all.ChkStr;
  var cstr = new Array();
  // at least 1 store must be selected
  var strsel = false;
  for(var i=0, j=0; i < stores.length; i++ )
  {
     if(stores[i].checked)
     {
        strsel=true;
        cstr[j] = stores[i].value;
        j++;
     }
  }

  if(!strsel) { msg += "\n Please, check at least 1 store";  error = true; }

  if (error) alert(msg);
  else{ sbmSlsRep(div, estr, cstr) }
  return error == false;
}
//==============================================================================
// Submit OTB Planning
//==============================================================================
function sbmSlsRep(div, estr, cstr)
{
  var url = null;
  url = "ItemMissBSR.jsp?"
    + "Example=" + estr

  for(var i=0; i < div.length; i++)
  {
     url += "&Div=" + div[i]
  }

  // selected store
  for(var i=0; i < cstr.length; i++)
  {
     url += "&Str=" + cstr[i]
  }

  //alert(url)
  window.location.href=url;
}

//==============================================================================
// reset All Division
//==============================================================================
function resetDiv(chk)
{
   var div = document.all.Div;
   for(var i=0; i < <%=iNumOfDiv%> ; i++) { div[i].checked = chk; }
}
//==============================================================================
// check/uncheck All Store
//==============================================================================
function resetChkStr(chk)
{
   var str = document.all.ChkStr;
   for(var i=0; i < <%=iNumOfStr%> ; i++) { str[i].checked = chk; }
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
<!-------------------------------------------------------------------->
<div id="dvVendor" class="dvVendor"></div>
<!-------------------------------------------------------------------->
<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <!--TR><TD height="20%"><IMG src="Sun_ski_logo4.png"></TD></TR -->

  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Item List with Missing BSR Level - Selection</B>
        <br><a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;<font size="-1">This Page</font>

      <TABLE>
        <TBODY>
        <!-- ------------- Division  --------------------------------- -->
        <TR>
          <TD class="Cell2" colspan=4><b><u>Divisions</u></b></TD>
        <TR>
          <TD class="Cell1" colspan=4>
             <%for(int i=0; i<iNumOfDiv; i++) {%>
               <input name="Div" type="checkbox" value="<%=sDiv[i]%>"><%=sDiv[i]%>&nbsp;&nbsp;
               <%if(i == 15) {%><br><%}%>
             <%}%>
             <br>
             <button class="small" onClick="resetDiv(false)">Reset Divisions</button>
          </TD>
        </TR>

        <!-- ===================== Examplary Store ========================= -->
        <TR><TD style="background:darkred; font-size:1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
          <TD class="Cell2" colspan=4><b><u>Examplary Stores</u></b></TD>
        <TR>
          <TD class="Cell1" colspan=4>
             <%for(int i=0; i<iNumOfStr; i++) {%>
               <input name="ExpStr" type="radio" value="<%=sStr[i]%>"><%=sStr[i]%>&nbsp;&nbsp;
               <%if(i == 15) {%><br><%}%>
             <%}%>
          </TD>
        </TR>
        <!-- ======================Checked Stores ========================== -->
        <TR><TD style="background:darkred; font-size:1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
          <TD class="Cell2" colspan=4><b><u>Checked Stores</u></b></TD>
        <TR>
          <TD class="Cell1" colspan=4>
             <%for(int i=0; i<iNumOfStr; i++) {%>
               <input name="ChkStr" type="checkbox" value="<%=sStr[i]%>"><%=sStr[i]%>&nbsp;&nbsp;
               <%if(i == 15) {%><br><%}%>
             <%}%>
             <br>
             <button class="small" onClick="resetChkStr(false)">Reset Store</button>
          </TD>
        </TR>

        <!-- =============================================================== -->
        <TR><TD style="background:darkred; font-size:1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
        <TR>
            <TD></TD>
            <TD class="Cell2" colSpan=4>
               <INPUT type=submit value=Submit name=SUBMIT onClick="Validate()">  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
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