<%@ page import="rciutility.RunSQLStmt, rental.RentContractInfo ,java.util.*, java.text.*"%>
<%
   String sSelContId = request.getParameter("ContId");
   String sPrint = request.getParameter("Print");

   //----------------------------------
   // Application Authorization
   //----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=RentReturnPrt.jsp&APPL=ALL&" + request.getQueryString());
}
else
{
    String sUser = session.getAttribute("USER").toString();
    RentContractInfo rentinfo = new RentContractInfo(sSelContId, "vrozen");
    
    String sPickDt = rentinfo.getPickDt();
    String sRtnDt = rentinfo.getRtnDt();
    String sSts = rentinfo.getSts();
    String sStr = rentinfo.getStr();
    String sUserNm = rentinfo.getUserNm();
    String sPayReq = rentinfo.getPayReq();
    String sSelGrp = rentinfo.getGrp();

    int iNumOfSkr = rentinfo.getNumOfSkr();
    
    String pattern = "MM/dd/yyyy";
    SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);

    String sCurrDt = simpleDateFormat.format(new Date());
    
    Vector<String> vSkCont = new Vector<String>(); 
    Vector<String> vSkFName = new Vector<String>();
    Vector<String> vSkMInit = new Vector<String>();
    Vector<String> vSkLName = new Vector<String>(); 
    Vector<String> vSkAddr1 = new Vector<String>();
    Vector<String> vSkAddr2 = new Vector<String>();
    Vector<String> vSkCity = new Vector<String>();
    Vector<String> vSkState = new Vector<String>();
    Vector<String> vSkZip = new Vector<String>();
    Vector<String> vSkEMail = new Vector<String>();
    Vector<String> vSkHPhone = new Vector<String>();
    Vector<String> vSkCPhone = new Vector<String>();
    Vector<String> vSkPickDt = new Vector<String>();
    Vector<String> vSkRtnDt = new Vector<String>();
    
    Vector<String []> vInSrlNum = new Vector<String []>();
    Vector<String []> vInDesc = new Vector<String []>();
    Vector<String []> vInSizNm = new Vector<String []>();
    Vector<String []> vInBrandNm = new Vector<String []>();
    Vector<String []> vInModel = new Vector<String []>();
    
    for(int i=0; i < iNumOfSkr; i++)
    {
    	rentinfo.setSkiersInfo();
    	
    	vSkCont.add(rentinfo.getCont());
    	vSkFName.add(rentinfo.getFName());
    	vSkMInit.add(rentinfo.getMInit());
    	vSkLName.add(rentinfo.getLName());
    	vSkAddr1.add(rentinfo.getAddr1());
    	vSkAddr2.add(rentinfo.getAddr2());
    	vSkCity.add(rentinfo.getCity());
    	vSkState.add(rentinfo.getState());
    	vSkZip.add(rentinfo.getZip());
    	vSkEMail.add(rentinfo.getEMail());
    	vSkHPhone.add(rentinfo.getHPhone());
    	vSkCPhone.add(rentinfo.getCPhone());
    	vSkPickDt.add(rentinfo.getPickDt());
    	vSkRtnDt.add(rentinfo.getRtnDt());
    	
    	rentinfo.setSkrInv();
        int iNumOfInv = rentinfo.getNumOfInv();         
        String [] sSrlNum = rentinfo.getSrlNum();
        String [] sDesc = rentinfo.getDesc();
        String [] sSizNm = rentinfo.getSizNm();
        String [] sBrandNm = rentinfo.getBrandNm();
        String [] sModel = rentinfo.getModel();
        
        vInSrlNum.add(sSrlNum);
        vInDesc.add(sDesc);
        vInSizNm.add(sSizNm);
        vInBrandNm.add(sBrandNm);
        vInModel.add(sModel);
    }
%>

<html>
<head>
<title>Rent_Ret_Prt</title>

<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">

<script type="text/javascript" src="http://code.jquery.com/jquery-1.4.4.min.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>
<script LANGUAGE="JavaScript1.2" src="XXsetFixedTblHdr.js"></script>


<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
//--------------- End of Global variables ----------------
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvChkItm", "dvStatus"]);
   <%if(sPrint != null){%>print(this);<%}%>
}

</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Get_Object_Position.js"></script>

