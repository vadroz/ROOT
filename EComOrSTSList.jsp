<%@ page import="ecommerce.EComOrSTSList, rciutility.StoreSelect,  java.util.*"%>
<%
   String sStore = request.getParameter("Store");
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=EComOrSTSList.jsp&APPL=ALL");
   }
   else
   {

      StoreSelect StrSelect = null;
      String sStrLst = null;
      String sStrLstName = null;

      String sUser = session.getAttribute("USER").toString();
      boolean bAuthChgSts = session.getAttribute("ECOMMCNL") != null;

      int iStrAlwLst = 0;
      String sStrAllowed = session.getAttribute("STORE").toString();
      if (sStore==null && sStrAllowed != null && sStrAllowed.startsWith("ALL"))
      {
         response.sendRedirect("index.jsp");
      }

      if (sStrAllowed != null && sStrAllowed.startsWith("ALL"))
      {
        StrSelect = new StoreSelect(4);
      }
      else
      {
        Vector vStr = (Vector) session.getAttribute("STRLST");
        String [] sStrAlwLst = new String[ vStr.size()];
        Iterator iter = vStr.iterator();

        while (iter.hasNext()){ sStrAlwLst[iStrAlwLst] = (String) iter.next(); iStrAlwLst++; }
        if (vStr.size() > 1) { StrSelect = new StoreSelect(sStrAlwLst); }
        else StrSelect = new StoreSelect(new String[]{sStrAllowed});
      }

      sStrLst = StrSelect.getStrNum();
      sStrLstName = StrSelect.getStrName();

      if(sStore == null) { sStore = sStrAllowed; }
      EComOrSTSList orstsl = new EComOrSTSList(sStore);
%>

<html>
<head>

<style>body {background:ivory; text-align:center;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}
        table.DataTable1 { border: darkred solid 1px;background:Cornsilk;text-align:center;}
        th.DataTable { background:#FFCC99;padding-top:3px; border-bottom: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }

        tr.DataTable { background:cornsilk; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:#efefef; font-family:Arial; font-size:10px }
        tr.DataTable11 { background:pink; font-family:Arial; font-size:10px }

        td.DataTable { border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:left; vertical-align:top}
        td.DataTable1 { border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:center; vertical-align:top}
        td.DataTable2 { border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:right; vertical-align:top}

        div.dvItem { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:150; background-color: white; z-index:10;
              text-align:center; font-size:10px}
                td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}

        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }

        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
        td.Prompt3 { text-align:left; vertical-align:midle; font-family:Arial; font-size:10px; }

        .Small {font-size:10px;}
        <!--------------------------------------------------------------------->
</style>




<SCRIPT language="JavaScript">
//--------------- Global variables -----------------------
var StrLst = [<%=sStrLst%>];
var StrLstName = [<%=sStrLstName%>];
//--------------- End of Global variables ----------------
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
   setStrSelection();
}
//==============================================================================
// set store selection
//==============================================================================
function setStrSelection()
{
  for(var i=1; i < StrLst.length; i++)
  {
     document.all.SelStr.options[i-1] = new Option(StrLst[i] + " - " + StrLstName[i], StrLst[i]);
  }
}
//==============================================================================
// Display order receiving by store confirmation
//==============================================================================
function dspConfWindow(site, ord, carton, action)
{
   var hdr = "Order:&nbsp;" + site + "&nbsp;" + ord + "&nbsp; Carton: " + carton;

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>"
        + popConfPanel(site, ord, carton, action)
     + "</td></tr>"
   + "</table>"

   document.all.dvItem.innerHTML = html;
   document.all.dvItem.style.pixelLeft= document.documentElement.scrollLeft + 300;
   document.all.dvItem.style.pixelTop= document.documentElement.scrollTop + 100;
   document.all.dvItem.style.visibility = "visible";
}
//--------------------------------------------------------
// populate Entry Panel
//--------------------------------------------------------
function popConfPanel(site, ord, carton, action)
{
  var panel = "<table border=0 width='100%' cellPadding='0' cellSpacing='0'>"
  if (action == "RCVCTN")
  {
     panel += "<tr class='DataTable'>"
             + "<td class='DataTable' nowrap>Is the order complete acurate?</td>"
             + "<td class='DataTable' nowrap><input name='Rcv' type=radio value='Y' checked>Yes</td>"
             + "<td class='DataTable' nowrap><input name='Rcv' type=radio value='N'>No</td>"
          + "</tr>"
          + "<tr class='DataTable'>"
             + "<td class='DataTable' colspan=3>"
             + "Yes - customer will be notified that order is ready for pickup<br>"
             + "No - ECom will be notified that there is a problem with the order"
             + "</td>"
          + "</tr>"
          + "<tr class='DataTable'>"
              + "<td class='DataTable1' colspan=3>"
                + "<button onClick='ValidateRcv(&#34;"
                + site + "&#34;,&#34;" + ord + "&#34;,&#34;" + carton + "&#34;)' class='Small'>Submit</button> &nbsp; &nbsp; "
                + "<button onClick='hidePanel();' class='Small'>Close</button>"
             + "</td>"
          + "</tr>";
  }
  else
  {
     panel += "<tr class='DataTable'>"
             + "<td class='DataTable' colspan=3>"
             + "Press the Submit button, to confirm the carton handling."
             + "</td>"
          + "</tr>"
          + "<tr class='DataTable'>"
              + "<td class='DataTable1' colspan=3>"
                + "<button onClick='ValidateHnd(&#34;"
                + site + "&#34;,&#34;" + ord + "&#34;,&#34;" + carton + "&#34;)' class='Small'>Submit</button> &nbsp; &nbsp; "
                + "<button onClick='hidePanel();' class='Small'>Close</button>"
             + "</td>"
          + "</tr>"
  }

  panel += "</table>";


  return panel;
}
//==============================================================================
// change Status
//==============================================================================
function chgStatus(site, ord, carton, ship, rcv, hnd)
{
   var hdr = "Order:&nbsp;" + site + "&nbsp;" + ord + "&nbsp; Carton: " + carton;

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>"
        + popNewStatus(site, ord, carton)
     + "</td></tr>"
   + "</table>"

   document.all.dvItem.innerHTML = html;
   document.all.dvItem.style.pixelLeft= document.documentElement.scrollLeft + 300;
   document.all.dvItem.style.pixelTop= document.documentElement.scrollTop + 100;
   document.all.dvItem.style.visibility = "visible";

   var stsarg = 0
   if(!ship){ document.all.Sts.options[stsarg] = new Option("Ship","SHIP"); stsarg++;}
   if(rcv){ document.all.Sts.options[stsarg] = new Option("Unhandled","UNHND"); stsarg++;}
   if(hnd) { document.all.Sts.options[stsarg] = new Option("Unreceived","UNRCV"); stsarg++;}
   document.all.Sts.selectedIndex=0;
}

