<%@ page import="rtvregister.MrVendforStr"%>
<%
      String sVendor = request.getParameter("Vendor");
      String sSearch = request.getParameter("Search");

      if(sVendor==null) sVendor = "0";
      if(sSearch==null) sSearch = " ";

      //System.out.print(sVendor + " " + sSearch);
      MrVendforStr mrvlst = new MrVendforStr(sVendor, sSearch);

      int iNumOfVen = mrvlst.getNumOfVen();

      String [] sVen = mrvlst.getVen();
      String [] sVenName = mrvlst.getVenName();

      String [] sCstCont = mrvlst.getCstCont();
      String [] sCstPhone = mrvlst.getCstPhone();
      String [] sCstWeb = mrvlst.getCstWeb();
      String [] sCstEMail = mrvlst.getCstEMail();
      int [] iNumOfAddr = mrvlst.getNumOfAddr();
      String [][] sCstAddr = mrvlst.getCstAddr();
      String [] sCstIns = mrvlst.getCstIns();

      String [] sDoc = mrvlst.getDoc();
      String [] sFileExt = mrvlst.getFileExt();

      boolean bMoreRec = mrvlst.getMoreRec();

      mrvlst.disconnect();

      %>

<style>body {background:ivory;}
        a:link { color:blue; font-size:10px} a:visited { color:blue; font-size:10px}  a:hover { color:red; font-size:10px}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable1 { cursor:hand; color: blue; background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       text-align:center; font-family:Verdanda; font-size:12px; text-decoration: underline;}

        tr.DataTable { background: #E7E7E7; font-family:Arial; font-size:10px }
        tr.DataTable1 { background: LemonChiffon; font-family:Arial; font-size:10px }
        tr.DataTable2 { background: #b5eaaa; font-family:Arial; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; white-space:}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right; white-space:}

        td.DataTable3 { cursor:hand; color:blue; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right; white-space: nowrap; text-decoration: underline;}

        select.Small {font-family:Arial; font-size:10px }
        input.Small {margin-top:3px; font-family:Arial; font-size:10px }
        button.Small {margin-top:3px; font-family:Arial; font-size:10px }
        textarea.Small {font-family:Arial; font-size:10px }

        div.Prompt { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:500; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move; background-color: blue; color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand; background-color: blue; color:white; border-bottom: black solid 1px; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt {border-bottom: black solid 2px; border-right: black solid 1px; text-align:left;
                   font-family:Arial; font-size:10px; }


</style>


<script name="javascript1.2">
var Vendor = "<%=sVendor%>";
var Search = "<%=sSearch%>";
var LastVendor = null;
<%if(iNumOfVen > 0) {%>LastVendor = "<%=sVen[iNumOfVen-1]%>"; <%}%>

var SelRow = 0;
//------------------------------------------------------------------------------
var VenName = [<%=mrvlst.getVenNameJsa()%>]
var Cont = [<%=mrvlst.getCstContJsa()%>]
var Phone = [<%=mrvlst.getCstPhoneJsa()%>]
var Web = [<%=mrvlst.getCstWebJsa()%>]
var EMail = [<%=mrvlst.getCstEMailJsa()%>]
var Addr = [<%=mrvlst.getCstAddrJsa()%>]
var Ins = [<%=mrvlst.getCstInsJsa()%>]
var Doc = [<%=mrvlst.getDocJsa()%>]
var FileExt = [<%=mrvlst.getFileExtJsa()%>]

//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   // activate move box
   setBoxclasses(["BoxName",  "BoxClose"], ["Prompt", "dvUpload"]);
}
//==============================================================================
// new Search
//==============================================================================
function newSearch()
{
   var ven = document.all.Vendor.value
   if(isNaN(ven) || ven.trim()=="") ven = 0;
   var vennm = document.all.Search.value;
   if(vennm.trim()=="") vennm = " ";

   var url = 'MrVendforStr.jsp?'
    + "Vendor=" + ven
    + "&Search=" + vennm

   //alert(url);
   window.location.href = url;
}
//==============================================================================
// show next page
//==============================================================================
function showMoreRec()
{
   var url = 'MrVendforStr.jsp?'
    + "Vendor=" + LastVendor
    + "&Search=" + Search;

   //alert(url);
   window.location.href = url;
}

//---------------------------------------------------------
// show Vendor for update
//---------------------------------------------------------
function showVend(ven, num)
{
   var url = "MrVendPrt.jsp?"
    + "Ven=" + ven
    + "&VenName=" + cvtText(VenName[num])
    + "&Cont=" + Cont[num]
    + "&Phone=" + Phone[num]
    + "&Web=" + Web[num]
    + "&EMail=" + EMail[num]

    for(var i=0; i < Addr[num].length; i++) { url += "&Addr=" + Addr[num][i]; }
    url += "&Ins=" + Ins[num];

   open(url, "DocUpload", "width=600,height=400, left=100,top=100, resizable=yes , toolbar=yes, location=yes, directories=no, status=yes, scrollbars=yes,menubar=yes")
   SelRow = num;
}
//---------------------------------------------------------
// convert text -  replace next line %0A on &#92;n
//---------------------------------------------------------
function cvtText(text)
{
   var newstr = "";

   for(var i=0; i < text.length; i++)
   {
      if(text.substring(i, i+1) == "#") { newstr += " " }
      else { newstr += text.substring(i, i+1) }
   }

   return newstr;
}


//--------------------------------------------------------
// position objec on the screen
//--------------------------------------------------------
function objPosition(obj)
{
   var curLeft = 0;
   var curTop = 0;
   var pos = new Array(2);


   if (obj.offsetParent)
   {
     while (obj.offsetParent)
     {
       curLeft += obj.offsetLeft
       curTop += obj.offsetTop
       obj = obj.offsetParent;
     }
   }
   else if (obj.x)
   {
     curLeft += obj.x;
     curTop += obj.y;
   }

   pos[0]=curLeft;
   pos[1]=curTop;
   return pos;
}
//--------------------------------------------------------
// Hide selection screen
//--------------------------------------------------------
function hidePanel()
{
   document.all.Prompt.innerHTML = " ";
   document.all.Prompt.style.visibility = "hidden";
}

//==============================================================================
//---------------------------------------------------------
//create String method Trim
//---------------------------------------------------------
function String.prototype.trim()
{ //trim leading and trailing spaces
    var s = this;
    var obj = /^(\s*)([\W\w]*)(\b\s*$)/;
    if (obj.test(s)) { s = s.replace(obj, '$2'); }
    var obj = /  /g;
    while (s.match(obj)) { s = s.replace(obj, ""); }
    return s;
}

</script>
<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>


<HTML><HEAD>

<META content="Microsoft FrontPage 4.0" name=GENERATOR></HEAD>
<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe
  id="frame1"
  src=""
  frameborder=0 height="0" width="0">
</iframe>
<!-------------------------------------------------------------------->
  <div id="Prompt" class="Prompt"></div>
  <div id="dvUpload" class="Prompt"></div>
<!-------------------------------------------------------------------->

<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>RTV - Vendor Search (for customer returns)</B><br>

        <table border=0 cellPadding="0" cellSpacing="0" id="tbSearch">
          <tr><td align="right">Vendor:&nbsp;</td>
              <td align="left"><input class="Small" name="Vendor" maxlength=5 size=5></td>
              <td align="center">- or -</td>
          </tr>
          <tr><td align="right">Name:&nbsp;</td>
              <td align="left"><input class="Small" name="Search" maxlength=25 size=25></td>
              <td align="right">&nbsp;&nbsp;&nbsp;<input onClick="newSearch()" type="submit" class="Small" name="Submit" value="Search"></td>
          </tr>
        </table>

       <a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;<font size="-1">This Page.</font>

<!-- ======================================================================= -->
       <table border=1 cellPadding="0" width="100%" cellSpacing="0" id="tbRtvEnt">

         <tr  class="DataTable">
           <th class="DataTable" >Vendor</th>
           <th class="DataTable" >Vendor<br>Name</th>

           <th class="DataTable" >&nbsp;</th>
           <th class="DataTable" >Address</th>
           <th class="DataTable" >Phone</th>
           <th class="DataTable" >Web Site</th>
           <th class="DataTable" >E-Mail</th>
           <th class="DataTable" >Instructions</th>
           <th class="DataTable" >Document</th>

         </tr>
       <!-- ============================ Details =========================== -->
       <%for(int i=0; i < iNumOfVen; i++ ){%>
          <tr id="trVen<%=i%>" class="DataTable">
            <td class="DataTable3"
               onClick="showVend('<%=sVen[i]%>', <%=i%>)"
                        id="tdVen<%=i%>" ><%=sVen[i]%></td>
            <td class="DataTable1" id="tdVenName<%=i%>"><%=sVenName[i]%></td>

            <th class="DataTable" >&nbsp;</th>

            <td class="DataTable1" id="tdAddr<%=i%>" ><%=sCstCont[i]%><%if(!sCstCont[i].equals("")){%><br><%}%>
                <%for(int j=0; j < iNumOfAddr[i]; j++ ){%><%=sCstAddr[i][j]%><br><%}%>
            </td>
            <td class="DataTable1" id="tdPhone<%=i%>" nowrap><%=sCstPhone[i]%></td>
            <td class="DataTable1" id="tdWeb<%=i%>" ><a target="_blank" href="http://<%=sCstWeb[i]%>"><%=sCstWeb[i]%></a></td>
            <td class="DataTable1" id="tdEmail<%=i%>" ><a href="mailto:<%=sCstEMail[i]%>"><%=sCstEMail[i]%></a></td>

            <td class="DataTable1" id="tdIns<%=i%>" ><%=sCstIns[i]%></td>

            <td class="DataTable1" id="tdDoc<%=i%>">
              <% if(sDoc[i].equals("Y")){%>
                 <a target="_blank" href="VendorDoc/VEN_<%=sVen[i] + "." + sFileExt[i]%>">VEN_<%=sVen[i] + "." + sFileExt[i]%></a>
              <%}%>
            </td>
          </tr>
       <%}%>
       </table>
<!-- ======================================================================= -->
      <%if(bMoreRec){%><button class="Small" name="More" onClick="showMoreRec()">More</button><%}%>

      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
