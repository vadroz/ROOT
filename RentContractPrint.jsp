<%@ page import="rciutility.RunSQLStmt, rental.RentContractInfo
, rciutility.RunSQLStmt, rciutility.BarcodeGen
, java.sql.*, java.util.*, java.text.*, java.io.*"%>
<%
	String sStr = request.getParameter("Str");
   String sSelContId = request.getParameter("ContId");
   String sPrint = request.getParameter("Print");
   String sSelGrp = request.getParameter("Grp");
  
   boolean bEmpty = false;
   
   if(sSelContId == null){ sSelContId = "0000000000"; bEmpty = true; }
   if(sStr == null){ sStr = " "; }
   if(sSelGrp == null){ sSelGrp = "SKI"; }
   
   
  
   //----------------------------------
   // Application Authorization
   //----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=RentContractPrint.jsp&APPL=ALL&" + request.getQueryString());
}
else
{
      String sUser = session.getAttribute("USER").toString();
      String sPickDt = "";
      String sRtnDt = "";
      String sSts = null;
      String sUserNm = null;
      String sPayReq = null;

      int iNumOfSkr = 0;
      RentContractInfo rentinfo = new RentContractInfo(sSelContId, sUser);
      sPickDt = rentinfo.getPickDt();
      sRtnDt = rentinfo.getRtnDt();
      sSts = rentinfo.getSts();
      sUserNm = rentinfo.getUserNm();
      sPayReq = rentinfo.getPayReq();
      String sContStr = rentinfo.getStr();

      // Skiers List and personal info
      iNumOfSkr = rentinfo.getNumOfSkr();
      
      SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
      Calendar cal = Calendar.getInstance();
      String sToday = sdf.format(cal.getTime());
      SimpleDateFormat stf = new SimpleDateFormat("h:mm a");
      String sCurTime = stf.format(cal.getTime());

      java.util.Date dtPick = sdf.parse(sPickDt);
      java.util.Date dtReturn = sdf.parse(sRtnDt);
      long lDays = (dtReturn.getTime() - dtPick.getTime()) / (1000*60*60*24) + 1;
      
      String sEmpFirst = "";
      String sEmpMI = "";
      String sEmpLast = "";
      String sEmpCity = "";
      String sEmpState = "";
      String sEmpEmail = "";
      String sEmpPhn = "";
      if(bEmpty)
      {  
    	 for(int i=0; i < 40;i++){ sEmpFirst += "&nbsp;"; }    	 
    	 for(int i=0; i <  5;i++){ sEmpMI += "&nbsp;"; }
    	 for(int i=0; i < 80;i++){ sEmpLast += "&nbsp;"; }
    	 for(int i=0; i < 80;i++){ sEmpCity += "&nbsp;"; }
    	 for(int i=0; i < 15;i++){ sEmpState += "&nbsp;"; }
    	 for(int i=0; i < 80;i++){ sEmpEmail += "&nbsp;"; }
    	 for(int i=0; i < 30;i++){ sEmpPhn += "&nbsp;"; }
      }
      
      // begining of fiscal year
      String sPrepStmt = "select pyr#"   	 	
       	+ " from rci.Fsyper"
      	+ " where pida=current date";
      ResultSet rslset = null;
      RunSQLStmt runsql = new RunSQLStmt();
      runsql.setPrepStmt(sPrepStmt);		   
      runsql.runQuery();
      
      String sCurFiscYr = null;
      if(runsql.readNextRecord()){ sCurFiscYr = runsql.getData("pyr#"); }
      
      String sContFileNm = sSelContId;
      if (!sSelContId.equals("0000000000"))
      {
    	  String sFilePath = "C:/Program Files/Apache Software Foundation/Tomcat 9.0/webapps/ROOT/Barcode/Rental/" + sContFileNm
			+ ".png";
		  File f = new File(sFilePath);
	      // not exists - generate picture
          try {
		     if (!f.exists()) {
		    	BarcodeGen bargen = new BarcodeGen();
				bargen.outputtingBarcodeAsPNG_NoText(sContFileNm, sFilePath);
			 }
          }
	      catch (Exception e) {
			System.out.println(e.getMessage());
		  }
	  }
      
      // begining of fiscal year
      sPrepStmt = "select ESFREED"   	 	
       	+ " from rci.ReStr"
      	+ " where esstr=" + sContStr;
      rslset = null;
      runsql = new RunSQLStmt();
      runsql.setPrepStmt(sPrepStmt);		   
      runsql.runQuery();
      
      boolean bFreeDays = false;
      if(runsql.readNextRecord()){ bFreeDays = runsql.getData("ESFREED").equals("Y"); }
%>

<html>
<head>
<title>SSER/L</title>

<style>
body {background:white;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}

        a.Small:link { color:blue; font-size:10px} a.Small:visited { color:blue; font-size:10px}  a.Small:hover { color:blue; font-size:10px}

        table.DataTable { border: gray solid 1px; text-align:center;}
        th.DataTable { background:white;padding-top:3px; padding-bottom:3px;
                       text-align:left; font-family:Verdanda; font-size:12px }
        th.DataTable1 { padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px;
                        border-bottom: darkred solid 1px;border-right: darkred solid 1px;
                        text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable2 { border-bottom: gray solid 1px; border-left: gray solid 1px;
                        padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px;
                        text-align:center; font-family:Verdanda; font-size:10px }

        tr.DataTable { background:white; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:#e7e7e7; font-family:Arial; font-size:10px }
        tr.DataTable2 { background:white; font-family:Arial; font-size:12px; font-weight: bold }
        tr.DataTable3 { background:CornSilk; font-family:Arial; font-size:10px }
        tr.DataTable4 { background:#FFCC99; font-family:Arial; font-size:10px }
        tr.DataTable5 { background:LemonChiffon; font-family:Arial; font-size:10px }
        tr.DataTable6 { background: lightpink; font-family:Arial; font-size:10px }
        tr.DataTable7 { background:white; font-family:Arial; font-size:14px; font-weight: bold;}
        tr.Divider { background:black; font-family:Arial; font-size:1px }

        td.DataTable {  border-bottom:gray 1px solid;border-left:gray 1px solid; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:left;}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;}
        td.DataTable2 { border-bottom:gray 1px solid; border-left: gray solid 1px; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:center;}
    
        td.DataTable4 { border-bottom: darkred solid 1px;border-right: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;}
        td.DataTable5 { border-bottom: darkred solid 1px;border-right: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center;}
        td.DataTable6 {  border-bottom:#e7e7e7 1px solid; text-align:left;}
        
        td.DataTable7 {  border-bottom:gray 1px solid;border-left:gray 1px solid; padding-top:3px; 
                         padding-bottom:3px; padding-left:3px; padding-right:3px; text-align: center; 
                         font-size:12px}

        td.StrInv { cursor:hand; padding-top:3px; padding-bottom:3px;
                    padding-left:3px; padding-right:3px;
                    border-bottom: darkred solid 1px; text-align:left;}

        td.StrInv1{ padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                    border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                    text-align:left;}

        td.StrLst { background:#FFCC99; border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                    text-align:center; font-size:9px}

        .Small {font-family:Arial; font-size:10px }
        input.Small1 { font-family:Arial; font-size:10px }
        input.Small2 {border:none; border-bottom:1px black solid; font-family:Arial;  font-size:10px }
        input.radio { font-family:Arial; font-size:10px }
        input.Menu {border: ridge 2px; background:white; font-family:Arial; font-size:10px }

        textarea {border:none; background:#E7E7E7; border-bottom: black solid 1px; font-family:Arial; font-size:10px }
        button.Small {font-size:10px; }
        select.selSts {display:none;font-size:10px; }
        button.selSts {display:none;font-size:10px; }
        input.selSts {display:none;font-size:10px; }
        span.Type {font-size:12px; font-weight:bold;}

        div.dvStatus  { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:200; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        div.dvHelp  { position:absolute; visibility:hidden; background-attachment: scroll;
              border: lightgray solid 1px;; width:50; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }

@media print
{
        td.tdOnlyDisp{ display:none;}
}
</style>




<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
var SelGrp = "<%=sSelGrp%>";
var PickDt = "<%=sPickDt%>";
var RtnDt = "<%=sRtnDt%>";
var NumOfSkr = "<%=iNumOfSkr%>"
//--------------- End of Global variables ----------------
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvChkItm", "dvStatus"]);
   <%if(sPrint != null){%>print(this);<%}%>
   
   if(SelGrp=="WATER")
   { 
	   for(var i=0; i < NumOfSkr; i++)
	   {
		   var nm = "dvSkiAgr" + i;
		   document.all[nm].style.display="none";
		   var nm = "dvSkiEq" + i;
		   document.all[nm].style.display="none";
		   var nm = "dvWaterAgr" + i;
		   document.all[nm].style.display="block";
		   var nm = "dvWaterEq" + i;
		   document.all[nm].style.display="block";		   
	   }
   }
   else if(SelGrp=="SKI" )
   { 
	   for(var i=0; i < NumOfSkr; i++)
	   {
		   var nm = "dvSkiAgr" + i;
		   document.all[nm].style.display="block";
		   var nm = "dvSkiEq" + i;
		   document.all[nm].style.display="block";
		   var nm = "dvWaterAgr" + i;
		   document.all[nm].style.display="none";
		   var nm = "dvWaterEq" + i;
		   document.all[nm].style.display="none";
	   }
   }
}
//==============================================================================
// refresh Contract
//==============================================================================
function refreshCont(cont)
{
   var url = "RentContractInfo.jsp?ContId=" + cont + "&Str=<%=sStr%>"
   window.location.href = url;
}

//==============================================================================
// show Skier adding panel
//==============================================================================
function showSkierPanel()
{
   document.all.dvNewSkiers.style.display="block";
   document.all.btnAddSkier.style.display="none";
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
<!-------------------------------------------------------------------->
<div id="dvHelp" class="dvHelp"></div>
<!-------------------------------------------------------------------->

 <%for(int i=0; i < iNumOfSkr;i++){
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
       String sGroup = rentinfo.getGroup();
       String sBDate = rentinfo.getBDate();
       String sHeightFt = rentinfo.getHeightFt();
       String sHeightIn = rentinfo.getHeightIn();
       String sWeight = rentinfo.getWeight();
       String sShoeSiz = rentinfo.getShoeSiz();
       String sSkierType = rentinfo.getSkierType();
       String sStance = rentinfo.getStance();
       String sPayee = rentinfo.getPayee();
       String sMondoSiz = rentinfo.getMondoSiz();
       String sAngleLeft = rentinfo.getAngleLeft();
       String sAngleRight = rentinfo.getAngleRight();
       String sDmgWaiver = rentinfo.getDmgWaiver();
       
       
       String sCustFileNm = sCust;
       String sFilePath = "C:/Program Files/Apache Software Foundation/Tomcat 9.0/webapps/ROOT/Barcode/Rental/Skier/" 
       		+ sCustFileNm + ".png";
 	   File f = new File(sFilePath);
 	   // not exists - generate picture
       try {
 		    if (!f.exists()) {
 		    	BarcodeGen bargen = new BarcodeGen();
 				bargen.outputtingBarcodeAsPNG_NoText(sCustFileNm, sFilePath);
 			}
        }
 	    catch (Exception e) {
 			System.out.println(e.getMessage());
 		} 
       

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
       
       String [] sBrand = rentinfo.getBrand();
       String [] sBrandNm = rentinfo.getBrandNm();
       String [] sModel = rentinfo.getModel();
       String [] sScanned = rentinfo.getScanned();
       
       String [] sInvFileNm = new String[iNumOfInv];  
       
       String sPaddle = "";
       for(int j=0; j < iNumOfInv; j++)
       {
    	   if(sInvId[j].equals("9999999999"))
    	   { 
    		   sPaddle = "<b>Y</b>"; 
    		   break;
    	   }
    	   
    	   sInvFileNm[j] = sSrlNum[j];
           sFilePath = "C:/Program Files/Apache Software Foundation/Tomcat 9.0/webapps/ROOT/Barcode/Rental/Inventory/" 
           		+ sInvFileNm[j] + ".png";
     	    f = new File(sFilePath);
     	   // not exists - generate picture
           try {
     		    if (!f.exists()) {
     		    	BarcodeGen bargen = new BarcodeGen();
     				bargen.outputtingBarcodeAsPNG_NoText(sInvFileNm[j], sFilePath);
     			}
            }
     	    catch (Exception e) {
     			System.out.println(e.getMessage());
     		} 
    	   
    	   
    	   
       }
 %>
 
  <div style="page-break-after:<%if(i < iNumOfSkr-1){%>always<%} else {%>avoid<%}%>;">
  <%if(sPayReq.equals("Y")){%>
     <div style="position:absolute; left: 40%; top: 60px;
       width:200px;height:50px;margin:30px 50px;background-color:#ffffff;border:none;
       opacity:0.6;filter:alpha(opacity=40); color=red; font-size:26px;font-weight: bold">
       COLLECT ON ARRIVAL
     </div>
  <%}%>
  


  <table border="0" cellPadding="0"  cellSpacing="0" width="100%">

     <tr>
      <td ALIGN="center" VALIGN="TOP" nowrap>
        <span style="font-size:30px; font-weight:bold">Snow Sports Equipment Rental / Lease</span>
      </td>
    </tr>

    <tr>
      <td ALIGN="center" VALIGN="TOP">

  <!---------------------- Exist Skiers Info panel ---------------------------->
 
     <div id="dvSkiers" style="width:100%;">
     <table style="border:gray 1px solid; width:100%;" cellPadding="0" cellSpacing="0" id="tbDept">
       <tr class="DataTable">
          <td class="DataTable" colspan=2>
            <%if(!bEmpty){%><img width=100 src="/Barcode/Rental/<%=sContFileNm%>.png"><%} %> 
           <!-- Contract:  -->
            <%if(!bEmpty){%><span style="font-size: 18px; font-weight:bold;"><%=sSelContId%></span> / <%=i+1%> of <%=iNumOfSkr%>
                  
            <%}%> &nbsp; &nbsp;
            <%if(!bEmpty){%><%=sToday%><%} else {%> &nbsp; &nbsp;/ &nbsp; &nbsp;/ &nbsp;<%}%> 
             &nbsp; &nbsp;
            Str# <%=sStr%> &nbsp; &nbsp;             
            User: <%=sUserNm%>            
          </td>
          <td class="DataTable2" rowspan="4">
             <img width=260 src="/images/rci_logo_rental_form.jpg">            
          </td>
       </tr>
       <tr class="DataTable">
         <td class="DataTable">
           First Name &nbsp;<span class="Type"><%=sFName%></span> &nbsp; <%=sEmpFirst%>
           M.I. &nbsp; <span class="Type"><%=sMInit%></span> &nbsp; <%=sEmpMI%>
           Last Name &nbsp; <span class="Type"><%=sLName%></span> <%=sEmpLast%>
           
           &nbsp;&nbsp;&nbsp;
           Skier <%=i+1%>: <%=sCust%> - 
           <img width=100 src="/Barcode/Rental/Skier/<%=sCustFileNm%>.png">    
         </td>         
       </tr>
       <tr class="DataTable">
         <td class="DataTable" style="border-right:none;">
           Home Address &nbsp; <span class="Type"><%=sAddr1%>&nbsp;<%=sAddr2%></span> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
         </td>         
         
      </tr>
      <tr class="DataTable">
         <td class="DataTable" width="70%"  colspan=2>
           City &nbsp; <span class="Type"><%=sCity%></span> &nbsp; <%=sEmpCity%>
               State &nbsp; <span class="Type"><%=sState%></span> &nbsp; <%=sEmpState%>
               Zip Code &nbsp; <span class="Type"><%=sZip%></span>&nbsp;
         </td>
          
      </tr>
      <tr class="DataTable">
         <td class="DataTable" colspan=2>
           E-Mail &nbsp; <span class="Type"><%=sEMail%></span> &nbsp;  &nbsp;<%=sEmpEmail%>
           <br> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 
           &nbsp; &nbsp; &nbsp;  
           Home Phone <span class="Type"><%=sHPhone%></span>&nbsp;<%=sEmpPhn%> 
           &nbsp; Mobile Phone &nbsp; <span class="Type"><%=sCPhone%></span> &nbsp;  &nbsp;  
         </td>
           
         <td class="DataTable7" rowspan=2>
            <b>Pickup Date:</b> ______/______/______
         </td>     
       </tr>
       <tr class="DataTable">
         <td class="DataTable6">
           <table cellPadding="0" cellSpacing="0" id="tbDept" width="100%">
            <tr class="DataTable">
             <td class="DataTable">Weight (lbs.) &nbsp; <span class="Type"><%=sWeight%></span> &nbsp;</td>
             <td class="DataTable">
                  Height (ft) &nbsp; <span class="Type"><%=sHeightFt%></span> &nbsp;
                         (in) &nbsp; <span class="Type"><%=sHeightIn%></span> &nbsp;
             </td>
             <td class="DataTable" style="border-left: gray 1px solid;">&nbsp;
               <%if(sSkierType.equals("-1")){%>Skier Type &nbsp; <b>-I</b><%}%>
               <%if(sSkierType.equals("1")){%>Skier Type &nbsp; <b>I</b><%}%>
               <%if(sSkierType.equals("2")){%>Skier Type &nbsp; <b>II</b><%}%>
               <%if(sSkierType.equals("3")){%>Skier Type &nbsp; <b>III</b><%}%>
               <%if(sSkierType.equals("3+")){%>Skier Type &nbsp; <b>III+</b><%}%>
               <%if(sStance.equals("R")){%>SB Stance &nbsp; <b>Regular</b><%}%>
               <%if(sStance.equals("G")){%>SB Stance &nbsp; <b>Goofy</b><%}%>
             </td>
             <td class="DataTable" style="border-left: gray 1px solid;">
               Age &nbsp; <span class="Type"><%=sBDate%></span> &nbsp;
             </td>
             <td class="DataTable" style="border-left: #e7e7e7 1px solid;">
               <!-- Shoe Size &nbsp; <span class="Type"><%=sShoeSiz%> / <%=sMondoSiz%></span> --> &nbsp;
             </td>
             </td>

            </tr>
           </table>
         </td>
       </tr>
    </table>
    </div>

    <!-- ================== End Skier List ================================= -->
     </td>
   </tr>
  </table>
  <div id="dvSkiEq<%=i%>" style="border:none; width:100%;">
      <span style="font-size:12px; font-weight:bold; width:100%; text-align:center; padding-top:3px; padding-bottom:3px;">
        &nbsp;<!--EQUIPMENT DAMAGE INSURANCE $1.00 PER DAY PER SET. NOT INSURED AGAINST THEFT OR ABUSE-->
      </span><br>
      
      
      <!-- table class="DataTable" cellPadding="0" cellSpacing="0" id="tbDept" width="100%">        
        <tr class="DataTable">
          <td class="DataTable">Accepted</td>
          <td class="DataTable" style="background:#e7e7e7;color: gray;"  nowrap><u> &nbsp;  &nbsp; Initial &nbsp;  &nbsp; </u></td>
          <td class="DataTable">This shop will absorb the cost of repairing  any damaged
           equipment caused NORMAL use, however, I am still responsible for the FULL
           value of any lost, misplaced or stolen equipment (or damage due to negligence or misuse).
          </td>
        </tr>
        
        <tr class="DataTable">
          <td class="DataTable">Declined</td>
          <td class="DataTable" style="background:#e7e7e7;color: gray;" nowrap><u> &nbsp;  &nbsp; Initial &nbsp;  &nbsp; </u></td>
          <td class="DataTable">I am still responsible for the FULL value of any loss of equipment
             regardless of fault, including repair and / or replacement or damaged lost misplaced
             or stolen equipment.<br>&nbsp;
          </td>
        </tr>        
      </table -->
      

      <!-- ============================ Section 3 ========================== -->
      <table class="DataTable" cellPadding="0" cellSpacing="0" id="tbDept" width="100%">
        <tr class="DataTable1">
          <th class="DataTable2">RENTAL TYPES:</th>
          <th class="DataTable2">TOTAL DAYS</th>
          <!-- th class="DataTable2">TOTAL PRICE</th -->
          <th class="DataTable2">DATE OUT - RETURN DUE DATE</th>
        </tr>
        <tr class="DataTable">
          <td class="DataTable2"><b><%if(!bEmpty){%><%if(lDays <= 30){%>DAILY<%} else {%>SEASON LEASE<%}%><%}%></b></td>
          <td class="DataTable2"><%if(!bEmpty){%><b><%=lDays%></b><%}%> <%if(bFreeDays){%><br>(Free days included)<%}%></td>
          <!--  td class="DataTable">&nbsp;</td -->
          <td class="DataTable2"><%if(!bEmpty){%><span style="font-size: 14px; font-weight: bold;"><%=sPickDt%> - <%=sRtnDt%></span><%}%></td>
        </tr>
      </table>

      <!-- ============================ Section 4 ========================== -->
      <table class="DataTable" cellPadding="0" cellSpacing="0" id="tbDept" width="100%">
        <tr class="DataTable">          
          <td class="DataTable" rowspan=3 width="20%">
           SNOWBOARD
           <table border="0" cellPadding="0" cellSpacing="0" id="tbDept" width="100%">
             <tr class="DataTable">
               <td class="DataTable" style="border:none;">STANCE</td>
               <td class="DataTable" style="border:none;" nowrap>
                  <span style="width:20px; height:23px; background:#e7e7e7; border:black 1px solid"><%if(sStance.equals("R")){%>XXXXX<%}%></span> Regular</td>
               <td class="DataTable" style="border:none;" nowrap>
                  <span style="width:20px; height:23px; background:#e7e7e7; border:black 1px solid"><%if(sStance.equals("G")){%>XXXXX<%}%></span> Goofy</td>
             </tr>
             <tr class="DataTable">
               <td class="DataTable" style="border:none;" nowrap>ANGLE</td>
               <td class="DataTable" style="border:none;" nowrap><span style="width: 20px; height:23px; background:#e7e7e7; border:black 1px solid; text-align:center"><%if(!sAngleLeft.equals("0")){%><%=sAngleLeft%><%}%></span> Left</td>
               <td class="DataTable" style="border:none;" nowrap><span style="width: 20px; height:23px; background:#e7e7e7; border:black 1px solid; text-align:center"><%if(!sAngleRight.equals("0")){%><%=sAngleRight%><%}%></span> Right</td>
             </tr>
           </table>
          </td>
          <td class="DataTable" colspan="2" nowrap>SKI/BOARD CLASS:
             <%for(int j=0; j < iNumOfInv; j++){%>
                <%if(sCls[j].equals("9740") || sCls[j].equals("9742") || sCls[j].equals("9750")
                    || sCls[j].equals("9760") || sCls[j].equals("9762") || sCls[j].equals("9766")
                    || sCls[j].equals("9770") || sCls[j].equals("9780") || sCls[j].equals("9781")
                    || sCls[j].equals("9730") || sCls[j].equals("9731") || sCls[j].equals("9733")
                    || sCls[j].equals("9680") || sCls[j].equals("9690") || sCls[j].equals("9741")
                    || sCls[j].equals("9742")
                    ){%>
                    <b><%=sDesc[j]%></b>
                <%}%>
             <%}%>


          </td>
          <!-- was ski size: -->
          <td class="DataTable"  colspan="2" nowrap>BOOT CLASS: &nbsp; &nbsp; 
             <%for(int j=0; j < iNumOfInv; j++){%>
                <%if(sCls[j].equals("9744") || sCls[j].equals("9745") || sCls[j].equals("9754")
                    || sCls[j].equals("9755") || sCls[j].equals("9764") || sCls[j].equals("9767")
                    || sCls[j].equals("9771")
                    || sCls[j].equals("9732") || sCls[j].equals("9734")
                    || sCls[j].equals("9681") || sCls[j].equals("9682")
                    || sCls[j].equals("9691") || sCls[j].equals("9692")
                    ){%>
                    <b><%=sDesc[j]%></b>
                <%}%>
             <%}%>
          </td>           
          <td class="DataTable" rowspan="3"  width="7%">
             POLES: &nbsp; &nbsp;
             <%for(int j=0; j < iNumOfInv; j++){%>
                <%if(sInvId[j].equals("9999999999")){%><b>Y</b><%}%>
             <%}%>
          </td>                    
        </tr>
        
        <tr class="DataTable">
          <td class="DataTable">SKI SIZE: &nbsp; &nbsp;             
            <%for(int j=0; j < iNumOfInv; j++){%> 
               <%if(sCls[j].equals("9740") || sCls[j].equals("9742") || sCls[j].equals("9750")
                    || sCls[j].equals("9760") || sCls[j].equals("9762") || sCls[j].equals("9766")
                    || sCls[j].equals("9770") || sCls[j].equals("9780") || sCls[j].equals("9781")
                    || sCls[j].equals("9730") || sCls[j].equals("9731") || sCls[j].equals("9733")
                    || sCls[j].equals("9680") || sCls[j].equals("9690") || sCls[j].equals("9741") 
                    || sCls[j].equals("9742") 
                    ){%>
                    <b><%=sSizNm[j]%></b> 
               <%}%>                
            <%}%>
          </td>  
          <td class="DataTable" nowrap>BRAND:<br> &nbsp;  &nbsp;
            <%for(int j=0; j < iNumOfInv; j++){%> 
               <%if(sCls[j].equals("9740") || sCls[j].equals("9742") || sCls[j].equals("9750")
                    || sCls[j].equals("9760") || sCls[j].equals("9762") || sCls[j].equals("9766")
                    || sCls[j].equals("9770") || sCls[j].equals("9780") || sCls[j].equals("9781")
                    || sCls[j].equals("9730") || sCls[j].equals("9731") || sCls[j].equals("9733")
                    || sCls[j].equals("9680") || sCls[j].equals("9690") || sCls[j].equals("9741")
                    || sCls[j].equals("9742")
                    ){%>
                    <b><%if(sScanned[j].equals("Y")){%><%=sBrandNm[j]%><%} else {%>&nbsp;<%}%></b> 
                    &nbsp;&nbsp;                      
               <%}%>                
            <%}%>
          </td>
          <td class="DataTable">BOOT SIZE: <br> &nbsp; &nbsp;
             <%boolean bBootFound = false;%>
             <%for(int j=0; j < iNumOfInv; j++){%>
                <%if(sCls[j].equals("9744") || sCls[j].equals("9745") || sCls[j].equals("9754")
                    || sCls[j].equals("9755") || sCls[j].equals("9764") || sCls[j].equals("9767")
                    || sCls[j].equals("9771")
                    || sCls[j].equals("9732") || sCls[j].equals("9734")
                    || sCls[j].equals("9681") || sCls[j].equals("9682")
                    || sCls[j].equals("9691") || sCls[j].equals("9692")
                    ){%>
                    <b><%=sSizNm[j]%></b>
                    <%bBootFound = true;%>
                <%}%>
             <%}%>
             <%if(!bBootFound && !sSelContId.equals("0000000000")){%><b>OWN BOOTS</b><%}%>
          </td>
          <td class="DataTable" nowrap >BOOT BRAND:<br> &nbsp; &nbsp; 
            <%for(int j=0; j < iNumOfInv; j++){
            %> 
               <%if(sCls[j].equals("9744") || sCls[j].equals("9745") || sCls[j].equals("9754")
                    || sCls[j].equals("9755") || sCls[j].equals("9764") || sCls[j].equals("9767")
                    || sCls[j].equals("9771")
                    || sCls[j].equals("9732") || sCls[j].equals("9734")
                    || sCls[j].equals("9681") || sCls[j].equals("9682")
                    || sCls[j].equals("9691") || sCls[j].equals("9692")
                    ){%>
                    <b><%if(sScanned[j].equals("Y")){%><%=sBrandNm[j]%><%} else {%>&nbsp;<%}%></b> 
                    &nbsp;&nbsp;                      
               <%}%>                
            <%}%>
          </td>
        </tr>
                
        <tr class="DataTable">
          <td class="DataTable">SKI SERIAL #: &nbsp;  &nbsp;
             <%for(int j=0; j < iNumOfInv; j++){%>
                <%if(sCls[j].equals("9740") || sCls[j].equals("9750") || sCls[j].equals("9760")
                    || sCls[j].equals("9766") || sCls[j].equals("9770") || sCls[j].equals("9780") || sCls[j].equals("9781")
                    || sCls[j].equals("9730") || sCls[j].equals("9731") || sCls[j].equals("9733")
                    || sCls[j].equals("9680") || sCls[j].equals("9690") || sCls[j].equals("9741") 
                    || sCls[j].equals("9742") 
                    ){%>
                    <b><%if(sScanned[j].equals("Y")){%><%=sSrlNum[j]%>
                        <img width=100 src="/Barcode/Rental/Inventory/<%=sInvFileNm[j]%>.png">  
                       <%} 
                         else{%><br><span style="color:red;">Scan S/N at Pick Up</span><%}%></b>
                <%}%>
             <%}%>
          </td>
          
          <td class="DataTable">MODEL: &nbsp;  &nbsp;
             <%for(int j=0; j < iNumOfInv; j++){%>
                <%if(sCls[j].equals("9740") || sCls[j].equals("9750") || sCls[j].equals("9760")
                    || sCls[j].equals("9766") || sCls[j].equals("9770") || sCls[j].equals("9780") || sCls[j].equals("9781")
                    || sCls[j].equals("9730") || sCls[j].equals("9731") || sCls[j].equals("9733")
                    || sCls[j].equals("9680") || sCls[j].equals("9690") || sCls[j].equals("9741")
                    || sCls[j].equals("9742")
                    ){%>
                    <b><%if(sScanned[j].equals("Y")){%><%=sModel[j]%><%} else {%>&nbsp;<%}%></b>
                <%}%>
             <%}%>
          </td>
          
          <td class="DataTable">BOOT SERIAL #: &nbsp; &nbsp;
             <%for(int j=0; j < iNumOfInv; j++){%>
                <%if(sCls[j].equals("9744") || sCls[j].equals("9745") || sCls[j].equals("9754")
                    || sCls[j].equals("9755") || sCls[j].equals("9764") || sCls[j].equals("9767")
                    || sCls[j].equals("9771")
                    || sCls[j].equals("9732") || sCls[j].equals("9734")
                    || sCls[j].equals("9681") || sCls[j].equals("9682")
                    || sCls[j].equals("9691") || sCls[j].equals("9692")
                    ){%>
                    <b><%if(sScanned[j].equals("Y")){%><%=sSrlNum[j]%>
                         <img width=100 src="/Barcode/Rental/Inventory/<%=sInvFileNm[j]%>.png">
                    <%} 
                         else{%><br><span style="color:red;">Scan S/N at Pick Up</span><%}%></b>
                <%}%>
             <%}%>
          </td>
          
          <td class="DataTable" nowrap>BOOT MODEL: &nbsp; 
            <%for(int j=0; j < iNumOfInv; j++){%> 
               <%if(sCls[j].equals("9744") || sCls[j].equals("9745") || sCls[j].equals("9754")
                    || sCls[j].equals("9755") || sCls[j].equals("9764") || sCls[j].equals("9767")
                    || sCls[j].equals("9771")
                    || sCls[j].equals("9732") || sCls[j].equals("9734")
                    || sCls[j].equals("9681") || sCls[j].equals("9682")
                    || sCls[j].equals("9691") || sCls[j].equals("9692")
                    ){%>
                    <b><%if(sScanned[j].equals("Y")){%><%=sModel[j]%><%} else {%>&nbsp;<%}%></b> 
                    &nbsp;&nbsp;                      
               <%}%>                
            <%}%>
          </td>                           
        </tr>
        
      </table>

      <!-- === -->
      <table class="DataTable" cellPadding="0" cellSpacing="0" id="tbDept" width="100%">
        <tr class="DataTable">
          <td class="DataTable" rowspan="2" style="vertical-align:top;">SKIER CODE:
          </td>
          <td class="DataTable" rowspan="2">
             <table border="0" cellPadding="0" cellSpacing="0" id="tbDept">
               <tr class="DataTable">
                <td class="DataTable1" style="border:none;" colspan="3">SETTING:</td>
               </tr> 
               <tr class="DataTable">                 
                 <td class="DataTable2" style=" border:none;padding:0px">Left</td>
                 <td class="DataTable2" style=" border:none;padding:0px">Right</td>
                 <td class="DataTable" style="border:none;padding:0px">&nbsp;</td>
               </tr>
               <tr class="DataTable">
                  <td class="DataTable" style="border:none;padding:0px">
                    <span style="width:40px; height:23px;  background:#e7e7e7; border:black 1px solid; text-align:center">
                       <%for(int j=0; j < iNumOfInv; j++){%>
                          <%if(!sLeftToe[j].equals("")){%><%=sLeftToe[j]%><%}%>
                       <%}%>
                    </span>
                  </td>
                  <td class="DataTable" style="border:none;padding:0px">
                     <span style="width:40px; height:23px;  background:#e7e7e7; border:black 1px solid; text-align:center">
                       <%for(int j=0; j < iNumOfInv; j++){%>
                          <%if(!sRightToe[j].equals("")){%><%=sRightToe[j]%><%}%>
                       <%}%>
                     </span>
                  </td>
                  <td class="DataTable" style="border:none;padding:0px">Toe</td>
                  
                  <td class="DataTable" style="border:none;padding:0px">&nbsp; &nbsp;
                     <span style="width:20px; height:23px;  background:#e7e7e7; border:black 1px solid; text-align:center">
                       &nbsp;
                     </span>
                  </td>
                  <td class="DataTable" style="border:none;padding:0px">Pass</td>
                  
                  
               </tr>
               <tr class="DataTable">
                  <td class="DataTable" style="border:none;padding:0px">
                     <span style="width:40px; height:23px; background:#e7e7e7; border:black 1px solid; text-align:center">
                       <%for(int j=0; j < iNumOfInv; j++){%>
                          <%if(!sLeftHeal[j].equals("")){%><%=sLeftHeal[j]%><%}%>
                       <%}%>
                     </span>
                  </td>
                  <td class="DataTable" style="border:none;padding:0px">
                     <span style="width:40px; height:23px; background:#e7e7e7; border:black 1px solid; text-align:center">
                       <%for(int j=0; j < iNumOfInv; j++){%>
                          <%if(!sRightHeal[j].equals("")){%><%=sRightHeal[j]%><%}%>
                       <%}%>
                     </span>
                  </td>
                  <td class="DataTable" style="border:none;padding:0px">Heel</td>
                  
                  <td class="DataTable" style="border:none;padding:0px">&nbsp; &nbsp;
                     <span style="width:20px; height:23px;  background:#e7e7e7; border:black 1px solid; text-align:center">
                       &nbsp;
                     </span>
                  </td>
                  <td class="DataTable" style="border:none;padding:0px">Fail</td>
                  
                  
               </tr>
             </table>
          </td>
          <td class="DataTable" rowspan="2" style="vertical-align:top;">TECH SIGNATURE:
           <br><br><br><br><br>Date: ______/______/______
          </td>
          <td class="DataTable" style="padding:1px; vertical-align:top;">BOOT SOLE LENGTH: &nbsp; &nbsp;
            <%for(int j=0; j < iNumOfInv; j++){%>
               <%if(!sBootLen[j].equals("")){%><b><%=sBootLen[j]%></b><% break; }%>
            <%}%>
          </td>
          <td class="DataTable" style="padding:0px;  vertical-align:top;" rowspan="2">DAMAGE WAIVER: &nbsp; 
           <%if(!bEmpty){%>   
              <%if(sDmgWaiver.equals("Y")){%>Yes<%} else {%>No<%}%>
           <%} else {%>
            <img alt="Yes" src="CheckBox_unchecked_001.jpg" width="10" height="10">Yes 
            &nbsp;  &nbsp; 
            <img alt="Yes" src="CheckBox_unchecked_001.jpg" width="10" height="10">No
           
           <%}%>   
              <br><span style="font-size: 8px;">
              <br>Damage waiver covers only breakage or minor
              <br>damage of equipment, it does not cover loss, theft 
              <br>or personal injury.
              </span> 
          </td>
        </tr>
        <tr class="DataTable">
          <td class="DataTable" style="padding:0px; vertical-align:top;">Boot Loc. (OUT):</td>
        </tr>
      </table>
      <!-- ============================ Section 5 ========================== -->      
      <table class="DataTable" cellPadding="0" cellSpacing="0" id="tbDept" width="100%">
        <tr class="DataTable">
           <td class="DataTable2" style="font-size: 10px; font-weight: bold;">
           ANY EQUIPMENT NOT RETURNED BY
           <%if(!bEmpty){%>
           <span style="font-size: 14px; font-weight: bold;"><%=sRtnDt%></span>
           <%} else {%>_____________<%}%>
           WILL BE CHARGED TO MY CREDIT CARD (on file) FOR IT'S FULL RETAIL VALUE: 
             _______<span style="font-size: 8px; font-weight: bold;">(Customer's Init.)</span>
           </td> 
        </tr>
      </table>
  </div>
    <br>   <!-- Water sport  vr v1.0 --> 
  <div id="dvWaterEq<%=i%>" style="border:none; width:100%; display:none;">
    <table class="DataTable" cellPadding="0" cellSpacing="0" id="tbWater" width="100%">
        <tr class="DataTable1">
          <th class="DataTable2">Barcode ID</th>
          <th class="DataTable2">Description</th>
          <th class="DataTable2">Paddles Included? &nbsp; <%=sPaddle%></th>
    	</tr>
    	<%for(int j=0; j < iNumOfInv; j++){%>
    	    <%if(!sInvId[j].equals("9999999999")){%> 
    	    <tr class="DataTable">
    			<td class="DataTable2"><%if(sScanned[j].equals("Y")){%><%=sSrlNum[j]%>
    				<img width=100 src="/Barcode/Rental/Inventory/<%=sInvFileNm[j]%>.png">
    			<%} 
                         else{%><span style="color:red;">Scan S/N at Pick Up</span><%}%></td>
    			<td class="DataTable"><%=sDesc[j]%></td>
    			<%if(j==0){%><td class="DataTable" style="vertical-align:top;" rowspan="<%=iNumOfInv%>"><b>Tech Signature: </b></td><%}%>
    		</tr>
    		<%}%>
    	<%}%>  
    </table>
  </div>
  <div style="border-width:none; text-align: center; white; 
  padding: 0px; border-spacing: 0; border-collapse: collapse; width:100%font-family:arial; font-weight:bold;">
    AGREEMENT
  </div>  
  <div id="dvSkiAgr<%=i%>" style="border-width:3px; border-style:ridge; border-color:lightgray; width:100%; font-size: 8px;font-family:arial;">
   I accept full financial responsibility for the equipment listed on this form. 
   I promise to return it clean and undamaged by the agreed time and date, and if I fail to 
   do so, I will pay for its repair, cleaning or replacement at the full retail rate, as 
   determined by the shop, as well as for the full rental value of any additional days.
   I understand how this equipment works and have received instructions and satisfactory 
   answers to any questions. I agree to check this equipment before each use (including the 
   binding anti-friction device); and if at any time this equipment does not seem to be working 
   properly, I will stop using it immediately and return it for inspection and possible repair 
   or adjustment.
   I understand that proper bindings settings depend upon the accuracy of my statements about
   weight, height, age, and skier type on this form. I have confirmed that the binding 
   release/retention settings on this equipment correspond to those stated on this form.
   If this equipment is to be used by someone other than me, I certify that I am acting as 
   agent for the user and that I will provide this form and all pertinent warnings and 
   information to the user.
  <br> <br>
  <span style="font-size:10px; font-weight:bold;">
   I HAVE CAREFULLY READ, UNDERSTOOD AND AGREED TO THE TERMS OF THE WARNING, ASSUMPTION OF RISK, 
   LIABILITY RELEASE, INDEMNITY AND HOLD HARMLESS AGREEMENT AND AGREEMENT NOT TO SUE AT THE 
   BOTTOM OF THIS DOCUMENT.
   </span>
  
   <table style="font-size: 8px;">
   <tr> 
   	<td style="background: #cecece;font-size: 16px;"><%for(int j=0; j < 80;j++){%>&nbsp;<%}%></td>
   	<td style="width: 20px;">&nbsp;</td>
   	<td style="background: #cecece;font-size: 16px;"><%for(int j=0; j < 30;j++){%>&nbsp;<%}%></td>
   </tr>
   <tr>
   	<td>Signature of the Equipment User or Parent/Guardian/Agent of Equipment User</td>
    <td></td>
    <td>Date</td>
   <tr>  
   </table>
   
   
   
   Parent/Guardian/Agent: I verify that I am the parent, guardian, or agent of the Equipment 
   User and that I have the authority to enter into this agreement on behalf of the Equipment 
   User. I agree to be bound by the terms of the Warning, Assumptions of Risk, Liability 
   Release, Indemnity, and Hold Harmless Agreement below.
 
  <table style="font-size: 8px;">
   <tr> 
   	<td style="background: #cecece;font-size: 16px;"><%for(int j=0; j < 80;j++){%>&nbsp;<%}%></td>
   	<td style="width: 20px;">&nbsp;</td>
   	<td style="background: #cecece;font-size: 16px;"><%for(int j=0; j < 30;j++){%>&nbsp;<%}%></td>
   </tr>
   <tr>
   	<td>Signature of Parent/Guardian/Agent of Equipment User (if not an adult user)</td>
    <td></td>
    <td>Date</td>
   <tr>  
   </table>
   
   <br>

   <span style="border-top:black solid 1px; font-size:8px;  font-weight:bold; width:100%;">
   WARNING, ASSUMPTION of RISK, LIABILITY RELEASE, INDEMNITY and HOLD HARMLESS AGREEMENT and 
   AGREEMENT NOT TO SUE PLEASE READ CAREFULLY BEFORE SIGNING
   </span>
   <br>
  <span style="font-size:8px">  
      1. I understand and agree that skiing and related activities are HAZARDOUS and that 
         injuries are common and ordinary occurrences during these activities. I AGREE TO 
         ASSUME ALL RISKS of death or of injury to any part of the user's body while using 
         this equipment.
   <br>2. I understand that the ski-boot-binding system is designed to release the boot from 
         the ski when certain forces on the system reach preset values, but that the binding 
         WILL NOT RELEASE OR RETAIN at all times where release or retention may prevent injury, 
         and that it CANNOT prevent all injuries to any part of the user's body. I understand 
         and agree that lower settings on my bindings will increase releasability but also 
         increase the risk of injury due to inadvertent release, that higher settings on my 
         bindings will increase retention but also increase the risk of injury due to 
         non-release, and that injuries due to unwanted release or retention are inherent 
         risks of skiing.
   <br>3. I understand and agree that certain risks of skiing, snowboarding, and ice skating 
         may be reduced, but not entirely eliminated, by taking lessons, by following 
         "YOUR RESPONSIBILITY CODE" which is posted at most winter sport areas and by using 
         reasonable care and common sense. I further understand that a leash or other runaway 
         prevention system must be used with all skis at all times, including while riding 
         lifts and while carrying equipment on or near a slope, in order to reduce the risk of 
         injury to others.
   <br>4. For Snowboards, Nordic equipment, and Ice Skates, I understand that these systems 
         function differently from Alpine ski bindings in that snowboard, ice skates and 
         Nordic bindings WILL NOT RELEASE in falls or accidents. I understand and agree that 
         these systems DO NOT PROTECT against any type of injury and that any injuries 
         resulting from these circumstances are inherent risks of the sport.
   <br>5. To the fullest extent allowed by law, I hereby agree to forever RELEASE AND HOLD 
          HARMLESS this ski shop, and all manufacturers and distributors of this equipment, 
          as well as their owners, agents, employees and affiliated companies, from ANY AND 
          ALL RESPONSIBILITY OR LEGAL LIABILITY for any injuries, damages or death to any 
          user of any equipment listed on this form, whether resulting from NEGLIGENCE or 
          any other cause. I further agree that I WILL DEFEND AND INDEMNIFY them if any claim 
          or action is pursued for any injuries, damages or death relating to skiing or 
          any related activities involving the use of this equipment.
   <br>6. I accept this equipment "AS IS" and with NO WARRANTIES, express or implied, beyond 
         those stated in this agreement and in the manufacturer's written limited warranty, 
         if any.   
   <br>7. This document is a LEGALLY BINDING CONTRACT which supersedes any other agreements by 
         or between the parties, and which constitutes the FINAL AND ENTIRE AGREEMENT 
         regarding this transaction and this equipment. This agreement is intended to provide 
         a COMPREHENSIVE RELEASE OF ALL LEGAL LIABILITY which is binding upon and for the 
         benefit of all parties, their heirs, agents and assigns, but it is not intended to 
         assert any claims or defenses that are prohibited by law. If any part of this 
         agreement is held to be invalid or unenforceable, the remainder shall be given full 
         force and effect. The specific legal rights of the parties may vary among different 
         states and provinces.
      
   </span>
   <span style="font-size:9px;  font-weight:bold; width:100%;">
   I HAVE CAREFULLY READ, UNDERSTOOD AND AGREED TO THE TERMS OF THIS WARNING, ASSUMPTION 
   OF RISK, LIABILITY RELEASE, INDEMNITY AND HOLD HARMLESS AGREEMENT AND AGREEMENT NOT TO SUE. 
   I AM AWARE THAT THIS IS A LEGALLY BINDING CONTRACT.
   </span>
 
 <table style="font-size: 8px;">
   <tr> 
   	<td style="background: #cecece;font-size: 16px;"><%for(int j=0; j < 80;j++){%>&nbsp;<%}%></td>
   	<td style="width: 20px;">&nbsp;</td>
   	<td style="background: #cecece;font-size: 16px;"><%for(int j=0; j < 30;j++){%>&nbsp;<%}%></td>
   </tr>
   <tr>
   	<td>Signature of the Equipment User</td>
    <td></td>
    <td>Date</td>
   <tr>  
   </table>
 
 
     Parent/Guardian/Agent: I verify that I am the parent, guardian or agent of the Equipment  
     User and that I have the authority to enter into this agreement on behalf of the  
     Equipment User and I agree to be bound by the terms of this Warning, Assumption of Risk, 
     Liability Release, Indemnity and Hold Harmless Agreement and Agreement Not to Sue.
  
  <table style="font-size: 8px;">
   <tr> 
   	<td style="background: #cecece;font-size: 16px;"><%for(int j=0; j < 80;j++){%>&nbsp;<%}%></td>
   	<td style="width: 20px;">&nbsp;</td>
   	<td style="background: #cecece;font-size: 16px;"><%for(int j=0; j < 30;j++){%>&nbsp;<%}%></td>
   </tr>
   <tr>
   	<td>Signature of Parent/Guardian/Agent of Equipment User</td>
    <td></td>
    <td>Date</td>
   <tr>  
   </table>

   </div>
   
   <!-- =============== Water Agreemnet ================================================ -->
   
   <div id="dvWaterAgr<%=i%>" style="display: none; border-width:3px; border-style:ridge; border-color:lightgray; width:100%; font-size: 8px;font-family:arial;">
  I accept full financial responsibility for the equipment listed on this form. I promise to return it clean and undamaged 
  by the agreed Return Due Date. I fail to do so, I will pay for any late return fees, repairs, cleaning or replacement of 
  major damages or lost rentals, at the full retail rate as determined by Sun & Ski.  If I elected the 'Damage Waiver' fees, 
  this covers only minor breakage or damage to the equipment, and does not cover loss, misuse or abuse, theft or personal 
  injury. I further authorize Sun & Ski Sports to charge my credit card (on file) to secure any of these additional charges, 
  should they occur.
  <br>
  I understand how this equipment works and have received instructions and satisfactory answers to any questions. I agree 
  to check this equipment before each use (including the binding anti-friction device - Alpine only); and if at any time 
  this equipment does not seem to be working properly, I will stop using it immediately and return it for inspection and 
  possible repair or adjustment. I understand that proper bindings settings or stance depend upon the accuracy of my 
  statements about weight, height, age, skier type and stance on this form. I have confirmed that the binding 
  release/retention settings or stance on this equipment correspond to those stated on this form. If this equipment is to 
  be used by someone other than me, I certify that I am acting as agent for the user and that I will provide this form and 
  all pertinent warnings and information to the user.
<br><br>
YOU MAY BE INJURED WHILE WATERSKIING, WAKEBOARDING, KNEEBOARDING, OR USING A STAND UP PADDLEBOARD (SUP)
<br><br>

   Signature of the Equipment User: <span style="text-decoration:underline;"><%for(int j=0; j < 150;j++){%>&nbsp;<%}%></span>
      <%for(int j=0; j < 20;j++){%>&nbsp;<%}%>
   Date <span style="text-decoration:underline;"><%for(int j=0; j < 50;j++){%>&nbsp;<%}%></span> &nbsp;
   <br>
   Parent/Guardian/Agent: I verify that I am the parent, guardian or agent of the Equipment User and that
   I have the authority to enter into this agreement on behalf of the Equipment User and
   I agree to be bound by the terms of the Warning, Assumption of Risk, Liability Release, Indemnity and Hold
   Harmless Agreement and Agreement Not to Sue as stated below this document.

   <br><br>
   Signature of Parent/Guardian/Agent (if not an adult user) <span style="text-decoration:underline;"><%for(int j=0; j < 150;j++){%>&nbsp;<%}%></span>
     <%for(int j=0; j < 20;j++){%>&nbsp;<%}%>
   Date <span style="text-decoration:underline;"><%for(int j=0; j < 50;j++){%>&nbsp;<%}%></span> &nbsp;
   <br><br>

   <span style="border-top:black solid 1px; border-bottom:black solid 1px; font-weight:bold; width:100%;">
   WARNING, ASSUMPTION of RISK, LIABILITY RELEASE, INDEMNITY and HOLD HARMLESS AGREEMENT and AGREEMENT NOT TO SUE
   PLEASE READ CAREFULLY BEFORE SIGNING
   </span>


  <span style="font-size:8px">
      <br>
      The performance of specialized water sports equipment (waterskis, kneeboards, wakeboards, and SUPs) 
      may expose you to injury from impact during a fall, from falling on the equipment or from falling 
      on your foot. Other injuries may result from specially designed bindings on this equipment which 
      provide the improved control necessary for advanced maneuvers. Each binding is designed for certain 
      types of participants and conditions. The high wrap and low wrap bindings offer more support and grip 
      than do our combo bindings. Increased support and grip in these bindings may cause higher stress to 
      your body during a fall, resulting in increased risk of serious ankle or leg injury. I understand that 
      the bindings are designed to reduce the risk or degree of injuries. I also understand and agree that 
      despite the fact adjustments have been made, THE BINDINGS WILL NOT RELEASE UNDER ALL CIRCUMSTANCES 
      and there are no guarantees made for the user's safety.
      <br>
      <br>
      
      1. I understand and am aware that the use of waterskis, wakeboards, kneeboards, and SUP's are hazardous 
      activities. I understand that watersports and the use of any waterskis, wakeboards, kneeboards, 
      and/or SUP's involves a risk of injury to any and all parts of my body and that I am voluntarily 
      participating in these activities with knowledge of the danger involved. 
      <b>I hereby agree to expressly 
      assume and accept any and all risks of injury or death to the user of the equipment and to any 
      other person.</b> 
      
      <br>
      <br>
      
      2. I agree that I will release Retail Concepts, Inc. dba Sun & Ski Sports, its owners, agents, employees and 
      affiliated companies from any and all responsibility or liability for any injuries, any damages or 
      death to the user of water sports equipment listed below, or any other person.
	  <br>
      <br>
      
      3. I agree, on behalf of myself, my assignees, heirs, next-of-kin, and executors not to make a claim 
      against or sue Retail Concepts, Inc., its affiliates or employees for injuries or damages relating 
      to the use of equipment. 
      
      <br>
      <br>
      
      4. This document is a LEGALLY BINDING CONTRACT which supersedes any other agreements by or between
       the parties, and which constitutes the FINAL AND ENTIRE AGREEMENT regarding this transaction and this
       equipment. This agreement is intended to provide a COMPREHENSIVE RELEASE OF ALL LEGAL LIABILITY which
       is binding upon and for the benefit of all parties, their heirs, agents and assigns, but it is not
       intended to assert any claims or defenses that are prohibited by law. If any part of this agreement 
       is held to be invalid or unenforceable, the remainder shall be given full force and effect. 
       The specific legal rights of the parties may vary among different states and provinces.
      
      <br>
      <br>      
   USER'S NAME (PRINT): <span style="text-decoration:underline;"><%for(int j=0; j < 200;j++){%>&nbsp;<%}%></span>
      <%for(int j=0; j < 20;j++){%>&nbsp;<%}%>
  <br><br>
   USER'S SIGNATURE: <span style="text-decoration:underline;"><%for(int j=0; j < 150;j++){%>&nbsp;<%}%></span>
      <%for(int j=0; j < 20;j++){%>&nbsp;<%}%>
   Date <span style="text-decoration:underline;"><%for(int j=0; j < 50;j++){%>&nbsp;<%}%></span> &nbsp;
   <br>
   <span style="font-weight:bold; font-size:12px; text-align:center; width:100%">
   IF MINOR(UNDER 18), PARENT/GUARDIAN MUST EXECUTE MINOR RELEASE BELOW.
   </span>
   <br>
   PARENT/GUARDIAN: I verify that I am the parent, guardian or agent of the Equipment User and that I have the authority to enter into this agreement on behalf of the
   Equipment User and I agree to be bound by the terms of this Warning, Assumption of Risk, Liability Release, Indemnity and Hold Harmless Agreement and Agreement Not to
   Sue.
   <br>
   <span style="border-top:black 1px solid;font-weight:bold; font-size:12px; width:100%" >
    <br>Signature of Parent/Guardian/Agent <%for(int j=0; j < 120;j++){%>&nbsp;<%}%> Date
   </span>

   </div>
   
   
   
  </div>
 <%}%>
 </body>
</html>


<%
  }%>