</head>
<body class="bd02" onload="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvHelp" class="dvHelp"></div>
<!-------------------------------------------------------------------->
  <table class="tbl01">

     <tr>
      <td ALIGN="center" VALIGN="TOP" COLSPAN="3" nowrap>
        <span style="font-size:22px; font-weight:bold">Returned Rental Equipment - Receipt</span>         
      </td>
    </tr>
    
    <tr class="trDtl04"><td class="td80" nowrap colspan=3>&nbsp;</td></tr>
    
    <tr>
      <td ALIGN="center" VALIGN="TOP" COLSPAN="2">
       <table class="tbl01">
        <tr class="trDtl04">
          <td class="td80"nowrap>Returned Date: <b><%=sCurrDt%></b> </td>
          <td class="td80"nowrap width="15%" >&nbsp;</td>
          <td class="td80"nowrap>Contract # 
             <span style="font-size:16px; font-weight: bold;"><%=sSelContId%></span> 
          </td>
        </tr>
        
        <tr class="trDtl04"><td class="td80" nowrap colspan=3>&nbsp;</td></tr>
         
        <tr class="trDtl04">
          <td class="td80"nowrap> &nbsp; &nbsp; <%if(!vSkHPhone.get(0).equals("")){%><%=vSkHPhone.get(0)%><%} else {%><%=vSkCPhone.get(0)%><%}%></td>
          <td class="td80"nowrap>&nbsp;</td>
          <td class="td80"nowrap>Contract Dates <%=sPickDt%> - <%=sRtnDt%></td>
        </tr>
        
        <tr class="trDtl04"><td class="td80" nowrap colspan=3>&nbsp;</td></tr>
        
        <!-- ======= Customer Name and address ============ -->  
        <tr class="trDtl04">
          <td class="td80"nowrap>            
            1. <b><%=vSkFName.get(0)%> <%=vSkMInit.get(0)%> <%=vSkLName.get(0)%></b>
            <br> &nbsp; &nbsp; &nbsp; <%=vSkAddr1.get(0)%>
            <%if(!vSkAddr2.get(0).equals("")){%><br> &nbsp; &nbsp; &nbsp; <%=vSkAddr2.get(0)%><%}%>
            <br> &nbsp; &nbsp; &nbsp; <%=vSkCity.get(0)%>, <%=vSkState.get(0)%> <%=vSkZip.get(0)%>
            <br> &nbsp; &nbsp; &nbsp; <%=vSkEMail.get(0)%>
          </td>
          <td class="td80"nowrap>&nbsp;</td>
          <td class="td80"nowrap><b><%if(sRtnDt.subSequence(0, 4).equals("04/15")){%>Seasonal Lease<%} else {%>Rent<%}%></b></td>
        </tr>
        
        <%for(int i=1; i < iNumOfSkr; i++){%>
           
           <tr class="trDtl04">
              <td class="td80"nowrap><%=i+1%>. <b><%=vSkFName.get(i)%> <%=vSkMInit.get(i)%> <%=vSkLName.get(i)%></b></td>
              <td class="td80"nowrap>&nbsp;</td>
              <td class="td80"nowrap><%if(i==1){%>Total Number Of Skiers <b><%=iNumOfSkr%></b><%}%></td>
           </tr>              
        <%}%>
        
        <tr class="trDtl04"><td class="td80" nowrap colspan=3>&nbsp;</td></tr>
        
        <!-- ========== Equipment List =========== -->
        <tr class="trDtl04">
          <td class="td80"nowrap colspan=3>
              <table class="tbl01">
                <tr class="trHdr01">
                   <th class="th01">Skier</th>
                   <th class="th01">Return Items:</th>
                   <th class="th01">Brand</th>
                   <th class="th01">Model</th>
                   <th class="th01">Size</th>
                   <th class="th01">Serial Number</th>
                </tr>
                
                <%for(int i=0; i < iNumOfSkr;i++)
                {
                	String [] sSrlNum = vInSrlNum.get(i);
                	String [] sDesc = vInDesc.get(i);
                	String [] sBrandNm = vInBrandNm.get(i);
                	String [] sModel = vInModel.get(i);
                	String [] sSizNm = vInSizNm.get(i);
                %>
                  <tr class="trDtl04">
     			      <td class="td18" nowrap rowspan="<%=sSrlNum.length%>"><%=i+1%></td>
                  <%for(int j=0; j < sSrlNum.length; j++){%>
     			     <%if(j > 0){%><tr class="trDtl04"><%}%>
     			        <td class="td11" nowrap><%=sDesc[j]%></td>
     			        <td class="td11" nowrap><%=sBrandNm[j]%></td>
     			        <td class="td11" nowrap><%=sModel[j]%></td>
     			        <td class="td11" nowrap><%=sSizNm[j]%></td>
     			        <td class="td11" nowrap><%=sSrlNum[j]%></td>     			        
     			     </tr>
     			   <%}%>
               <%}%>
              </table>
                            
          </td>
        </tr>  
        
        
     </table>
     
     <br><b>Thank You for choosing Sun & Ski Sports for your Ski Rental Equipment - <br>hope to see you again soon!</b>
     
    </td>
   </tr>

   </table>
 </body>
</html>

<%
rentinfo.disconnect();
  }%>










