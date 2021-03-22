<%@ page import="vendorsupport.VenRep , java.util.*"%>
<%
  String sUser = request.getParameter("User");
  boolean bExist = request.getParameter("Exist") != null;

  VenRep venrep = new VenRep("testrep");

     String sName = venrep.getName();
     String sPwd = venrep.getPwd();
     String sAddr = venrep.getAddr();
     String sCity = venrep.getCity();
     String sState = venrep.getState();
     String sZip = venrep.getZip();
     String sPhone = venrep.getPhone();
     String sCell = venrep.getCell();
     String sEMail = venrep.getEMail();
     int iNumOfBrn = venrep.getNumOfBrn();
     String sBrand = venrep.getBrand();

     venrep.disconnect();
     venrep = null;
%>
<html>
<head>

<style>
  body {background:white;}
  a:link { color:blue;  font-size:12px;} a:visited { color:blue; font-size:12px;}  a:hover { color:blue; font-size:12px;}

  table.DataTable { border: #F7F7F7 ridge 2px; background:#e7e7e7; text-align:center;}
  tr.DataTable { background:#FFCC99; font-family:Verdanda; text-align:center; font-size:12px; font-weight:bold}
  tr.DataTable1 { background: #F7F7F7; font-family:Verdanda; text-align:left; font-size:12px; font-weight:bold}
  th.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                 border: #F7F7F7 ridge 2px;}
  td.DataTable { color:red; border-right: none; text-align:right; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;}
  td.DataTable1 { border-right: none; text-align:center; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;}
  .Small { font-size:12px; }

</style>

<SCRIPT language="JavaScript">
//==============================================================================
// Global variable
//==============================================================================
var Name = "<%=sName%>";
var User = "<%=sUser%>";
var Pwd = "<%=sPwd%>";
var Addr = "<%=sAddr%>";
var City = "<%=sCity%>";
var State = "<%=sState%>";
var Zip = "<%=sZip%>";
var Phone = "<%=sPhone%>";
var Cell = "<%=sCell%>";
var EMail = "<%=sEMail%>";
var Brand = [<%=sBrand%>];
//==============================================================================
// Load initial value on page
//==============================================================================
function bodyLoad()
{
   <%if(bExist){%>
     document.all.Name.value = Name;
     document.all.User.value = User;
     document.all.Pwd.value = Pwd
     document.all.Address.value = Addr;
     document.all.City.value = City;
     document.all.State.value = State;
     document.all.Zip.value = Zip;
     document.all.Phone.value = Phone;
     document.all.Cell.value = Cell;
     document.all.EMail.value = EMail;
     for(var i=0; i < Brand.length; i++)
     {
        document.all.Brand[i].value = Brand[i]
     }
   <%}%>
}
//--------------------------------------------------------
// Validate entries
//--------------------------------------------------------
function Validate(exist)
{
  var error = false;
  var msg = "";

  var name = document.all.Name.value.trim(" ");
  var user = document.all.User.value.trim(" ");
  var pwd = document.all.Pwd.value.trim(" ");
  var addr = document.all.Address.value.trim(" ");
  var city = document.all.City.value.trim(" ");
  var state = document.all.State.value.trim(" ");
  var zip = document.all.Zip.value.trim(" ");
  var phone = document.all.Phone.value.trim(" ");
  var cell = document.all.Cell.value.trim(" ");
  var email = document.all.EMail.value.trim(" ");
  var action = "ADD";
  var brand = new Array();

  for(var i=0, j=0; i < 9; i++)
  {
    if( document.all.Brand[i].value.trim(" ") !="" && document.all.Brand[i].value.trim(" ") !=" ")
    {
      brand[j] = document.all.Brand[i].value.trim();
      j++;
    }
  }

  if(exist) action = "UPD";

  if(name=="" || name==" "){ error=true; msg += "Please, enter your name.\n"}
  if(user=="" || user==" "){ error=true; msg += "Please, enter the user name.\n"}
  if(pwd=="" || pwd==" "){ error=true; msg += "Please, enter a password.\n"}
  if(addr=="" || addr==" "){ error=true; msg += "Please, enter an address.\n"}
  if(city=="" || city==" "){ error=true; msg += "Please, enter a city.\n"}
  if(state=="" || state==" "){ error=true; msg += "Please, enter a state.\n"}
  if(zip=="" || zip==" "){ error=true; msg += "Please, enter a zip code .\n"}
  if((phone=="" || phone==" ") && (cell=="" || cell==" ")){ error=true; msg += "Please, enter at least 1 phone number .\n"}
  if(email=="" || email==" "){ error=true; msg += "Please, enter E-Mail address.\n"}

  if(brand.length==0){ error=true; msg += "At least 1 brand name must be entered.\n" }

  if (error) { alert(msg)}
  else { sbmVendor(name, user, pwd, addr, city, state, zip, phone, cell, email, brand, action) }
}
//--------------------------------------------------------
// submit Vendor Registration
//--------------------------------------------------------
function sbmVendor(name, user, pwd, addr, city, state, zip, phone, cell, email, brand, action)
{
   var url = "VenRegSave.jsp?"
       + "Name=" + name
       + "&User=" + user
       + "&Pwd=" + pwd
       + "&Addr=" + addr
       + "&City=" + city
       + "&State=" + state
       + "&Zip=" + zip
       + "&Phone=" + phone
       + "&Cell=" + cell
       + "&EMail=" + email

   for(var i=0; i < brand.length; i++)
   {
       url += "&Brand=" + brand[i]
   }
   url += "&Action=" + action

   //alert(url)
   //window.location.href = url;
   window.frame1.location.href = url;
}
//--------------------------------------------------------
// show vendor entry results
//--------------------------------------------------------
function showSaveResults(numoferr, errcode, error)
{
  var msg = "";
  if(numoferr > 0)
  {
      for(var i=0; i < numoferr; i++){ msg += error[i] + "\n"; }
  }
  else
  {
     <%if(!bExist){%>
          msg += "Your user profile have been successfully created. Thank you."
     <%}
       else {%>
          msg += "Your user profile have been changed. Thank you."
        <%}%>
  }
  alert(msg)
  <%if(bExist){%>window.close()<%}
    else {%>window.location.href="";<%}%>
}
</SCRIPT>

<script LANGUAGE="JavaScript" src="String_Trim_function.js"></script>
</head>

<body  onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvClinic" class="dvClinic"></div>
<!-------------------------------------------------------------------->

  <table border="0" width="100%" height="100%">
     <tr>
      <td ALIGN="center" VALIGN="TOP">
       <b>Retail Concepts, Inc
       <br>Vendor Representative Registration
       <br>
       </b>
        <!----------------- start of ad table ------------------------>
        <table  class="DataTable" cellPadding="0" cellSpacing="0" id="tblPersonal">
            <tr class="DataTable"><td class="DataTable1" colspan=3><sup style="color:red">*</sup> - Required fields</td></tr>
            <tr class="DataTable1">
              <td class="DataTable"><sup>*</sup></td>
              <td>Full Name: </td>
              <td><input class="Small" name="Name" size=30 maxlength=30 autocomplete="off"></td>
            </tr>
            <tr class="DataTable1">
              <td class="DataTable"><sup>*</sup></td>
              <td>User Name:&nbsp;</td>
              <td><input class="Small" name="User" size=10 maxlength=10 autocomplete="off"></td>
            </tr>
            <tr class="DataTable1">
              <td class="DataTable"><sup>*</sup></td>
              <td>Password:&nbsp;</td>
              <td><input class="Small" type="Password" name="Pwd" size=10 maxlength=10 autocomplete="off"></td>
            </tr>
            <tr class="DataTable1">
              <td class="DataTable"><sup>*</sup></td>
              <td>Address :&nbsp;</td>
              <td><input class="Small" name="Address" size=50 maxlength=50 autocomplete="off">&nbsp;</td>
            </tr>
            <tr class="DataTable1">
              <td class="DataTable"><sup>*</sup></td>
              <td>City:&nbsp;</td>
              <td><input class="Small" name="City" size=50 maxlength=50 autocomplete="off">&nbsp;</td>
            </tr>
            <tr class="DataTable1">
              <td class="DataTable"><sup>*</sup></td>
              <td>State:&nbsp;</td>
              <td><input class="Small" name="State" size=2 maxlength=2 autocomplete="off"></td>
            </tr>
            <tr class="DataTable1">
              <td class="DataTable"><sup>*</sup></td>
              <td>Zip Code:&nbsp;</td>
              <td><input class="Small" name="Zip" size=10 maxlength=10 autocomplete="off"></td>
            </tr>
            <tr class="DataTable1">
              <td class="DataTable"><sup>*</sup></td>
              <td>Phone 1:&nbsp;</td>
              <td><input class="Small" name="Phone" size=14 maxlength=14 autocomplete="off"></td>
            </tr>
            <tr class="DataTable1">
              <td class="DataTable"></td>
              <td>Phone 2:&nbsp;</td>
              <td><input class="Small" name="Cell" size=14 maxlength=14 autocomplete="off"></td>
            </tr>
            <tr class="DataTable1">
              <td class="DataTable"><sup>*</sup></td>
              <td>E-Mail:&nbsp;</td>
              <td><input class="Small" name="EMail" size=50 maxlength=50 autocomplete="off"></td>
            </tr>
       </table>

       <p>
       You must enter at least 1 brand that you represent. You will be able to change the names later.
       <table  class="DataTable" cellPadding="0" cellSpacing="0" id="tblBrands">
            <tr class="DataTable">
              <th>Brand Names</th>
              <th>Brand Names</th>
              <th>Brand Names</th>
            </tr>
            <tr class="DataTable1">
              <td>&nbsp;<input class="Small" name="Brand" size=50 maxlength=50 autocomplete="off">&nbsp;</td>
              <td>&nbsp;<input class="Small" name="Brand" size=50 maxlength=50 autocomplete="off">&nbsp;</td>
              <td>&nbsp;<input class="Small" name="Brand" size=50 maxlength=50 autocomplete="off">&nbsp;</td>
            </tr>
            <tr class="DataTable1">
              <td>&nbsp;<input class="Small" name="Brand" size=50 maxlength=50 autocomplete="off"></td>
              <td>&nbsp;<input class="Small" name="Brand" size=50 maxlength=50 autocomplete="off"></td>
              <td>&nbsp;<input class="Small" name="Brand" size=50 maxlength=50 autocomplete="off"></td>
            </tr>
            <tr class="DataTable1">
              <td>&nbsp;<input class="Small" name="Brand" size=50 maxlength=50 autocomplete="off"></td>
              <td>&nbsp;<input class="Small" name="Brand" size=50 maxlength=50 autocomplete="off"></td>
              <td>&nbsp;<input class="Small" name="Brand" size=50 maxlength=50 autocomplete="off"></td>
            </tr>
       </table>
       <button onclick="Validate(<%=bExist%>)">Submit</button>
      </td>
     </tr>
   </table>
  </body>
</html>