//--------------------------------------------------------
// populate Entry Panel
//--------------------------------------------------------
function popNewStatus(site, ord, carton)
{
  var panel = "<table border=0 width='100%' cellPadding='0' cellSpacing='0'>"
  panel += "<tr class='DataTable'>"
             + "<td class='DataTable' nowrap>Change Carton Status</td>"
             + "<td class='DataTable' nowrap><select name='Sts' type=checkbox><select></td>"
          + "</tr>"

          + "<tr class='DataTable'>"
              + "<td class='DataTable1' colspan=3>"
                + "<button onClick='ValidateSts(&#34;"
                + site + "&#34;,&#34;" + ord + "&#34;,&#34;" + carton + "&#34;)' class='Small'>Submit</button> &nbsp; &nbsp; "
                + "<button onClick='hidePanel();' class='Small'>Close</button>"
             + "</td>"
          + "</tr>";
  panel += "</table>";


  return panel;
}


//==============================================================================
// Display order receiving by store confirmation
//==============================================================================
function dspNoteEntry(site, ord, carton)
{
   var hdr = "Order:&nbsp;" + site + "&nbsp;" + ord + "&nbsp; Carton: " + carton;

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>"
        + popNoteEntry(site, ord, carton)
     + "</td></tr>"
   + "</table>"

   document.all.dvItem.innerHTML = html;
   document.all.dvItem.style.pixelLeft= document.documentElement.scrollLeft + 300;
   document.all.dvItem.style.pixelTop= document.documentElement.scrollTop + 100;
   document.all.dvItem.style.visibility = "visible";
}
//==============================================================================
// populate Entry Panel
//==============================================================================
function popNoteEntry(site, ord, carton)
{
  var panel = "<table border=0 width='100%' cellPadding='0' cellSpacing='0'>"
  panel +=
          "<tr class='DataTable'>"
           + "<td class='DataTable'>Notes:</td>"
           + "<td class='DataTable' colspan=2><Textarea name='Note' class='Small' cols=50 rows=4></Textarea></td>"
        + "</tr>"
        + "<tr class='DataTable'>"
           + "<td class='DataTable1' colspan=3>"
              + "<button onClick='ValidateNote(&#34;"
              + site + "&#34;,&#34;" + ord + "&#34;,&#34;" + carton + "&#34;)' class='Small'>Submit</button> &nbsp; &nbsp; "
              + "<button onClick='hidePanel();' class='Small'>Close</button>"
           + "</td>"
        + "</tr>"

  panel += "</table>";


  return panel;
}
//==============================================================================
// Validate processed Items
//==============================================================================
function ValidateRcv(site, ord, carton)
{
   var error = false;
   var msg = "";

   var rcv = "";
   for(var i =0; i < document.all.Rcv.length; i++)
   {
      if(document.all.Rcv[i].checked){rcv = document.all.Rcv[i].value}
   }

   if(error){ alert(msg); }
   else { sbmRcvCtn(site, ord, carton, rcv) }
}
//==============================================================================
// submit processed Items
//==============================================================================
function sbmRcvCtn(site, ord, carton, rcv)
{
  hidePanel();

  var url = "EComSTSSave.jsp?"
    + "Site=" + site
    + "&Ord=" + ord
    + "&Carton=" + carton
    + "&RcvSts=" + rcv
    + "&Action=RCVCTN"

  //alert(url)
  //window.location = url;
  window.frame1.location = url;
}
//==============================================================================
// Validate a carton handling
//==============================================================================
function ValidateHnd(site, ord, carton)
{
   var error = false;
   var msg = "";

   if(error){ alert(msg); }
   else { sbmHndCtn(site, ord, carton, "HNDCTN") }
}

