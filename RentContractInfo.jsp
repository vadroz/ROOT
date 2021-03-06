<%@page import="java.time.temporal.ChronoUnit"%>
<%@ page import="rciutility.RunSQLStmt, rental.RentContractInfo, rciutility.StoreSelect
, java.sql.*, java.util.*, java.text.*, java.util.concurrent.TimeUnit "%>
<%
   	String sSelContId = request.getParameter("ContId");
	String sSelGrp = request.getParameter("Grp");

   if(sSelContId == null){ sSelContId = "0000000000"; }
 
   
   //----------------------------------
   // Application Authorization
   //----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=RentContractInfo.jsp&APPL=ALL&" + request.getQueryString());
}
else
{
      boolean bChgCust = session.getAttribute("RECHGCUST") != null;

      StoreSelect StrSelect = null;
      String sStrAllowed = session.getAttribute("STORE").toString();
      String sUser = session.getAttribute("USER").toString();

      if (sStrAllowed != null && sStrAllowed.startsWith("ALL"))
      {
        StrSelect = new StoreSelect(10);
      }
      else
      {
         Vector vStr = (Vector) session.getAttribute("STRLST");
         String [] sStrAlwLst = new String[ vStr.size()];
         Iterator iter = vStr.iterator();

         int iStrAlwLst = 0;
         while (iter.hasNext()){ sStrAlwLst[iStrAlwLst] = (String) iter.next(); iStrAlwLst++; }

         if (vStr.size() > 1) { StrSelect = new StoreSelect(sStrAlwLst); }
         else StrSelect = new StoreSelect(new String[]{sStrAllowed});
      }

      String [] sStrAlw = StrSelect.getStrLst();

      String sPickDt = "";
      String sRtnDt = "";
      String sSts = null;
      String sStr = null;
      String sStrJsa = "";
      String sUserNm = null;
      String sPayReq = null;
      String sHalf = "";
      String sOnline = "";
      String sPickAmPm = "";
      String sDropAmPm = "";
      String sOpenDt = " ";
      String sOpenTm = " ";
 	  long lDays = 0;
      
      String sSubtot = "";
      String sTaxRate = "";
      String sTax = "";
      String sTotal = "";
       
      RentContractInfo rentinfo = null;
      int iNumOfSkr = 0;
      int iAsgEqp = 0;

      if(!sSelContId.equals("0000000000"))
      {
         rentinfo = new RentContractInfo(sSelContId, sUser);
         sPickDt = rentinfo.getPickDt();
         sRtnDt = rentinfo.getRtnDt();
         sSts = rentinfo.getSts();
         sStr = rentinfo.getStr();
         sUserNm = rentinfo.getUserNm();
         sPayReq = rentinfo.getPayReq();
               
         sHalf = rentinfo.getHalf();
         sOnline = rentinfo.getOnline();
         if(sOnline.equals("Y"))
         {
        	sSelGrp = "ALL";    
         }
         else if (sSelGrp == null || sSelGrp.equals("null"))
         {         
        	 sSelGrp = rentinfo.getGrp();
         }
         
         sPickAmPm = rentinfo.getPickAmPm();
         sDropAmPm = rentinfo.getDropAmPm();
         sOpenDt = rentinfo.getOpenDt();
         sOpenTm = rentinfo.getOpenTm();
         
         try {
             SimpleDateFormat sdfMdy = new SimpleDateFormat("MM/dd/yyyy");            
             java.util.Date dPick = sdfMdy.parse(sPickDt);
             java.util.Date dRetn = sdfMdy.parse(sRtnDt);
             
             lDays = TimeUnit.MILLISECONDS.toDays(Math.abs(dRetn.getTime() - dPick.getTime()));
             if(lDays == 0){ lDays = 1; }
             else { lDays++;  }
             }
             catch(Exception e)
             { 
                System.out.println("Error" + e.getMessage()); 
             }
             
             if(sOnline.equals("Y"))
             {
                // get calculated online payment
                 rentinfo.setOnlinePayments();
                 sSubtot = rentinfo.getSubtot();
                 sTaxRate = rentinfo.getTaxRate();
                 sTax = rentinfo.getTax();
                 sTotal = rentinfo.getTotal();
             }
             //System.out.println("RentContractSave sSelGrp=" + sSelGrp);


         if(sSts.equals(""))
         {
           response.sendRedirect("RentContListSel.jsp");
         }

         // Skiers List and personal info
         iNumOfSkr = rentinfo.getNumOfSkr();
      }
      else
      {
          String sStmt = "select store"
             + " from RCI.ReStr"
             + " where store in (";
             ;
          String sComa = "";
          for(int i=0; i < sStrAlw.length; i++)
          {
             if(sStrAlw[i] != null)
             {
               sStmt += sComa + sStrAlw[i];
               sComa = ",";
             }
          }
          sStmt +=  ")" ;

          sStmt += " order by store";
          RunSQLStmt runsql = new RunSQLStmt();
          runsql.setPrepStmt(sStmt);
          ResultSet rs = runsql.runQuery();
          int j=0;
          sComa= "";

          while(runsql.readNextRecord())
          {
             String sStrAll = runsql.getData("store").trim();
             sStrJsa += sComa + "\"" + sStrAll + "\"";
             j++;
             sComa=",";
          }

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
<title>Rent_Equipment_Order</title>

<style>
body {background:white;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}

        a.Small:link { color:blue; font-size:10px} style="font-size:11px" { color:blue; font-size:10px}  a.Small:hover { color:blue; font-size:10px}

        table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}
        table.DataTable1 { border: darkred solid 1px;background:Cornsilk;text-align:center;}
        
        table.tbl01 { border:none; padding: 0px; border-spacing: 0; border-collapse: collapse; width:100%}
 		table.tbl02 { border: lightblue ridge 2px; margin-left: auto; margin-right: auto; 
         padding: 0px; border-spacing: 0; border-collapse: collapse; }
        
        th.DataTable { background:white;padding-top:3px; padding-bottom:3px;
                       text-align:left; vertical-align:top; font-family:Verdanda; font-size:12px }
        th.DataTable1 { padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px;
                        border-bottom: darkred solid 1px;border-right: darkred solid 1px;
                        text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable2 { padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px;
                        border-left: black solid 1px;
                        text-align:center; font-family:Verdanda; font-size:10px }
        th.DataTable21 { padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px;
                        border-bottom: darkred solid 1px;border-right: darkred solid 3px;
                        text-align:center; font-family:Verdanda; font-size:10px }
        th.DataTable3 { background:white;padding-top:3px; padding-bottom:3px;
                        text-align:left; ; vertical-align:top; font-family:Verdanda; font-size:12px }
        th.DataTable4 { background:white;padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:top; font-family:Verdanda; font-size:12px }

        tr.DataTable { background:white; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:#e7e7e7; font-family:Arial; font-size:10px }
        tr.DataTable2 { background:white; font-family:Arial; font-size:12px; font-weight: bold }
        tr.DataTable3 { background:CornSilk; font-family:Arial; font-size:10px }
        tr.DataTable4 { background:#FFCC99; font-family:Arial; font-size:10px; vertical-align:top; }
        tr.DataTable41 { background:#ccccff; color: darkred; font-family:Arial; font-size:12px; vertical-align:top; }
        tr.DataTable5 { background:#e7e7e7; font-family:Arial; font-size:10px }
        tr.DataTable6 { background: lightpink; font-family:Arial; font-size:10px }
        tr.DataTable7 { background: #cccfff; font-family:Arial; font-size:10px }
        tr.DataTable8 { background: #ccffcc; font-family:Arial; font-size:10px }
        tr.DataTable9 { background: LemonChiffon; font-family:Arial; font-size:10px }
        tr.DataTable10 { background: yellow; font-family:Arial; font-size:10px }
        tr.Divider { background:black; font-family:Arial; font-size:1px }


        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:left;}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:center;}

        td.DataTable3 { border-bottom: darkred solid 1px;border-right: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center;}
        td.DataTable31 { border-bottom: darkred solid 1px;border-right: darkred solid 3px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center;}
        td.DataTable4 { border-bottom: darkred solid 1px;border-right: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;}
        td.DataTable5 { border-bottom: darkred solid 1px;border-right: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center;}

        td.StrInv { cursor:hand; padding-top:3px; padding-bottom:3px;
                    padding-left:3px; padding-right:3px;
                    border-bottom: darkred solid 1px; text-align:left;}

        td.StrInv1{ padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                    border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                    text-align:left;}

        td.StrLst { background:#FFCC99; border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                    text-align:center; font-size:9px}

        .Small {font-family:Arial; font-size:10px }
        .Large {font-family:Arial; font-size:18px; font-weight:bold; }
        
        input.Small1 { font-family:Arial; font-size:10px }
        input.Small2 {background: white; border:none; border-bottom:1px black solid; font-family:Arial;  font-size:10px }
        input.Small3 {border:none; font-family:Arial;  font-size:10px }
        input.Small4 {background:#e7e7e7; border:none; border-bottom:1px black solid; font-family:Arial;  font-size:10px }
        input.Small5 {color: gray; background:#e7e7e7; border:none; border-bottom:1px black solid; font-family:Arial;  font-size:10px }
        input.radio { font-family:Arial; font-size:10px }
        input.Menu {border: ridge 2px; background:white; font-family:Arial; font-size:10px }
           
        input.inpAsDate { font-weight:bold; }   
        input.inpAsDateLink { font-weight:bold; text-decoration: underline; color: blue; cursor:pointer; }

        textarea {border:none; background:#E7E7E7; border-bottom: black solid 1px; font-family:Arial; font-size:10px }
        button.Small {font-size:10px; }
        select.selSts {display:none;font-size:10px; }
        button.selSts {display:none;font-size:10px; }
        input.selSts {display:none;font-size:10px; }
        .Warn { color: yellow; }

        div.dvStatus  { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:200; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        div.dvChkItm  { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:200; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        div.dvHelp  { position:absolute; visibility:hidden; background-attachment: scroll;
              border: lightgray solid 1px;; width:50; background-color:LemonChiffon; z-index:10;
              padding:3px;
              text-align:center; font-size:10px}
              
         div.dvHelpDoc { position:absolute;border: none;text-align:center; width: 50px;height:50px; 
     top: 0; right: 50px; font-size:11px; white-space: nowrap;}
  
    
  a.helpLink { background-image:url("/scripts/Help02.png"); display:block;
     height:50px; width:50px; text-indent:-9999px; }
     
              

        td.BoxName {cursor:move; background: #016aab; color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand; background: #016aab;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
        
        #btnBootTag { display:none; }
</style>

<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
var StrLst = [<%=sStrJsa%>];
var SelGrp = "<%=sSelGrp%>";
var UserId = "<%=sUser%>";
var ContractId = "<%=sSelContId%>";
var NewContract = <%=sSelContId.equals("0000000000")%>;
var Lease = false;
var ContCust = null; 

var PickDt = "<%=sPickDt%>";
var RtnDt = "<%=sRtnDt%>";
var PickAmPm = "<%=sPickAmPm%>";
var DropAmPm = "<%=sDropAmPm%>";

var Dpt = new Array();
var DptNm = new Array();
var Sport = new Array();
var Cls = new Array();
var ClsNm = new Array();

// save first customer on contract address
var DftAddr1 = "";
var DftAddr2 = "";
var DftCity = "";
var DftState = "";
var DftZip = "";
var DftHPhone = "";
var DftIntl = "";
var DftEMail = "";
var DftGroup = "";


var NumOfCommt = 0;

var SelCust = null;
var SelFirstNm = null;
var SelMInit = null;
var SelLastNm = null;
var SelDesc = null;
var SelSize = null;
var SelSrlNum = null;
var SelStr = "<%=sStr%>"

var FootWearRented = <%=bFootWear%>;
var AsgEqp = <%=(iAsgEqp > 0)%>;

var ExClsNm = ""; 

var NumOfSkr = "<%=iNumOfSkr%>";
var SkrFName = new Array();
var SkrLName = new Array();
var SkrId = new Array();
var SkrPrim = new Array();

//--------------- End of Global variables ----------------
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{
   if (ua.match(/iPad/i) || ua.match(/iPhone/i)) { isSafari = true; }
   
   setBoxclasses(["BoxName",  "BoxClose"], ["dvChkItm", "dvStatus"]);
   doSelDate();
   getAvailEquip();
   //set store selection
   <%if(sSelContId.equals("0000000000")) {%>
   
   document.getElementsByName("PhoneUOM")[0].checked=true;
   document.getElementsByName("PhoneUOM")[1].checked=false;
   document.getElementsByName("UOM")[0].checked = true;
   document.getElementsByName("UOM")[1].checked = false;   
   setStrSel(); 
   setUOM("U");
   setWeight('lbs');
   setHeight('ft');
   <%}
     else {%> getComments(); <%}%>
   
   setSport();   
   
}


//==============================================================================
//set sport group
//==============================================================================
function setSport()
{
	// sport group  
	var tblperson = document.all.tblPerson;
	if(SelGrp == "SKI"){ tblperson.style.visibility = "visible"; }
	else if(SelGrp == "WATER"){ tblperson.style.visibility = "hidden"; }
	else if(SelGrp == "BIKE"){ tblperson.style.visibility = "hidden"; }
	
	if(NewContract && StrLst.length > 1)
	{
		for(var i=0; i < StrLst.length; i++)
		{
			if(SelGrp == "WATER")
			{
	    		if( document.getElementsByName("SelStr")[i].value == "28"){ document.getElementsByName("SelStr")[i].checked = true; }
	    		else
	    		{ 
	    			document.getElementsByName("SelStr")[i].checked = false; 
	    			document.getElementsByName("SelStr")[i].disabled = true;
	    		}
			}
			else if(SelGrp == "SKI") { document.all.SelStr[i].checked = false; }
		}
	}
}
//==============================================================================
//  set store selection
//==============================================================================
function setStrSel()
{
   html = "";
   for(var i=0; i < StrLst.length; i++)
   {
      html += "<input type='radio' name='SelStr' value='" + StrLst[i] + "'>" + StrLst[i] + " &nbsp; ";
   }

   document.all.spnStrLst.innerHTML = html;
   if(StrLst.length == 1){ document.getElementsByName("SelStr")[0].checked = true;  }
}
//==============================================================================
// Open new contract
//==============================================================================
function openCont()
{
   var error=false;
   var msg = "";
   var numdgt = 0;

   var str = null;
   if ( StrLst.length > 1 )
   {
      for(var i=0; i < document.all.SelStr.length; i++)
      {
         if(document.all.SelStr[i].checked){ str = document.all.SelStr[i].value; break;}
      }
      if(str==null){ error=true; msg += "Please, select a store."; }
   }
   else
   {
       str = document.all.SelStr.value;
   }

   var usernm = UserId;
   if(ContractId == "0000000000" && UserId.indexOf("cashr") >= 0)
   {
       usernm = document.all.UserNm.value.trim();
       if (usernm == "")  {   error=true; msg += "Please, type your name.";  }
   }

   var cust = document.all.Cust.value.trim();
   if(cust=="NEW"){ cust = " ";}

   var frdate = document.all.FrDate.value.trim();
   var todate = document.all.ToDate.value.trim();
   var dtToday = new Date(new Date() - 86400000 * 30); 
   var dtFrom = new Date(frdate);
   var dtTo = new Date(todate);

   dtToday.setHours(6,0,0,0,0);
   dtFrom.setHours(6,0,0,0,0);
   dtTo.setHours(6,0,0,0,0);
   
   if(dtFrom > dtTo){error=true; msg += "\nPick up date is greater then Drop off date";}
   if(dtFrom < dtToday){error=true; msg += "\nPick up date cannot be less then todays date.";}

   var pickAmPm = "AM"; 
   if(document.getElementsByName("PickAmPm")[1].checked){ pickAmPm = "PM"; }
   var dropAmPm = "AM"; 
   if(document.getElementsByName("DropAmPm")[1].checked){ dropAmPm = "PM"; }
   
   var fname = document.all.FName.value.trim().replaceSpecChar();
   if(fname==""){ error=true; msg += "\nPlease enter first name."; }

   var minit = document.all.MInit.value.trim();
   minit = minit.replace(/[^\w\s]/gi, '');
   document.all.MInit.value = minit;

   var lname = document.all.LName.value.trim().replaceSpecChar();
   if( lname==""){ error=true; msg += "\nPlease enter last name."; }

   var addr1 = document.all.Addr1.value.trim().replaceSpecChar();
   var addr2 = document.all.Addr2.value.trim().replaceSpecChar();
   if( addr1=="" && addr2==""){ error=true; msg += "\nPlease, enter address."; }

   var city = document.all.City.value.trim().replaceSpecChar();
   if( city==""){ error=true; msg += "\nPlease enter city name."; }

   var state = document.all.State.value.trim().replaceSpecChar();
   if( state==""){ error=true; msg += "\nPlease enter state name."; }
   numdgt = state.length;
   if( numdgt != 2){ error=true; msg += "\nInvalid State name. Must be 2 characters."; }

   var zip = document.all.Zip.value.trim().replaceSpecChar();
   if( zip==""){ error=true; msg += "\nPlease enter zip code."; }
   numdgt = zip.length;
   if( numdgt < 5){ error=true; msg += "\nInvalid Zip code. Must be equal or greater then 5 characters."; }

   var email = document.all.EMail.value.trim().replaceSpecChar();
   if(email == ""){ error=true; msg += "\nPlease enter E-Mail address."; }
   else if(email != "" && !checkEmail(email)){ error=true; msg += "\nInvalid E-Mail address."; }

   var hphone = document.all.HPhone.value.trim().replaceSpecChar();
   var cphone = document.all.CPhone.value.trim().replaceSpecChar();
   if( hphone=="" && cphone==""){ error=true; msg += "\nPlease, enter Home or Cell phone numbers."; }

   numdgt = hphone.length;
   for(var i=0; i < hphone.length; i++)
   {
      if( hphone.substring(i,i+1) == "-" )
      {
         numdgt += -1;
      }
   }
   if( hphone!="" && numdgt != 10){ error=true; msg += "\nInvalid Home phone number. Must be 10 digits."; }

   numdgt = cphone.length;
   for(var i=0; i < cphone.length; i++)
   {
      if( cphone.substring(i,i+1) == "-" )
      {
         numdgt += -1;
      }
   }
   if( cphone!="" && numdgt != 10){ error=true; msg += "\nInvalid Cell phone number. Must be 10 digits."; }
   
   var parent = ""; 
   var parentChk =  document.getElementsByName("Parent")[0].checked;
   if(document.getElementsByName("Parent")[0].checked){ parent = "Y"; }
   
   var bdate = document.all.BirthDt.value.trim().replaceSpecChar();
   if( SelGrp == "SKI" && (bdate=="" || bdate=="0")){ error=true; msg += "\nPlease enter Age."; }

   var group = document.all.Group.value.trim().replaceSpecChar();

   var weight = document.all.Weight.value.trim().replaceSpecChar();
   if( parent == "" && SelGrp == "SKI" && weight==""){ error=true; msg += "\nPlease enter skier weight."; }

   var hgtft = document.all.HeightFt.value.trim().replaceSpecChar();
   if( parent == "" && SelGrp == "SKI" && hgtft==""){ error=true; msg += "\nPlease enter skier height(ft)."; }
   var hgtin = document.all.HeightIn.value.trim().replaceSpecChar();
   if( parent == "" && SelGrp == "SKI" && hgtin==""){ error=true; msg += "\nPlease enter skier height(in)."; }

   var shoesz = "0"; //document.all.ShoeSiz.value.trim().replaceSpecChar();
   //if( shoesz==""){ error=true; msg += "\nPlease, enter skier shoe size."; }

   var dmgwvr = "";
   for(var i=0; i < document.all.DmgWaiver.length; i++)
   {
      if(document.all.DmgWaiver[i].checked){ dmgwvr = document.all.DmgWaiver[i].value; break;}      
   }
   if(dmgwvr == "" ){ error=true; msg += "\nPlease select or decline Damage Waiver."; }
   
   var skity = "";
   var stance = "";
   for(var i=0; i < document.all.SkiType.length; i++)
   {
      if(i <= 4 && document.all.SkiType[i].checked){ skity = document.all.SkiType[i].value; }
      else if(i > 4 && document.all.SkiType[i].checked){ stance = document.all.SkiType[i].value; }
   }
   if(parent == "" && SelGrp == "SKI" && skity == "" && stance == ""){ error=true; msg += "\nPlease enter Skier Type or Snowboard Stance."; }
   if(skity == "3+"){ skity = "3%2B";}
      
   var mondosz = "";//document.all.MondoSiz.value.trim().replaceSpecChar();
   var anglel = document.all.AngleLeft.value.trim().replaceSpecChar();;
   var angler = document.all.AngleRight.value.trim().replaceSpecChar();;
   if(parent == "" && stance != "" && (anglel == "" || angler == ""))
   {
      error=true; msg += "\nPlease enter Snowboard Left and Right Angle.";
   }
   
   var half = "";
   /*
   var half_check = document.getElementsByName("inpHalf")[0];
   if(SelGrp == "BIKE" && frdate == todate && half_check.checked)
   {
	   half = "Y";
   }
   */
   

   if(error){ alert(msg); }
   else{ sbmOpenCont(str, cust, frdate, todate, fname, minit, lname, addr1, addr2, city
	, state, zip, email, hphone, cphone, bdate, group, weight, hgtft, hgtin, shoesz
	, skity, stance, mondosz, anglel, angler, usernm, dmgwvr, half, parent
	, pickAmPm, dropAmPm) 
  }
}

//==============================================================================
// Open new contract
//==============================================================================
function sbmOpenCont(str, cust, frdate, todate, fname, minit, lname, addr1, addr2
	, city, state, zip, email, hphone, cphone, bdate, group, weight, hgtft, hgtin
	, shoesz, skity, stance, mondosz, anglel, angler, usernm, dmgwvr, half, parent
	, pickAmPm, dropAmPm)
{
   var url = "RentContractSave.jsp?Str=" + str
     + "&Cust=" + cust
     + "&Grp=" + SelGrp
     + "&FrDate=" + frdate
     + "&ToDate=" + todate
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
     + "&UserNm=" + usernm
     + "&DmgWvr=" + dmgwvr
     + "&HalfDay=" + half
     + "&Parent=" + parent
     + "&PickAmPm=" + pickAmPm
     + "&DropAmPm=" + dropAmPm
     + "&Action=OPEN_CONT"

   //alert(url)
   window.frame1.location.href = url;
}

//==============================================================================
// validate Skier
//==============================================================================
function chgSkier(cust, fname, minit, lname, addr1, addr2, city, state, zip, email
     , hphone, cphone, group, bdate, heightft, heightin, weight, shoesiz, skiertype
     , stance, payee, mondosz, anglel, angler, dmgwvr, intl, parent, equip, skiskr)
{
      // populate address with fisrst customer information
      document.all.Cust.value = cust;
      document.all.Action.value = "UPD_CUST_CONT";
      document.all.FName.value = fname;
      document.all.MInit.value = minit;
      document.all.LName.value = lname;
      document.all.Addr1.value = addr1;
      document.all.Addr2.value = addr2;
      document.all.City.value = city;
      document.all.State.value = state;
      document.all.Zip.value = zip;
      document.all.HPhone.value = hphone;
      document.all.CPhone.value = cphone;
      document.all.EMail.value = email;
      document.all.BirthDt.value = bdate;
      document.all.Group.value = group;
      document.all.Weight.value = weight;
      document.all.HeightFt.value = heightft;
      document.all.HeightIn.value = heightin;
      
      if(intl != "Y")
      {
    	  document.getElementsByName("PhoneUOM")[0].checked=true;
    	  document.getElementsByName("PhoneUOM")[1].checked=false;
      }
      else
      {
    	  document.getElementsByName("PhoneUOM")[0].checked=false;
    	  document.getElementsByName("PhoneUOM")[1].checked=true;
      }

      for(var i=0; i < document.all.SkiType.length; i++)
      {
         if(i <= 4 && document.all.SkiType[i].value == skiertype){ document.all.SkiType[i].checked = true; }
         else if(i <= 4){document.all.SkiType[i].checked = false;}
         else if(i > 4 && document.all.SkiType[i].value == stance){ document.all.SkiType[i].checked = true; }
         else if(i > 4){document.all.SkiType[i].checked = false;}
      }
      
      for(var i=0; i < document.all.DmgWaiver.length; i++)
      {
    	  if(document.all.DmgWaiver[i].value == dmgwvr) { document.all.DmgWaiver[i].checked = true; break; }
      }
      

      //document.all.MondoSiz.value = mondosz;
      document.all.AngleLeft.value = anglel;
      document.all.AngleRight.value = angler;

      document.all.dvNewSkiers.style.display="block";
      document.all.btnAddSkier.style.display="none";
      document.all.btnAddPartner.style.display="none";      
      document.all.lnkRtnCust.style.display="none";
      
      document.getElementsByName("UOM")[0].checked = true;
      document.getElementsByName("UOM")[1].checked = false;  
      
      if(parent=="Y"){  document.getElementsByName("Parent")[0].checked = true; }
      
      if(equip){ document.getElementsByName("Parent")[0].disabled = true; }
      
      document.getElementsByName("SkiRent")[0].checked = skiskr;
      
      setUOM("U");
      setWeight('lbs');
      setHeight('ft');
}

//==============================================================================
//set UOM for Hegth and weight
//==============================================================================
function setUOM(type)
{
	if(type=="U")
	{
		document.getElementsByName("Weight")[0].disabled = false;
		document.getElementsByName("WeightKg")[0].disabled = true;
		
		document.getElementsByName("HeightFt")[0].disabled = false;
		document.getElementsByName("HeightIn")[0].disabled = false;
		document.getElementsByName("HeightCm")[0].disabled = true;		 	
	}
	else
	{
		document.getElementsByName("Weight")[0].disabled = true;
		document.getElementsByName("WeightKg")[0].disabled = false;
		
		document.getElementsByName("HeightFt")[0].disabled = true;
		document.getElementsByName("HeightIn")[0].disabled = true;
		document.getElementsByName("HeightCm")[0].disabled = false;
		
		document.getElementsByName("WeightKg")[0].focus();
		document.getElementsByName("WeightKg")[0].select();	
	}
}
//==============================================================================
//weight conversion - from lbs  to kg
//==============================================================================
function setWeight(uom)
{
	if(uom == 'lbs')
	{
		document.getElementById("WeightKg").value = (document.getElementById("Weight").value / 2.2).toFixed(0);
	}
	else if(uom == 'kg')
	{
		document.getElementById("Weight").value = (document.getElementById("WeightKg").value * 2.2).toFixed(0);
	}
}
//==============================================================================
//height conversion - from ft/in  to cm
//==============================================================================
function setHeight(uom)
{
	if(uom == 'ft')
	{
		var ft = document.getElementById("HeightFt").value;
		var inch = document.getElementById("HeightIn").value;
		document.getElementById("HeightCm").value = (ft * 30 + inch * 2.5).toFixed(0);
	}
	else if(uom == 'cm')
	{
		var cm = document.getElementById("HeightCm").value;
		var inch = parseInt(cm / 2.5);		
		var ft = parseInt(inch / 12); 
		inch = (inch % 12).toFixed(0)
		document.getElementById("HeightFt").value = ft;
		document.getElementById("HeightIn").value = inch;
	}
}
//==============================================================================
// validate Skier
//==============================================================================
function validateSkier()
{
   var error=false;
   var msg = "";
   var numdgt = 0;

   var action = "ADD_CUST";
   var cust = document.all.Cust.value;
   if( cust !="NEW"){ action = "UPD_CUST"; }
   else{ cust = ""; }

   var skierAction = document.all.Action.value.trim();
   if (skierAction != ""){  action += "_" + skierAction; }

   var fname = document.all.FName.value.trim();
   if(fname==""){ error=true; msg += "Please, enter first name."; }
   else if(isWrongChar(fname, 1)){ error=true; msg += "\nThe first name contained unallowed special character(s)."; }
   else{ fname = fname.replaceSpecChar(); }

   var minit = document.all.MInit.value.trim();
   minit = minit.replace(/[^\w\s]/gi, '');
   document.all.MInit.value = minit;

   var lname = document.all.LName.value.trim();
   if( lname==""){ error=true; msg += "\nPlease enter last name."; }
   else if(isWrongChar(lname, 1)){ error=true; msg += "\nThe last name contained unallowed special character(s)."; }
   else{ lname = lname.replaceSpecChar(); }

   var addr1 = document.all.Addr1.value.trim();
   if(isWrongChar(addr1, 1)){ error=true; msg += "\nThe Address Line 1 contained unallowed special character(s)."; }
   else{ addr1 = addr1.replaceSpecChar() };
   
   var addr2 = document.all.Addr2.value.trim();
   if(isWrongChar(addr2, 1)){ error=true; msg += "\nThe Address Line 2 contained unallowed special character(s)."; }
   else{ addr2 = addr2.replaceSpecChar() };   
   
   if( addr1=="" && addr2==""){ error=true; msg += "\nPlease enter address."; }

   var city = document.all.City.value.trim();
   if( city==""){ error=true; msg += "\nPlease enter city name."; }
   else if(isWrongChar(city, 1)){ error=true; msg += "\nThe city contained unallowed special character(s)."; }
   else{ city = city.replaceSpecChar() };   

   var state = document.all.State.value.trim();
   if( state==""){ error=true; msg += "\nPlease enter state name."; }
   else if(isWrongChar(state, 2)){ error=true; msg += "\nThe state contained unallowed special character(s)."; }
   else{ state = state.replaceSpecChar() };   
   
   numdgt = state.length;
   if( numdgt != 2){ error=true; msg += "\nInvalid State name. Must be 2 characters."; }

   var zip = document.all.Zip.value.trim();
   if( zip==""){ error=true; msg += "\nPlease enter zip code."; }
   else if(isWrongChar(zip, 2)){ error=true; msg += "\nThe zip code contained unallowed special character(s)."; }
   else{ zip = zip.replaceSpecChar() };   
   
   numdgt = zip.length;
   if( numdgt < 5){ error=true; msg += "\nInvalid Zip code. Must be equal or greater then 5 characters."; }

   var email = document.all.EMail.value.trim();
   if(email == ""){ error=true; msg += "\nPlease, enter E-Mail address."; }
   else if(isWrongChar(email, 3)){ error=true; msg += "\nThe E-Mail contained unallowed special character(s)."; }
   else{ email = email.replaceSpecChar() };   
   if(email != "" && !checkEmail(email)){ error=true; msg += "\nInvalid E-Mail address."; }
      

   var hphone = document.all.HPhone.value.trim();
   if(isWrongChar(hphone, 3)){ error=true; msg += "\nThe Home phone number contained unallowed special character(s)."; }
   else{ hphone = hphone.replaceSpecChar() };   
   
   var cphone = document.all.CPhone.value.trim();
   if(isWrongChar(cphone, 3)){ error=true; msg += "\nThe Cell phone number contained unallowed special character(s)."; }
   else{ cphone = cphone.replaceSpecChar() };   
   
   if( hphone=="" && cphone==""){ error=true; msg += "\nPlease, enter Home or Cell phone numbers."; }

   var intl = "";
   if(document.getElementsByName("PhoneUOM")[1].checked)
   {
	   intl = "Y";
   }
   
   numdgt = hphone.length;
   for(var i=0; i < hphone.length; i++)
   {
      if( hphone.substring(i,i+1) == "-" )
      {
         numdgt += -1;
      }
   }
   if( intl=="" && hphone!="" && numdgt != 10){ error=true; msg += "\nInvalid Home phone number. Must be 10 digits."; }

   numdgt = cphone.length;
   for(var i=0; i < cphone.length; i++)
   {
      if( cphone.substring(i,i+1) == "-" )
      {
         numdgt += -1;
      }
   }
   if( intl=="" && cphone!="" && numdgt != 10){ error=true; msg += "\nInvalid Cell phone number. Must be 10 digits."; }

   var parent = ""; 
   var parentChk =  document.getElementsByName("Parent")[0].checked;
   if(document.getElementsByName("Parent")[0].checked){ parent = "Y"; }
   
   var bdate = document.all.BirthDt.value.trim().replaceSpecChar();
   if( bdate=="" || bdate =="0" ){ error=true; msg += "\nPlease, enter Age."; }

   var group = document.all.Group.value.trim().replaceSpecChar();

   var skirent =  document.getElementsByName("Parent")[0].checked;
   
   var weight = document.all.Weight.value.trim().replaceSpecChar();
   if( skirent && parent == "" && weight==""){ error=true; msg += "\nPlease enter skier weight."; }

   var hgtft = document.all.HeightFt.value.trim().replaceSpecChar();
   if( skirent && parent == "" && hgtft==""){ error=true; msg += "\nPlease, enter skier height(ft)."; }
   var hgtin = document.all.HeightIn.value.trim().replaceSpecChar();
   if( parent == "" && hgtin==""){ error=true; msg += "\nPlease enter skier height(in)."; }

   var shoesz = "0"; //document.all.ShoeSiz.value.trim().replaceSpecChar();
   if( skirent && parent == "" && shoesz==""){ error=true; msg += "\nPlease enter skier shoe size."; }
   
   var dmgwvr = "";
   for(var i=0; i < document.all.DmgWaiver.length; i++)
   {
      if(document.all.DmgWaiver[i].checked){ dmgwvr = document.all.DmgWaiver[i].value; break;}      
   }
   if(parent == "" && dmgwvr == "" ){ error=true; msg += "\nPlease select or decline Damage Waiver."; }
   
   var skity = "";
   var stance = "";
   for(var i=0; i < document.all.SkiType.length; i++)
   {
      if(i <= 4 && document.all.SkiType[i].checked){ skity = document.all.SkiType[i].value; }
      else if(i > 4 && document.all.SkiType[i].checked){ stance = document.all.SkiType[i].value; }
   }
   if(skirent && parent == "" && skity == "" && stance == ""){ error=true; msg += "\nPlease enter Skier Type or Snowboard Stance."; }

   if(skity == "3+"){ skity = "3%2B";}
   
   var mondosz = "0"; //document.all.MondoSiz.value.trim().replaceSpecChar();
   var anglel = document.all.AngleLeft.value.trim().replaceSpecChar();;
   var angler = document.all.AngleRight.value.trim().replaceSpecChar();;
   if(skirent && parent == "" && stance != "" && (anglel == "" || angler == ""))
   {
      error=true; msg += "\nPlease enter Snowboard Left and Right Angle.";
   }


   if(error){ alert(msg); }
   else{ sbmAddSkier(cust, fname, minit, lname, addr1, addr2, city, state, zip, email, hphone, cphone
     , bdate, group, weight, hgtft, hgtin, shoesz, skity, stance, mondosz, anglel, angler
     , dmgwvr, intl,parent, action) }
}
//==============================================================================
//test for special characters - exclude ', #, -
//==============================================================================
function isWrongChar(str, set)
{	
	var found  = false;
	var wrong = "";
	var wrong1 = "~`!$%^&*+=[]\\;,/{}|\":<>?"; // allow ', #, -
	var wrong2 = "~`!#$%^&*+=-[]\\\';,/{}|\":<>?"; // exclude all
	var wrong3 = "~`!#$%^&*+=[]\\\';,/{}|\":<>?"; // allow -
	
	if(set == 1){ wrong = wrong1; }
	else if(set == 2){ wrong = wrong2; }
	else if(set == 3){ wrong = wrong3; }
	
	for(var i=0; i < str.length; i++)
	{
		if(wrong.indexOf(str.charAt(i)) != - 1 ) 
		{
			found = true;
			break;
		}
	}

	return found;
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
     , bdate, group, weight, hgtft, hgtin, shoesz, skity, stance, mondosz, anglel, angler
     , dmgwvr, intl, parent, action)
{
   var url = "RentContractSave.jsp?"
     + "&Cont=<%=sSelContId%>"
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
     + "&DmgWvr=" + dmgwvr
     + "&Intl=" + intl
     + "&Parent=" + parent
     + "&Action=" + action

   //alert(url+ "\n" + url.length)
   window.frame1.location.href = url;
}
//==============================================================================
// add skier
//==============================================================================
function dltSkier(cust)
{
    var url = "RentContractSave.jsp?Str=<%=sStr%>"
     + "&Cont=<%=sSelContId%>"
     + "&Cust=" + cust
     + "&Action=DLT_CUST_CONT"

   //alert(url+ "\n" + url.length)
   window.frame1.location.href = url;
}

//==============================================================================
// change contract status
//==============================================================================
function chgStatusMenu(cont, cursts)
{
   var hdr = "Contract: " + cont + "  Current Status: " + cursts + " &nbsp; ";

   var html = "<table class='tbl01'>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popStatusPanel()
     + "</td></tr>"
   + "</table>"

   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvStatus.style.width = "300";}
   else { document.all.dvStatus.style.width = "auto";} 
   
   document.all.dvStatus.innerHTML = html;
   document.all.dvStatus.style.left=getLeftScreenPos() + 140;
   document.all.dvStatus.style.top=getTopScreenPos() + 95;
   document.all.dvStatus.style.visibility = "visible";

   document.all.selSts.options[0] = new Option("OPEN","OPEN");
   document.all.selSts.options[1] = new Option("READY","READY");
   document.all.selSts.options[2] = new Option("PICKEDUP","PICKEDUP");
   document.all.selSts.options[3] = new Option("RETURNED","RETURNED");
   document.all.selSts.options[4] = new Option("CANCELLED","CANCELLED");

   document.all.FrDate1.value = PickDt;
   document.all.ToDate1.value = RtnDt
   document.all.tdUnrel.style.display="none";
   
   if(PickAmPm == "A"){ document.getElementsByName("PickAmPm1")[0].checked = true; }
   else { document.getElementsByName("PickAmPm1")[0].checked = false; } 
   if(PickAmPm == "P"){ document.getElementsByName("PickAmPm1")[1].checked = true; }
   else { document.getElementsByName("PickAmPm1")[1].checked = false; } 
   
   if(DropAmPm == "A"){ document.getElementsByName("DropAmPm1")[0].checked = true; }
   else { document.getElementsByName("DropAmPm1")[0].checked = false; }
   if(DropAmPm == "P"){ document.getElementsByName("DropAmPm1")[1].checked = true; }
   else { document.getElementsByName("DropAmPm1")[1].checked = false; }
}
//==============================================================================
// populate Entry Panel
//==============================================================================
function popStatusPanel()
{
  var panel = "<table class='tbl01'>"
  panel += "<tr class='DataTable9'>"
          + "<td>Status </td>"
          + "<td colspan=7 nowrap><select name='selSts' class='Small' onchange='chkSelSts(this)'></select></td>"
        + "</tr>"

        + "<tr class='DataTable9'>"
         + "<td nowrap>Pick Up</td>"
         + "<td nowrap>"
             + "<button class='Small' name='Down' onClick='setDate(&#34;DOWN&#34;, &#34;FrDate1&#34;)'>&#60;</button>"
             + "<input name='FrDate1' class='Small' type='text' size=10 maxlength=10 readonly>&nbsp;"
             + "<button class='Small' name='Up' onClick='setDate(&#34;UP&#34;, &#34;FrDate1&#34;)'>&#62;</button>"
             + "<a href='javascript:showCalendar(1, null, null, 200, 250, document.all.FrDate1)' >"
             + "<img src='calendar.gif' alt='Calendar Prompt' width='34' height='21'></a>"             
          + "</td>"
          + "<td nowrap> &nbsp; &nbsp; &nbsp; &nbsp; </td>"
          + "<td nowrap>Drop Off</td>"
          + "<td class='DataTable' nowrap>"
            + "<button class='Small' name='Down' onClick='setDate(&#34;DOWN&#34;, &#34;ToDate1&#34;)'>&#60;</button>"
            + "<input name='ToDate1' class='Small' type='text' size=10 maxlength=10 readonly>&nbsp;"
            + "<button class='Small' name='Up' onClick='setDate(&#34;UP&#34;, &#34;ToDate1&#34;)'>&#62;</button>"
            + "<a href='javascript:showCalendar(1, null, null, 500, 250, document.all.ToDate1)' >"
            + "<img src='calendar.gif' alt='Calendar Prompt' width='34' height='21'></a>"
          + "</td>"
       + "</tr>";
  
       
  panel += "<tr class='DataTable9'>"
	  + "<td nowrap>&nbsp;</td>"
	  + "<td nowrap>"
	  	+ "<input name='PickAmPm1'  type='radio' value='A'>AM &nbsp;"
      	+ "<input name='PickAmPm1'  type='radio' value='P'>PM &nbsp;"
	  + "</td>"
	  + "<td nowrap>&nbsp;</td>"
	  + "<td nowrap>&nbsp;</td>"
	  + "<td nowrap>"
	  	+ "<input name='DropAmPm1'  type='radio' value='A'>AM &nbsp;"
      	+ "<input name='DropAmPm1'  type='radio' value='P'>PM &nbsp;"
	  + "</td>"
  panel += "</tr>";  
  
  /* panel += "<tr class='DataTable9'>"
          + "<td nowrap>Half Day</td>"          	
          + "<td class='DataTable' nowrap>"
          	+ "<input name='inpHalf' type='checkbox' class='Small' type='text'  readonly>&nbsp;"
          	+ "(will be saved only for 1 day rent)"
          + "</td>"
       + "</tr>";
   */
   
   
  panel += "<tr class='DataTable9'>"
        + "<td id='tdUnrel' colspan=2 nowrap>"
          + "<input type='checkbox' name='Unrel' value='Y'>"
          + " Reservation - Not Picked up!"
        + "</td></tr>"

  panel += "<tr class='DataTable9'>";
  panel += "<td colspan=7 ><br><br><button onClick='showStsWarn()' class='Small'>Change</button>&nbsp;"
  panel += " &nbsp;  &nbsp; &nbsp;<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"
  panel += "</table>";
  return panel;
}
//==============================================================================
// check selected status
//==============================================================================
function chkSelSts(sel)
{
   if(sel.options[sel.selectedIndex].value=="CANCELLED")
   {
     document.all.tdUnrel.style.display="block";
   }
}
//==============================================================================
// validate new status
//==============================================================================
function showStsWarn()
{
    var sts = document.all.selSts[document.all.selSts.selectedIndex].value;
    var todate = document.all.ToDate1.value;

    if(sts=="CANCELLED")
    {
        var answer = confirm("Are you sure? All Equipment will be available immediately!");
	if (answer){ ValidateSts(); }
    }
    else if(sts=="RETURNED" )
    {
       if( chkRtnDt(sts, todate) ) { ValidateSts(); }
    }
    else { ValidateSts(); }
}
//==============================================================================
// check returned date when returned status selected
//==============================================================================
function chkRtnDt(sts, rtnDt)
{
   var rdate = new Date(rtnDt);
   var today = new Date();
   rdate.setHours("23");
   var aproove = true;

   if(rdate > today)
   {
      aproove = confirm("Are you sure you want to RETURN this contract?")
   }
   return aproove;
}
//==============================================================================
// validate new status
//==============================================================================
function ValidateSts()
{
   var error=false;
   var msg = "";

   var sts = document.all.selSts[document.all.selSts.selectedIndex].value;
   var frDt = new Date(document.all.FrDate1.value);
   var toDt = new Date(document.all.ToDate1.value);
   var unrel = " ";
   if (document.all.Unrel.checked){unrel=document.all.Unrel.value;}

   var pickAmPm = "A";
   if( document.getElementsByName("PickAmPm1")[1].checked){  pickAmPm = "P"; }
   var dropAmPm = "A";
   if( document.getElementsByName("DropAmPm1")[1].checked){  dropAmPm = "P"; }
   
   if(!AsgEqp && (sts=="READY" || sts=="PICKEDUP" || sts=="RETURNED") ) 
   {
	   error=true; msg += "No Equipment found. You cannot changed status to READY, PICKEDUP or REUTNED now."
   }
   if(frDt > toDt){error=true; msg += "Pick up date must be less or equal Drop off date."}

   var frdate = document.all.FrDate1.value;
   var todate = document.all.ToDate1.value;

   var half = "";
   var half_check = document.getElementsByName("inpHalf")[0];
   if(SelGrp == "BIKE" && frdate == todate && half_check.checked)
   {
	   half = "Y";
   }

   if(error){ alert(msg); }
   else{ sbmNewSts(sts, frdate, todate, unrel, half, pickAmPm, dropAmPm) }
}
//==============================================================================
// submit new status
//==============================================================================
function sbmNewSts(sts, frdate, todate, unrel, half, pickAmPm, dropAmPm)
{
var url = "RentContractSave.jsp?"
     + "&Cont=<%=sSelContId%>"
     + "&Sts=" + sts
     + "&FrDate=" + frdate
     + "&ToDate=" + todate
     + "&Unrel=" + unrel
     + "&HalfDay=" + half
     + "&PickAmPm=" + pickAmPm
     + "&DropAmPm=" + dropAmPm
     + "&Action=CHG_CONT_STS"

   //alert(url)
   window.frame1.location.href = url;
}
//==============================================================================
// add, update delete skier equipments
//==============================================================================
function showConflicts( ConfCont, ConfInvId, ConfSts, ConfSrlNum, ConfDesc, ConfSizeNm
     , ConfCust, ConfFName, ConfMInit, ConfLName)
{
   var hdr = "Contract Equipment Conflict";

   var html = "<table class='tbl01'>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popDispConflicts(ConfCont, ConfInvId, ConfSts, ConfSrlNum, ConfDesc, ConfSizeNm
     , ConfCust, ConfFName, ConfMInit, ConfLName)
     + "</td></tr>"
   + "</table>"
   
   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvStatus.style.width = "300";}
   else { document.all.dvStatus.style.width = "auto";} 

   document.all.dvStatus.innerHTML = html;
   document.all.dvStatus.style.left=getLeftScreenPos() + 140;
   document.all.dvStatus.style.top=getTopScreenPos() + 95;
   document.all.dvStatus.style.visibility = "visible";
}
//==============================================================================
// populate customer equipment
//==============================================================================
function popDispConflicts(ConfCont, ConfInvId, ConfSts, ConfSrlNum, ConfDesc, ConfSizeNm
     , ConfCust, ConfFName, ConfMInit, ConfLName)
{
  var dummy="<table>";
  var panel = "<table class='tbl01'>"

  panel += "<tr class='DataTable'>"
           + "<th nowrap style='color:red;' colspan=5>NO Inventory Available!</th>"
        + "</tr>"
  panel += "<tr class='DataTable'>"
         + "<th nowrap>Customer</th>"
         + "<th nowrap>Desc</th>"
         + "<th nowrap>Size<br>Name</th>"
         + "<th nowrap>Serial<br>Number</th>"
         + "<th nowrap>Conflict<br>Contract</th>"
       + "</tr>"

  for(var i=0; i < ConfCont.length; i++)
  {
     panel += "<tr class='DataTable1'>"
            + "<td nowrap>" + ConfFName[i]  + " " + ConfMInit[i] + " " + ConfLName[i] + "</td>"
            + "<td nowrap>" + ConfDesc[i] + "</td>"
            + "<td nowrap>" + ConfSizeNm[i] + "</td>"
            + "<td nowrap>" + ConfSrlNum[i] + "</td>"
            + "<td nowrap>" + ConfCont[i] + "</td>"
          + "</tr>";
  }

  panel += "</td></tr>";

  panel += "<tr>";
  panel += "<td class='Prompt1' colspan=5>"
  panel += " &nbsp;  &nbsp; &nbsp;<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"
  panel += "</table>";

  return panel;
}
//==============================================================================
// show warning when conflict found
//==============================================================================
function showWarning()
{
   var hdr = "Contract Equipment Conflict";

   var html = "<table class='tbl01'>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript: refreshCont(&#34;<%=sSelContId%>&#34;);' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>"
       + "<div style='color:darkred'>Equipment on this contract is already reserved on another contracts,"
          + " and were replaced to different serial number."
          + "<br>Please reprint the Print form for all Skiers listed with conflicting equipment reservations."
          + "<br><button onclick='refreshCont(&#34;<%=sSelContId%>&#34;)'>Close</button>"
       + "</div>"
     + "</td></tr>"
   + "</table>"

   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvStatus.style.width = "300";}
   else { document.all.dvStatus.style.width = "auto";} 
   
   document.all.dvStatus.innerHTML = html;
   document.all.dvStatus.style.left=getLeftScreenPos() + 140;
   document.all.dvStatus.style.top=getTopScreenPos() + 95;
   document.all.dvStatus.style.visibility = "visible";
}
//==============================================================================
// add, update delete skier equipments
//==============================================================================
function chgEquip(cust, firstNm, mInit, lastNm, type)
{
   SelCust = cust;
   SelFirstNm = firstNm;
   SelMInit = mInit;
   SelLastNm = lastNm;

   var hdr = "Equipment";

   var html = "<table class='tbl01'>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popEquipPanel(cust, firstNm, mInit, lastNm, type)
     + "</td></tr>"
   + "</table>"
   
   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvStatus.style.width = "300";}
   else { document.all.dvStatus.style.width = "auto";} 
   
   document.all.dvStatus.innerHTML = html;
   document.all.dvStatus.style.left=getLeftScreenPos() + 140;
   document.all.dvStatus.style.top=getTopScreenPos() + 95;
   document.all.dvStatus.style.visibility = "visible";
   document.all.inpSrlNum.focus();
}
//==============================================================================
// populate customer equipment
//==============================================================================
function popEquipPanel(cust, firstNm, mInit, lastNm, type)
{
  var panel = "<table class='tbl01'>"
  panel += "<tr>"
         + "<td class='Prompt' nowrap>Customer:</td>"
         + "<td class='Prompt' nowrap>" + cust + "</td>"
       + "</tr>"
       + "<tr>"
         + "<td class='Prompt' nowrap>Name:</td>"
         + "<td class='Prompt' nowrap>" + firstNm + " " + mInit + " " + lastNm + "</td>"
       + "</tr>"
  
  panel += "<tr>"
	  + "<td class='Prompt1' style='border-top: #e7e7e7 ridge 1px; background:yellow; color: red; font-size: 12px;' colspan= 2 nowrap>" 
	     + "<b>Ski Tech</b> - if you are pulling rental equipment for this Renter"
	     + " <b><u>Now</u></b>,<br>Then <b>Scan</b> equipment's Serial Number <b><u>Now!</u></b></td>"
   + "</tr>"
   panel += "<tr>"
	    + "<td class='Prompt' nowrap>&nbsp;</td>"
	 + "</tr>"   
  panel += "<tr>"
    + "<td class='Prompt' nowrap>SS Barcode ID<br>OR<br>Mfg Barcode S/N</td>"
    + "<td class='Prompt' nowrap><input name='inpSrlNum' class='Large' id='inpSrlNum' maxlength='10' size='12'" 
    + " onkeypress='if (window.event.keyCode == 13) { chkSrlNum(this.value.trim(), &#34;1&#34;); }'></td>"
  + "</tr>"     

  
  panel += "<tr>"
	  + "<td class='Prompt1' style='font-size: 14px; font-weight: bold;' colspan= 2 nowrap><br> - OR - <br><br></td>"
	  + "</tr>"
	+ "<tr id='tdWarn01'>"  
	  + "<td class='Prompt1' style='border-top: #e7e7e7 ridge 1px; background:yellow; color: red; font-size: 12px;' colspan= 2 nowrap>"
	  + "<a style='font-size:16px; font-weight:bold;' href='javascript: showSelEqp();'>Click Here</a>" 
	  + " to <b>Select Rental Equipment</b> for a <b>future</b> Reservation!" 
	  + "<br>to deplete available QTY's in a specific Rental Category/Size."
	  + "<br><span style='font-size: 10px;'>(Equipment's actual serial numbers must be <b>&#34;scanned&#34;</b>" 
	  + "<br>later before the customer picks up their rentals)</span>"
	  + "</td>"
   + "</tr>"
 
  
  panel += "<tbody id='tbSelEqp01' style='display: none;'>"
  
  panel += "<tr>"  
	  + "<td class='Prompt1' style='border-top: #e7e7e7 ridge 1px; background:yellow; color: red; font-size: 12px; font-weight: bold;' colspan= 2 nowrap>" 
	     + "Select Equipment only for Reservation (will Scan Equipment Later, when picked up):</span>"
	  + "<br></td>"
   + "</tr>"
  
  panel += "<tr>"
         + "<td class='Prompt' colspan=2>"
           + "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>"
           + "<tr class='DataTable4'>"
               + "<th colspan='" + Dpt.length + "'>Rental Categories<th>"
           + "</tr>"
  panel += "<tr class='DataTable4'>"
  for(var i=0; i < Dpt.length; i++)
  {
	 if(!Lease && Sport[i]==type || Lease && Sport[i]=="Lease")
	 {
     	panel += "<th>" + " " + DptNm[i];
     	panel += "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>"

     	for(var j=0; j < Cls[i].length; j++)
     	{
        	panel += "<tr class='DataTable1'>"
            + "<td nowrap>"
              + "<a href='javascript: getAvailItems(&#34;" + Cls[i][j] + "&#34;)'>"
              + " " +  ClsNm[i][j] + "</a>"
            + "</td>"
          + "</tr>";
     	}     
     	panel += "</table>"
     	panel += "</th>";
	 }
  }
  panel += "</tr>"

  panel += "<tr>"
         + "<td style='background:darkred;font-size:2px;' colspan=2><div id=></div></td>"
        + "</tr>"
        + "<tr>"
         + "<td class='DataTable' colspan=" + Dpt.length + ">"
            + "<div id='dvItems' style='font-size:10px;' >Click on class to see item list.</div></td>"
        + "</tr>"
  panel += "<tr>"
         + "<td style='background:darkred;font-size:2px;' colspan=2><div id=></div></td>"
        + "</tr>"
        + "<tr>"
          + "<td class='DataTable' colspan=" + Dpt.length + ">"
            + "<div id='dvTags' style='font-size:10px;' >Click on item to see item list.</div></td>"
        + "</tr>"

  panel += "</table></td></tr>";
  
  panel += "</tbody>"
  
  panel += "<tr>";
  panel += "<td class='Prompt1' colspan=5>"
  if(type == "Ski")
  { 	
	  panel += " &nbsp;  &nbsp; &nbsp;<button onClick='addPoles(&#34;" + cust + "&#34;);' class='Small'>Add Poles</button> &nbsp "
  }
  else if(type == "Water")
  {
	  panel += " &nbsp;  &nbsp; &nbsp;<button onClick='addPoles(&#34;" + cust + "&#34;);' class='Small'>Add Paddles</button> &nbsp "
  }
  else if(type == "Bike")
  {
	  panel += " &nbsp;  &nbsp; &nbsp;<button onClick='addPoles(&#34;" + cust + "&#34;);' class='Small'>Add Helmet</button> &nbsp "
  }
  panel += " &nbsp;  &nbsp; &nbsp;<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"
  panel += "</table>";
  return panel;
}
//==============================================================================
//check Srl SKU
//==============================================================================
function showSelEqp()
{
	document.getElementById("tbSelEqp01").style.display="table-row-group";
	document.getElementById("tdWarn01").style.display="none";
}
//==============================================================================
// check Srl SKU
//==============================================================================
function chkSrlNum(srn, type)
{
	url="RentRtvEquipLst.jsp?Sn=" + srn
    	+ "&Action=CHK_SN_" + type
    	+ "&FrDate=" + PickDt
        + "&ToDate=" + RtnDt
    ;
	//window.location.href=url;
 	window.frame1.location.href=url;
}
//==============================================================================
//check Srl SKU
//==============================================================================
function setScanItem(invid, sn, desc, siznm, assig_cont, sts, clsnm)
{
	var msg = "";
	var error = false;
	
	if(sn.trim() == ""){ msg = "The Serial Number is not entered."; error=true; }
	else if(invid == ""){ msg = "The Serial Number is not found."; error=true; }
	else if(assig_cont != "N"){ msg = "This serial number is already assigned on Contract " +  assig_cont + "."; error=true; }
	else if(sts != ""){ msg = "The Serial Number is not available."; error=true; }
	
	var warn1 = ClsNm[0][0].indexOf("L-") >= 0 && clsnm.indexOf("D-") >= 0;
	var warn2 = ClsNm[0][0].indexOf("D-") >= 0 && clsnm.indexOf("L-") >= 0;
	
	if(error){ alert(msg); }
	else
	{ 
		var conf = true;
		if(warn1)
		{
			conf = confirm("Scanned S/N is defined as Rental equipment, but contract has Lease dates.");
		}
		if(warn2)
		{
			conf = confirm("Scanned S/N is defined as Lease equipment, but contract has Rental dates.");
		}
		
		if(conf){ chkOutTag(invid, desc, siznm, sn, "Y"); }
	}
	document.getElementsByName("inpSrlNum")[0].value = "";
} 
//==============================================================================
// addpoles for selected skier
//==============================================================================
function addPoles(cust)
{
   SelDesc = "Poles";
   if(SelGrp == "WATER"){ SelDesc = "Paddles"; }
   else if(SelGrp == "BIKE"){ SelDesc = "Helmet"; }
   SelSize = " ";
   SelSrlNum = " ";

   var url = "RentContractSave.jsp?"
     + "Cont=<%=sSelContId%>"
     + "&Cust=" + cust
     + "&InvId=9999999999"
     + "&Action=ADD_POLES"

   //alert(url)
   window.frame1.location.href = url;
}
//==============================================================================
// refresh Contract
//==============================================================================
function refreshCont(cont, action)
{
   var url = "RentContractInfo.jsp?Grp=<%=sSelGrp%>&ContId=" + cont
   window.location.href = url;
}
//==============================================================================
// refresh Contract and open equipment selection
//==============================================================================
function refreshTag(cont, cust, newequip, invId, srlNum)
{   
   // add one row to skier equipment
   var tblnm = "tb" + cust + "Inv"
   var tbl = document.all[tblnm];

   var row = tbl.insertRow(1);
   row.id = "trNew";
   row.className="DataTable8"

   var cell = row.insertCell(0);
   cell.className="DataTable";
   cell.innerHTML = SelDesc;

   cell = row.insertCell(1);
   cell.className="DataTable2";
   cell.innerHTML = SelSize;

   cell = row.insertCell(2);
   cell.className="DataTable2";
   //if(srlNum == null || srlNum == "SAME"){  cell.innerHTML = SelSrlNum; }
   //else {  cell.innerHTML = srlNum; }
   cell.innerHTML = "<b>*** Refresh (F5) to see ***</b>";
   
   cell = row.insertCell(3);
   cell.className="DataTable2";
   cell.colSpan=4;
   cell.innerHTML = "New Equipment Added." 
   + " &nbsp;  &nbsp; <span style='color: red;'><b>*** Refresh (F5) for updates to Equipment Info ***<b></span>";
   
   AsgEqp = true;

   // re-display equipment selection
   //if (newequip) {  chgEquip(cust, SelFirstNm, SelMInit, SelLastNm, SelGrp) }
   if (newequip) 
   {
	   document.getElementById("dvItems").innerHTML = "";
	   document.getElementById("dvTags").innerHTML = "";	   
   }
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
//Hide selection screen
//==============================================================================
function hidePanel1()
{
	document.all.dvHelp.innerHTML = " ";
	document.all.dvHelp.style.visibility = "hidden";
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function doSelDate()
{
  var df = document.all;
  if(PickDt != "")
  {
     df.FrDate.value = PickDt;
     df.ToDate.value = RtnDt;
  }
  else
  {
     //var date = new Date(new Date() - 24 * 60 * 60 * 1000);
     var date = new Date();
     df.FrDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
     df.ToDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
  }
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function setDate(direction, id)
{
  var button = document.all[id];
  var date = new Date(button.value);

  if(direction == "DOWN"){ date = new Date(new Date(date) - 86400000); }
  else if(direction == "UP"){ date = new Date(new Date(date) - -86400000);}
  //end Of season
  else if(direction == "EOS")
  {
    var year = date.getFullYear();
    var mon = date.getMonth();
    if( mon > 3){ year = eval(year) - -1; }
    eosdt = "4/15/" + year;
    date = new Date(eosdt);
  }

  button.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}
//==============================================================================
// show Skier adding panel
//======================= =======================================================
function showSkierPanel(shows)
{
   if(shows)
   {
      document.all.dvNewSkiers.style.display="block";
      document.all.btnAddSkier.style.display="none";
      document.all.btnAddPartner.style.display="none";     
      document.all.lnkRtnCust.style.display="inline";

      // populate address with fisrst customer information
      document.all.Cust.value = "NEW";
      document.all.Action.value = "ADD_CUST_CONT";
      document.all.FName.value = "";
      document.all.MInit.value = "";
      document.all.LName.value = "";
      document.all.Addr1.value = DftAddr1;
      document.all.Addr2.value = DftAddr2;
      document.all.City.value = DftCity;
      document.all.State.value = DftState;
      document.all.Zip.value = DftZip;
      document.all.HPhone.value = DftHPhone;
      document.all.CPhone.value = "";
      document.all.EMail.value = DftEMail;
      document.all.BirthDt.value = "";
      document.all.Group.value = DftGroup;
      document.all.Weight.value = "";
      document.all.HeightFt.value = "";
      document.all.HeightIn.value = "";
      //document.all.ShoeSiz.value = "";
      //document.all.MondoSiz.value = "";
      document.all.AngleLeft.value = "";
      document.all.AngleRight.value = "";
      for(var i=0; i < document.all.SkiType.length; i++)
      {
         document.all.SkiType[i].checked = false;
      }
   }
   else
   {
      document.all.dvNewSkiers.style.display="none";
      document.all.btnAddSkier.style.display="inline";
      document.all.btnAddPartner.style.display="inline";     
   }
}
//==============================================================================
// get available equipment
//==============================================================================
function getAvailEquip()
{
   var pick = new Date(PickDt);
   var retn = new Date(RtnDt);
   
   pick.setHours(6,0,0,0,0);
   retn.setHours(6,0,0,0,0);
   
   var days = (retn.getTime() - pick.getTime()) / (24*60*60*1000);   
   
   var action = "GET_DPT";
   if(days > 14 ) { action = "GET_DPT_LEASE"; Lease = true;}
   
   var url = "RentRtvEquipLst.jsp?Grp=" + SelGrp 
	+ "&Action=" + action
   ;
   window.frame2.location.href=url
}
//==============================================================================
// get available Items
//==============================================================================
function getAvailItems(cls)
{
   var url = "RentRtvEquipLst.jsp?Action=GET_ITEMS"
     + "&Str=<%=sStr%>"
     + "&Cont=<%=sSelContId%>"
     + "&Cls=" + cls
     + "&FrDate=" + PickDt
     + "&ToDate=" + RtnDt
     ;
   window.frame1.location.href=url
}
//==============================================================================
// get available Tags
//==============================================================================
function getAvailTag(cls, ven, sty, clr, siz, desc, clrnm, siznm)
{
    url="RentSNAvlQuickLst.jsp?Cls=" + cls
         + "&Ven=" + ven
         + "&Sty=" + sty
         + "&Clr=" + clr
         + "&Siz=" + siz
         + "&Str=<%=sStr%>"
         + "&FrDate=" + PickDt
         + "&ToDate=" + RtnDt
         + "&Desc=" + desc
         + "&ClrNm=" + clrnm
         + "&SizNm=" + siznm
         + "&Row=0"
   //alert(url)
   window.frame1.location.href=url
}
//==============================================================================
//set available Tag on contract
//==============================================================================
function setAvailTag(cls, ven, sty, clr, siz, desc, clrnm, siznm)
{	
	var url = "RentContractSave.jsp?Cls=" + cls
       + "&Ven=" + ven
       + "&Sty=" + sty
       + "&Clr=" + clr
       + "&Siz=" + siz
       + "&Str=<%=sStr%>"
	   + "&Cont=<%=sSelContId%>"
	   + "&Cust=" + SelCust
	   + "&Action=ADD_AVAIL_TAG"

	   //alert(url)
	   window.frame1.location.href = url;
}
//==============================================================================
// receive available equipment
//==============================================================================
function rcvAvailDptCls(dpt, dptNm, cls, clsNm, sport)
{
   Dpt = dpt;
   DptNm = dptNm;
   Cls = cls;
   ClsNm = clsNm;
   Sport = sport
}

//==============================================================================
// receive available equipment
//==============================================================================
function rcvAvailItem(cls, ven, sty, clr, siz, desc, clrNm, sizNm, totQty, unasgQty)
{
   var html = "<table border=1 cellPadding='0' cellSpacing='0'>"
     + "<tr class='DataTable4'>"
        //+ "<th>Item</th>"
        + "<th>Description</th>"
        + "<th>Size Name</th>"
        + "<th>Available<br>Qty</th>"
        //+ "<th>Unassigned</th>"
     + "</tr>"
   for(var i=0; i < cls.length; i++)
   {
      html += "<tr class='DataTable2'>"
          //+ "<td>" + cls[i] + "-" + ven[i] + "-" + sty[i] + "-" + clr[i] + "-" + siz[i] + "</td>"
          + "<td>" + desc[i] + "</td>"
          + "<td>" + sizNm[i] + "</td>"
          + "<td style='text-align:right'>"
              + "<a href='javascript: getAvailTag(&#34;" + cls[i] + "&#34;,&#34;" + ven[i]
              + "&#34;,&#34;" + sty[i] + "&#34;,&#34;" + clr[i] + "&#34;,&#34;" + siz[i]
              + "&#34;,&#34;" + desc[i] + "&#34;,&#34;" + clrNm[i] + "&#34;,&#34;" + sizNm[i]
              + "&#34;)'> &nbsp; " + totQty[i] + " &nbsp; </a>"
          + "</td>"
          + "<td style='text-align:right'>";
      /*if(unasgQty[i] != "")
      {
          html += "<a href='javascript: setAvailTag(&#34;" + cls[i] + "&#34;,&#34;" + ven[i]
          + "&#34;,&#34;" + sty[i] + "&#34;,&#34;" + clr[i] + "&#34;,&#34;" + siz[i]
          + "&#34;,&#34;" + desc[i] + "&#34;,&#34;" + clrNm[i] + "&#34;,&#34;" + sizNm[i]
          + "&#34;)'> &nbsp; " + unasgQty[i] + " &nbsp; </a>";
      } 
      else{ html += "&nbsp"; }
      */
      html += "</td>"
      + "</tr>"
   }
   html += "</table>";
   
   document.all.dvItems.innerHTML = html;
}
//==============================================================================
// receive available tags
//==============================================================================
function showTagAvl(cls, ven,  sty, clr, siz, desc, clrNm, sizNm, invId, srlNum )
{
	//alert(pickDt + " " + rtnDt)
    var html = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>"
     + "<tr class='DataTable41'>"
        + "<th colspan='3'>Description: " + desc + " &nbsp; Size:" + sizNm + "</th>"
     + "</tr>"
     + "<tr class='DataTable4'>"
        + "<th>Reserve Serial #</th>"
     + "</tr>"

   html += "<tr class='DataTable8'>"
         + "<td style='text-align:left'>"
   var coma = "&nbsp; &nbsp;";
   for(var i=0; i < srlNum.length; i++)
   {
      // check availability
      var avail = true;
      var caution = false;
      
      var cssClass = "DataTable8";
      
      if(avail) 
      {     	  
    	  html += coma + " <a href='javascript: chkOutTag(&#34;" 
    	   + invId[i] + "&#34;,&#34;" + desc + "&#34;,&#34;" + sizNm 
    	   + "&#34;,&#34;" + srlNum[i] + "&#34;,&#34;N&#34;)'>";
    	  
    	  // display in yellow for warning  
    	  //if( caution ){ html += "<span class='Warn'>" + srlNum[i] + "</span>"; } 
    	  //else { html += srlNum[i]; } 
    	  if( caution ){ html += "<span class='Warn'>" + (i+1) + "</span>"; }
    	  else { html += i+1; } 
    	  html +=  "</a>"
      }      	
      //else{ html += coma + "<span style='text-decoration:line-through'>" + srlNum[i]  + "</span>"}
      else{ html += coma + "<span style='text-decoration:line-through'>" + (i+1)  + "</span>"}
      coma = ",&nbsp; &nbsp;"
   }

   html += "</td>"
        + "</tr>"
   html += "<tr class='DataTable8'>"
         + "<td style='text-align:left'>"
           + "<span style='background:yellow;'>*Caution</span> - This item may or may not be available, as it is only <b><u>1</u></b> day between <b>Pick</b> up or <b>Return</b> date  -  on another rental contract!"
         + "</td>"
        + "</tr>"

   html += "</table>";
   document.all.dvTags.innerHTML = html;
}
//==============================================================================
// check out actual item
//==============================================================================
function chkOutTag(invId, desc, size, srlnum, scan)
{
   SelDesc = desc;
   SelSize = size;
   SelSrlNum = srlnum;

   var url = "RentContractSave.jsp?Str=<%=sStr%>"
     + "&Cont=<%=sSelContId%>"
     + "&Cust=" + SelCust
     + "&InvId=" + invId
     + "&Action=ADD_CONT_TAG" + "_" + scan
     

   //alert(url)
   window.frame1.location.href = url;
}
//==============================================================================
// delete Inventroy Id
//==============================================================================
function dltInv(invId, cust, desc)
{
   var hdr = "Remove Equipment";

   var html = "<table class='tbl01'>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popDltInv(invId, cust, desc)
     + "</td></tr>"
   + "</table>"
   
   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvStatus.style.width = "300";}
   else { document.all.dvStatus.style.width = "auto";} 

   document.all.dvStatus.innerHTML = html;
   document.all.dvStatus.style.left=getLeftScreenPos() + 240;
   document.all.dvStatus.style.top=getTopScreenPos() + 295;
   document.all.dvStatus.style.visibility = "visible";
}
//==============================================================================
// populate customer equipment
//==============================================================================
function popDltInv(invId, cust, desc)
{
  var dummy="<table>";
  var panel = "<table class='tbl01'>"
  panel += "<tr style='font-size:12px;'>"
         + "<td nowrap>Do you want to delete <br><b>" + desc + "</b><br> from contract.</td>"
       + "</tr>"

  panel += "<tr>";
  panel += "<td class='Prompt1'>"
    + "<button onClick='sbmDltInv(&#34;" + invId + "&#34;, &#34;" + cust + "&#34;);' class='Small'>Delete</button> &nbsp; "
    + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"
  panel += "</table>";
  return panel;
}
//==============================================================================
// check out actual item
//==============================================================================
function sbmDltInv(invId, cust)
{
   var url = "RentContractSave.jsp?"
     + "Cont=<%=sSelContId%>"
     + "&Cust=" + cust
     + "&InvId=" + invId
     + "&Action=DLT_CONT_TAG"

   //alert(url)
   window.frame1.location.href = url;
}
//==============================================================================
//update serial number
//==============================================================================
function updSrlNum(invId, srln)
{
	var hdr = "Scan Equipment";
    
	hidePanel1();
	
	var html = "<table class='tbl01'>"
	     + "<tr>"
	       + "<td class='BoxName' nowrap>" + hdr + "</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
	       + "</td></tr>"
	    + "<tr><td class='Prompt' colspan=2>" + popSrlNum(invId,srln)
	     + "</td></tr>"
	   + "</table>"
	   
	   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvStatus.style.width = "200";}
	   else { document.all.dvStatus.style.width = "auto";} 

	   document.all.dvStatus.innerHTML = html;
	   document.all.dvStatus.style.left=getLeftScreenPos() + 240;
	   document.all.dvStatus.style.top=getTopScreenPos() + 155;
	   document.all.dvStatus.style.visibility = "visible";
	   
	   document.all.inpSrlNum.focus();
}
//==============================================================================
// populate serial number panel 
//==============================================================================
function popSrlNum(invId,srln)
{
	var panel = "<table class='tbl01'>"
  	panel += "<tr class='DataTable8'>"
       	 + "<td width='30%' nowrap>SS Barcode ID <br>or<br>MFG Barcode S/N &nbsp; &nbsp; &nbsp; &nbsp; </td>"
         + "<td nowrap>" 
         	+ "<input class='Large' name='inpSrlNum' maxlength='10' size='12'" 
         	+ " onkeypress='if (window.event.keyCode == 13) { chkSrlNum(this.value.trim(), &#34;2&#34;); }'"
         	+ ">"  
         	+ "<input name='inpSrlNumOrg' type='hidden' value='" + srln + "'>"
         + "</td>"
       + "</tr>"
       + "</tr>"

    panel += "<tr class='DataTable8'>";
    panel += "<td class='Prompt1' colspan='2'>"
        /*+ "<button onClick='vldSrlNum(&#34;" + invId + "&#34;, &#34;" + srln + "&#34;);' class='Small'>Update</button> &nbsp; "*/
         + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"
    panel += "</table>";
    return panel;     
}    
//==============================================================================
//validate scanned serial number
//==============================================================================
function vldSrlNum(invid, sn, desc, siznm, assig_cont, sts, clsnm)
{
	var error=false;
	var msg = "";
	var warn1 = "";
	var warn2 = "";
	
	if(sn.trim() == ""){ msg = "The Serial Number is not entered."; error=true; }
	else if(invid == ""){ msg = "The Serial Number is not found."; error=true; }
	else if(assig_cont != "N"){ msg = "This serial number is already assigned on Contract " +  assig_cont + "."; error=true; }
	else if(sts != ""){ msg = "The Serial Number is not available."; error=true; }
	
	var warn1 = ClsNm[0][0].indexOf("L-") >= 0 && clsnm.indexOf("D-") >= 0;
	var warn2 = ClsNm[0][0].indexOf("D-") >= 0 && clsnm.indexOf("L-") >= 0;

	var srlnumOrg =  document.all.inpSrlNumOrg.value.trim();  
	
	if(error){ alert(msg); }
	else
	{ 
		var conf = true;
		if(warn1)
		{
			conf = confirm("Scanned S/N is defined as Rental equipment, but contract has Lease dates.");
		}
		if(warn2)
		{
			conf = confirm("Scanned S/N is defined as Lease equipment, but contract has Rental dates.");
		}
		
		if(conf){ sbmChgSrlNum(sn, srlnumOrg); } 
	}
}
//==============================================================================
//check scanned item against order
//==============================================================================
function getScannedItem(sn)
{
	var valid = true;
	var url = "RentChkSrlNum.jsp?Sn=" + sn 
	   + "&Str=" + SelStr;

	var xmlhttp;
	// code for IE7+, Firefox, Chrome, Opera, Safari
	if (window.XMLHttpRequest){ xmlhttp=new XMLHttpRequest(); }
	// code for IE6, IE5
	else { xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");}

	xmlhttp.onreadystatechange=function()
	{
		if (xmlhttp.readyState==4 && xmlhttp.status==200)
		{			
			var  resp = xmlhttp.responseText;
			
			valid = getXmlValue("SN_Valid", resp) == "true";
			if(valid)
			{
				ExClsNm = getXmlValue("ClsNm", resp);				
			}
		}
	}
	xmlhttp.open("GET",url,false); // synchronize with this apps
	xmlhttp.send();

	//alert(sku.trim());
	return valid;
}
//==============================================================================
//get XML value 
//==============================================================================
function getXmlValue(tag, resp)
{
	var opntag = "<" + tag + ">";
	var beg = resp.indexOf(opntag) + opntag.length;
	var clstag = "</" + tag + ">";
	var end = resp.indexOf(clstag);
	xmlval = resp.substring(beg, end);
	return xmlval;
}
//==============================================================================
// submit change serial number
//==============================================================================
function sbmChgSrlNum(srlnum, srlnumOrg)
{
	var url = "RentContractSave.jsp?"
	     + "Cont=<%=sSelContId%>"
	     + "&SrlNm=" + srlnum
	     + "&OldSrlNum=" + srlnumOrg
	     + "&Action=CHG_CONT_EQP"
	   //alert(url)
	   window.frame1.location.href = url;
}
//==============================================================================
//update checked out inventory
//==============================================================================
function refreshEqp(error, NumOfConf, ConfCont, ConfInvId, ConfSts, ConfSrlNum, ConfDesc, ConfSizeNm
	     , ConfCust, ConfFName, ConfMInit, ConfLName)
{
	if(error != "" || NumOfConf != "0" )
	{
		if(ConfCont.length == 0) { alert(error); }
		else{ showConflicts( ConfCont, ConfInvId, ConfSts, ConfSrlNum, ConfDesc, ConfSizeNm
			     , ConfCust, ConfFName, ConfMInit, ConfLName) }
	}
	else
	{
		location.reload();
	}
}
//==============================================================================
//update checked out inventory
//==============================================================================
function refreshAvlEqp(error)
{
	if(error != "" ){ alert(error); }	
	else { location.reload(); }
}
//==============================================================================
// update checked out inventory
//==============================================================================
function updInv(invId, cust, desc, bootln, ltoe, rtoe, lheal, rheal,srln)
{
   var hdr = "Change Equipment Adjustment";

   var html = "<table class='tbl01'>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popUpdInv(invId, cust, desc, bootln, ltoe, rtoe, lheal
    		, rheal,srln)
     + "</td></tr>"
   + "</table>"
   
   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvStatus.style.width = "300";}
   else { document.all.dvStatus.style.width = "auto";} 

   document.all.dvStatus.innerHTML = html;
   document.all.dvStatus.style.left=getLeftScreenPos() + 240;
   document.all.dvStatus.style.top=getTopScreenPos() + 155;
   document.all.dvStatus.style.visibility = "visible";
}

//==============================================================================
// populate customer equipment
//==============================================================================
function popUpdInv(invId, cust, desc, bootln, ltoe, rtoe, lheal, rheal, srln)
{
  var panel = "<table class='tbl01'>"
  panel += "<tr class='DataTable8'>"
         + "<td class='DataTable2' colspan='5'><b><u>" + desc + "</u></b></td>"
       + "</tr>"
       
       + "<tr class='DataTable8'>"
         + "<td nowrap>Boot Length: </td>"
         + "<td nowrap colspan=4><input class='Small' name='BootLn' value='" + bootln + "' maxlength=10 size=10></td>"
       + "</tr>"
       + "<tr class='DataTable8'>"
         + "<td nowrap>Left Toe: </td>"
         + "<td nowrap><input class='Small' name='LeftToe' value='" + ltoe + "' maxlength=10 size=10></td>"
         + "<td nowrap>&nbsp;</td>"
         + "<td nowrap>Right Toe: </td>"
         + "<td nowrap><input class='Small' name='RightToe' value='" + rtoe + "' maxlength=10 size=10></td>"
       + "</tr>"
       + "<tr class='DataTable8'>"
         + "<td nowrap>Left Heel: </td>"
         + "<td nowrap><input class='Small' name='LeftHeal' value='" + lheal + "' maxlength=10 size=10></td>"
         + "<td nowrap>&nbsp;</td>"
         + "<td nowrap>Right Heel: </td>"
         + "<td nowrap><input class='Small' name='RightHeal' value='" + rheal + "' maxlength=10 size=10></td>"
       + "</tr>"

  panel += "<tr class='DataTable8'>";
  panel += "<td class='Prompt1' colspan='5'>"
    + "<button onClick='vldUpdInv(&#34;" + invId + "&#34;, &#34;" + cust + "&#34;);' class='Small'>Update</button> &nbsp; "
    + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"
  panel += "</table>";
  return panel;
}
//==============================================================================
// validate inventory updates
//==============================================================================
function vldUpdInv(invId, cust)
{
   var error=false;
   var msg = "";
   
   var bootln = document.all.BootLn.value.trim();
   if(isNaN(bootln) || eval(bootln) <= 0 || bootln ==""){ error=true; msg+="Please, enter correct boot length.\n" }

   var ltoe = document.all.LeftToe.value.trim();
   if(isNaN(ltoe) || eval(ltoe) <= 0 || ltoe==""){ error=true; msg+="Please, enter correct left toe.\n" }

   var rtoe = document.all.RightToe.value.trim();
   if(isNaN(rtoe) || eval(rtoe) <= 0 || rtoe==""){ error=true; msg+="Please, enter correct right toe.\n" }

   var lheal = document.all.LeftHeal.value.trim();
   if(isNaN(lheal) || eval(lheal) <= 0 || lheal==""){ error=true; msg+="Please, enter correct left heel.\n" }

   var rheal = document.all.RightHeal.value.trim();
   if(isNaN(rheal) || eval(rheal) <= 0 || rheal==""){ error=true; msg+="Please, enter correct right heel.\n" }

   if(error){ alert(msg); }
   else{ sbmUpdInv(invId, cust, bootln, ltoe, rtoe, lheal, rheal) }
}
//==============================================================================
// check out actual item
//==============================================================================
function sbmUpdInv(invId, cust, bootln, ltoe, rtoe, lheal, rheal)
{
   var url = "RentContractSave.jsp?"
     + "Cont=<%=sSelContId%>"
     + "&Cust=" + cust
     + "&InvId=" + invId
     + "&BootLn=" + bootln
     + "&LeftToe=" + ltoe
     + "&RightToe=" + rtoe
     + "&LeftHeal=" + lheal
     + "&RightHeal=" + rheal
     + "&Action=UPD_CONT_TAG"
   //alert(url)
   window.frame1.location.href = url;
}
//==============================================================================
// get comments
//==============================================================================
function getComments()
{
   var url = "RentContractComments.jsp?"
     + "Cont=<%=sSelContId%>"
     + "&Action=ALL"

   //alert(url)
   window.frame1.location.href = url;
}
//==============================================================================
// get comments
//==============================================================================
function showComments(commId, firstTy, firstId, secondTy, secondId, thirdTy, thirdId
      , line, subType, commt, recUsr, recDt, recTm)
{
   var hdr = "All Comments";
   var html = "<table class='tbl01'>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "</tr>"
    + "<tr><td class='Prompt'>" + popComments(commId, firstTy, firstId, secondTy, secondId, thirdTy, thirdId
      , line, subType, commt, recUsr, recDt, recTm)
     + "</td></tr>"
   + "</table>"
   
   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvComment.style.width = "800";}
   else { document.all.dvComment.style.width = "auto";} 

   document.all.dvComment.innerHTML = html;
   document.all.dvComment.style.left=getLeftScreenPos() + 100;
   document.all.dvComment.style.top=getTopScreenPos() + 145;
   document.all.dvComment.style.visibility = "visible";
   
   setSskierSpecIns(commId, firstTy, firstId, secondTy, secondId, thirdTy, thirdId
		      , line, subType, commt, recUsr, recDt, recTm)
}
//==============================================================================
// populate customer equipment
//==============================================================================
function popComments(commId, firstTy, firstId, secondTy, secondId, thirdTy, thirdId
      , line, subType, commt, recUsr, recDt, recTm)
{
  var dummy="<table>";
  var panel = "<table class='tbl01'>"
  panel += "<tr class='DataTable'>"
         + "<th>Type</th>"
         + "<th width='75%'>Comments</th>"
         + "<th>User</th>"
         + "<th>Date</th>"
         + "<th>Time</th>"
       + "</tr>"

  var clsId = "1";
  for(var i=0, j=0; i < commId.length; i++)
  {
     if(subType[i] != "SPCINS")
     {
	 	if(i > 0 && commId[i] != commId[i-1])
     	{
        	if( clsId=="1" ){ clsId = ""; }
        	else { clsId = "1"; }
     	}

     	if(i == 0 || i > 0 && commId[i] != commId[i-1] )
     	{
     		if(subType[i] != "USER")
     		{
     			panel += "<tr class='DataTable" + clsId + "' id='trCommt" + j + "'>"
     		}
     		else 
     		{
     			panel += "<tr class='DataTable10' id='trCommt" + j + "'>"
     		}
        	panel += "<td class='DataTable' id='tdType" + j + "'>" + subType[i] + "</td>"
        	panel += "<td class='DataTable'>"
        	j++;
        	NumOfCommt = j;
     	}

     	panel += commt[i];

     	if( commId[i] != commId[i+1])
     	{
        	panel += "</td>"
               + "<td class='DataTable' nowrap>" + recUsr[i] + "</td>"
               + "<td class='DataTable' nowrap>" + recDt[i] + "</td>"
               + "<td class='DataTable' nowrap>" + recTm[i] + "</td>"
          	+ "</tr>"
     	}
  	}
  }

  panel += "</table>";
  return panel;
}

//==============================================================================
//set skier special instruction
//==============================================================================
function setSskierSpecIns(commId, firstTy, firstId, secondTy, secondId, thirdTy, thirdId
	      , line, subType, commt, recUsr, recDt, recTm)
{
	
	for(var i=0; i < NumOfSkr; i++)
	{
	
		var specIns = document.getElementById("tdSkiIns" + i);
		var bFirst = true;
		
	 	for(var j=0; j < commId.length; j++)
		{
		
			if(subType[j] == "SPCINS" && SkrId[i] == secondId[j])
			{
				if(bFirst)
				{ 
					specIns.style.backgroundColor = "white";
					specIns.innerHTML = "<span style='background:yellow;text-decoration: underline;'>" 
					  + "<b>Special Instruction</b> (from online reservation):</span> &nbsp;<br>"
				}
				specIns.innerHTML += commt[j];
				bFirst = false;
 			}
			 
   		}	
	 
	}
}

//==============================================================================
// filter comments
//==============================================================================
function filterCommt(grp)
{
   for(var i=0; i < NumOfCommt; i++)
   {
      var tdname = "tdType" + i;
      var trname = "trCommt" + i;
      var block = "table-row";
      if(isIE && ua.indexOf("MSIE 7.0") >= 0){ block = "block"; }
      
      if(grp == "All" || document.all[tdname].innerHTML == grp)
      {
         document.all[trname].style.display=block;
      }
      else{ document.all[trname].style.display="none"; }
      }
}
//==============================================================================
// add new comments
//==============================================================================
function addNewComments()
{
   var hdr = "Add Comments";

   var html = "<table class='tbl01'>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
         + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popNewComments()
     + "</td></tr>"
   + "</table>"
   
   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvStatus.style.width = "500";}
   else { document.all.dvStatus.style.width = "auto";} 

   document.all.dvStatus.innerHTML = html;
   document.all.dvStatus.style.left=getLeftScreenPos() + 20;
   document.all.dvStatus.style.top=getTopScreenPos() + 295;
   document.all.dvStatus.style.visibility = "visible";
}
//==============================================================================
// populate new comments panel
//==============================================================================
function popNewComments()
{
  var panel = "<table class='tbl01'>"
  panel += "<tr style='font-size:12px;'>"
         + "<td nowrap><textarea name='Commt' id='Commt' cols=100 rows=5></textarea></td>"
       + "</tr>"

  panel += "<tr>";
  panel += "<td class='Prompt1'>"
    + "<button onClick='sbmAddComments();' class='Small'>Add</button> &nbsp; "
    + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"
  panel += "</table>";
  return panel;
}
//==============================================================================
// save new comments
//==============================================================================
function sbmAddComments()
{
    var commt = document.all.Commt.value;
    commt = commt.replace(/\n\r?/g, '<br />');

    var nwelem = "";
	
    if(isIE){ nwelem = window.frame1.document.createElement("div"); }
    else if(isSafari){ nwelem = window.frame1.document.createElement("div"); }
    else{ nwelem = window.frame1.contentDocument.createElement("div");}
    
    nwelem.id = "dvSbmCommt"

    var html = "<form name='frmAddComment'"
       + " METHOD=Post ACTION='RentContractSave.jsp'>"
       + "<input class='Small' name='Cont'>"
       + "<input class='Small' name='Commt'>"
       + "<input class='Small' name='Action'>"
     + "</form>"

   nwelem.innerHTML = html;
   frmcommt = document.all.frmEmail;
   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ window.frame1.document.appendChild(nwelem); }
   else if(isIE){ window.frame1.document.body.appendChild(nwelem); }
   else if(isSafari){window.frame1.document.body.appendChild(nwelem);}  
   else{ window.frame1.contentDocument.body.appendChild(nwelem); }

   if(isIE || isSafari)
   {
	   window.frame1.document.all.Cont.value = "<%=sSelContId%>";
	   window.frame1.document.all.Commt.value=commt;
	   window.frame1.document.all.Action.value="ADD_COMMT";
	   window.frame1.document.frmAddComment.submit();
   }	   
   else
   {
	   window.frame1.contentDocument.forms[0].Cont.value = "<%=sSelContId%>";
	   window.frame1.contentDocument.forms[0].Commt.value=commt;
	   window.frame1.contentDocument.forms[0].Action.value="ADD_COMMT";
	   window.frame1.contentDocument.forms[0].submit();
   }
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

   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvStatus.style.width = "250";}
   else { document.all.dvStatus.style.width = "auto";}
   
   document.all.dvStatus.innerHTML = html;
   document.all.dvStatus.style.left=getLeftScreenPos() + 300;
   document.all.dvStatus.style.top=getTopScreenPos() + 100;
   document.all.dvStatus.style.visibility = "visible";
}
//==============================================================================
// populate Customer Searched
//==============================================================================
function popCstSearchPanel()
{
  var panel = "<table class='tbl02'>"
  panel += "<tr id='trReg'><td class='Prompt' nowrap>Last Name:</td>"
         + "<td class='Prompt'><input class='Small1' name='Last' size=50 maxsize=50 onkeypress='chkRetCust()'></td>"
       + "</tr>"
       + "<tr id='trReg'><td class='Prompt' nowrap>First Name:</td>"
         + "<td class='Prompt'><input class='Small1' name='First' size=50 maxsize=50 onkeypress='chkRetCust()'></td>"
       + "</tr>"
       + "<tr id='trReg'><td class='Prompt' nowrap>Phone:</td>"
         + "<td class='Prompt'><input class='Small1' name='Phone' size=14 maxsize=14 onkeypress='chkRetCust()'></td>"
       + "</tr>"
       + "<tr id='trReg'><td class='Prompt' nowrap>E-Mail:</td>"
         + "<td class='Prompt'><input class='Small1' name='SrchEMail' size=50 maxsize=50 onkeypress='chkRetCust()'></td>"
       + "</tr>"
       + "<tr id='trReg'><td class='Prompt' nowrap>Contract:</td>"
         + "<td class='Prompt'><input class='Small1' name='SrchCont' size=10 maxsize=10 onkeypress='chkRetCust()'></td>"
       + "</tr>"

  panel += "<tr><td class='Prompt1' colspan='2'><br><br><button onClick='ValidateCustSearch()' class='Small1'>Submit</button>&nbsp;"
  + "<button onClick='hidePanel();' class='Small1'>Close</button></td></tr>"

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

   var last = document.all.Last.value.trim().toUpperCase();
   var first = document.all.First.value.trim().toUpperCase();
   var phone = document.all.Phone.value.trim().toUpperCase();
   var email = document.all.SrchEMail.value.trim().toLowerCase();
   var cont = document.all.SrchCont.value.trim();
   
   if   ((last == null || last == "") && (first == null || first == "")
      && (phone == null || phone == "") && (email == null || email == "")
      && (cont == null || cont == ""))
   {
      msg = "Please, enter search criteria."
      error = true;
   }
   if(error) { alert(msg) }
   else { sbmCustSearch(last, first, phone, email, cont, " ", "Search_Flex"); }
}
//==============================================================================
//check skier by customer id
//==============================================================================
function chkRetCustId()
{
	e = window.event;     
	var keyCode = null;    
	if(e != null ){ keyCode = e.keyCode || e.which; }

	if ( keyCode == '13' )
	{  	 	
	  ValidateCustSearchId();
	  e.keyCode = 0;
	}    
}
//==============================================================================
//populate Customer Searched
//==============================================================================
function ValidateCustSearchId()
{
	var error = false;
	var msg = "";

	var id = document.all.SearchCustId.value.trim();

	if(isNaN(id)){ msg = "Customer Id must be numeric.";  error = true; }
	
	if(error) { alert(msg) }
	else 
	{ 
		sbmCustSearch(" ", " ", " ", " ", " ", id, "Search_Only"); 
	}
}
//==============================================================================
// populate Customer Searched
//==============================================================================
function sbmCustSearch(last, first, phone, email, cont, id, action)
{
   var url = "RentCustSearch.jsp?"
     + "Last=" + last
     + "&First=" + first
     + "&Phone=" + phone
     + "&EMail=" + email
     + "&Cont=" + cont
     + "&Cust=" + id
     + "&Action=" + action
   hidePanel();
   //alert(url)
   //window.location.href=url
   window.frame1.location.href=url
}
//==============================================================================
// customer list
//==============================================================================
function showCustLst(Cust, FirstNm, MInit, LastNm, Addr1, Addr2, City, State, Zip, EMail
  , HPhone, CPhone, Group, BDate, HeightFt, HeightIn, Weight, ShoeSiz, SkierTy, Stance
  ,RecUsr, RecDt, RecTm, MondoSiz, AngleLeft, AngleRight, CntOpn, CntRdy, CntCnl, CntPck
  , CntRtn, Unrel)
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
        , CntOpn, CntRdy, CntCnl, CntPck, CntRtn, Unrel)
     + "</td></tr>"
   + "</table>"
   
   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvStatus.style.width = "300";}
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
  , CntRtn, Unrel)
{
  var panel = "<table class='tbl01'>"
  panel += "<tr class='DataTable7'>"
      + "<th nowrap rowspan=2>ID</th>"
      + "<th nowrap rowspan=2>Name</th>"
      + "<th nowrap rowspan=2>Address</th>"
      + "<th nowrap rowspan=2>Date</th>"
      + "<th nowrap rowspan=2><span style='color:red;font-size:12px;'>*</span></th>"
      + "<th nowrap colspan=5>All Current Contract Statuses</th>"
    + "</tr>"
    + "<tr class='DataTable7'>"
      + "<th nowrap>opened &nbsp;</th>"
      + "<th nowrap>ready</th>"
      + "<th nowrap>returned &nbsp;</th>"
      + "<th nowrap>picked up &nbsp;</th>"      
      + "<th nowrap>cancelled &nbsp;</th>"
    + "</tr>"

    for(var i=0; i < Cust.length; i++)
    {
    	FirstNm[i] = FirstNm[i].replace("'", "&#39;");
    	LastNm[i] = LastNm[i].replace("'", "&#39;");
    	
        panel += "<tr class='DataTable8'>"
           + "<td class='DataTable' nowrap>" + Cust[i] + "</td>"
           + "<td class='DataTable' nowrap><a href='javascript: setCust(&#34;" + Cust[i]
            + "&#34;, &#34;" + FirstNm[i] + "&#34;, &#34;" + MInit[i] + "&#34;, &#34;" + LastNm[i]
            + "&#34;, &#34;" + Addr1[i] + "&#34;, &#34;" + Addr2[i] + "&#34;, &#34;" + City[i]
            + "&#34;, &#34;" + State[i] + "&#34;, &#34;" + Zip[i] + "&#34;, &#34;" + EMail[i]
            + "&#34;, &#34;" + HPhone[i] + "&#34;, &#34;" + CPhone[i] + "&#34;, &#34;" + Group[i]
            + "&#34;, &#34;" + BDate[i] + "&#34;, &#34;" + HeightFt[i] + "&#34;, &#34;" + HeightIn[i]
            + "&#34;, &#34;" + Weight[i] + "&#34;, &#34;" + ShoeSiz[i] + "&#34;, &#34;" + SkierTy[i]
            + "&#34;, &#34;" + Stance[i] + "&#34;, &#34;" + MondoSiz[i] + "&#34;, &#34;" + AngleLeft[i]
            + "&#34;, &#34;" + AngleRight[i] + "&#34;,&#34;" + RecDt[i] + "&#34;)'>"
              + FirstNm[i] + " " + MInit[i] + " " + LastNm[i] + "</a></td>"
           + "<td class='DataTable' nowrap>" + Addr1[i] + " " + Addr2[i] + " " + City[i] + " " + State[i] + " " + Zip[i] + "</td>"
           + "<td class='DataTable' nowrap>" + RecDt[i] + "</td>"
        var unr = "OK";
        if(Unrel[i]=="Y"){ unr = "<span style='border:red ridge 1px; background:red;font-size:12px;'>***</span>" }

        <%if(bChgCust){%>
            panel += "<td class='DataTable' nowrap><a href='javascript: chgCustSts(&#34;" + Cust[i]
               + "&#34;,&#34;" + FirstNm[i] + "&#34;,&#34;" + MInit[i] + "&#34;,&#34;"
               + LastNm[i] + "&#34;,&#34;" + Unrel[i] + "&#34;)'>" + unr + "</a></td>"
        <%}
          else {%>panel += "<td class='DataTable' nowrap>" + unr + "</td>";<%}%>

        panel += "<td class='DataTable' nowrap>" + CntOpn[i] + "</td>"
           + "<td class='DataTable' nowrap>" + CntRdy[i] + "</td>"          
           + "<td class='DataTable' nowrap>" + CntRtn[i] + "</td>"
           + "<td class='DataTable' nowrap>" + CntPck[i] + "</td>"
           + "<td class='DataTable' nowrap>" + CntCnl[i] + "</td>"           
         + "</tr>"
    }

    panel += "<tr class='DataTable8'><td class='DataTable2' colspan='10'>"
        + "<span style='border:red ridge 1px; background:red; font-size:12px;'>***</span> - Reservation - Not Picked up!</td></tr>"

    panel += "<tr class='DataTable8'><td class='DataTable2' colspan='10'>"
        + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"

     panel += "</table>";
  return panel;
}
//==============================================================================
// set selected customer
//==============================================================================
function setCust(cust, firstnm, minit, lastnm, addr1, addr2, city, state, zip, email
  , hphone, cphone, group, bdate, heightft, heightin, weight, shoesiz, skierty, stance
  , mondosiz, anglel, angler, recDt)
{

    // populate address with fisrst customer information
      document.all.Cust.value = cust;
      document.all.FName.value = firstnm;
      document.all.MInit.value = minit;
      document.all.LName.value = lastnm;
      document.all.Addr1.value = addr1;
      document.all.Addr2.value = addr2;
      document.all.City.value = city;
      document.all.State.value = state;
      document.all.Zip.value = zip;
      document.all.HPhone.value = hphone;
      document.all.CPhone.value = cphone;
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

      document.all.CustLastChgDt.innerHTML = "Last updated: " + recDt
      document.all.CustLastChgDt.style.display = "inline";

      hidePanel();
}
//==============================================================================
// selected customer is not found
//==============================================================================
function setCustError()
{
	alert("The Customer is not found") 
}
//==============================================================================
// retreived equipment previousely used by customer
//==============================================================================
function getUsedEquip(cust, fname, minit, lname)
{
   var url = "RentPreviouslyUsedEquipment.jsp?Str=<%=sStr%>"
     + "&Cont=<%=sSelContId%>"
     + "&Cust=" + cust
     + "&FirstNm=" + fname
     + "&MInit=" + minit
     + "&LastNm=" + lname
   //alert(url)
   window.frame1.location.href = url
}
//==============================================================================
// change customer status
//==============================================================================
function chgCustSts(cust, fnam, minit, lnam, sts)
{
   var hdr = fnam + " " + minit + ". " + lnam;

   var html = "<table class='tbl01'>"
       + "<tr>"
          + "<td class='BoxName' nowrap>" + hdr + "</td>"
          + "<td class='BoxClose' valign=top>"
            +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel01();' alt='Close'>"
        + "</td></tr>"
        + "<tr><td class='Prompt' colspan=2>"
           + popCustSts(cust, fnam, minit, lnam, sts)
         + "</td></tr>"
      + "</table>"
      
      if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvChkItm.style.width = "300";}
      else { document.all.dvChkItm.style.width = "auto";} 

   document.all.dvChkItm.innerHTML = html;
   document.all.dvChkItm.style.left=getLeftScreenPos() + 320;
   document.all.dvChkItm.style.top=getTopScreenPos() + 120;
   document.all.dvChkItm.style.visibility = "visible";

   if(sts=="Y") { document.all.CustSts.checked = true; }
}
//==============================================================================
// populate change customer status
//==============================================================================
function popCustSts(cust, fnam, minit, lnam, sts)
{
  var panel = "<table class='tbl01'>"
  panel += "<tr class='DataTable3'>"
      + "<td colspan=2 nowrap>Change Customer Status</td>"
    + "</tr>"
    + "<tr class='DataTable3'>"
      + "<td nowrap><input type='checkbox' name='CustSts' value='Y'>"
        + "<input type='hidden' name='CustSelId' value='" + cust + "'>"
      + "</td>"
      + "<td nowrap>Customer was a NO SHOW for Reservation - Pre-Pay Only!</td>"
    + "</tr>"

    panel += "<tr class='DataTable3'><td class='DataTable2' colspan='10'>"
        + "<button onClick='sbmCustSts()' class='Small'>Change</button> &nbsp; &nbsp; &nbsp; "
        + "<button onClick='hidePanel01();' class='Small'>Close</button></td></tr>"

     panel += "</table>";
  return panel;
}
//==============================================================================
// submit customer status changes
//==============================================================================
function sbmCustSts()
{
   var cust = document.all.CustSelId.value
   var sts = "N";
   if(document.all.CustSts.checked){ sts = "Y"; }

   var url = "RentContractSave.jsp?"
     + "&Cont=<%=sSelContId%>"
     + "&Cust=" + cust
     + "&Unrel=" + sts
     + "&Action=CUST_CHG_STS"
   //alert(url)
   window.frame1.location.href = url;
}
//==============================================================================
// displayed previously rented equipments
//==============================================================================
function showUsedEquip(Cust, FirstNm, MInit, LastNm, InvId, SrlNum, Desc, SizeNm, Brand, Model)
{
   if(InvId.length > 0)
   {
      var hdr = "Rented by " + FirstNm + " " + MInit + ". " + LastNm;

      var html = "<table class='tbl01'>"
        + "<tr>"
          + "<td class='BoxName' nowrap>" + hdr + "</td>"
          + "<td class='BoxClose' valign=top>"
            +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel01();' alt='Close'>"
        + "</td></tr>"
        + "<tr><td class='Prompt' colspan=2>"
           + popUsedEquip(Cust, InvId, SrlNum, Desc, SizeNm, Brand, Model)
         + "</td></tr>"
      + "</table>"
      
      if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvChkItm.style.width = "300";}
      else { document.all.dvChkItm.style.width = "auto";} 

      document.all.dvChkItm.innerHTML = html;
      document.all.dvChkItm.style.left=getLeftScreenPos() + 500;
      document.all.dvChkItm.style.top=getTopScreenPos() + 100;
      document.all.dvChkItm.style.visibility = "visible";
   }
   else{ alert("No previously rented equipment found") }
}
//==============================================================================
// populate previously rented equipment selection list
//==============================================================================
function popUsedEquip(Cust, InvId, SrlNum, Desc, SizeNm, Brand, Model)
{
  var panel = "<table class='tbl01'>"
  panel += "<tr class='DataTable7'>"
      + "<th nowrap>Desc</th>"
      + "<th nowrap>Size</th>"
      + "<th nowrap>Brand</th>"
      + "<th nowrap>Model</th>"
      + "<th nowrap>Actual<br>Serial #</th>"
      + "<th nowrap>Checkout</th>"
    + "</tr>"

    for(var i=0; i < InvId.length; i++)
    {
       panel += "<tr class='DataTable8'>"
           + "<td class='DataTable' nowrap>" + Desc[i] + "</td>"
           + "<td class='DataTable' nowrap>" + SizeNm[i] + "</td>"
           + "<td class='DataTable' nowrap>" + SrlNum[i] + "</td>"
           + "<td class='DataTable' nowrap>" + Brand[i] + "</td>"
           + "<td class='DataTable' nowrap>" + Model[i] + "</td>"
           + "<td class='DataTable1' nowrap>"
             + "<button id='btnUsed" + i+ "' onClick='setSelUsedEquip(&#34;" + Cust + "&#34;,&#34;" + InvId[i]
                  + "&#34;,&#34;" + i + "&#34;,&#34;" + Desc[i]
                  + "&#34;,&#34;" + SizeNm[i] + "&#34;,&#34;" + SrlNum[i] + "&#34;);' class='Small'>Get</button>"
           + "</td>"
         + "</tr>"
    }

    panel += "<tr class='DataTable8'><td class='DataTable2' colspan='6' style='color: darkred;'>"         
         + "Note: The actual S/N previously rented may not be available, and will be replaced with the next available S/N."
    	+ "</td></tr>";
    	
    panel += "<tr class='DataTable8'><td class='DataTable2' colspan='6'>"
          + "<button onClick='hidePanel01();' class='Small'>Close</button>"
        + "</td></tr>";

    panel += "</table>";
  return panel;
}
//==============================================================================
// set selected recently used equipment
//==============================================================================
function setSelUsedEquip(cust, invId, line, desc, size, srlnum)
{
   SelDesc = desc;
   SelSize = size;
   SelSrlNum = srlnum;

   var btn = "btnUsed" + line
   document.all[btn].disabled = true;

   var url = "RentContractSave.jsp?"
     + "Cont=<%=sSelContId%>"
     + "&Cust=" + cust
     + "&InvId=" + invId
     + "&Action=ADD_USED_TAG"
   //alert(url)
   window.frame1.location.href = url;
}
//==============================================================================
// change pay status for call in customer
//==============================================================================
function chgPaySts(payreq)
{
   var pay = "N";
   if(payreq.checked){ pay = "Y"; }

   var url = "RentContractSave.jsp?"
     + "Cont=<%=sSelContId%>"
     + "&PayReq=" + pay
     + "&Action=NEED_PAY"
   //alert(url)
   window.frame1.location.href = url;
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
// Hide selection screen
//==============================================================================
function printForm(cont)
{
     window.open("RentContractPrint.jsp?Grp=<%=sSelGrp%>&ContId=<%=sSelContId%>&Str=<%=sStr%>&Print=Y", "_blank");
     window.open("RentTicket.jsp?ContId=<%=sSelContId%>&Print=Y", "_blank");
     if(!FootWearRented)
     {      
    	 window.open("RentBootTag.jsp?ContId=<%=sSelContId%>&Print=Y", "_blank");
     }
}
//==============================================================================
//set test stamp
//==============================================================================
function setTestStamp(invId, action, srlNum)
{
	var hdr = "Set Test Stamp &nbsp; Serial# " + srlNum;

	   var html = "<table class='tbl01'>"
	     + "<tr>"
	       + "<td class='BoxName' nowrap>" + hdr + "</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
	       + "</td></tr>"
	   html += "<tr><td class='Prompt' colspan=2>"

	   html += popTestStamp(invId, action)

	   html += "</td></tr></table>"

	   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvStatus.style.width = "200"; }
	   else { document.all.dvStatus.style.width = "auto"; }
	   
	   document.all.dvStatus.innerHTML = html;
	   document.all.dvStatus.style.left= getLeftScreenPos() + 400;
	   document.all.dvStatus.style.top= getTopScreenPos() + 180;
	   document.all.dvStatus.style.visibility = "visible";
}
//==============================================================================
//populate Marked Item Panel
//==============================================================================
function popTestStamp(invId, action)
{
var panel = "<table  border=1 width='100%' cellPadding='0' cellSpacing='0' >";
panel += "<tr class='DataTable3'>"
     + "<td>Grade:</td>"
     + "<td nowrap>" 
       	+ " <input type='radio' name='Grade' value='PASSED'>Passed &nbsp; " 
       	+ " <input type='radio' name='Grade' value='FAILED'>Failed"
     + "</td>"
  + "</tr>"
  + "<tr class='DataTable3'>"
  	+ "<td nowrap>Tech Emp ID:</td>"
  	+ "<td nowrap><input name='Tech' maxlength='4' size='6'></td>"
	+ "</tr>"

	panel += "<tr class='DataTable3'>" 
	 + "<td align=center colspan=2><button onClick='vldItmTest(&#34;" + invId + "&#34;,&#34;" + action
		+ "&#34;);' class='Small'>Submit</button> &nbsp; &nbsp;"
	panel += "<button onClick='hidePanel();' class='Small'>Close</button> &nbsp; &nbsp;"
     + "</td></tr>"
	panel += "</table>";
	return panel;
}
//==============================================================================
//validate item test stamp
//==============================================================================
function vldItmTest(invId, action)
{
	var error = false;
	var msg = "";
	
	var grade = null;
	for(var i=0; i < document.all.Grade.length; i++)
	{
		if(document.all.Grade[i].checked){ grade = document.all.Grade[i].value; break; }
	}
	if(grade == null){ error=true; msg += "\nPlease check grade."; }
	
	var tech = document.all.Tech.value.trim();
	if(tech==""){error = true; msg += "\nPlease enter your employee number"; }
	else if(isNaN(tech)){error = true; msg += "\n>The employee number is not numeric"; }
	else if (!isEmpNumValid(tech)){error = true; msg += "\nEmployee number is invalid."; }	
 
	
	if(error) { alert(msg) }
	else { sbmItmTest(invId, grade, tech, action) }
}
//==============================================================================
//submit Item Test Grade 
//==============================================================================
function sbmItmTest(invId, grade, tech, action)
{
	url = "RentContractSave.jsp?InvId=" + invId
	 + "&Grade=" + grade
	 + "&Tech=" + tech
	 + "&Cont=" + ContractId
	 + "&Action=" + action
	;
	if(isIE || isSafari){ window.frame1.location.href = url; }
	else if(isChrome || isEdge) { window.frame1.src = url; }
}
//==============================================================================
//check employee number
//==============================================================================
function isEmpNumValid(emp)
{
	var valid = true;
	var url = "EComItmAsgValidEmp.jsp?Emp=" + emp;
	var xmlhttp;
	// code for IE7+, Firefox, Chrome, Opera, Safari
	if (window.XMLHttpRequest){ xmlhttp=new XMLHttpRequest(); }
	// code for IE6, IE5
	else { xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");}

	xmlhttp.onreadystatechange=function()
	{
 		if (xmlhttp.readyState==4 && xmlhttp.status==200)
 		{
    		valid = xmlhttp.responseText.indexOf("true") >= 0;
 		}
	}
	xmlhttp.open("GET",url,false); // synchronize with this apps
	xmlhttp.send();

	return valid;
}
//==============================================================================
// show help 
//==============================================================================
function getHelp(helpId, cell)
{
	var html="";
	if(helpId == "001")
	{ 
		html = "The serial number has been \"scanned\" as the equipment pulled/sized/fitted on this renter. Change Contact status to 'Ready' or 'Picked Up'.  Click the S/N to scan a different S/N, but DIN setting will also need to be re-entered.";
		  
	}
	else if(helpId == "002")
	{
	   html = "This Equipment has only been selected as a 'virtual' QTY place holder in" 
	    + " this SIZE - for reservation ONLY.  'Click to Scan S/N' when the actual S/N is" 
	    + " pulled/sized/fitted on this renter.  This must be done prior to printing the" 
	    + " Contract(s)!";
	} 
	
	html += "<p style='text-align:center;'>&nbsp; &nbsp; &nbsp; &nbsp; " 
	  + "<button class='Small' onclick='hidePanel1();'>Close</button>";
	
	  
	  
	if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvHelp.style.width = "350";}
	else { document.all.dvHelp.style.width = "auto";} 
	
	var pos = getObjPosition(cell);
	
	document.all.dvHelp.innerHTML = html;
	document.all.dvHelp.style.textAlign="left"
	document.all.dvHelp.style.fontSize="14px"
	document.all.dvHelp.style.left = pos[0] + 150;
	document.all.dvHelp.style.top = pos[1] - 180;
	document.all.dvHelp.style.visibility = "visible";
}

