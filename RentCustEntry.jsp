<!DOCTYPE html>
<%@ page import="rciutility.RunSQLStmt, java.sql.*, java.util.*, java.text.*"%>
<%   	
   //----------------------------------
   // Application Authorization
   //----------------------------------
      boolean bChgCust = session.getAttribute("RECHGCUST") != null;
          String sStmt = "select store"
             + " from RCI.ReStr"
             + " where store not in (16,17, 30,63)" 
             + " and store in (";
             ;
           

          sStmt += " order by store";
          RunSQLStmt runsql = new RunSQLStmt();
          runsql.setPrepStmt(sStmt);
          ResultSet rs = runsql.runQuery();
          int j=0;
         
          while(runsql.readNextRecord())
          {
             String sStrAll = runsql.getData("store").trim();
          }

      

      SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
      Calendar cal = Calendar.getInstance();
      String sToday = sdf.format(cal.getTime());
      sdf = new SimpleDateFormat("h:mm a");
      String sCurTime = sdf.format(cal.getTime());
      
      boolean bFootWear = false;
%>

<html>
<head>
<title>Rent_Cutomer_Entry</title>

 

<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">

<script type="text/javascript" src="http://code.jquery.com/jquery-1.4.4.min.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>


<SCRIPT language="JavaScript1.2">

//--------------- Global variables -----------------------

