<%@ page import="rciutility.StoreSelect, rciutility.ConvertToJsArray, java.util.*"%>
<%
   String [] sSelStr = request.getParameterValues("Str");
   String [] sSelType = request.getParameterValues("Type");
   String [] sSelSts = request.getParameterValues("Sts");
   String sPOSts = request.getParameter("POSts");
   String sFrDate = request.getParameter("From");
   String sToDate = request.getParameter("To");
   String sSelAckn = request.getParameter("Ackn");
   String [] sSelIss = request.getParameterValues("IssFlg");
   String sSort = request.getParameter("Sort");

   boolean bSetParam = sSelStr != null;
   //----------------------------------
   // Application Authorization
   //----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=SpecOrdLstSel.jsp&APPL=ALL");
}
else
{
    String sStrAllowed = session.getAttribute("STORE").toString();
    String sUser = session.getAttribute("USER").toString();
    StoreSelect strlst = null;
    int iStrAlwLst = 0;

    if (sStrAllowed != null && sStrAllowed.startsWith("ALL"))
    {
      strlst = new StoreSelect(5);
    }
    else
    {
     Vector vStr = (Vector) session.getAttribute("STRLST");
     String [] sStrAlwLst = new String[ vStr.size()];
     Iterator iter = vStr.iterator();

     while (iter.hasNext()){ sStrAlwLst[iStrAlwLst] = (String) iter.next(); iStrAlwLst++; }

     if (vStr.size() > 1) { strlst = new StoreSelect(sStrAlwLst); }
     else strlst = new StoreSelect(new String[]{sStrAllowed});
    }

    String sStrJsa = strlst.getStrNum();
    String sStrNameJsa = strlst.getStrName();

    int iNumOfStr = strlst.getNumOfStr();
    String [] sStr = strlst.getStrLst();

    String [] sStrRegLst = strlst.getStrRegLst();
    String sStrRegJsa = strlst.getStrReg();

    String [] sStrDistLst = strlst.getStrDistLst();
    String sStrDistJsa = strlst.getStrDist();
    String [] sStrDistNmLst = strlst.getStrDistNmLst();
    String sStrDistNmJsa = strlst.getStrDistNm();

    String [] sStrMallLst = strlst.getStrMallLst();
    String sStrMallJsa = strlst.getStrMall();

    String sSelStrJsa = " ";
    String sSelTypeJsa = " ";
    String sSelStsJsa = " ";
    String sSelIssJsa = " ";
    if(bSetParam)
    {
      ConvertToJsArray cvtjsa = new ConvertToJsArray();
      sSelStrJsa = cvtjsa.cvtToJavaScriptArray(sSelStr);
      sSelTypeJsa = cvtjsa.cvtToJavaScriptArray(sSelType);
      sSelStsJsa = cvtjsa.cvtToJavaScriptArray(sSelSts);
      sSelIssJsa = cvtjsa.cvtToJavaScriptArray(sSelIss);
    }
%>

<style>
  .Small {font-family: times; font-size:10px }
  .Small1 {font-family: times; font-size:10px; text-transform:uppercase; }

  td.Cell {font-size:12px; text-align:right; vertical-align:top}
  td.Cell1 {font-size:12px; text-align:left; vertical-align:top}
  td.Cell2 {font-size:12px; text-align:center; vertical-align:top; font-weight:bold;text-decoration:underline}
  td.Cell3 {font-size:12px; text-align:center; vertical-align:top}
  td.Cell4 {font-size:12px; text-align:center; vertical-align:top; font-weight:bold;}

  div.dvVendor { position:absolute; visibility:hidden; border: gray solid 1px;
                 width:300; height:250;background-color:white; z-index:10; text-align:left; font-size:10px}
  div.dvInternal { overflow: auto;border: none; width:300; height:220;
                   background-color:white; z-index:10; text-align:left; font-size:10px}
  </style>

<script LANGUAGE="JavaScript1.2" src="Calendar.js">
</script>


<script name="javascript">
var stores = [<%=sStrJsa%>];
var storeNames = [<%=sStrNameJsa%>];

var ArrStr = [<%=sStrJsa%>];
var ArrStrReg = [<%=sStrRegJsa%>];
var ArrStrDist = [<%=sStrDistJsa%>];
var ArrStrDistNm = [<%=sStrDistNmJsa%>];
var ArrStrMall = [<%=sStrMallJsa%>];

// if return from the list with parameters
var SelStr = [<%=sSelStrJsa%>];
var SelType = [<%=sSelTypeJsa%>];
var SelSts = [<%=sSelStsJsa%>];
var SelIss = [<%=sSelIssJsa%>];

//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   showAllDates(1);

   <%if(!bSetParam){%>
       <%if(iNumOfStr > 1) {%>setAll(true);<%} else {%>document.all.Str.checked=true<%}%>
   <%} else {%>setParam();<%}%>
}
//==============================================================================
// set previously selected parameters
//==============================================================================
function setParam()
{
   var str = document.all.Str;
   for(var i=0; i < str.length; i++)
   {
      str[i].checked = false;
      for(var j=0; j < SelStr.length; j++)
      {
         if(str[i].value == SelStr[j]) { str[i].checked = true; }
      }
   }

   var type = document.all.Type;
   for(var i=0; i < type.length; i++)
   {
      type[i].checked = false;
      for(var j=0; j < SelType.length; j++)
      {
         if(type[i].value == SelType[j]) { type[i].checked = true; }
      }
   }

   var sts = document.all.Sts;
   for(var i=0; i < sts.length; i++)
   {
      sts[i].checked = false;
      for(var j=0; j < SelSts.length; j++)
      {
          if(sts[i].value == SelSts[j]) { sts[i].checked = true; }
      }
   }

   var posts = document.all.POSts;
   var selPosts = "<%=sPOSts%>";
   for(var i=0; i < posts.length; i++)
   {
       posts[i].checked = false;
       if(posts[i].value == selPosts){posts[i].checked = true; }
   }

   var from = "<%=sFrDate%>";
   var to = "<%=sToDate%>";
   if(from!="ALLDAYS")
   {
        document.all.OrdFrDate.value = from;
        document.all.OrdToDate.value = to;
        document.all.tdDate1.style.display="none"
        document.all.tdDate2.style.display="block"
   }

   var iss = document.all.IssFlg;
   for(var i=0, j=0; i < iss.length; i++)
   {
      iss[i].checked == false;
      j = eval(iss[i].value ) - 1;
      if(SelIss[j] == "Y"){ iss[i].checked = true; }
   }

   var ackn = document.all.Ackn;
   var selAckn = "<%=sSelAckn%>";
   for(var i=0; i < ackn.length; i++)
   {
       ackn[i].checked = false;
       if(ackn[i].value == selAckn){ackn[i].checked = true; }
   }
}
//==============================================================================
// set all store or unmark
//==============================================================================
function setAll(on)
{
   var str = document.all.Str;
   for(var i=0; i < str.length; i++) { str[i].checked = on; }
}
//==============================================================================
// check by regions
//==============================================================================
function checkReg(dist)
{
  var str = document.all.Str
  var chk1 = false;
  var chk2 = false;

  // check 1st selected group check status and save it
  var find = false;
  for(var i=0; i < str.length; i++)
  {
     for(var j=0; j < ArrStr.length; j++)
     {
        if(dist != "PATIO" && str[i].value == ArrStr[j] && ArrStrReg[j] == dist
          || (dist == "PATIO" && (str[i].value == "35" || str[i].value == "46"
          || str[i].value == "50" || str[i].value == "63" || str[i].value == "64"
          || str[i].value == "68" || str[i].value == "86")))
        {
          chk1 = !str[i].checked;
          find = true;
          break;
        };
     }
     if (find){ break;}
  }
  chk2 = !chk1;

  for(var i=0; i < str.length; i++)
  {
     str[i].checked = chk2;
     for(var j=0; j < ArrStr.length; j++)
     {
        if(dist != "PATIO" && str[i].value == ArrStr[j] && ArrStrReg[j] == dist
          || (dist == "PATIO" && (str[i].value == "35" || str[i].value == "46"
          || str[i].value == "50" || str[i].value == "63" || str[i].value == "64"
          || str[i].value == "68" || str[i].value == "86")))
        {
           str[i].checked = chk1;
        };
     }
  }
}