//==============================================================================
// Validate processed Items
//==============================================================================
function ValidateSts(site, ord, carton)
{
   var error = false;
   var msg = "";

   var action = document.all.Sts.options[document.all.Sts.selectedIndex].value

   if(error){ alert(msg); }
   else { sbmHndCtn(site, ord, carton, action) }
}
//==============================================================================
// submit processed Items
//==============================================================================
function sbmHndCtn(site, ord, carton, action)
{
  hidePanel();

  var url = "EComSTSSave.jsp?"
    + "Site=" + site
    + "&Ord=" + ord
    + "&Carton=" + carton
    + "&Action=" + action

  //alert(url)
  //window.location = url;
  window.frame1.location = url;
}
//==============================================================================
// Validate processed Items
//==============================================================================
function ValidateNote(site, ord, carton)
{
   var error = false;
   var msg = "";

   var note = document.all.Note.value.trim();
   note = note.removeNextLine().trim();

   if(note == ""){error = true; msg += "Please, type any text."}

   if(error){ alert(msg); }
   else { sbmNote(site, ord, carton, note) }
}
//==============================================================================
// submit processed Items
//==============================================================================
function sbmNote(site, ord, carton, note)
{
  hidePanel();

  var url = "EComSTSSave.jsp?"
    + "Site=" + site
    + "&Ord=" + ord
    + "&Carton=" + carton
    + "&Note=" + note
    + "&Action=CTNNOTE"

  //alert(url)
  //window.location = url;
  window.frame1.location = url;
}