//--------------- End of Global variables ----------------
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{
   if (ua.match(/iPad/i) || ua.match(/iPhone/i)) { isSafari = true; }
   
   setBoxclasses(["BoxName",  "BoxClose"], ["dvChkItm", "dvStatus"]);
   
   var cust  = document.getElementById("Cust");
   cust.value = "NEW"; 
   
   document.getElementsByName("PhoneUOM")[0].checked = true;
   document.getElementsByName("PhoneUOM")[1].checked = false;
   
   document.getElementsByName("WgtUOM")[0].checked = true;
   document.getElementsByName("WgtUOM")[1].checked = false;   
   setUOM("U");
}
//==============================================================================
// set UOM for Hegth and weight
//==============================================================================
function setUOM(type)
{
	if(type=="U")
	{
		document.getElementsByName("Weight")[0].disabled  = false;
		document.getElementsByName("WeightKg")[0].disabled  = true;
		
		document.getElementsByName("HeightFt")[0].disabled  = false;
		document.getElementsByName("HeightIn")[0].disabled  = false;
		document.getElementsByName("HeightCm")[0].disabled  = true;
	}
	else
	{
		document.getElementsByName("Weight")[0].disabled  = true;
		document.getElementsByName("WeightKg")[0].disabled  = false;
		
		document.getElementsByName("HeightFt")[0].disabled  = true;
		document.getElementsByName("HeightIn")[0].disabled  = true;
		document.getElementsByName("HeightCm")[0].disabled  = false;
	}
}
//==============================================================================
// validate Skier
//==============================================================================
function validateSkier()
{
   var error=false;
   var msg = "";
   var tdError = document.getElementById("tdError");
   tdError.innerHTML = "";
   var numdgt = 0;

   var action = "ADD_CUST_ONLY";
   var cust = document.all.Cust.value;
   if( cust !="NEW"){ action = "UPD_CUST_ONLY"; }
   else{ cust = ""; }

   //var skierAction = document.all.Action.value.trim();
   //if (skierAction != ""){  action += "_" + skierAction; }

   var fname = document.all.FName.value.trim().replaceSpecChar();
   if(fname==""){ error=true; msg += "Please enter first name.<br>"; }

   var minit = document.all.MInit.value.trim().replaceSpecChar();
   minit = minit.replace(/[^\w\s]/gi, '');
   document.all.MInit.value = minit;

   var lname = document.all.LName.value.trim().replaceSpecChar();
   if( lname==""){ error=true; msg += "\nPlease enter last name.<br>"; }

   var addr1 = document.all.Addr1.value.trim().replaceSpecChar();
   var addr2 = document.all.Addr2.value.trim().replaceSpecChar();
   if( addr1=="" && addr2==""){ error=true; msg += "\nPlease enter address.<br>"; }
   
   var addrNum = false;
   for(var i=0; i < addr1.length; i++)
   {
	   if(addr1.substring(i,i+1) >= '1' && addr1.substring(i,i+1) <= '9'){ addrNum = true; break;}
   }
   if( !addrNum ){ error=true; msg += "\nAddress Line 1 - must contain at least 1 number.<br>"; }

   var city = document.all.City.value.trim().replaceSpecChar();
   if( city==""){ error=true; msg += "\nPlease enter city name.<br>"; }

   var state = document.all.State.value.trim().replaceSpecChar();
   if( state==""){ error=true; msg += "\nPlease enter state name.<br>"; }
   numdgt = state.length;
   if( numdgt != 2){ error=true; msg += "\nInvalid State name. Must be 2 characters.<br>"; }

   var zip = document.all.Zip.value.trim().replaceSpecChar();
   if( zip==""){ error=true; msg += "\nPlease enter zip code.<br>"; }
   numdgt = zip.length;
   if( numdgt < 5){ error=true; msg += "\nInvalid Zip code. Must be equal or greater then 5 characters.<br>"; }

   var email = document.all.EMail.value.trim().replaceSpecChar();
   if(email == ""){ error=true; msg += "\nPlease enter E-Mail address.<br>"; }
   if(email != "" && !checkEmail(email)){ error=true; msg += "\nInvalid E-Mail address.<br>"; }

   var hphone = document.all.HPhone.value.trim().replaceSpecChar();
   var cphone = document.all.CPhone.value.trim().replaceSpecChar();
   if( hphone=="" && cphone==""){ error=true; msg += "\nPlease enter Home or Cell phone numbers.<br>"; }

   var intl = "";
   if(document.getElementsByName("PhoneUOM")[1].checked)
   {
	   intl = "Y";
   }
   
   numdgt = hphone.length;
   var onlyzero = true; 
   for(var i=0; i < hphone.length; i++)
   {
      if( hphone.substring(i,i+1) == "-" )
      {
         numdgt += -1;         
      }
      if(hphone.substring(i,i+1) != '0'){ onlyzero = false; }
   }
   if(intl=="" && hphone != "" && numdgt != 10){ error=true; msg += "\nInvalid Home phone number. Must be 10 digits.<br>"; }
   else if( hphone != "" && onlyzero ){ error=true; msg += "\nInvalid Home phone number.<br>"; }

   numdgt = cphone.length;
   for(var i=0; i < cphone.length; i++)
   {
      if( cphone.substring(i,i+1) == "-" )
      {
         numdgt += -1;
      }
   }
   if(intl=="" && cphone!="" && numdgt != 10){ error=true; msg += "\nInvalid Cell phone number. Must be 10 digits.<br>"; }

   var sport = "";
   var inpSport = document.getElementsByName("inpSport"); 
   for(var i; i < inpSport.length ; i++ )
   {
	   if(inpSport[i].checked){ sport = inpSport[i].value; break; }
   }
      
   var bdate = document.all.BirthDt.value.trim().replaceSpecChar();
   var curdt = new Date();
   var curyr = curdt.getFullYear();
   var limitage = curyr - 1940;
   
   if( sport == "Ski" && bdate==""){ error=true; msg += "\nPlease enter Age.<br>"; }
   else if( curyr - bdate < 1940){ error=true; msg += "\nAge entry cannot be " + limitage + " .<br>"; }

   var group = document.all.Group.value.trim().replaceSpecChar();
      
   var weight = document.all.Weight.value.trim().replaceSpecChar();
   if( sport == "Ski" && weight==""){ error=true; msg += "\nPlease enter skier weight.<br>"; }
   else if( eval(weight) > 500 ){ error=true; msg += "\nWeight cannot be higher than 500.<br>"; }

   var hgtft = document.all.HeightFt.value.trim().replaceSpecChar();
   if( sport == "Ski" && hgtft==""){ error=true; msg += "\nPlease enter skier height(ft).<br>"; }
   var hgtin = document.all.HeightIn.value.trim().replaceSpecChar();
   if( sport == "Ski" && hgtin==""){ error=true; msg += "\nPlease enter skier height(in).<br>"; }

   var shoesz = "0"; //document.all.ShoeSiz.value.trim().replaceSpecChar();
   if( sport == "Ski" && shoesz==""){ error=true; msg += "\nPlease enter skier shoe size.<br>"; }

   var skity = "";
   var stance = "";
   for(var i=0; i < document.all.SkiType.length; i++)
   {
      if(i <= 4 && document.all.SkiType[i].checked){ skity = document.all.SkiType[i].value; }
      else if(i > 4 && document.all.SkiType[i].checked){ stance = document.all.SkiType[i].value; }
   }
   
   var mondosz = "0"; //document.all.MondoSiz.value.trim().replaceSpecChar();
   var anglel = document.all.AngleLeft.value.trim().replaceSpecChar();;
   var angler = document.all.AngleRight.value.trim().replaceSpecChar();;   
   


   if(error){ tdError.innerHTML = msg; tdError.style.color = "red"; }
   else{ sbmAddSkier(cust, fname, minit, lname, addr1, addr2, city, state, zip, email, hphone, cphone
     , bdate, group, weight, hgtft, hgtin, shoesz, skity, stance, mondosz, anglel, angler, intl, action) }
}
//==============================================================================
// check email
//==============================================================================
function checkEmail(email)
{
   var good = true;
   var atpos=email.indexOf("@");
   var dotpos=email.lastIndexOf(".");
   if (atpos<1 || dotpos<atpos+2 || dotpos+2>=email.length)
   {
      good = false;
   }
   return good;
}
//==============================================================================
// add skier
//==============================================================================
function sbmAddSkier( cust, fname, minit, lname, addr1, addr2, city, state, zip, email, hphone, cphone
     , bdate, group, weight, hgtft, hgtin, shoesz, skity, stance, mondosz, anglel, angler, intl, action)
{
   var url = "RentContractSave.jsp?"
     + "&Cust=" + cust
     + "&FName=" + fname
     + "&MInit=" + minit
     + "&LName=" + lname
     + "&Addr1=" + addr1
     + "&Addr2=" + addr2
     + "&City=" + city
     + "&State=" + state
     + "&Zip=" + zip
     + "&EMail=" + email
     + "&HPhone=" + hphone
     + "&CPhone=" + cphone
     + "&BDate=" + bdate
     + "&Group=" + group
     + "&Weight=" + weight
     + "&HeightFt=" + hgtft
     + "&HeightIn=" + hgtin
     + "&ShoeSiz=" + shoesz
     + "&SkiType=" + skity
     + "&Stance=" + stance
     + "&MondoSiz=" + mondosz
     + "&AngleLeft=" + anglel
     + "&AngleRight=" + angler
     + "&Intl=" + intl
     + "&Action=" + action

   //alert(url+ "\n" + url.length)
     if(isIE || isSafari){ window.frame1.location.href = url; }
     else if(isChrome || isEdge) { window.frame1.src = url; }
}

