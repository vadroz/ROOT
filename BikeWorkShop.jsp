<%@ page import="specialorder.* ,java.util.*, java.text.*"%>
<%
   String sTicket = request.getParameter("Ticket");
   String sStore = request.getParameter("Store");
   String sStrName = request.getParameter("StrName");

   SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
   Calendar cal = Calendar.getInstance();
   cal.add(Calendar.DATE, 2);
   String sDueDate = sdf.format(cal.getTime());

   sdf = new SimpleDateFormat("h:mm a");
   String sCurTime = sdf.format(cal.getTime());

   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=BikeWorkShop.jsp&APPL=ALL&" + request.getQueryString());
   }
   else
   {
      String sSalesperson = session.getAttribute("USER").toString();
      // generate new job number
      if (sTicket.trim().equals("0"))
      {
         TicketEntry ticket = new TicketEntry();
         sTicket = ticket.getNewTicket();
         ticket.disconnect();

         // redirect with new number
         response.sendRedirect("BikeWorkShop.jsp?Store=" + sStore + "&StrName=" + sStrName + "&Ticket=" + sTicket);
      }
      // retreive ticket info
      else
      {
         TicketInfo tkInfo = new TicketInfo(sTicket, true);

         //String sTicket = tkInfo.getTicket();
         String sEntStore = tkInfo.getStore();
         String sUser = tkInfo.getUser();
         String sCustNum = tkInfo.getCustNum();
         String sTicketType = tkInfo.getTicketType();
         String sMake = tkInfo.getMake();
         String sModel = tkInfo.getModel();
         String sColor = tkInfo.getColor();
         String sGender = tkInfo.getGender();
         String sParts = tkInfo.getParts();
         String sLastName = tkInfo.getLastName();
         String sFirstName = tkInfo.getFirstName();
         String sDate = tkInfo.getDate();
         String sAddress = tkInfo.getAddress();
         String sCity = tkInfo.getCity();
         String sState = tkInfo.getState();
         String sZip = tkInfo.getZip();
         String sHomePh = tkInfo.getHomePh();
         String sWorkPh = tkInfo.getWorkPh();
         String sExtWrk = tkInfo.getExtWrk();
         String sCellPh = tkInfo.getCellPh();
         String sEMail = tkInfo.getEMail();
         String sTicketFnd = tkInfo.getTicketFnd();

         tkInfo.disconnect();
%>

<html>
<head>

<style>body {background:ivory;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}
        table.DataTable1 { border: darkred solid 1px;background:Cornsilk;text-align:center;}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       text-align:center; font-family:Verdanda; font-size:12px }

        tr.DataTable { background:#E7E7E7; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:Seashell; font-family:Arial; font-size:10px }
        tr.DataTable2 { background:Cornsilk; font-family:Arial; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left;}

        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;}

        td.StrInv { cursor:hand; padding-top:3px; padding-bottom:3px;
                    padding-left:3px; padding-right:3px;
                    border-bottom: darkred solid 1px; text-align:left;}

        td.StrInv1{ padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                    border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                    text-align:left;}

        td.StrLst { background:#FFCC99; border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                    text-align:center; font-size:9px}

        <!-------- select another div/dpt/class pad ------->
        .Small {font-family:Arial; font-size:10px }
        input {border:none; background:#E7E7E7; border-bottom: black solid 1px; font-family:Arial; font-size:10px }
        input.radio {border:none; font-family:Arial; font-size:10px }
        input.Menu {border: ridge 2px; background:white; font-family:Arial; font-size:10px }

        textarea {border:none; background:#E7E7E7; border-bottom: black solid 1px; font-family:Arial; font-size:10px }
        button.Small {font-size:10px; }

        <!-------- transfer entry pad ------->
        div.Fake { };
        div.dvTicket  { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:200; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.Grid  { background:darkblue; color:white; text-align:center; font-family:Arial; font-size:11px; font-weight:bolder}
        td.Grid1 { text-align:left; font-family:Arial; font-size:10px;}
        td.Grid2  { background:darkblue; color:white; text-align:right;
                    font-family:Arial; font-size:11px; font-weight:bolder}
        td.Grid3 { text-align:center; font-family:Arial; font-size:10px;}

        td.Menu { text-align:center; font-family:Arial; font-size:10px;}
        <!-------- end transfer entry pad ------->

</style>
<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
var Ticket ="<%=sTicket%>";
var Store ="<%=sStore%>";
var User  = "<%=sUser%>";
var CustNum = "<%=sCustNum%>";
var TiketType = "<%=sTicketType%>";
var Gender = "<%=sGender%>";
//--------------- End of Global variables ----------------
function bodyLoad()
{
  if(TicketType=="B" || TicketType == " ")
  {
     document.all.TicketType[0].checked=true;
     document.all.TicketType[1].checked=false;
  }
  else if(TicketType=="P")
  {
     document.all.TicketType[0].checked=false;
     document.all.TicketType[1].checked=true;
  }

  document.all.Gender[0].checked=false;
  document.all.Gender[1].checked=false;
  document.all.Gender[2].checked=false;
  if(Gender=="M" || Gender == " ") { document.all.Gender[0].checked=true; }
  else if(Gender=="W")  {  document.all.Gender[1].checked=true;  }
  else if(Gender=="J")  {  document.all.Gender[2].checked=true;  }


  activateBike_or_Parts("B");
}
//------------------------------------------------------------------------------
// Activate Bike or ticket entry fields
//------------------------------------------------------------------------------
function activateBike_or_Parts(TicketType)
{
   if(TicketType=="B")
   {
      document.all.Make.readOnly=false;
      document.all.Model.readOnly=false;
      document.all.Color.readOnly=false;
      document.all.Gender.readOnly=false;
      document.all.Part.readOnly=true;
   }
   else
   {
      document.all.Make.readOnly=true;
      document.all.Model.readOnly=true;
      document.all.Color.readOnly=true;
      document.all.Gender.readOnly=true;
      document.all.Part.readOnly=false;
   }
}
//------------------------------------------------------------------------
// entered customer number when salesperson know it.
//------------------------------------------------------------------------
function getCustNumber()
{
  var menuHtml = "<table cellPadding='0' cellSpacing='0' width='100%'>"
   + "<tr align='center'>"
       + "<td class='Grid' nowrap>Enter Customer Number</td>"
       +"<td  class='Grid2'>"
       + "<img src='CloseButton.bmp' onclick='hidedvTicket();' alt='Close'></td>"
   + "</tr>"
   + "<tr><td class='Menu' ><input name='CustNum' class='Menu' size=10 maxlength=10>&nbsp;"
       + "<button class='Small' onclick='rtvCustInfo()'>Retreive</button></td>"
   + "</tr>"
   + "<tr><td class='Menu'>"

   + "</td></tr></table>"

  //pos = clcPosition(obj);

  document.all.dvTicket.innerHTML=menuHtml
  document.all.dvTicket.style.width=250;
  document.all.dvTicket.style.pixelLeft=300;
  document.all.dvTicket.style.pixelTop=120;
  document.all.dvTicket.style.visibility="visible"
  document.all.CustNum.focus();
}
//------------------------------------------------------------------------
// calculate object coordinates
//------------------------------------------------------------------------
function clcPosition(obj)
{
 var pos = [0, 0];

 if (obj.offsetParent) {
   while (obj.offsetParent){
     pos[0] += obj.offsetLeft
     pos[1] += obj.offsetTop
     obj = obj.offsetParent;
   }
 }
 else if (obj.x) {
    pos[0] += obj.x;
    pos[1] += obj.y;
 }

 pos[0] += 5;
 pos[1] += 20;
 return pos;
}
//------------------------------------------------------------------------
// retreive Customer Information
//------------------------------------------------------------------------
function rtvCustInfo()
{
   var url = "BikShpCustInfo.jsp"
     + "?CustNum=" + document.all.CustNum.value

    //alert(url);
    //window.location.href = url
    window.frame1.location = url;
    hidedvTicket()
}
//------------------------------------------------------------------------
// set Customer Information return by BikShpCustInfo.jsp
//------------------------------------------------------------------------
function setSelectedCust( last, first, addr, city, state, zip, homeph, workph,
     extwrk, cellph, email )
{
    document.all.LastName.value = last;
    document.all.FirstName.value = first;
    document.all.Address.value = addr;
    document.all.City.value = city;
    document.all.State.value = state;
    document.all.Zip.value = zip;
    document.all.HomePh.value = homeph;
    document.all.CellPh.value = cellph;
    document.all.WorkPh.value = workph;
    document.all.ExtWorkPh.value = extwrk;
    document.all.EMail.value = email;
}
//------------------------------------------------------------------------
// close transfer entry panel
//------------------------------------------------------------------------
function hidedvTicket()
{
    document.all.dvTicket.style.visibility="hidden"
}

//------------------------------------------------------------------------
// save Customer Information (hide table after entry)
//------------------------------------------------------------------------
function saveCustInfo()
{
  if(! validateCustInfo())
  {
    var ticketType = getSelectRadio(document.all.TicketType);
    var make = document.all.Make.value;
    var model = document.all.Model.value;
    var color = document.all.Color.value
    var gender = getSelectRadio(document.all.Gender);
    var part = document.all.Part.value;
    var lastName = document.all.LastName.value;
    var firstName = document.all.FirstName.value;
    var date = document.all.Date.value;
    var address = document.all.Address.value;
    var city = document.all.City.value;
    var state = document.all.State.value;
    var zip = document.all.Zip.value;
    var homePh = document.all.HomePh.value;
    var cellPh = document.all.CellPh.value;
    var workPh = document.all.WorkPh.value;
    var extWorkPh = document.all.ExtWorkPh.value;
    var email = document.all.EMail.value;

    var url = "BikShpGenTicket.jsp"
     + "?JobNum=" + Ticket
     + "&Store=" + Store
     + "&User=" + "<%=sSalesperson%>"
     + "&CustNum=" + "<%=sCustNum%>"
     + "&TicketType=" + ticketType
     + "&Make=" + make
     + "&Model=" + model
     + "&Color=" + color
     + "&Gender=" + gender
     + "&Part=" + part
     + "&LastName=" + lastName
     + "&FirstName=" + firstName
     + "&Date=" + date
     + "&Address=" + address
     + "&City=" + city
     + "&State=" + state
     + "&Zip=" + zip
     + "&HomePh=" + homePh
     + "&CellPh=" + cellPh
     + "&WorkPh=" + workPh
     + "&ExtWorkPh=" + extWorkPh
     + "&EMail=" + email

    //alert(url);
    //window.location.href = url
    window.frame1.location = url;
  }
}

//------------------------------------------------------------------------
// Set Job Number generated for new workshop job
// This rutine called by child document "BikShpGenTicket.jsp"
// that was called from saveCustInfo()
//------------------------------------------------------------------------
function setTicket(ticket)
{
   window.frame1.close();
}
//------------------------------------------------------------------------
// retreive selected radio button value
//------------------------------------------------------------------------
function getSelectRadio(radio)
{
  var sel = " ";
  for(var i=0; i < radio.length; i++)
  {
     if(radio[i].checked==true)
     {
       sel = radio[i].value;
       break;
     }
  }
  return sel;
}
//------------------------------------------------------------------------
// Validate Top part of ticket - customer information
//------------------------------------------------------------------------
function validateCustInfo()
{
   var error = false;
   var msg="";
   var type = "B"
   if (document.all.TicketType[1].checked==true) type = "P"


   if(type=="B")
   {
      if(document.all.Make.value.trim()=="") msg +="Type make of the bike.\n"
   }

   if(document.all.LastName.value.trim()=="")
   {
      msg +="Type customer last name.\n"
   }

   if(document.all.FirstName.value.trim()=="")
   {
      msg +="Type customer first name.\n"
   }

   if(document.all.HomePh.value.trim()=="" && document.all.CellPh.value.trim()==""
      && document.all.WorkPh.value.trim()=="" && document.all.EMail.value.trim()=="")
   {
      msg +="Type at least one of those: home/cell/work phone number or e-mail.\n"
   }

   if(msg.trim()!="")
   {
     alert(msg)
     error=true;
   }

   return error;
}
//------------------------------------------------------------------------
// save Customer Information (hide table after entry)
//------------------------------------------------------------------------
function addLine(id)
{
    var tbody = document.getElementById(id).getElementsByTagName("TBODY")[0];
    var row = document.createElement("TR")

    var td1 = document.createElement("TD")
    td1.appendChild(document.createTextNode("1"))

    var td2 = document.createElement("TD")
    td2.appendChild (document.createTextNode("2"))
    row.appendChild(td1);
    row.appendChild(td2);
    tbody.appendChild(row);
    alert(row.id)
}
// -------------------------------------------------------------------
//                       Move Boxes
//--------------------------------------------------------------------
var dragapproved=false
var z,x,y
function move(){
if (event.button==1&&dragapproved){
z.style.pixelLeft=temp1+event.clientX-x
z.style.pixelTop=temp2+event.clientY-y
return false
}
}
function drags()
{
  if (!document.all) return;
  var obj = event.srcElement

  if (event.srcElement.className=="Grid")
  {
    while (obj.offsetParent)
    {
      if (obj.id=="dvTicket")
      {
        z=obj;
        break;
      }
      obj = obj.offsetParent;
    }
    dragapproved=true;
    temp1=z.style.pixelLeft
    temp2=z.style.pixelTop
    x=event.clientX
    y=event.clientY
    document.onmousemove=move
  }

  // move table cell data
  if ((event.srcElement.className=="StrInv"
    || event.srcElement.className=="StrInv1") && draged==true)
  {
    z=obj;
    dragapproved=true;
    temp1=z.style.pixelLeft
    temp2=z.style.pixelTop
    x=event.clientX
    y=event.clientY
    document.onmousemove=move
    showDragedCell();
  }
}

document.onmousedown=drags
document.onmouseup=new Function("dragapproved=false")
// ---------------- End of Move Boxes ---------------------------------------
// --------------------------------------------------------------------------
// trim method
// --------------------------------------------------------------------------
String.prototype.trim = function()
{
  return( this.replace(/^\s*/,'').replace(/\s*$/,'') );
}



</SCRIPT>


</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe
  id="frame1"
  src=""
  frameborder=0 height="0" width="0">
</iframe>
<!-------------------------------------------------------------------->
    <div id="dvTicket" class="dvTicket"></div>
<!-------------------------------------------------------------------->

    <table border="0" cellPadding="0" width="100%" cellSpacing="0">
     <tr bgColor="moccasin">
      <td ALIGN="left" VALIGN="TOP" nowrap>
         <b><font size="-1">
            <%if(sTicketFnd.equals("1")) {%>
               Entered in store: <%=sEntStore%><br>
               Entered by: <%=sUser%>
            <%}
            else {%>
               Entered in store: <%=sStore%><br>
               Entered by: <%=sSalesperson%>
            <%}%></font></b></td>
      <td ALIGN="center" VALIGN="TOP"nowrap>
      <b>Retail Concepts, Inc
      <br>Bike Workshop Ticket</b></td>
      <td ALIGN="right" VALIGN="TOP" nowrap>
         <b><font size="-1">Date: <%=sDueDate%><br>Time: <%=sCurTime%></font></b></td>
    </tr>
     <tr bgColor="moccasin">
      <td ALIGN="left" VALIGN="TOP" colspan="3">

      <a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;
      <a href="BikeWorkshopSel.jsp">
         <font color="red" size="-1">Bike Shop Selection</font></a>&#62;This Page.
<!-------------------------------------------------------------------->
   <table border=1 cellPadding="0" cellSpacing="0" >
     <tr  class="DataTable">
        <td class="DataTable" rowspan="2" nowrap>Job Number<br><%=sTicket%></td>
        <td class="DataTable" nowrap>
          Bike<input class="radio" type="radio" name="TicketType" value="B" onclick="activateBike_or_Parts('B')" checked>

            <br>Taken by <%if(sUser.trim().equals("")){%><%=sSalesperson%><%} else {%><%=sUser%><%}%>
        </td>
        <td class="DataTable1" nowrap>
           Make: <input type="text" name="Make" value="<%=sMake.trim()%>" size=10 maxlength=25 >&nbsp;&nbsp;
           Model: <input type="text" name="Model" value="<%=sModel.trim()%>" size=10 maxlength=25>&nbsp;&nbsp;
           Color: <input type="text" name="Color" value="<%=sColor.trim()%>" size=10 maxlength=25></td>
         <td class="DataTable" nowrap>
           <input class="radio" type="radio" name="Gender" value="M" checked> Men's&nbsp;
           <input class="radio" type="radio" name="Gender" value="W" > Women's&nbsp;
           <input class="radio" type="radio" name="Gender" value="J" > Juvenale's&nbsp;
         </td>
         <td class="DataTable" rowspan="2" nowrap><u>Due Date</u><br><%=sDueDate%></td>
      </tr>
      <tr  class="DataTable">
        <td class="DataTable" nowrap>
            Parts<input class="radio" type="radio" onclick="activateBike_or_Parts('P')" name="TicketType" value="P" >
        </td>
        <td class="DataTable" colspan="2" nowrap>
          Part(s) <input name="Part" type="text" size=120 maxlength=120></td>
      </tr>
   </table>
 <!----------------------- end of table ------------------------>
   </tr>
   <tr bgColor="moccasin">
     <td ALIGN="left" VALIGN="TOP"  colspan="2" nowrap><br>
  <!----------------------- Customer Data ------------------------------>
     <table border=1 cellPadding="0" cellSpacing="0" id="tbCustInfo">
      <tr  class="DataTable">
        <td class="DataTable" nowrap>Last Name<br><input type="text" name="LastName" value="<%=sLastName.trim()%>" size=25 maxlength=25></td>
        <td class="DataTable" nowrap>First Name<br><input type="text" name="FirstName" value="<%=sFirstName.trim()%>" size=15 maxlength=25></td>
        <td class="DataTable" nowrap>Date<br><input type="text" name="Date" value="<%=sDate%>" size="10" maxlength=10></td>
      </tr>
      <tr  class="DataTable">
        <td class="DataTable" colspan="3" nowrap>Address<br><input type="text" name="Address" value="<%=sAddress.trim()%>" size=100 maxlength=100></td>
      </tr>
      <tr  class="DataTable">
        <td class="DataTable" nowrap>City<br><input type="text" name="City" value="<%=sCity.trim()%>" size=15 maxlength=25></td>
        <td class="DataTable" nowrap>State<br><input type="text" name="State" value="<%=sState.trim()%>" size=2 maxlength=2></td>
        <td class="DataTable" nowrap>Zip<br><input type="text" name="Zip" value="<%=sZip.trim()%>" size=10 maxlength=10></td>
      </tr>
      <tr  class="DataTable">
        <td class="DataTable" nowrap>Home Phone<br><input type="text" name="HomePh" value="<%=sHomePh.trim()%>" size=12 maxlength=12></td>
        <td class="DataTable" colspan="2" nowrap>Work Phone x(Ext.)<br><input type="text" name="WorkPh" value="<%=sWorkPh.trim()%>" size=12 maxlength=12>&nbsp;&nbsp;
               x <input type="text" name="ExtWorkPh" value="<%=sExtWrk.trim()%>"size=5 maxlength=5></td>
      </tr>
      <tr  class="DataTable">
        <td class="DataTable" nowrap>Cell Phone<br><input type="text" name="CellPh" value="<%=sCellPh.trim()%>" size=12 maxlength=12></td>
        <td class="DataTable" colspan="2" nowrap>E-Mail<br><input type="text" name="EMail" value="<%=sEMail.trim()%>" size=65 maxlength=65></td>
      </tr>
   </table>
  <!----------------------- end of table ------------------------>
     </td>
     <td ALIGN="center" VALIGN="TOP" nowrap><br>
       <img src="logo.gif" >
       <br><h2>Bike Workshop Ticket</h2>
      </td>
   </tr>

   <!----------------------- end of table ------------------------>
   </tr>
   <tr bgColor="moccasin">
     <td ALIGN="center" VALIGN="TOP" colspan="3" nowrap><br>
     <%if(sTicketFnd.equals("0")){%>
        <button name="GetCust" class="Small" onclick="getCustNumber(this)" >Get Customer</button>&nbsp;&nbsp;
     <%}%>
     <button name="CurtInfo" class="Small" onclick="saveCustInfo()" >Save</button>
     <br><br>
   </tr>
   <tr bgColor="moccasin">
     <td ALIGN="left" VALIGN="TOP" colspan="3" nowrap>
  <!----------------------- Customer Data ------------------------------>
     <table border=1 cellPadding="0" width="100%" cellSpacing="0" id="tbLabor">
       <tr  class="DataTable">
        <th class="DataTable" nowrap>No.</th>
        <th class="DataTable" nowrap>Qty</th>
        <th class="DataTable" nowrap>Sku/Upc Number</th>
        <th class="DataTable" nowrap>Description of Part and Service</th>
        <th class="DataTable" nowrap>Price</th>
        <th class="DataTable" nowrap>Extension</th>
      </tr>
      <tr  class="DataTable2">
        <td class="DataTable" nowrap><button name="PartLine" onclick="addLine('tbLabor')">Add Line</button></td>
        <td class="DataTable" nowrap><input type="text" name="Qty" size=5 maxlength=5></td>
        <td class="DataTable" nowrap>
                <input type="text" name="Sku" size=12 maxlength=12>
                <a href="#">Add Sku</a>&nbsp;/&nbsp;&nbsp;<a href="#">Charge Labor</a>
        </td>
        <td class="DataTable" nowrap>&nbsp;</td>
        <td class="DataTable" nowrap><input type="text" name="Price" size=8 maxlength=8></td>
        <td class="DataTable" nowrap>&nbsp;</td>
      </tr>
      <tr  class="DataTable">
        <td class="DataTable" nowrap>1</td>
        <td class="DataTable" nowrap>5</td>
        <td class="DataTable" nowrap>5</td>
        <td class="DataTable" nowrap>5</td>
        <td class="DataTable" nowrap>5</td>
        <td class="DataTable" nowrap>5</td>
      </tr>

    </table>
  <!----------------------- end of table ------------------------>


     </td>
   </tr>

  </table>
 </body>
</html>

  <%}
}%>