//--------------------------------------------------------
// Hide selection screen
//--------------------------------------------------------
function hidePanel()
{
   document.all.dvItem.innerHTML = " ";
   document.all.dvItem.style.visibility = "hidden";
}
//==============================================================================
// change text color on mouse moved over table row
//==============================================================================
function mouseOver(obj)
{
  SavColor = obj.style.backgroundColor;
  obj.style.backgroundColor = "white";
}
//==============================================================================
// change text color on mouse moved out table row
//==============================================================================
function mouseOut (obj)
{
  obj.style.color = "black";
  obj.style.backgroundColor = SavColor;
}

//==============================================================================
// refresh screen
//==============================================================================
function refresh()
{
   window.location.reload(true);
}
//==============================================================================
// get another store report
//==============================================================================
function sbmStr()
{
   var str = document.all.SelStr.options[document.all.SelStr.selectedIndex].value;
   var url = "EComOrSTSList.jsp?Store=" + str;
   //alert(str)
   window.location.href=url
}
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>

</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvItem" class="dvItem"></div>
<!-------------------------------------------------------------------->

    <table border="0" cellPadding="0"  cellSpacing="0">
     <tr>
      <td ALIGN="center" VALIGN="TOP"nowrap>
        <b>Retail Concepts, Inc
        <br>Ship-to-Store Order List
        <br>Store: <%=sStore%> &nbsp;
        <br><select class="Small" name="SelStr"></select>
            <button onclick="sbmStr();">Submit</button>
        </b>
      </td>
    </tr>

    <tr>
      <td ALIGN="center" VALIGN="TOP">
      <a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;
      <font size="-1">This Page</font> &nbsp; &nbsp; &nbsp; &nbsp;

      <!--a href="javascript: markAll()">Mark All</a -->
  <!----------------------- Order List ------------------------------>
     <table class="DataTable" cellPadding="0" width="100%" cellSpacing="0" id="tbDetail">
       <tr class="DataTable">
         <th class="DataTable" nowrap>Site</th>
         <th class="DataTable" nowrap>Order</th>
         <th class="DataTable" nowrap>Customer<br>Name</th>
         <th class="DataTable" nowrap>Shipped<br>To<br>Store</th>
         <th class="DataTable" nowrap>Received<br>At<br>Store</th>
         <th class="DataTable" nowrap>Pickup<br>Completed</th>
         <th class="DataTable" nowrap>P<br>r<br>i<br>n<br>t</th>
         <th class="DataTable" nowrap>Ready<br>for<br>Pickup</th>
         <th class="DataTable" nowrap>N<br>o<br>t<br>e</th>
         <th class="DataTable" nowrap>Picked up<br>by<br>Customer</th>
         <th class="DataTable" nowrap>Carton</th>
         <th class="DataTable" nowrap>Freight<br>Bill</th>
         <th class="DataTable" nowrap>Pallet</th>
         <th class="DataTable" nowrap>Notes</th>
         <%if(bAuthChgSts){%>
            <th class="DataTable" nowrap>Change<br>Status</th>
         <%}%>
      </tr>
      <TBODY>

      <!----------------------- Order List ------------------------>
      <%
        int iNum = 0;
        while( orstsl.getNext() ){%>
        <%
           orstsl.getOrder();
           String sSite = orstsl.getSite();
           String sOrd = orstsl.getOrd();
           String sCust = orstsl.getCust();
           String sCarton = orstsl.getCarton();
           String sFirstName = orstsl.getFirstName();
           String sLastName = orstsl.getLastName();

           String sShipped = orstsl.getShipped();
           String sShipDate = orstsl.getShipDate();
           String sShipTime = orstsl.getShipTime();

           String sReceived = orstsl.getReceived();
           String sRcvUser = orstsl.getRcvUser();
           String sRcvDate = orstsl.getRcvDate();
           String sRcvTime = orstsl.getRcvTime();

           String sHandled = orstsl.getHandled();
           String sHndUser = orstsl.getHndUser();
           String sHndDate = orstsl.getHndDate();
           String sHndTime = orstsl.getHndTime();

           String sFrtBill = orstsl.getFrtBill();
           String sPallet = orstsl.getPallet();
           String sRcvSts = orstsl.getRcvSts();
           String sPickBy = orstsl.getPickBy();

           orstsl.getOrdNote();
           int iNumOfNote = orstsl.getNumOfNote();
           String [] sCtnNote = orstsl.getCtnNote();
        %>
          <tr  class="DataTable1" id="trItem<%=iNum%>" onmouseover="mouseOver(this)" onmouseout="mouseOut(this)">
            <td class="DataTable"><%=sSite%></td>
            <td class="DataTable"><%=sOrd%></td>
            <td class="DataTable" nowrap><%=sFirstName + " " + sLastName%>
              <%if(!sPickBy.equals("")){%><br>m/b pickup by <%=sPickBy%><%}%>
            </td>
            <td class="DataTable1" nowrap><%=sShipped%><%if(sShipped.equals("Y")){%><br><%=sShipDate%> <%=sShipTime%><%}%></td>
            <td class="DataTable1" nowrap><%=sReceived%><%if(sShipped.equals("Y")){%><br><%=sRcvDate%> <%=sRcvTime%><br>Status: <%=sRcvSts%><br><%=sRcvUser%><%}%></td>
            <td class="DataTable1" nowrap><%=sHandled%><%if(sHandled.equals("Y")){%><br><%=sHndDate%> <%=sHndTime%><br><%=sHndUser%><%}%></td>

            <th class="DataTable"><a href="EComOrdPack.jsp?Site=<%=sSite%>&Order=<%=sOrd%>" target="_blank">P</a></th>

            <th class="DataTable">
              <%if(sShipped.equals("Y") && !sHandled.equals("Y") && !sReceived.equals("Y")){%><a href="javascript: dspConfWindow('<%=sSite%>', '<%=sOrd%>', '<%=sCarton%>', 'RCVCTN')">R</a><%}%>
            </th>

            <th class="DataTable">
              <a href="javascript: dspNoteEntry('<%=sSite%>', '<%=sOrd%>', '<%=sCarton%>')">N</a>
            </th>

            <th class="DataTable">
              <%if(sShipped.equals("Y") && !sHandled.equals("Y") && sReceived.equals("Y")){%><a href="javascript: dspConfWindow('<%=sSite%>', '<%=sOrd%>', '<%=sCarton%>', 'HNDCTN')">H</a><%}%>
            </th>

            <td class="DataTable"><%=sCarton%></td>
            <td class="DataTable"><%=sFrtBill%></td>
            <td class="DataTable"><%=sPallet%></td>
            <td class="DataTable">
              <%if(iNumOfNote > 0){%>
                <div style = "height: 60px; width: 250px; overflow: auto; border: 1px solid gray;
                            background-color: white; padding-left: 5px;">
                   <%for(int j=0; j < iNumOfNote; j++){%>
                      <%=sCtnNote[j]%><br>
                   <%}%>
                </div>
              <%}%>
            </td>

            <%if(bAuthChgSts){%>
               <th class="DataTable">
                 <a href="javascript: chgStatus('<%=sSite%>', '<%=sOrd%>', '<%=sCarton%>',<%=sShipped.equals("Y")%>, <%=sReceived.equals("Y")%>, <%=sHandled.equals("Y")%>)">S</a>
               </th>
            <%}%>
          </tr>
      <%}%>

      </TBODY>
    </table>
  <!----------------------- end of table ------------------------>
     </td>
   </tr>

  </table>
 </body>
</html>
<%
    orstsl.disconnect();
    orstsl = null;
%>
<%}%>