//==============================================================================
// Hide selection screen
//==============================================================================
function hidePanel()
{
   document.all.dvStatus.innerHTML = " ";
   document.all.dvStatus.style.visibility = "hidden";
}
 
//==============================================================================
// get customer search panel
//==============================================================================
function getCustLst()
{
   var hdr = "Search Customer Information";

   var html = "<table class='tbl01'>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popCstSearchPanel()
     + "</td></tr>"
   + "</table>"

   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvStatus.style.width = "410";}
   else { document.all.dvStatus.style.width = "auto";}
   
   document.all.dvStatus.innerHTML = html;
   document.all.dvStatus.style.left=getLeftScreenPos() + 800;
   document.all.dvStatus.style.top=getTopScreenPos() + 100;
   document.all.dvStatus.style.visibility = "visible";
}
//==============================================================================
// populate Customer Searched
//==============================================================================
function popCstSearchPanel()
{
  var panel = "<table class='tbl02'>"
  panel += "<tr id='trReg'><td class='td48' nowrap colspan=2 style='font-size: 10px;'>"
        + "Search Criteria:"
        + "<br>&nbsp; &nbsp; &nbsp; - Phone (only)"
        + "<br>&nbsp; &nbsp; &nbsp; - E-Mail (only)"
        + "<br>&nbsp; &nbsp; &nbsp; - First Name, Last Name and Zip Code"
             + "</td>"
  panel +=  "<tr id='trReg'><td class='td48' nowrap>Phone:</td>"
  			+ "<td class='td48'><input name='Phone' size=14 maxsize=14 onkeypress='chkRetCust()'></td>"
  	   + "</tr>"
  	   + "<tr id='trReg'><td class='td48' nowrap>E-Mail:</td>"
    		+ "<td class='td48'><input name='SrchEMail' size=50 maxsize=50 onkeypress='chkRetCust()'></td>"
  	   + "</tr>"	   	
       + "<tr id='trReg'><td class='td48' nowrap>First Name:</td>"
         	+ "<td class='td48'><input name='First' size=50 maxsize=50 onkeypress='chkRetCust()'></td>"
       + "</tr>"
       + "<tr id='trReg'><td class='td48' nowrap>Last Name:</td>"
    	    + "<td class='td48'><input name='Last' size=50 maxsize=50 onkeypress='chkRetCust()'></td>"
       + "</tr>"
       + "<tr id='trReg'><td class='td48' nowrap>Zip:</td>"
         	+ "<td class='td48'><input name='SrchZip' size=10 maxsize=10 onkeypress='chkRetCust()'></td>"
       + "</tr>"
       
  panel += "<tr><td class='td48' colspan='2'><br><br><button onClick='ValidateCustSearch()' class='Small'>Search</button>&nbsp;"
  + "<button class='Small' onClick='hidePanel();'>Close</button></td></tr>"
  
  panel += "<tr><td class='tdError' colspan='2' id='tdSrchErr'></td></tr>"

     panel += "</table>";
  return panel;
}
//==============================================================================
//check serial number
//==============================================================================
function chkRetCust()
{
	e = window.event;     
	var keyCode = null;    
  if(e != null ){ keyCode = e.keyCode || e.which; }
  
  if ( keyCode == '13' )
  {  	 	
	  ValidateCustSearch();
	  e.keyCode = 0;
  }    
}
//==============================================================================
// populate Customer Searched
//==============================================================================
function ValidateCustSearch()
{
   var error = false;
   var msg = "";
   var tdSrchErr = document.getElementById("tdSrchErr");
   tdSrchErr.innerHTML = "";

   var last = document.all.Last.value.trim().toUpperCase();
   var first = document.all.First.value.trim().toUpperCase();
   var phone = document.all.Phone.value.trim().toUpperCase();
   var email = document.all.SrchEMail.value.trim().toLowerCase();
   var zip = document.all.SrchZip.value.trim();
   
   // check if entered information is enough
   var notEnough = true;   
   if (phone != null && phone != ""){ notEnough = false; }
   else if (email != null && email != ""){ notEnough = false; }
   else if (last != null && last != "" && first != null && first != "" && zip != null && zip != ""){ notEnough = false; }

   if   (notEnough)
	{
	   msg = "Please, enter search criteria - Last/First/Zip or Phone or E-Mail"
	   error = true;
	}
   
   if(error) { tdSrchErr.innerHTML = msg; }
   else { sbmCustSearch(last, first, phone, email, zip); }
}
//==============================================================================
// populate Customer Searched
//==============================================================================
function sbmCustSearch(last, first, phone, email, zip)
{
   var url = "RentCustSearch.jsp?"
     + "Last=" + last
     + "&First=" + first
     + "&Phone=" + phone
     + "&EMail=" + email
     + "&Zip=" + zip
     + "&Action=Search_Flex"
     
   hidePanel();
   
   if(isIE || isSafari){ window.frame1.location.href = url; }
   else if(isChrome || isEdge) { window.frame1.src = url; }
   
   hidePanel();
}
//==============================================================================
// customer list
//==============================================================================
function showCustLst(Cust, FirstNm, MInit, LastNm, Addr1, Addr2, City, State, Zip, EMail
  , HPhone, CPhone, Group, BDate, HeightFt, HeightIn, Weight, ShoeSiz, SkierTy, Stance
  ,RecUsr, RecDt, RecTm, MondoSiz, AngleLeft, AngleRight, CntOpn, CntRdy, CntCnl, CntPck
  , CntRtn
  , Unrel, Intl)
{
   var hdr = "Customer List";

   var html = "<table class='tbl01'>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popCustSelPanel(Cust, FirstNm, MInit, LastNm, Addr1
        , Addr2, City, State, Zip, EMail, HPhone, CPhone, Group, BDate, HeightFt, HeightIn, Weight
        , ShoeSiz, SkierTy, Stance, RecUsr, RecDt, RecTm, MondoSiz, AngleLeft, AngleRight
        , CntOpn, CntRdy, CntCnl, CntPck, CntRtn, Unrel, Intl)
     + "</td></tr>"
   + "</table>"
   
   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvStatus.style.width = "570";}
   else { document.all.dvStatus.style.width = "auto";} 

   document.all.dvStatus.innerHTML = html;
   document.all.dvStatus.style.left=getLeftScreenPos() + 300;
   document.all.dvStatus.style.top=getTopScreenPos() + 100;
   document.all.dvStatus.style.visibility = "visible";
}
//==============================================================================
// populate Customer Searched
//==============================================================================
function popCustSelPanel(Cust, FirstNm, MInit, LastNm, Addr1, Addr2, City, State, Zip, EMail
  , HPhone, CPhone, Group, BDate, HeightFt, HeightIn, Weight, ShoeSiz, SkierTy, Stance
  ,RecUsr, RecDt, RecTm, MondoSiz, AngleLeft, AngleRight, CntOpn, CntRdy, CntCnl, CntPck
  , CntRtn, Unrel, Intl)
{
  var panel = "<table class='tbl01'>"
  panel += "<tr class='trHdr10'>"
      + "<th class='th01' nowrap >ID</th>"
      + "<th class='th01' nowrap >Name</th>"
      + "<th class='th01' nowrap >Address</th>"
      + "<th class='th01' nowrap >Date</th>"            
    + "</tr>"
    

    for(var i=0; i < Cust.length; i++)
    {
       var fn = fixString(FirstNm[i]); 	
       var ln = fixString(LastNm[i]);
       
       panel += "<tr class='trDtl15'>"
           + "<td class='td77' nowrap>" + Cust[i] + "</td>"
           + "<td class='td77' nowrap><a href='javascript: setCust(&#34;" + Cust[i]
            + "&#34;, &#34;" + fn+ "&#34;, &#34;" + MInit[i] + "&#34;, &#34;" + ln
            + "&#34;, &#34;" + Addr1[i] + "&#34;, &#34;" + Addr2[i] + "&#34;, &#34;" + City[i]
            + "&#34;, &#34;" + State[i] + "&#34;, &#34;" + Zip[i] + "&#34;, &#34;" + EMail[i]
            + "&#34;, &#34;" + HPhone[i] + "&#34;, &#34;" + CPhone[i] + "&#34;, &#34;" + Group[i]
            + "&#34;, &#34;" + BDate[i] + "&#34;, &#34;" + HeightFt[i] + "&#34;, &#34;" + HeightIn[i]
            + "&#34;, &#34;" + Weight[i] + "&#34;, &#34;" + ShoeSiz[i] + "&#34;, &#34;" + SkierTy[i]
            + "&#34;, &#34;" + Stance[i] + "&#34;, &#34;" + MondoSiz[i] + "&#34;, &#34;" + AngleLeft[i]
            + "&#34;, &#34;" + AngleRight[i] + "&#34;,&#34;" + RecDt[i] + "&#34;"
            + ",&#34;" + Intl + "&#34;)'>"
              + FirstNm[i] + " " + MInit[i] + " " + LastNm[i] + "</a></td>"
           + "<td class='td77' nowrap>" + Addr1[i] + " " + Addr2[i] + " " + City[i] + " " + State[i] + " " + Zip[i] + "</td>"
           + "<td class='td77' nowrap>" + RecDt[i] + "</td>"      
        panel += "</tr>"
    }
    
    if(Cust == null || Cust.length == 0)
    {
    	panel += "<tr class='trDtl15'><td class='td78' colspan='10'>Customer is not found.</td></tr>"
    }
   
    panel += "<tr class='trDtl15'><td class='td78' colspan='10'>"
        + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"

     panel += "</table>";
  return panel;
}
//==============================================================================
// fix string - remove spec char
//==============================================================================
function fixString(str)
{
	if(str == null || str.trim() == "" || str.indexOf("'") < 0) { return str; }
	else
	{
		while(str.indexOf("'") >= 0)
		{
			str = str.replace("'", "@#@1@#@");
		}		
	}
	return str;
}
//==============================================================================
// set selected customer
//==============================================================================
function setCust(cust, firstnm, minit, lastnm, addr1, addr2, city, state, zip, email
  , hphone, cphone, group, bdate, heightft, heightin, weight, shoesiz, skierty, stance
  , mondosiz, anglel, angler, recDt, intl )
{
    // populate address with fisrst customer information
      document.all.Cust.value = cust;
      document.all.FName.value = restoreString(firstnm);
      document.all.MInit.value = minit;
      document.all.LName.value = restoreString(lastnm);
      document.all.Addr1.value = addr1;
      document.all.Addr2.value = addr2;
      document.all.City.value = city;
      document.all.State.value = state;
      document.all.Zip.value = zip;
      document.all.HPhone.value = hphone;
      document.all.CPhone.value = cphone;
      if(intl != "Y")
      {
    	  document.getElementsByName("PhoneUOM")[0].checked = true;
    	  document.getElementsByName("PhoneUOM")[1].checked = false;
      }
      else 
      {
    	  document.getElementsByName("PhoneUOM")[0].checked = false;
    	  document.getElementsByName("PhoneUOM")[1].checked = true;
      }
      document.all.EMail.value = email;
      document.all.BirthDt.value = bdate;
      document.all.Group.value = group;
      document.all.Weight.value = weight;
      document.all.HeightFt.value = heightft;
      document.all.HeightIn.value = heightin;
      //document.all.ShoeSiz.value = shoesiz;

      for(var i=0; i < document.all.SkiType.length; i++)
      {
         if(i <= 4 && document.all.SkiType[i].value == skierty){ document.all.SkiType[i].checked = true; }
         else if(i <= 4){document.all.SkiType[i].checked = false;}
         else if(i > 4 && document.all.SkiType[i].value == stance){ document.all.SkiType[i].checked = true; }
         else if(i > 4){document.all.SkiType[i].checked = false;}
      }

      //document.all.MondoSiz.value = mondosiz;
      document.all.AngleLeft.value = anglel;
      document.all.AngleRight.value = angler;

      document.all.CustLastChgDt.innerHTML = "Last Updated: " + recDt
      document.all.CustLastChgDt.style.display = "inline";
      document.getElementById("btnAddSkier").style.display="inline";
      
      setWeight('lbs')
      setHeight( 'ft')

      hidePanel();
}
//==============================================================================
//restore string -  place spec char back
//==============================================================================
function restoreString(str)
{
	if(str == null || str.trim() == "" || str.indexOf("@#@1@#@") < 0) { return str; }
	else
	{
		while(str.indexOf("@#@1@#@") >= 0)
		{
			str = str.replace("@#@1@#@", "'");
		}		
	}
	return str;
}
//==============================================================================
// refresh after add/update customer 
//==============================================================================
function refreshCust(cust)
{
	document.getElementById("Cust").value = cust;
	document.getElementById("btnAddSkier").style.display="inline";
	
	// show completeion message 
	var tdError = document.getElementById("tdError");
	var today = new Date();
	var h = today.getHours();
	var m = today.getMinutes();
	if(m < 10) { m = "0" + m;}
	
	tdError.style.color = "black";
	tdError.innerHTML = "This is your Customer ID " 
	  + "<span style='color: red; font-size: 18px; font-weight: bold; '>" + cust + "</span>" 
	  + "provide this at rental counter to help expedite contract entry. Saved at **"+ h + ":" + m
	  + "**" ;
	 
}
//==============================================================================
//reset skier 
//======================= =======================================================
function reset()
{
   document.all.btnAddSkier.style.display="none";
   document.all.lnkRtnCust.style.display="inline";
   document.all.CustLastChgDt.style.display = "none";

   // populate address with fisrst customer information
   document.all.Cust.value = "NEW";
   document.all.Action.value = "ADD_CUST_CONT";
   document.all.FName.value = "";
   document.all.FName.focus();
   document.all.MInit.value = "";
   document.all.LName.value = "";
   document.all.Addr1.value = "";
   document.all.Addr2.value = "";
   document.all.City.value = "";
   document.all.State.value = "";
   document.all.Zip.value = "";
   document.all.HPhone.value = "";
   document.all.CPhone.value = "";
   document.all.EMail.value = "";
   document.all.BirthDt.value = "";
   document.all.Group.value = "";
   document.all.Weight.value = "";
   document.all.HeightFt.value = "";
   document.all.HeightIn.value = "";
   document.all.AngleLeft.value = "";
   document.all.AngleRight.value = "";
 
   for(var i=0; i < document.all.SkiType.length; i++)
   {
      document.all.SkiType[i].checked = false;
   }
   var tdError = document.getElementById("tdError");
   tdError.innerHTML = "";
}
//==============================================================================
// add skier with same address 
//======================= =======================================================
function addSkier()
{
	   document.all.btnAddSkier.style.display="none";
	   document.all.lnkRtnCust.style.display="inline";

	   // populate address with fisrst customer information
	   document.all.Cust.value = "NEW";
	   document.all.Action.value = "ADD_CUST_CONT";
	   document.all.FName.value = "";
	   document.all.FName.focus();
	   document.all.MInit.value = "";
	   document.all.LName.value = "";
	   document.all.BirthDt.value = "";
	   document.all.Weight.value = "";
	   document.all.HeightFt.value = "";
	   document.all.HeightIn.value = "";
	   document.all.AngleLeft.value = "";
	   document.all.AngleRight.value = "";
	 
	   for(var i=0; i < document.all.SkiType.length; i++)
	   {
	      document.all.SkiType[i].checked = false;
	   }
	   var tdError = document.getElementById("tdError");
	   tdError.innerHTML = "";
}
//==============================================================================
// Hide selection screen
//==============================================================================
function hidePanel01()
{
   document.all.dvChkItm.innerHTML = " ";
   document.all.dvChkItm.style.visibility = "hidden";
}
//==============================================================================
// weight conversion - from lbs  to kg
//==============================================================================
function setWeight(uom)
{
	if(uom == 'lbs')
	{
		document.getElementsByName("WeightKg")[0].value = (document.getElementsByName("Weight")[0].value / 2.2).toFixed(0);
	}
	else if(uom == 'kg')
	{
		document.getElementsByName("Weight")[0].value = (document.getElementsByName("WeightKg")[0].value * 2.2).toFixed(0);
	}
}
//==============================================================================
// height conversion - from ft/in  to cm
//==============================================================================
function setHeight(uom)
{
	if(uom == 'ft')
	{
		var ft = document.getElementsByName("HeightFt")[0].value;
		var inch = document.getElementsByName("HeightIn")[0].value;
		document.getElementsByName("HeightCm")[0].value = (ft * 30 + inch * 2.5).toFixed(0);
	}
	else if(uom == 'cm')
	{
		var cm = document.getElementsByName("HeightCm")[0].value;
		var inch = parseInt(cm / 2.5);		
		var ft = parseInt(inch / 12); 
		inch = (inch % 12).toFixed(0)
		document.getElementsByName("HeightFt")[0].value = ft;
		document.getElementsByName("HeightIn")[0].value = inch;
	}
}
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Get_Object_Position.js"></script>