//==============================================================================
// check by districts
//==============================================================================
function checkDist(dist)
{
  var str = document.all.Str
  var chk1 = false;
  var chk2 = false;

  // check 1st selected group check status and save it
  var find = false;
  for(var i=0; i < str.length; i++)
  {
     for(var j=0; j < ArrStr.length; j++)
     {
        if(str[i].value == ArrStr[j] && ArrStrDist[j] == dist)
        {
          chk1 = !str[i].checked;
          find = true;
          break;
        };
     }
     if (find){ break;}
  }
  chk2 = !chk1;

  for(var i=0; i < str.length; i++)
  {
     str[i].checked = chk2;
     for(var j=0; j < ArrStr.length; j++)
     {
        if(str[i].value == ArrStr[j] && ArrStrDist[j] == dist)
        {
           str[i].checked = chk1;
        };
     }
  }
}

//==============================================================================
// check mall
//==============================================================================
function checkMall(type)
{
  var str = document.all.Str
  var chk1 = true;
  var chk2 = false;

  for(var i=0; i < str.length; i++)
  {
     str[i].checked = chk2;
     for(var j=0; j < ArrStr.length; j++)
     {
        if(str[i].value == ArrStr[j] && ArrStrMall[j] == type)
        {
           str[i].checked = chk1;
        };
     }
  }
}