//==============================================================================
// switch responsible customer (primary)  
//==============================================================================
function switchSkierPanel()
{
	var hdr = "Switch Primary Customer";

	   var html = "<table class='tbl01'>"
	     + "<tr>"
	       + "<td class='BoxName' nowrap>" + hdr + "</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
	       + "</td></tr>"
	   html += "<tr><td class='Prompt' colspan=2>"

	   html += popSkierPanel()

	   html += "</td></tr></table>"

	   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvStatus.style.width = "200"; }
	   else { document.all.dvStatus.style.width = "auto"; }
	   
	   document.all.dvStatus.innerHTML = html;
	   document.all.dvStatus.style.left= getLeftScreenPos() + 400;
	   document.all.dvStatus.style.top= getTopScreenPos() + 180;
	   document.all.dvStatus.style.visibility = "visible";
}
//==============================================================================
// populate switch skier panel
//==============================================================================
function popSkierPanel()
{
	var panel = "<table  border=1 width='100%' cellPadding='0' cellSpacing='0' >";
	panel += "<tr class='DataTable3'>"
  		+ "<th>Primary</th>"
  		+ "<th>Customer Id</th>"
  		+ "<th>Customer Name</th>"  		
  	+ "</tr>"
    ;
  	
  	for(var i=0; i < NumOfSkr; i++)
  	{
  		panel += "<tr class='DataTable3'>" 
  			 + "<td align=center><input type='radio' name='inpCust' value='" + SkrId[i] + "'" 
  		if(SkrPrim[i] == "1" ){ panel += " checked "; }
  	    panel += "></td>"
  			+ "<td align=center>" + SkrId[i] + "</td>"
  			 + "<td align=center nowrap>" + SkrFName[i] + " " + SkrLName[i] +"</td>"
  		  + "</tr>" 
  	}
  	
	panel += "<tr class='DataTable3'>" 
	 + "<td align=center colspan=3><button onClick='sbmSwitchCust();' class='Small'>Submit</button> &nbsp; &nbsp;"
	panel += "<button onClick='hidePanel();' class='Small'>Close</button> &nbsp; &nbsp;"
  	+ "</td></tr>"
	panel += "</table>";
	return panel;
}
//==============================================================================
//  validate switch skier
//==============================================================================
function sbmSwitchCust()
{
     var cust = "";
     for(var i=0; i < NumOfSkr; i++)
   	 {
    	 var chkobj = document.getElementsByName("inpCust")[i];
    	 if(chkobj.checked)
    	 {
    		 cust  = chkobj.value; 
    		 break;
    	 }
    		 
   	 }
	 var url = "RentContractSave.jsp?Cont=<%=sSelContId%>"
     	+ "&Cust=" + cust
     	+ "&Action=Switch_Payee"
     ;
	 
	 window.frame1.location.href = url;
}
//==============================================================================
//get renter partner  
//==============================================================================
function getPartner()
{	
	var url = "RentCustSearch.jsp?"
	    + "&Cont=" + ContractId
	    + "&Cust=" + ContCust
	    + "&Action=Get_Partner"
	hidePanel();
	window.frame1.location.href=url;
	
	showSkierPanel(true);
}
//==============================================================================
//customer list
//==============================================================================
function showPartners(Cust, FirstNm, MInit, LastNm, Addr1, Addr2, City, State, Zip, EMail
, HPhone, CPhone, Group, BDate, HeightFt, HeightIn, Weight, ShoeSiz, SkierTy, Stance
,RecUsr, RecDt, RecTm, MondoSiz, AngleLeft, AngleRight, CntOpn, CntRdy, CntCnl, CntPck
, CntRtn, Unrel)
{
	var hdr = "Partner List";

	var html = "<table class='tbl01'>"
	+ "<tr>"
  + "<td class='BoxName' nowrap>" + hdr + "</td>"
  + "<td class='BoxClose' valign=top>"
    +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
  + "</td></tr>"
	 + "<tr><td class='Prompt' colspan=2>" + popPartner(Cust, FirstNm, MInit, LastNm, Addr1
   , Addr2, City, State, Zip, EMail, HPhone, CPhone, Group, BDate, HeightFt, HeightIn, Weight
   , ShoeSiz, SkierTy, Stance, RecUsr, RecDt, RecTm, MondoSiz, AngleLeft, AngleRight
   , CntOpn, CntRdy, CntCnl, CntPck, CntRtn, Unrel)
		+ "</td></tr>"
	+ "</table>"

	if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvStatus.style.width = "300";}
	else { document.all.dvStatus.style.width = "auto";} 

	document.all.dvStatus.innerHTML = html;
	document.all.dvStatus.style.left=getLeftScreenPos() + 300;
	document.all.dvStatus.style.top=getTopScreenPos() + 100;
	document.all.dvStatus.style.visibility = "visible";
}
//==============================================================================
//populate Customer Searched
//==============================================================================
function popPartner(Cust, FirstNm, MInit, LastNm, Addr1, Addr2, City, State, Zip, EMail
, HPhone, CPhone, Group, BDate, HeightFt, HeightIn, Weight, ShoeSiz, SkierTy, Stance
,RecUsr, RecDt, RecTm, MondoSiz, AngleLeft, AngleRight, CntOpn, CntRdy, CntCnl, CntPck
, CntRtn, Unrel)
{
	var panel = "<table class='tbl01'>"
	panel += "<tr class='DataTable7'>"
 	+ "<th nowrap >ID</th>"
 	+ "<th nowrap >Name</th>"
 	+ "<th nowrap >Address</th>"
 	+ "<th nowrap >Date</th>"
 	+ "</tr>"
	 
	for(var i=0; i < Cust.length; i++)
	{
		FirstNm[i] = FirstNm[i].replace("'", "&#39;");
		LastNm[i] = LastNm[i].replace("'", "&#39;");
	
   panel += "<tr class='DataTable8'>"
      + "<td class='DataTable' nowrap>" + Cust[i] + "</td>"
      + "<td class='DataTable' nowrap><a href='javascript: setCust(&#34;" + Cust[i]
       + "&#34;, &#34;" + FirstNm[i] + "&#34;, &#34;" + MInit[i] + "&#34;, &#34;" + LastNm[i]
       + "&#34;, &#34;" + Addr1[i] + "&#34;, &#34;" + Addr2[i] + "&#34;, &#34;" + City[i]
       + "&#34;, &#34;" + State[i] + "&#34;, &#34;" + Zip[i] + "&#34;, &#34;" + EMail[i]
       + "&#34;, &#34;" + HPhone[i] + "&#34;, &#34;" + CPhone[i] + "&#34;, &#34;" + Group[i]
       + "&#34;, &#34;" + BDate[i] + "&#34;, &#34;" + HeightFt[i] + "&#34;, &#34;" + HeightIn[i]
       + "&#34;, &#34;" + Weight[i] + "&#34;, &#34;" + ShoeSiz[i] + "&#34;, &#34;" + SkierTy[i]
       + "&#34;, &#34;" + Stance[i] + "&#34;, &#34;" + MondoSiz[i] + "&#34;, &#34;" + AngleLeft[i]
       + "&#34;, &#34;" + AngleRight[i] + "&#34;,&#34;" + RecDt[i] + "&#34;)'>"
         + FirstNm[i] + " " + MInit[i] + " " + LastNm[i] + "</a></td>"
      + "<td class='DataTable' nowrap>" + Addr1[i] + " " + Addr2[i] + " " + City[i] + " " + State[i] + " " + Zip[i] + "</td>"
      + "<td class='DataTable' nowrap>" + RecDt[i] + "</td>"
     + "</tr>"
	;
	}
	
	panel += "<tr class='DataTable8'><td class='DataTable2' colspan='10'>"
   + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"

	panel += "</table>";
	return panel;
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
<div id="dvHelp" class="dvHelp"></div>
<div id="dvStatus" class="dvStatus"></div>
<div id="dvChkItm" class="dvChkItm"></div>

<div id="dvHelpDoc" class="dvHelpDoc">
<a  class="helpLink" href="Intranet Reference Documents/3.0%20Open%20a%20New%20Contract.pdf" title="Click here for help" target="_blank">&nbsp;</a>
</div>

<%if(sPayReq != null && sPayReq.equals("Y")){%>
     <div style="position:absolute; left: 5%; top: 60px;
       width:200px;height:50px;margin:30px 50px;background-color:#ffffff;border:none;
       opacity:0.6;filter:alpha(opacity=40); color=red; font-size:26px;font-weight: bold">
       COLLECT ON ARRIVAL
     </div>
  <%}%>
<!-------------------------------------------------------------------->

    <table border="0" cellPadding="0"  cellSpacing="0" width="100%">
     <tr>
      <td ALIGN="left" VALIGN="TOP" width="30%" nowrap>
         <b><font size="-1">
            Store: <%if(!sSelContId.equals("0000000000")){%><%=sStr%><%}
                     else {%><span id="spnStrLst">Select Store</span><%}%>
            <br>
            User: <%if(sOnline.equals("Y")){%><span style="background: yellow; color: red; font-weight: bold;">** ON-LINE RESERVATION **</span><%} else {%><%=sUser%><%}%>&nbsp;
              <%if(sSelContId.equals("0000000000") && sUser.indexOf("cashr") >= 0){%><input name="UserNm" maxlength="20" size="20"><%}%><br>
              <%if(!sSelContId.equals("0000000000") && !sUserNm.equals("")){%>Opened By: <%=sUserNm%><%}%>
            </font></b>
      </td>
      <td ALIGN="center" VALIGN="TOP" nowrap>
        <b>Rental Contract
        <br>
          <%if(sSelContId.equals("0000000000")){%><button class="Small" onClick="openCont();">Open Contract</button><%}
            else {%>
            <button class="Small" onClick="chgStatusMenu('<%=sSelContId%>', '<%=sSts%>');">Change</button>
          <%}%>

          Status: <span style="background:yellow"><%if(sSelContId.equals("0000000000")){%>New<%} else {%><%=sSts%><%}%></span>

      </td>
      <td ALIGN="left" VALIGN="TOP" width="20%" nowrap>
         <b><font size="-1">Created Date:  <%if(!sSelContId.equals("0000000000")) {%><%=sOpenDt%><%} else {%><%=sToday%><%}%>
         <br>Created Time: <%if(!sSelContId.equals("0000000000")) {%><%=sOpenTm%><%} else {%><%=sCurTime%><%}%>
         <!--  <br>Contract: <%=sSelContId%> -->
         </font></b></td>
    </tr>

    <tr>
      <td ALIGN="center" VALIGN="TOP" colspan=3 nowrap>
      <a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;
      <a href="RentContListSel.jsp"><font color="red" size="-1">Selection</font></a>&#62;This Page. &nbsp; &nbsp; &nbsp;

      <%if(!sSelContId.equals("0000000000")) {%>
        <button class="small" onclick="window.open('RentContractPrint.jsp?Grp=<%=sSelGrp%>&ContId=<%=sSelContId%>&Str=<%=sStr%>', '_blank')">Print Contracts</button>
        &nbsp; &nbsp;
        <button class="small" onclick="window.open('RentTicket.jsp?Grp=<%=sSelGrp%>&ContId=<%=sSelContId%>', '_blank')">POS Ticket</button>
        &nbsp; &nbsp;
        
        <button id="btnBootTag" class="small" onclick="window.open('RentBootTag.jsp?ContId=<%=sSelContId%>&Str=<%=sStr%>', '_blank')">Boot Tag</button>
        &nbsp; &nbsp;
        
        <button class="small" onclick="printForm('<%=sSelContId%>')">Print Contracts<span id="spnBootPrt" style="display:none">, Boot Tag</span> & POS</button>
        &nbsp; &nbsp;
        <a href="javascript: addNewComments()"><font size="-1">New Comments</font></a>
        <input name="PayReq" type="checkbox" onclick="chgPaySts(this)" value="Y"
          <%if(sPayReq != null && sPayReq.equals("Y")){%>checked<%}%>>
          <font size="-1">Collect on Arrival</font>
      <%}%>
      <br>

      <br>
  <!-------------------------- Contract Info ------------------------------------>
    <div id="dvCont" style="border-width:3px; border-style:ridge; border-color:lightgray; width:100%;">
      <table cellPadding="0" cellSpacing="0" id="tbDept" width="100%" border=0>
        <tr class="DataTable">
          <td class="DataTable" style="font-size:14px; color: red; background: yellow;"  nowrap>
          <%if(sOnline.equals("Y")){%>Reservation ID<%} else {%>Contract<%}%>: 
          <span style="font-size: 18px; font-weight: bold;"><%=sSelContId%></span></td>
          <td class="DataTable" style=" width:30%;">&nbsp;</td>
          
          
          <!-------- Picka Up Date ----------->
          
          <td class="DataTable" style="font-size:14px;"  nowrap><b>Pick Up </b></td>
          <td class="DataTable" nowrap>
            <%if(sSelContId.equals("0000000000")){%>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'FrDate')">&#60;</button>
            <%}%>
              <input name="FrDate" class="inpAsDate<%if(!sSelContId.equals("0000000000")){%>Link<%}%>" type="text" size=10 maxlength=10 readonly 
                 <%if(!sSelContId.equals("0000000000")){%>onClick="chgStatusMenu('<%=sSelContId%>', '<%=sSts%>');"<%}%>>&nbsp;
            <%if(sSelContId.equals("0000000000")){%>
              <button class="Small" name="Up" onClick="setDate('UP', 'FrDate')">&#62;</button>
              <a href="javascript:showCalendar(1, null, null, 400, 150, document.all.FrDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>          
            <%}%>
            </td>
            <td class="DataTable" nowrap style="font-size:14px; font-weight:bold; width:5%;" >
               <%if(sSelContId.equals("0000000000")){%>
               	<input name="PickAmPm" style="font-weight:bold;" type="radio" value='A' checked>AM &nbsp;
            	<br>
            	<input name="PickAmPm" style="font-weight:bold;" type="radio" value='P' >PM &nbsp;
               <%} else {%><%if(sPickAmPm.equals("A")){%>AM<%} else {%>PM<%}%><%}%>	            
          </td>
         
         <!-- --------- Drop off ---------------->
         
          <td class="DataTable" style="font-size:14px;"  nowrap><b> &nbsp; &nbsp; Drop Off </b></td>
          <td class="DataTable" nowrap>
            <%if(sSelContId.equals("0000000000")){%>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'ToDate')">&#60;</button>
            <%}%>
              <input name="ToDate" class="inpAsDate<%if(!sSelContId.equals("0000000000")){%>Link<%}%>" type="text" size=10 maxlength=10 readonly
                 <%if(!sSelContId.equals("0000000000")){%>onClick="chgStatusMenu('<%=sSelContId%>', '<%=sSts%>');"<%}%>>&nbsp;
            <%if(sSelContId.equals("0000000000")){%>
              <button class="Small" name="Up" onClick="setDate('UP', 'ToDate')">&#62;</button>
              <a href="javascript:showCalendar(1, null, null, 630, 150, document.all.ToDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>
              &nbsp; &nbsp; &nbsp;
            </td>
            <%}%>
            <td class="DataTable" nowrap style="font-size:14px; font-weight:bold; width:5%;">
            	<%if(sSelContId.equals("0000000000")){%>
            		<input name="DropAmPm" style="font-weight:bold;" type="radio" value='A' >AM &nbsp;
            		<br>
            		<input name="DropAmPm" style="font-weight:bold;" type="radio" value='P' checked>PM &nbsp;
                <%} else {%><%if(sDropAmPm.equals("A")){%>AM<%} else {%>PM<%}%><%}%> 		
            </td>
            
            <%if(sSelContId.equals("0000000000")){%>
            <td class="DataTable" nowrap>  
              <%if(sSelGrp.equals("SKI")){%>
              	<button class="Small" name="btnEofS" onClick="setDate('EOS', 'ToDate')">Lease</button>
              <%}%>               
            <%}%>
            </td>
 			
            
            <td class="DataTable" nowrap>
            <%if(!sSelContId.equals("0000000000")){%>
                <%for(int i=0; i < 5; i++){%>&nbsp;<%}%>
                <%if(sHalf.equals("Y")){%>
                	<span style="color:green; font-size:12px; font-weight:bold;">Half Day Rent</span>
                <%}%> 
            	<%for(int i=0; i < 25; i++){%>&nbsp;<%}%>
               	<button class="Small" onclick="window.close()">Done</button> &nbsp;
            <%}%>
          </td>
           <td style="width:25%">&nbsp;</td>
          
          <td class="DataTable1" style="color: red; background: yellow; font-size: 18px; font-weight: bold;"  nowrap>
          <%if(sOnline.equals("Y")){%><%=lDays%> Days = $<%=sSubtot%><%} else {%>&nbsp;<%}%></td>
          
        </tr>
      </table>
    </div>
    <br>
  <!------------------------- New Skiers Info entry panel --------------------->
     <div id="dvNewSkiers" style="border-width:3px; border-style:ridge; border-color:lightgray; width:100%;
       <%if(!sSelContId.equals("0000000000")){%>display:none;<%}%>">
     <table cellPadding="0" cellSpacing="0" id="tbDept" width="100%">
       <tr class="DataTable">
         <td class="DataTable">
           First Name &nbsp; <input class='Small2' name="FName" maxlength=30 size=30 onFocus="this.select()"> &nbsp;
           M.I. &nbsp; <input class='Small2' name="MInit" maxlength=1 size=1 onFocus="this.select()" > &nbsp;
           Last Name &nbsp; <input class='Small2' name="LName" maxlength=30 size=30 onFocus="this.select()">
           &nbsp; &nbsp;
           <input type="hidden" name="Cust" readOnly>
           <input name="Action" type="hidden">
           <a id="lnkRtnCust" href="javascript: getCustLst()">Returning Customer<a> &nbsp; &nbsp; &nbsp;
             <b>-OR-</b>  &nbsp; &nbsp; &nbsp;
           Enter Customer ID:<input size=12 class="small" maxlength=10 name="SearchCustId" onkeypress='chkRetCustId()'>
           <span id="CustLastChgDt" style="display:none;"></span>
         </td>
       </tr>
       <tr class="DataTable">
         <td class="DataTable">
           Home Address &nbsp; <input class='Small2' name="Addr1" maxlength=50 size=50 onFocus="this.select()"> &nbsp;
                               <input class='Small2' name="Addr2" maxlength=50 size=50 onFocus="this.select()"> &nbsp;
           <br>City &nbsp; <input class='Small2' name="City" maxlength=50 size=50 onFocus="this.select()"> &nbsp;
               State &nbsp; <input class='Small2' name="State" maxlength=2 size=2 onFocus="this.select()"> &nbsp;
               Zip Code &nbsp; <input class='Small2' name="Zip" maxlength=10 size=10 onFocus="this.select()"> &nbsp;
         </td>
       </tr>
       <tr class="DataTable">
         <td class="DataTable">
           E-Mail &nbsp; <input class='Small2' name="EMail" maxlength=50 size=50 onFocus="this.select()"> &nbsp;
           
           &nbsp; US <input type=radio class="Small" name="PhoneUOM" value="U"> 
           or International <input type=radio class="Small" name="PhoneUOM" value="I">
           
           Home Phone &nbsp; <input class='Small2' name="HPhone" maxlength=20 size=25 onFocus="this.select()"> &nbsp;
           Mobile Phone &nbsp; <input class='Small2' name="CPhone" maxlength=20 size=25 onFocus="this.select()"> &nbsp;
         </td>
       </tr>
       <tr class="DataTable">
         <td class="DataTable">
          Age &nbsp; <input class='Small2' name="BirthDt" maxlength=2 size=2 onFocus="this.select()"> &nbsp;
           Non-renter (parent/guardian) Only &nbsp; <input class='Small' name="Parent" type="checkbox" value="Y"> 
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
           Group Name &nbsp; <input class='Small2' name="Group" maxlength=20 size=20 onFocus="this.select()" disabled style="background: grey;"> &nbsp;
              &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
           Selected Sport: 
           <%if(sSelGrp.equals("SKI")){%> Ski/Snowboard<%}
             else if(sSelGrp.equals("WATER")){%>Watersport<%} 
             else if(sSelGrp.equals("BIKE")){%>Bike<%} 
             else if(sSelGrp.equals("ALL")){%>Online Order - All Sport<%}%>  
            <input name="SkiRent" type="checkbox" style="display: none;">            
         </td>
       </tr>
       <tr class="DataTable">
         <td class="DataTable">
           <table border=1 cellPadding="0" cellSpacing="0" id="tblPerson" width="100%">
            <tr class="DataTable">
             <td class="DataTable">Damage Waiver: &nbsp;
                <input class='radio' type="radio" name="DmgWaiver" value="Y"> Yes &nbsp;
                <input class='radio' type="radio" name="DmgWaiver" value="N" checked> No
                <br>$2 Daily / $10 Season
             </td>
             <td class="DataTable">US &nbsp;  &nbsp; &nbsp;<input name="UOM" type="radio" onclick="setUOM('U')" value="U">
                 Weight (lbs.) &nbsp; <input class='Small2' name="Weight" onblur="setWeight('lbs')" onfocus="this.select()" maxlength=3 size=3> &nbsp;
                 Height (ft) &nbsp; <input class='Small2' name="HeightFt" onblur="setHeight( 'ft')" onfocus="this.select()" maxlength=1 size=1> &nbsp;
                        (in) &nbsp; <input class='Small2' name="HeightIn" onblur="setHeight( 'ft')" onfocus="this.select()" maxlength=2 size=2> &nbsp;
                 <br>
                 Metric <input name="UOM" type="radio"  onclick="setUOM('M')" value="M"> 
                 Weight (Kg) &nbsp; <input class='Small2' name="WeightKg" onblur="setWeight('kg')" onfocus="this.select()" maxlength=3 size=3> &nbsp;
                 Height (Cm) &nbsp; <input class='Small2' name="HeightCm"onblur="setHeight( 'cm')" onfocus="this.select()" maxlength=3 size=3> &nbsp;                               
             </td>
             <td class="DataTable">Skier Type &nbsp; <input class='radio' type="radio" name="SkiType" value="-1"> -I &nbsp;
                             <input class='radio' type="radio" name="SkiType" value="1"> I &nbsp;
                             <input class='radio' type="radio" name="SkiType" value="2"> II &nbsp;
                             <input class='radio' type="radio" name="SkiType" value="3"> III &nbsp;
                             <input class='radio' type="radio" name="SkiType" value="3+"> III+ &nbsp; &nbsp;
             </td>
             <td class="DataTable">
                    SB Stance &nbsp; <input class='radio' type="radio" name="SkiType" value="R"> Regular &nbsp;
                                 <input class='radio' type="radio" name="SkiType" value="G"> Goofy &nbsp;
                <br>Angle &nbsp; Left <input class='Small2' name="AngleLeft" maxlength=4 size=3> &nbsp;
                          &nbsp; Right <input class='Small2' name="AngleRight" maxlength=4 size=3> &nbsp;
             </td>
            <tr>
           </table>
         </td>
       </tr>
    </table>
    <%if(!sSelContId.equals("0000000000")){%>
       <button class="Small" onclick="validateSkier();">Save Renter</button> &nbsp;
       <button class="Small" onclick="showSkierPanel(false);">Close</button>
    <%}%>
    </div>

    <%if(!sSelContId.equals("0000000000") && (sSts.equals("OPEN") || sSts.equals("PICKEDUP"))){%>
       <button class="Small" id="btnAddSkier" onclick="showSkierPanel(true);">Add Renter</button>
       &nbsp; &nbsp;
        <button class="Small" id="btnAddPartner" onclick="getPartner();">Add Renter Partner</button>
       &nbsp; &nbsp;
       <%if(iNumOfSkr > 1){%>
       <button class="Small" id="btnWwitchSkier" onclick="switchSkierPanel();">Switch Primary Renter</button>
       <%} %>
       <br>
    <%}%>
  <!----------------------- end of new skier entry table ---------------------->


  <!---------------------- Exist Skiers Info panel ---------------------------->
     <%for(int i=0; i < iNumOfSkr;i++){%>
     <%
       boolean bSkiSkr = false;
     
       rentinfo.setSkiersInfo();

       String sCust = rentinfo.getCust();
       String sFName = rentinfo.getFName();
       String sMInit = rentinfo.getMInit();
       String sLName = rentinfo.getLName();
       String sAddr1 = rentinfo.getAddr1();
       String sAddr2 = rentinfo.getAddr2();
       String sCity = rentinfo.getCity();
       String sState = rentinfo.getState();
       String sZip = rentinfo.getZip();
       String sEMail = rentinfo.getEMail();
       String sHPhone = rentinfo.getHPhone();
       String sCPhone = rentinfo.getCPhone();
       String sIntl = rentinfo.getIntl();
       String sParent = rentinfo.getParent();
       String sGroup = rentinfo.getGroup();
       String sBDate = rentinfo.getBDate();
       String sHeightFt = rentinfo.getHeightFt();
       String sHeightIn = rentinfo.getHeightIn();
       String sWeight = rentinfo.getWeight();
       String sShoeSiz = rentinfo.getShoeSiz();
       String sSkierType = rentinfo.getSkierType();
       String sStance = rentinfo.getStance();
       String sMondoSiz = rentinfo.getMondoSiz();
       String sAngleLeft = rentinfo.getAngleLeft();
       String sAngleRight = rentinfo.getAngleRight();
       String sHist = rentinfo.getHist();
       String sPayee = rentinfo.getPayee();
       String sDmgWaiver = rentinfo.getDmgWaiver();
       
       
       // checkout inventory
       rentinfo.setSkrInv();
       int iNumOfInv = rentinfo.getNumOfInv();
       String [] sInvId = rentinfo.getInvId();
       String [] sBootLen = rentinfo.getBootLen();
       String [] sLeftToe = rentinfo.getLeftToe();
       String [] sRightToe = rentinfo.getRightToe();
       String [] sLeftHeal = rentinfo.getLeftHeal();
       String [] sRightHeal = rentinfo.getRightHeal();
       String [] sInvStr = rentinfo.getInvStr();
       String [] sCls = rentinfo.getCls();
       String [] sVen = rentinfo.getVen();
       String [] sSty = rentinfo.getSty();
       String [] sClr = rentinfo.getClr();
       String [] sSiz = rentinfo.getSiz();
       String [] sSrlNum = rentinfo.getSrlNum();
       String [] sTestDt = rentinfo.getTestDt();
       String [] sGrade = rentinfo.getGrade();
       String [] sDesc = rentinfo.getDesc();
       String [] sClrNm = rentinfo.getClrNm();
       String [] sSizNm = rentinfo.getSizNm();
       String [] sBrandNm = rentinfo.getBrandNm();
       String [] sModel = rentinfo.getModel();
       String [] sScanned = rentinfo.getScanned();
       String [] sSkiRent = rentinfo.getSkiRent();
       
       iAsgEqp += iNumOfInv;
       
    // check if boot found
       boolean bBootFound = false;
       for(int j=0; j < iNumOfInv; j++){
          if(sCls[j].equals("9744") || sCls[j].equals("9745") || sCls[j].equals("9754")
              || sCls[j].equals("9755") || sCls[j].equals("9764") || sCls[j].equals("9767")
              || sCls[j].equals("9771")
              || sCls[j].equals("9732") || sCls[j].equals("9734")
              || sCls[j].equals("9681") || sCls[j].equals("9682")
              || sCls[j].equals("9691") || sCls[j].equals("9692")
              ){ bFootWear = true; }
             
       }  
       sFName = sFName.replaceAll("'", "&#146;");
       sLName = sLName.replaceAll("'", "&#146;");
       
       sAddr1 = sAddr1.replaceAll("'", "&#146;");
       sAddr1 = sAddr1.replaceAll("\"", "&#34;");       
       sAddr2 = sAddr2.replaceAll("'", "&#146;");
       sAddr2 = sAddr2.replaceAll("\"", "&#34;");
       
       sCity = sCity.replaceAll("'", "&#146;");  
       sCity = sCity.replaceAll("\"", "&#34;");
       
       sZip = sZip.replaceAll("'", "&#146;");
       sZip = sZip.replaceAll("\"", "&#34;");
       
       sGroup = sGroup.replaceAll("'", "&#146;");
       
       int iWgtLbs = Integer.parseInt(sWeight);
       int iWgtKg = (int) Math.round(iWgtLbs / 2.2);
       
       int iHgtFt = Integer.parseInt(sHeightFt);
       int iHgtIn = Integer.parseInt(sHeightIn);
       int iHgtCm = (int) Math.round( iHgtFt * 30 + iHgtIn * 2.5 );      
       
     %>
     <script>SkrId[<%=i%>]="<%=sCust%>"; SkrFName[<%=i%>]="<%=sFName%>"; SkrLName[<%=i%>]="<%=sLName%>"; SkrPrim[<%=i%>] = "<%=sPayee%>";
     ContCust = "<%=sCust%>";
     </script>
     <div id="dvSkiers" style="background:#e7e7e7;
         border:<%if(!sHist.equals("2")){%>lightgray ridge 3px;<%} else {%>red ridge 3px;<%}%> width:100%;">
     <table cellPadding="0" cellSpacing="0" id="tbSkier" width="100%" style="background:#e7e7e7;">
       <tr class="DataTable1">
         <td class="DataTable">
           First Name &nbsp; <input class='Small4' name="FName<%=i%>" maxlength=30 size=30 value="<%=sFName%>" readOnly> &nbsp;
           M.I. &nbsp; <input class='Small4' name="MInit<%=i%>" maxlength=1 size=1 value="<%=sMInit%>" readOnly> &nbsp;
           Last Name &nbsp; <input class='Small4' name="LName<%=i%>" maxlength=30 size=30 value="<%=sLName%>" readOnly>
           &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Customer ID: &nbsp;<%=sCust%> &nbsp; &nbsp;
           <%if(sHist.equals("2")){%>
            <!-- span style="border: darkred solid 1px; background: cornsilk; color: red; font-size:12px;font-weight: bold">
            </span -->
            <div style="position:absolute; left:50%; top:expression(getObjPosition(this)););
              width:300px;height:30px;margin:30px;background-color:#ffffff;border:none;
              opacity:0.6;filter:alpha(opacity=40); color=red; font-size:16px;font-weight: bold;
              border:red solid 1px">
              Customer was a NO SHOW for Reservation - Pre-Pay Only!
            </div>
         <%}%>
         </td>
         <td class="DataTable" style="font-size:50px;font-weight:bold" rowspan=4><%=i+1%></td>
       </tr>
       <tr class="DataTable1">
         <td class="DataTable">
           Home Address &nbsp; <input class='Small4' name="Addr1<%=i%>" maxlength=50 size=50 value="<%=sAddr1%>" readOnly> &nbsp;
                               <input class='Small4' name="Addr2<%=i%>" maxlength=50 size=50 value="<%=sAddr2%>" readOnly> &nbsp;
           <br>City &nbsp; <input class='Small4' name="City<%=i%>" maxlength=50 size=50 value="<%=sCity%>" readOnly> &nbsp;
               State &nbsp; <input class='Small4' name="State<%=i%>" maxlength=2 size=2 value="<%=sState%>" readOnly> &nbsp;
               Zip Code &nbsp; <input class='Small4' name="Zip<%=i%>" maxlength=10 size=10 value="<%=sZip%>" readOnly> &nbsp;
         </td>
       </tr>
       <tr class="DataTable1">
         <td class="DataTable">
           E-Mail &nbsp; <input class='Small4' name="EMail<%=i%>" maxlength=50 size=50 value="<%=sEMail%>" readOnly> &nbsp;
           <%if(sIntl.equals("Y")){%>(International)<%}%>
           Home Phone &nbsp; <input class='Small4' name="HPhone<%=i%>" maxlength=20 size=20 value="<%=sHPhone%>" readOnly> &nbsp;
           Mobile Phone &nbsp; <input class='Small4' name="CPhone<%=i%>" maxlength=20 size=20 value="<%=sCPhone%>" readOnly> &nbsp;
         </td>
       </tr>
       <tr class="DataTable1">
         <td class="DataTable">           
           Age &nbsp; <input class='Small4' name="BirthDt<%=i%>" maxlength=2 size=2 value="<%=sBDate%>" readOnly> &nbsp;
           Non-renter (parent/guardian) Only &nbsp; <b><u><%=sParent%></u></b> &nbsp; <input class='Small' name="Parent<%=i%>" type="hidden" value="<%=sParent%>"> &nbsp;
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
           Group Name &nbsp; <input class='Small4' name="Group<%=i%>" maxlength=20 size=20 value="<%=sGroup%>" readOnly> &nbsp;
         </td>
       </tr>
       <tr class="DataTable1">
         <td class="DataTable" colspan=2>
           <%if(sSelGrp.equals("SKI") || sSelGrp.equals("ALL")){%>
           <table border=1 cellPadding="0" cellSpacing="0" id="tbDept" width="100%">
            <tr class="DataTable1">
             <td class="DataTable">Damage Waiver: &nbsp; 
                <%if(sDmgWaiver.equals("Y")){%>Yes<%} else {%>No<%}%>
             </td>
             <td class="DataTable">
               Weight (lbs.) &nbsp; <input class='Small4' name="Weight<%=i%>" maxlength=3 size=3 value="<%=sWeight%>" readOnly> &nbsp;
               
               Height (ft) &nbsp; <input class='Small4' name="HeightFt<%=i%>" maxlength=1 size=1 value="<%=sHeightFt%>" readOnly> &nbsp;
                      (in) &nbsp; <input class='Small4' name="HeightIn<%=i%>" maxlength=2 size=2 value="<%=sHeightIn%>" readOnly> &nbsp;
              
               <br>Weight (kg) &nbsp; &nbsp;<input class='Small5' name="WeightKg<%=i%>" maxlength=3 size=3 value="<%=iWgtKg%>" readOnly> &nbsp;
               &nbsp;Height (cm) &nbsp; <input class='Small5' name="HeightCm<%=i%>" maxlength=1 size=1 value="<%=iHgtCm%>" readOnly> &nbsp;
               
             </td>
             <td class="DataTable">
               Skier Type &nbsp; <input class='radio' type="radio" name="SkiType<%=i%>" value="-1" <%if(sSkierType.equals("-1")){%>checked<%}%> readOnly> -I &nbsp;
                             <input class='radio' type="radio" name="SkiType<%=i%>" value="1" <%if(sSkierType.equals("1")){%>checked<%}%> readOnly> I &nbsp;
                             <input class='radio' type="radio" name="SkiType<%=i%>" value="2" <%if(sSkierType.trim().equals("2")){%>checked<%}%> readOnly> II &nbsp;
                             <input class='radio' type="radio" name="SkiType<%=i%>" value="3" <%if(sSkierType.equals("3")){%>checked<%}%> readOnly> III &nbsp;
                             <input class='radio' type="radio" name="SkiType<%=i%>" value="3+" <%if(sSkierType.equals("3+")){%>checked<%}%> readOnly> III+ &nbsp;
             </td>
             <td class="DataTable">
               SB Stance &nbsp; <input class='radio' type="radio" name="SkiType<%=i%>" value="R" <%if(sStance.equals("R")){%>checked<%}%> readOnly> Regular &nbsp;
                         <input class='radio' type="radio" name="SkiType<%=i%>" value="G" <%if(sStance.equals("G")){%>checked<%}%> readOnly> Goofy &nbsp;
               <br>Angle: &nbsp; Left <input class='Small4' name="AngleLeft<%=i%>" maxlength=4 size=3 value="<%=sAngleLeft%>" readOnly> &nbsp;
                                Right <input class='Small4' name="AngleRight<%=i%>"maxlength=4 size=3 value="<%=sAngleRight%>" readOnly> &nbsp;

               </td>
             </tr>
           </table>
           <%}%>
           <%if(i==0){%><script>DftAddr1 = "<%=sAddr1%>"; DftAddr2 = "<%=sAddr2%>"; DftCity = "<%=sCity%>"; DftState = "<%=sState%>"; DftZip = "<%=sZip%>"; DftHPhone = "<%=sHPhone%>";DftIntl="<%=sIntl%>";  DftEMail = "<%=sEMail%>"; DftGroup = "<%=sGroup%>"</script><%}%>
         </td>
       </tr>

       <!--========= Skier's Checkout Inventories ===========================-->
       <tr class="DataTable1">
         <td class="DataTable" colspan=2>
            <table border=1 cellPadding="0" cellSpacing="0" id="tb<%=sCust%>Inv" width="100%">
               <tr class="DataTable7">
                 <th>Description</th>
                 <th>Size</th>
                 <th>Serial<br>Number</th>
                 <th>Brand</th>
                 <th>Model</th>
                 <th>Setting</th>
                 <th>Update<br>Settings</th>                 
                 <th>Tech Test/Grade</th>
                 <th>Delete<br>Equipment</th>
               </tr>
               <%boolean bSkrEquip = iNumOfInv > 0;
                 bSkiSkr = false;
                 for(int j=0; j < iNumOfInv; j++){%>
                    <tr class="DataTable7">
                      <td class="DataTable"><%=sDesc[j]%></td>
                      <%if(!sInvId[j].equals("9999999999")){%>
                          <td class="DataTable"><%=sSizNm[j]%></td>
                          <td class="DataTable2" <%if(sScanned[j].equals("Y")){%>style="background:lightgreen;"<%}%>
                            onmouseover="getHelp('<%if(sScanned[j].equals("Y")){%>001<%} else {%>002<%}%>', this)"
                            onmouseout="hidePanel1();"
                            >
                              <%if(!sSts.equals("PICKEDUP") && !sSts.equals("RETURNED")){%>
                                 <a href="javascript: updSrlNum('<%=sInvId[j]%>', '<%=sSrlNum[j]%>')" 
                                   style="font-size:12px;">
                                   <%if(sScanned[j].equals("Y")){%><%=sSrlNum[j]%><%} 
                                     else {%><span style="color:red; font-size:12px;">Click to Scan S/N<%}%>
                                 </a>
                                 
                              <%} else {%><%=sSrlNum[j]%><%}%>   
                              <%if(sScanned[j].equals("Y")){%><sup>Scanned</sup><%}%>
                                                        
                          </td>
                          <td class="DataTable"><%=sBrandNm[j]%></td>
                          <td class="DataTable"><%=sModel[j]%></td>
                          <td class="DataTable">
                             <%if(sSelGrp.equals("SKI")){%>
                             Boot Length: <%=sBootLen[j]%> &nbsp;
                             Left Toe: <%=sLeftToe[j]%> &nbsp; Right Toe: <%=sRightToe[j]%> &nbsp;
                             Left Heel: <%=sLeftHeal[j]%> &nbsp; Right Heel: <%=sRightHeal[j]%> &nbsp;
                        <%} else {%>&nbsp;<%} %>                              
                          </td>
                          <td class="DataTable2">
                          	<%if(sSelGrp.equals("SKI")){%>
                          	<a href="javascript: updInv('<%=sInvId[j]%>', '<%=sCust%>', '<%=sDesc[j]%>'
                            ,'<%=sBootLen[j]%>','<%=sLeftToe[j]%>', '<%=sRightToe[j]%>', '<%=sLeftHeal[j]%>'
                            , '<%=sRightHeal[j]%>', '<%=sSrlNum[j]%>')">Update</a>
                            <%} else {%>&nbsp;<%} %>
                          </td>                            
                      <%}
                      else {%><td class="DataTable2" colspan=6>&nbsp;</td><%}%>
                      
                      <td class="DataTable2">
                      <%if(sSelGrp.equals("SKI") && !sInvId[j].equals("9999999999")){%>
                            <%if(!sTestDt[j].equals("01/01/0001")){%><%=sTestDt[j]%><%}%> &nbsp; 
                            <a href="javascript: setTestStamp('<%=sInvId[j]%>','TEST_STAMP_CONT', '<%=sSrlNum[j]%>')">Grade</a> 
                            <%if(!sGrade[j].equals("")){%>: &nbsp;<%=sGrade[j]%><%}%>
                      <%} else{%>&nbsp;<%}%>
                      </td>
                      <td class="DataTable2">
                        <%if(sSts.equals("OPEN") || sSts.equals("READY")){%><a href="javascript: dltInv('<%=sInvId[j]%>', '<%=sCust%>', '<%=sDesc[j]%>')">Delete</a><%}
                        else {%>&nbsp;<%}%>
                      </td>
                    </tr> 
                    <%if(sSkiRent.equals("Y")){bSkiSkr = true;}%>                   
               <%}%>

            </table>
         </td>
       </tr>
    </table>

    <table border=0  cellPadding="0" cellSpacing="0" width="100%">
    <tr>
    <td id="tdSkiIns<%=i%>" style="font-size:11px; width: 35%;"> </td>
    <td align="center" width=30%">
    <%if(sSts != null && ( sSts.equals("OPEN") ))
    {%>
      
       <%if(!sParent.equals("Y")){%> 
       <br>
       
       <%if(sSelGrp.equals("SKI") || sSelGrp.equals("ALL")){%> 
         <a class="Small" style="border: black solid 1px;" onClick="javascript: chgEquip('<%=sCust%>', '<%=sFName%>', '<%=sMInit%>', '<%=sLName%>', 'Ski');" >
         <img alt="Add Ski Equipment" src="/images/Snowsport.png" height="45px">
         </a>
         &nbsp;  &nbsp;
       <%}%>
       <%if(sSelGrp.equals("WATER") || sSelGrp.equals("ALL")){%> 
       	 <a class="Small" style="border: black solid 1px;" onClick="javascript: chgEquip('<%=sCust%>', '<%=sFName%>', '<%=sMInit%>', '<%=sLName%>', 'Water');" >
         <img alt="Add Watersport Equipment" src="/images/Watersport.png" height="45px">
         </a>
         &nbsp;  &nbsp;
       <%}%> 
       <%if(sSelGrp.equals("BIKE") || sSelGrp.equals("ALL")){%>   
       <a class="Small" style="border: black solid 1px;" onClick="javascript: chgEquip('<%=sCust%>', '<%=sFName%>', '<%=sMInit%>', '<%=sLName%>', 'Bike');" >
         <img alt="Add Bikes" src="/images/Bike.png" height="45px">
       </a>
       <%}%>
     <%}%>
       
      
       
       <!-- button class="Small" onClick="chgEquip('<%=sCust%>', '<%=sFName%>', '<%=sMInit%>', '<%=sLName%>','Ski');">Add Snowsports Eqp</button> &nbsp; 
       <button class="Small" onClick="chgEquip('<%=sCust%>', '<%=sFName%>', '<%=sMInit%>', '<%=sLName%>','Bike');">Add Bikes Eqp</button> &nbsp;
       <button class="Small" onClick="chgEquip('<%=sCust%>', '<%=sFName%>', '<%=sMInit%>', '<%=sLName%>','Water');">Add Watersports Eqp</button> &nbsp;
        -->
       
       <%if(!sParent.equals("Y") && !sHist.equals("0")){%>
          &nbsp; &nbsp;
          <br><br><button class="Small" onClick="getUsedEquip('<%=sCust%>', '<%=sFName%>', '<%=sMInit%>', '<%=sLName%>');">Previously Rented</button>
       <%}%>

       &nbsp; &nbsp;
       <button class="Small" onClick="chgSkier('<%=sCust%>', '<%=sFName%>', '<%=sMInit%>', '<%=sLName%>'
         , '<%=sAddr1%>', '<%=sAddr2%>', '<%=sCity%>', '<%=sState%>', '<%=sZip%>', '<%=sEMail%>', '<%=sHPhone%>'
         , '<%=sCPhone%>', '<%=sGroup%>', '<%=sBDate%>', '<%=sHeightFt%>', '<%=sHeightIn%>', '<%=sWeight%>'
         , '<%=sShoeSiz%>', '<%=sSkierType%>', '<%=sStance%>', '<%=sPayee%>', '<%=sMondoSiz%>'
         , '<%=sAngleLeft%>', '<%=sAngleRight%>', '<%=sDmgWaiver%>', '<%=sIntl%>', '<%=sParent%>', <%=bSkrEquip%>
         , <%=bSkiSkr%>);">Change Renter Info</button>
    <%}%>
    <%if(i > 0 ){%>
      &nbsp; &nbsp;
      <button class="Small" onClick="dltSkier('<%=sCust%>');">Delete Skier</button>
    <%}%>
    </td>
    <td>&nbsp;</td>
    </tr>
     </table>

    </div>
    
     <br>
    <%}%>
    <!-- ================== Comments ================================= -->
    <%if(!sSelContId.equals("0000000000")){%>
    
        <%if(sOnline.equals("Y"))
        {
        	// get calculated online payment
            rentinfo.setOnlinePayments();
            sSubtot = rentinfo.getSubtot();
            sTaxRate = rentinfo.getTaxRate();
            sTax = rentinfo.getTax();
            sTotal = rentinfo.getTotal();
        %>
          <div style="font-size:12px">
             <b><u>Online Calculated Ticket Payment:</u></b>
             
             <table border=0 style="font-size:12px">
             <tr>
               <td>Subtotal &nbsp;</td><td>$<%=sSubtot%></td>
             </tr>
             <tr>  
               <td>Tax Rate &nbsp;</td><td>$<%=sTaxRate%></td>
             </tr>
             <tr> 
               <td>Tax &nbsp;</td><td>$<%=sTax%></td>
              </tr>
             <tr>  
               <td>Total &nbsp;</td><td>$<%=sTotal%></td>
             </tr>
             </table>
          </div>
        <%}%> 
    
    <br>
        <a class="Small" href="javascript: filterCommt('USER')">User comments only</a> &nbsp;  &nbsp;
        <a class="Small" href="javascript: filterCommt('AUTO')">Auto comments only</a> &nbsp;  &nbsp;
        <a class="Small" href="javascript: filterCommt('All')">All</a> &nbsp;  &nbsp;


        <div id="dvComment" style="border-width:3px; border-style:ridge; border-color:lightgray;
           width:100%;height: 200px;overflow: auto;"><div>

        </td>
      <%}%>
   </tr>

  </table>
 </body>
 <script>
 FootWearRented = <%=bFootWear%>;
 
 AsgEqp = <%=(iAsgEqp > 0)%>;
 if(!FootWearRented)
 { 
	 if(document.all.btnBootTag != null) {document.all.btnBootTag.style.display = "inline"; }
	 if(document.all.spnBootPrt != null) {document.all.spnBootPrt.style.display = "inline";}
 } 
 </script>
 
 <%if(sOnline.equals("Y")){%>
 <a href="RentGetJson.jsp?ContId=<%=sSelContId%>" target="_blank">JSON</a>
 <%}%>
</html>


<%
  }%>