</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<iframe  id="frame2"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvStatus" class="dvItem"></div>

<!-------------------------------------------------------------------->

    <table border="0" cellPadding="0"  cellSpacing="0" width="100%">
     <tr>
     <td ALIGN="center" VALIGN="TOP" nowrap>
        <img src="Sun_ski_logo4.png" width="280px" />
        <br><b>Rental Customer Information Entry        
        </b>
      </td>
      
     <td width="40%">
       <table border="0" cellPadding="0"  cellSpacing="0" style="font-size:11px; background: #e9f0da; border: ridge 1px grey">
         <tr><td class="td80" colspan=5><b><u>Walk-In Customers Instructions (New or Returning):</u></b></td><tr>
         <tr><td class="td80" style="width: 20px;" nowrap>&nbsp;</td><td class="td80" colspan=2 nowrap><b>New Customers:</b></td><td class="td80" colspan=2  nowrap>Fill in all information including Skier Type/SB Stance, if renting Ski/SB.</td></tr>  
         <tr><td class="td80">&nbsp;</td><td class="td80"colspan=2 nowrap><b>Returning Customers:</b>&nbsp;</td><td class="td80" nowrap>Lookup prior S&S lease/renter profile - Enter Search criteria, select your NAME, verify information is correct.</td></tr>
         <tr><td class="td80">&nbsp;</td>
         <tr><td class="td80">&nbsp;</td><td class="td80"><b>Then:</b></td>
             <td class="td80" nowrap><b>Save Renter</b></td>
             <td class="td80" nowrap>Make note of your Customer ID displayed in 
                  <span style="color:red;">RED</span>
                 , to help expedite rental contract entry.
             </td></tr> 
         <tr><td class="td80">&nbsp;</td><td class="td80">&nbsp;</td><td class="td80" nowrap><b>Add Renter</b></td><td class="td80" nowrap>For additional renters (Address/E-mail/Phone will copy from previous entry).</td></tr>
         <tr><td class="td80">&nbsp;</td><td class="td80">&nbsp;</td><td class="td80"><b>Clear</b></td><td class="td80" nowrap>When finished.</td></tr>
        </table>
     </td>
    </tr>
    
    <tr>
     <td ALIGN="left" VALIGN="TOP" nowrap>
     <span style="font-size:12px; color:darkgreen;">
               <u>Existing Reservation Customers:</u>  Please go to any available Ski Tech Station.
              <br><u>Walk-In Customers (New or Returning):</u>  Follow the instructions on the right.
            </span>
     </td>
    </tr>
     
    

    <tr>
      <td ALIGN="center" VALIGN="TOP" colspan=3 nowrap>
    </table>   
