<!DOCTYPE html>
<%@ page import="rciutility.RunSQLStmt, rental.RentContractInfo ,java.util.*, java.text.*"%>
<%
   String sStr = request.getParameter("Str");
   String sSelContId = request.getParameter("ContId");
   String sPrint = request.getParameter("Print");
   
   boolean bEmpty = false;
   
   if(sSelContId == null){ sSelContId = "0000000000"; bEmpty = true; }
   if(sStr == null){ sStr = " "; }
   if(sPrint == null){ sPrint = " "; }
   

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

    // Skiers List and personal info
    iNumOfSkr = rentinfo.getNumOfSkr();

    SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
    Calendar cal = Calendar.getInstance();
    String sToday = sdf.format(cal.getTime());
    SimpleDateFormat stf = new SimpleDateFormat("h:mm a");
    String sCurTime = stf.format(cal.getTime());

    Date dtPick = sdf.parse(sPickDt);
    Date dtReturn = sdf.parse(sRtnDt);
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
%>

<html>
<head>
<title>Rent-Boot Tag</title>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10" />
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">

<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
var PickDt = "<%=sPickDt%>";
var RtnDt = "<%=sRtnDt%>";
//--------------- End of Global variables ----------------
//==============================================================================
//initialize process
//==============================================================================
function bodyLoad()
{
 setBoxclasses(["BoxName",  "BoxClose"], ["dvChkItm", "dvStatus"]);
 <%if(sPrint != null){%>print(this);<%}%>
}
//==============================================================================
//refresh Contract
//==============================================================================
function refreshCont(cont)
{
 var url = "RentContractInfo.jsp?ContId=" + cont + "&Str=<%=sStr%>"
 window.location.href = url;
}
//==============================================================================
//show Skier adding panel
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

<%for(int i=0, k=-1; i < iNumOfSkr;i++){
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
     
     int iEuqip = 0;
     for(int j=0; j < iNumOfInv; j++){
       if(sCls[j].equals("9740") || sCls[j].equals("9742") || sCls[j].equals("9750")
         || sCls[j].equals("9760") || sCls[j].equals("9762") || sCls[j].equals("9766")
         || sCls[j].equals("9770") || sCls[j].equals("9780") || sCls[j].equals("9781")
         || sCls[j].equals("9730") || sCls[j].equals("9731") || sCls[j].equals("9733")
         || sCls[j].equals("9680") || sCls[j].equals("9690")
       ){
    	   iEuqip = j;break;
       }
     }
     // check if boot found
     boolean bBootFound = false;
     for(int j=0; j < iNumOfInv; j++){
        if(sCls[j].equals("9744") || sCls[j].equals("9745") || sCls[j].equals("9754")
            || sCls[j].equals("9755") || sCls[j].equals("9764") || sCls[j].equals("9767")
            || sCls[j].equals("9771")
            || sCls[j].equals("9732") || sCls[j].equals("9734")
            || sCls[j].equals("9681") || sCls[j].equals("9682")
            || sCls[j].equals("9691") || sCls[j].equals("9692")
            ){ bBootFound = true; }
     }
     if(!bBootFound){ k++; }
%>
<div style="page-break-after:<%if(i < iNumOfSkr-1 && k > 0 && k % 2 != 0){%>always<%} else {%>avoid<%}%>;">
<%if(sPayReq.equals("Y")){%>
   <div style="position:absolute; left: 40%; top: 60px;
     width:200px;height:50px;margin:30px 50px;background-color:#ffffff;border:none;
     opacity:0.6;filter:alpha(opacity=40); color=red; font-size:26px;font-weight: bold">
     COLLECT ON ARRIVAL
   </div>
<%}%>

<table class="tbl01">
   <tr>     
     <td ALIGN="center" VALIGN="TOP" nowrap width="50%">
       <span  class="Large">SSER - Skier<%=i+1%></span>
     </td>
     <td ALIGN="center" VALIGN="TOP" nowrap width="50%">
       <span class="Large">SSER - Skier <%=i+1%></span>
     </td>     
   </tr>
   
   <tr>     
     <td ALIGN="center" VALIGN="TOP" nowrap colspan=2>
       <span  class="Small"><u>Store Instructions:</u> Tear on dotted line and attach to the CUSTOMER's Boot/Binding Equipment:</span>
     </td>
   </tr>
   
   <tr>
     <%for(int j=0; j < 2; j++){%>
     <td ALIGN="center" VALIGN="TOP" nowrap width="50%" <%if(j==0){%>style="border-right: black dashed 3px; "<%}%>>
       <table class="tbl03" width="80%">
       		<tr><td class="td15"><%if(j==0){%>BOOTS<%} else{%>BINDINGS<%}%></td></tr>
       		
       		<tr><td class="td13">Contract #:</td></tr>
       		<tr><td class="td14"><%=sSelContId%></td></tr>
       		<tr><td class="td13">Start Date:</td></tr>
       		<tr><td class="td14"><%=sPickDt%></td></tr>
       		<tr><td class="td13">Equipment:</td></tr>
       		<tr><td class="td14"><%=sDesc[iEuqip]%></td></tr>
       		<tr><td class="td13">Size:</td></tr>
       		<tr><td class="td14"><%=sSizNm[iEuqip]%></td></tr>
       		<tr><td class="td13">Serial:</td></tr>
       		<tr><td class="td14"><%=sSrlNum[iEuqip]%></td></tr>
       		<tr><td class="td13">Name:</td></tr>
       		<tr><td class="td14"><%=sLName%>,<%=sFName%></td></tr>
       		<tr><td class="td13">Customer Pick Up Date:</td></tr>
       		<tr><td class="td14">_______/_______/_______</td></tr>
       </table>
     </td>
     <%}%>
   </tr>

  </table>
</div>
<%}%>
</body>
</html>


<%
}%>