//==============================================================================
// show date selection
//==============================================================================
function showDates(type)
{
   if(type==1)
   {
     document.all.tdDate1.style.display="none"
     document.all.tdDate2.style.display="block"
   }
   doSelDate(type)
}
//==============================================================================
// show optional date selection button
//==============================================================================
function showAllDates(type)
{
   if(type==1)
   {
      document.all.tdDate1.style.display="block"
      document.all.tdDate2.style.display="none"
      document.all.OrdFrDate.value = "ALLDAYS"
      document.all.OrdToDate.value = "ALLDAYS"
   }
   else
   {
      document.all.ShpFrDate.value = "ALL"
      document.all.ShpToDate.value = "ALL"
   }
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function doSelDate(type)
{
  var df = document.all;
  var date = new Date(new Date() - 86400000);
  date.setHours(18);

  if(type==1)
  {
    df.OrdFrDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
    df.OrdToDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
  }
  else
  {
    df.ShpFrDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
    df.ShpToDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
  }
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function  setDate(direction, id, numdays)
{
  var button = document.all[id];
  var date = new Date(button.value);


  if(direction == "DOWN") date = new Date(new Date(date) - 86400000 * numdays);
  else if(direction == "UP") date = new Date(new Date(date) - -86400000 * numdays);
  button.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}


//==============================================================================
// Validate form
//==============================================================================
function Validate()
{
  var error = false;
  var msg = "";

  //selected store
  var str = new Array();
 <%if(iNumOfStr > 1) {%>
  var strbox = document.all.Str
  var chkstr = false;
  for(var i=0, j=0; i < strbox.length; i++)
  {
     if(strbox[i].checked){ str[j] = strbox[i].value; chkstr = true; j++}
  }
  if(!chkstr){ msg +="\nCheck at least 1 store."; error = true; }
 <%}
 else {%>
  str[0] = document.all.Str.value; document.all.Str.checked = true;
 <%}%>

   // selected status
  var ordtype = new Array();
  sel = false
  for (var i=0, j=0; i < document.all.Type.length; i++)
  {
     if(document.all.Type[i].checked)
     {
       ordtype[j] = document.all.Type[i].value;
       sel = true;
       j++;
     }
  }
  if(!sel) {error = true; msg += "\nSelect at least 1 order type"}

  // selected status
  var sts = new Array();
  sel = false
  for (var i=0, j=0; i < document.all.Sts.length; i++)
  {
     if(document.all.Sts[i].checked)
     {
       sts[j] = document.all.Sts[i].value;
       sel = true;
       j++;
     }
  }
  if(!sel) {error = true; msg += "\nSelect at least 1 status"}

  var posts = null;
  for (var i=0; i < document.all.POSts.length; i++)
  {
     if(document.all.POSts[i].checked) { posts = document.all.POSts[i].value }
  }

  // order date
  var ordfrdate = document.all.OrdFrDate.value;
  var ordtodate = document.all.OrdToDate.value;

  var issflg = new Array(document.all.IssFlg.length);
  for (var i=0; i < document.all.IssFlg.length; i++)
  {
     if(document.all.IssFlg[i].checked) { issflg[i] = "Y"; }
     else { issflg[i] = "N"; }
  }

  // Approved
  var ackn = null;
  for (var i=0; i < document.all.Ackn.length; i++)
  {
     if(document.all.Ackn[i].checked) { ackn = document.all.Ackn[i].value; break; }
  }

  // Employeeor Store sales
  var empsls = null;
  for (var i=0; i < document.all.EmpSls.length; i++)
  {
     if(document.all.EmpSls[i].checked) { empsls = document.all.EmpSls[i].value; break; }
  }

  if (error) alert(msg);
  else{ sbmOrdList(str, ordtype, sts, posts, ordfrdate, ordtodate, ackn, issflg, empsls) }
  return error == false;
}
//==============================================================================
// Submit OTB Planning
//==============================================================================
function sbmOrdList(str, ordtype, sts, posts, ordfrdate, ordtodate, ackn, issflg, empsls)
{
  var url = null;
  url = "SpecOrdLst.jsp?&POSts=" + posts
       + "&From=" + ordfrdate
       + "&To=" + ordtodate
       + "&Ackn=" + ackn
       + "&EmpSls=" + empsls

  for(var i=0; i < str.length; i++) { url += "&Str=" + str[i] }

  for(var i=0; i < ordtype.length; i++) { url += "&Type=" + ordtype[i] }
  for(var i=0; i < sts.length; i++)
  {
    url += "&Sts=" + sts[i]
    if(sts[i] == "C") { url += "&Sts=R"; } // add received ror closed
  }

  for(var i=0; i < issflg.length; i++)
  {
    url += "&IssFlg=" + issflg[i]
  }

  //alert(url)
  window.location.href=url;
}
//==============================================================================
// check All Types
//==============================================================================
function chkTypeAll(chko)
{
   var type = document.all.Type;
   var mark = false;
   var alltype = chko.name == "TypeAll";

   if (chko.checked) mark = true;
   if (alltype)
   {
      for(var i=0; i < type.length; i++) { type[i].checked = mark }
      document.all.TypeAllOrd.checked = false;
   }
   else
   {
      for(var i=0; i < type.length; i++) { type[i].checked = false; }
      type[0].checked = mark;
      type[1].checked = mark;
      type[3].checked = mark;
      document.all.TypeAll.checked = false;
   }
}
//==============================================================================
// check All Status
//==============================================================================
function chkStsAll(chko)
{
   var sts = document.all.Sts;
   var mark = false;
   if (chko.checked) mark = true;
   for(var i=0; i < sts.length; i++)
   {
      if(sts[i].value != "P" && sts[i].value != "N"){ sts[i].checked = mark }
   }
}
//==============================================================================
// check All types
//==============================================================================
function checkAllTypes(chk)
{
   var type = document.all.Type;
   if(chk=="ALL")
   {
      for(var i=0; i < type.length; i++){ type[i].checked = true;}
   }
   if(chk=="NONE")
   {
      for(var i=0; i < type.length; i++){ type[i].checked = false;}
   }
   if(chk=="ALLSOBSSO")
   {
      for(var i=0; i < type.length; i++){ type[i].checked = false;}
      type[0].checked = true;
      type[1].checked = true;
   }
}
//==============================================================================
// uncheck issue flags
//==============================================================================
function selAnyIssFlg(chk)
{
   //  uncheck any
   var chkbx = document.all.IssFlg;
   for(var i=0; i < chkbx.length; i++)
   {
      chkbx[i].checked = chk;
   }
}
//==============================================================================
// show Order Info
//==============================================================================
function ValidateOrd()
{
    var error=false;
    var msg="";
	
	var str=document.all.SelStr.value.trim();
    var ord=document.all.SelOrd.value.trim();
    
    if(str==""){error=true; msg += "\nPlease type store number.";}
    else if(isNaN(str)){error=true; msg += "\nStore is not a valid number.";}
    
    if(ord==""){error=true; msg += "\nPlease type Order number.";}
    else if(isNaN(ord)){error=true; msg += "\nOrder is not a valid number.";}
    
    if(error){alert(msg)}
    else{ sbmSngOrd(str, ord); }
}
//==============================================================================
//show single order
//==============================================================================
function sbmSngOrd(str, ord)
{
	var url="SpecOrdInfo.jsp?Str=" + str 
	 + "&Ord=" + ord;
	window.location.href=url;
}
</script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>


<HTML><HEAD><meta http-equiv="refresh">

</HEAD>
<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<div id="dvVendor" class="dvVendor"></div>
<!-------------------------------------------------------------------->
<iframe id="frame1" src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>CP POS Order List - Selection</B>
        <br><a href="../" class="small"><font color="red">Home</font></a>

      <TABLE border=0>
        <TBODY>
        <!-- =================== Go to order ================================ -->
        <TR>
            <TD class="Cell3" colspan=5>
               Store &nbsp; <input name="SelStr" maxlength=2 size=5> &nbsp; &nbsp;
               Order &nbsp; <input name="SelOrd" maxlength=10 size=12> &nbsp; &nbsp;
               <button onclick="ValidateOrd()")>Go</button>
            </TD>
        </tr>
        
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="5" >&nbsp;</TD></TR>
        <TR>
            <TD class="Cell2" colspan=5>Store Selection</TD>
        </tr>
        <tr>
            <TD class="Cell1">&nbsp;</td>
            <TD class="Cell1" nowrap>
              <%for(int i=0; i < iNumOfStr; i++){%>
                  <input name="Str" type="checkbox" value="<%=sStr[i]%>"><%=sStr[i]%>&nbsp;
                  <%if(i > 0 && i % 14 == 0){%><br><%}%>
              <%}%>
              <%if(iNumOfStr > 1) {%>
              <br><button class="Small" onClick="setAll(true)">All Store</button> &nbsp;

              <button onclick='checkReg(&#34;1&#34;)' class='Small'>Dist 1</button> &nbsp; &nbsp;
              <button onclick='checkReg(&#34;2&#34;)' class='Small'>Dist 2</button> &nbsp; &nbsp;
              <button onclick='checkReg(&#34;3&#34;)' class='Small'>Dist 3</button> &nbsp; &nbsp;
              <button onclick='checkReg(&#34;99&#34;)' class='Small'>Dist 99</button> &nbsp; &nbsp;
              <button onclick='checkReg(&#34;PATIO&#34;)' class='Small'>Patio</button> &nbsp; &nbsp;
              <br>
              <button onclick='checkDist(&#34;9&#34;)' class='Small'>Houston</button> &nbsp; &nbsp;
              <button onclick='checkDist(&#34;20&#34;)' class='Small'>Dallas/FtW</button> &nbsp; &nbsp;
              <button onclick='checkDist(&#34;35&#34;)' class='Small'>Ski Chalet</button> &nbsp; &nbsp;
              <button onclick='checkDist(&#34;38&#34;)' class='Small'>Boston</button> &nbsp; &nbsp;
              <button onclick='checkDist(&#34;41&#34;)' class='Small'>OKC</button> &nbsp; &nbsp;
              <button onclick='checkDist(&#34;52&#34;)' class='Small'>Charl</button> &nbsp; &nbsp;
              <button onclick='checkDist(&#34;53&#34;)' class='Small'>Nash</button> &nbsp; &nbsp;
              <br>
              <button onclick='checkMall(&#34;&#34;)' class='Small'>Mall</button> &nbsp; &nbsp;
              <button onclick='checkMall(&#34;NOT&#34;)' class='Small'>Non-Mall</button> &nbsp; &nbsp;

              <button class="Small" onClick="setAll(false)">Reset</button><br><br>
              <%}%>
        </TR>
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="5" >&nbsp;</TD></TR>
        <TR>
            <TD class="Cell2" colspan=5>Order Types</TD>
        </tr>
        <tr>
            <TD class="Cell1"> &nbsp;</td>
            <TD class="Cell1">
                <input class="Small" name="Type" type="checkbox" value="SO" checked>Special Order(SO) &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                <input class="Small" name="Type" type="checkbox" value="BSSO" checked>Bike Shop Repair Special Order(BSSO)&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            <br><input class="Small" name="Type" type="checkbox" value="ST">Special Transfer(ST)&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                <input class="Small" name="Type" type="checkbox" value="BSRO">Bike Shop Requisition Order(BSRO)
            <br><button class="Small" onclick="checkAllTypes('ALL')">All</button>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                <button class="Small" onclick="checkAllTypes('ALLSOBSSO')">All SO + BSSO</button>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                <button class="Small" onclick="checkAllTypes('NONE')">Reset</button>
        </TR>

        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="5" >&nbsp;</TD></TR>
        <TR>
            <TD class="Cell2" colspan=5>Order Statuses</TD>
        </tr>
        <tr>
            <TD class="Cell2" colspan=5>
              <input class="Small" onclick="chkStsAll(this)" name="StsAll" type="checkbox" value="All">All
        <tr>
            <TD class="Cell3" colspan=5>
              <input class="Small" name="Sts" type="checkbox" value="O" checked>Open &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
              <input class="Small" name="Sts" type="checkbox" value="C">Closed &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
              <input class="Small" name="Sts" type="checkbox" value="X">Canceled &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        </TR>


        <!-- =======================Cmments Approved ======================= -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="5" >&nbsp;</TD></TR>
        <TR>
            <TD class="Cell2" colspan=5>Comments Approved?</TD>
        </tr>
        <tr>
            <TD class="Cell3" colspan=5>
              <input class="Small" name="Ackn" type="radio" value="1">Approved &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
              <input class="Small" name="Ackn" type="radio" value="2">UNapproved &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
              <input class="Small" name="Ackn" type="radio" value="3" checked>Both &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        </tr>

        <!-- ========================= Issue Flags ========================= -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="5" >&nbsp;</TD></TR>
        <TR>
            <TD class="Cell2" colspan=5>Issue Flags</TD>
        </tr>
        <tr>
            <TD class="Cell3" colspan=5>
              <input class="Small" name="IssFlg" type="checkbox" value="1" >Canceled &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
              <input class="Small" name="IssFlg" type="checkbox" value="2" >No Shipping &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
              <input class="Small" name="IssFlg" type="checkbox" value="3" >GM% &#60; 40 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
              <input class="Small" name="IssFlg" type="checkbox" value="4" >Discount &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
              <br><br>Click All, to select <u>only</u> orders that have Issue Flags
              <br><button class="Small" type="checkbox" onclick="selAnyIssFlg(true)">All</button>
              &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
              &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                  <button class="Small" type="checkbox" onclick="selAnyIssFlg(false)">Reset</button>

        </tr>

        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="5" >&nbsp;</TD></TR>
        <TR>
            <TD class="Cell2" colspan=5>Vendor Order Placed</TD>
        </tr>
        <tr>
            <TD class="Cell3" colspan=5>
               <input class="Small" name="POSts" type="radio" value="P">PO Placed &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
               <input class="Small" name="POSts" type="radio" value="N">PO Not Placed
               <span style="font-size:10px;">(Or flagged as not ordered)</span>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
               <input class="Small" name="POSts" type="radio" value="A" checked>All
            </td>
        </tr>

        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="5" >&nbsp;</TD></TR>
        <TR>
            <TD class="Cell2" colspan=5>Employee Sales and Shop Orders</TD>
        </tr>
        <tr>
            <TD class="Cell3" colspan=5>
               <input class="Small" name="EmpSls" type="radio" value="E">Exclude &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
               <input class="Small" name="EmpSls" type="radio" value="I">Include &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
               <input class="Small" name="EmpSls" type="radio" value="B" checked>Both
            </td>
        </tr>

        <!-- ============== select Order changes ========================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="5" >&nbsp;</TD></TR>
        <TR><TD class="Cell2" colspan=5>Select order dates when item was added or modified</TD></tr>

        <TR>
          <TD id="tdDate1" colspan=4 align=center style="padding-top: 10px;" >
             <button id="btnSelDates" onclick="showDates(1)">Optional Order Date Selection</button>
          </td>
          <TD id="tdDate2" colspan=4 align=center style="padding-top: 10px;" >
             <b>From Date:</b>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'OrdFrDate', 10)">&#60;&#60;</button>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'OrdFrDate', 1)">&#60;</button>
              <input class="Small" name="OrdFrDate" type="text" value="MONTH" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'OrdFrDate', 1)">&#62;</button>
              <button class="Small" name="Up" onClick="setDate('UP', 'OrdFrDate', 10)">&#62;&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 200, 400, document.all.OrdFrDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>

              <%for(int i=0; i < 20; i++){%>&nbsp;<%}%>

              <b>To Date:</b>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'OrdToDate', 10)">&#60;&#60;</button>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'OrdToDate', 1)">&#60;</button>
              <input class="Small" name="OrdToDate" type="text" value="MONTH" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'OrdToDate', 1)">&#62;</button>
              <button class="Small" name="Up" onClick="setDate('UP', 'OrdToDate', 10)">&#62;&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 200, 400, document.all.OrdToDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a><br>
              <button id="btnSelDates" onclick="showAllDates(1)">All Days</button>
          </TD>
        </TR>
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="5" >&nbsp;</TD></TR>
        <TR>
            <TD align=center colSpan=5>
               <INPUT type=submit value=Submit name=SUBMIT onClick="Validate()">
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