<br>
    <table border="0" cellPadding="0"  cellSpacing="0" width="100%">
    <!-------------------------- Contract Info ------------------------------------>
      <!------------------------- New Renters Info entry panel --------------------->
       <tr class="trDtl06">
         <td class="td73" >
           First Name &nbsp; <input class='Small2' name="FName" maxlength=30 size=30 onFocus="this.select()"> &nbsp;
           M.I. &nbsp; <input class='Small2' name="MInit" maxlength=1 size=1 onFocus="this.select()" > &nbsp;
           Last Name &nbsp; <input class='Small2' name="LName" maxlength=30 size=30 onFocus="this.select()">
           &nbsp; &nbsp;
           <input type="hidden" name="Cust" id="Cust" readOnly>
           <input name="Action" type="hidden">
           <a id="lnkRtnCust" href="javascript: getCustLst()">Returning Customer<a> &nbsp; &nbsp; &nbsp;
           <span id="CustLastChgDt" style="display:none; font-size: 10px; font-style: italic;"></span>
         </td>
       </tr>
       <tr class="trDtl06">
         <td class="td73">
           Home Address &nbsp; <input class='Small2' name="Addr1" maxlength=50 size=50 onFocus="this.select()"> &nbsp;
                               <input class='Small2' name="Addr2" maxlength=50 size=50 onFocus="this.select()"> &nbsp;
         </td>
       </tr>
       <tr class="trDtl06">
         <td class="td73">
            City &nbsp; <input class='Small2' name="City" maxlength=50 size=50 onFocus="this.select()"> &nbsp;
               State &nbsp; <input class='Small2' name="State" maxlength=2 size=2 onFocus="this.select()"> &nbsp;
               Zip Code &nbsp; <input class='Small2' name="Zip" maxlength=10 size=10 onFocus="this.select()"> &nbsp;
         </td>
       </tr>
       <tr class="trDtl06">
         <td class="td73">
           E-Mail &nbsp; <input class='Small2' name="EMail" maxlength=50 size=50 onFocus="this.select()"> &nbsp;
           &nbsp; US <input type=radio class="Small" name="PhoneUOM" value="U"> 
           or International <input type=radio class="Small" name="PhoneUOM" value="I">
           Home Phone &nbsp; <input class='Small2' name="HPhone" maxlength=20 size=20 onFocus="this.select()"> &nbsp;
           Mobile Phone &nbsp; <input class='Small2' name="CPhone" maxlength=20 size=20 onFocus="this.select()"> &nbsp;
         </td>
       </tr>
       <tr class="trDtl06">
         <td class="td73">           
           Group Name &nbsp; <input class='Small2' name="Group" maxlength=20 size=20 onFocus="this.select()" disabled> &nbsp;
            <!-- (Create a Family or Group Name) -->
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
           Select Sport: <input type="radio" name="inpSport" value="Ski" checked>Snow Sports 
               &nbsp; &nbsp; <input type="radio" name="inpSport" value="Bike">Bikes 
               &nbsp; &nbsp; <input type="radio" name="inpSport" value="Water">Watersports 
            
            
         </td>
       </tr>
       <tr class="trDtl06">
         <td class="td73">
           <table border=1 cellPadding="0" cellSpacing="0" id="tblPerson" width="100%">
            <tr class="trDtl06">
             <td class="td11" rowspan="2">
                <table style="border: gray solid 1px;" cellPadding="0" cellSpacing="0">
                  <tr>
                    <td style="border-bottom: gray solid 1px; vertical-align: middle;">&nbsp;Age &nbsp; </td>
                    <td style="border-bottom: gray solid 1px;vertical-align: middle;" colspan=4>
                        &nbsp;<input class='Small2' name="BirthDt" maxlength=2 size=2 onFocus="this.select()"> </td>                    
                  </tr>    
                  
                  <tr>
                    <td style="border: gray solid 1px;border-right: none; vertical-align: middle;">&nbsp;US</td>
                    <td style="border: gray solid 1px;border-left: none;vertical-align: middle;" >
                        &nbsp;<input class='Small2' type="radio" name="WgtUOM" value="U" onclick="setUOM('U')"></td>
                    <td style="background:gray ">&nbsp;</td>
                    <td style="border: gray solid 1px;border-right: none;vertical-align: middle;">&nbsp;Metric</td>
                    <td style="border: gray solid 1px;border-left: none;vertical-align: middle;">
                       &nbsp;<input class='Small2' type="radio" name="WgtUOM" value="M" onclick="setUOM('M')"></td>
                  </tr>
                  <tr>
                    <td style="border: gray solid 1px;border-right: none;">&nbsp;Weight</td>
                    <td style="border: gray solid 1px;border-left: none;">
                        &nbsp;<input class='Small2' name="Weight" maxlength=3 size=3 onblur="setWeight('lbs')" onfocus="this.select()">(lbs.)</td>
                    <td style="background:gray ">&nbsp;</td>
                    <td style="border: gray solid 1px;border-right: none;">&nbsp;Weight</td>
                    <td style="border: gray solid 1px;border-left: none;">
                        &nbsp;<input class='Small2' name="WeightKg" maxlength=3 size=3 onblur="setWeight( 'kg')" onfocus="this.select()">(kg)</td>
                  </tr>
                  <tr>
                    <td style="border: gray solid 1px;border-right: none;">&nbsp;Height</td>
                    <td style="border: gray solid 1px;border-left: none;">
                        &nbsp;<input class='Small2' name="HeightFt" maxlength=1 size=1 onblur="setHeight( 'ft')"  onfocus="this.select()">(ft)
                        &nbsp;<input class='Small2' name="HeightIn" maxlength=2 size=2  onblur="setHeight('ft')"  onfocus="this.select()">(in)</td>
                    <td style="background:gray ">&nbsp;</td>
                    <td style="border: gray solid 1px;border-right: none;">&nbsp;Height</td>                 
                    <td  style="border: gray solid 1px;border-left: none;">
                        &nbsp;<input class='Small2' name="HeightCm" maxlength=3 size=3  onblur="setHeight('cm')" onfocus="this.select()">(cm)</td>                 
                  </tr>    
                </table>                
             </td>
             
            
               <td class="td18" colspan=2>                   
               If you are unsure of your Renter Type or Snowboard Stance, leave blank and speak with the Ski Technician during fitting:</b>
               </td>
            </tr> 
            <tr class="trDtl06">
             <td class="td11"><b>Skier Type (ability)</b> 
               &nbsp; 
                <table border=0 cellPadding="0" cellSpacing="0">
                  <tr>
                    <td><input class='radio' type="radio" name="SkiType" value="-1"></td>
                    <td class="td81">-I</td><td>= Beginner (Entry level)</td>                    
                  <tr>    
                  <tr>
                    <td><input class='radio' type="radio" name="SkiType" value="1"></td>
                    <td class="td81">I</td><td>= Conservative (Prefer easy moderate slopes at slower speeds)</td>
                  </tr>
                  <tr>
                   <td><input class='radio' type="radio" name="SkiType" value="2"></td>
                   <td class="td81">II</td><td>= Moderate (Prefer varied slopes and terrain at medium speeds)</td>
                  </tr>
                  <tr>
                   <td><input class='radio' type="radio" name="SkiType" value="3"></td>
                   <td class="td81">III</td><td>= Aggressive (Prefer steep slopes at high speeds)</td>
                  </tr>
                  <tr>
                   <td><input class='radio' type="radio" name="SkiType" value="3+"></td>
                   <td class="td81">III+</td><td>= Advanced</td>
                  </tr>
                </table>     
             </td>
             <td class="td11">
                    <b>Snowboard Stance</b> &nbsp; 
                <table border=0 cellPadding="0" cellSpacing="0">
                  <tr>
                   <td><input class='radio' type="radio" name="SkiType" value="R"></td>
                   <td class="td79">Regular (left foot forward)</td>
                  </tr>
                  <tr>
                   <td><input class='radio' type="radio" name="SkiType" value="G"></td>
                   <td class="td79">Goofy (right foot forward)</td>
                  </tr>
                </table>
                
                <br>
                <br>Angle &nbsp; Left <input class='Small2' name="AngleLeft" maxlength=4 size=3> &nbsp;
                          &nbsp; Right <input class='Small2' name="AngleRight" maxlength=4 size=3> &nbsp;              
             </td>
            <tr>
           </table>
         </td>
       </tr>
       <tr class="trDtl06">
         <td class="tdError" id="tdError"></td>
       </tr>    
           
    </table>
    <button class="Small" onclick="validateSkier();">Save Renter</button> &nbsp;  &nbsp;
    
    <button class="Small" id="btnAddSkier" style="display: none;" onclick="addSkier();">Add Renter</button> 
    &nbsp;  &nbsp; &nbsp;  &nbsp;    
    <button class="Small" onclick="reset();">Clear</button>
     <br>
     <br>
     

       
       <br>
   <!----------------------- end of new skier entry table ---------------------->
    </div>
   
   <br> 
   <span style="color: darkred; font-weight: bold;">
   After saving your information (and other family Renters), please proceed to the Rental area to complete the Lease/Rental process.
   </span>  
   </tr>

  </table>
 </body>
 <script>
 FootWearRented = <%=bFootWear%>;
 









