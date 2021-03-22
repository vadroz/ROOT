<%@ page import="rciutility.RunSQLStmt, badcredhist.BchCustInfo, rciutility.StoreSelect, java.sql.*, java.util.*, java.text.*"%>
<%
   String sSelCustId = request.getParameter("CustId");

   if(sSelCustId == null){ sSelCustId = "0000000000"; }

   //----------------------------------
   // Application Authorization
   //----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=BchCustInfo.jsp&APPL=ALL&" + request.getQueryString());
}
else
{
      String sUser = session.getAttribute("USER").toString();
      String sUserNm = null;

      BchCustInfo bchcusti = null;
      String sCust = null;
      String sFName = null;
      String sMName = null;
      String sLName = null;
      String sCard = null;
      String sStr = null;
      String sByUser = null;
      String sRecDt = null;
      String sRecTm = null;
      String sComment = null;
      String sNote = null;

      if(!sSelCustId.equals("0000000000"))
      {
         bchcusti = new BchCustInfo(sSelCustId, "vrozen");
         sCust = bchcusti.getCust();
         sFName = bchcusti.getFName();
         sMName = bchcusti.getMName();
         sLName = bchcusti.getLName();
         sCard = bchcusti.getCard();
         sStr = bchcusti.getStr();
         sByUser = bchcusti.getByUser();
         sRecDt = bchcusti.getRecDt();
         sRecTm = bchcusti.getRecTm();
         sComment = bchcusti.getComment();
         sNote = bchcusti.getNote();

         bchcusti.disconnect();
      }


      SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
      Calendar cal = Calendar.getInstance();
      String sToday = sdf.format(cal.getTime());
      sdf = new SimpleDateFormat("h:mm a");
      String sCurTime = sdf.format(cal.getTime());
%>

<html>
<head>
<title>Missing Customer Information</title>

<style>
body {background:white;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}

        a.Small:link { color:blue; font-size:10px} a.Small:visited { color:blue; font-size:10px}  a.Small:hover { color:blue; font-size:10px}

        table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}
        table.DataTable1 { border: darkred solid 1px;background:Cornsilk;text-align:center;}
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
        input.Small1 { font-family:Arial; font-size:10px }
        input.Small2 {background: white; border:none; border-bottom:1px black solid; font-family:Arial;  font-size:10px }
        input.Small3 {border:none; font-family:Arial;  font-size:10px }
        input.Small4 {background:#e7e7e7; border:none; border-bottom:1px black solid; font-family:Arial;  font-size:10px }
        input.radio { font-family:Arial; font-size:10px }
        input.Menu {border: ridge 2px; background:white; font-family:Arial; font-size:10px }

        textarea {border:none; background:#E7E7E7; border-bottom: black solid 1px; font-family:Arial; font-size:10px }
        button.Small {font-size:10px; }
        select.selSts {display:none;font-size:10px; }
        button.selSts {display:none;font-size:10px; }
        input.selSts {display:none;font-size:10px; }

        div.dvStatus  { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:200; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
</style>




<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
var CustId = "<%=sSelCustId%>";
//--------------- End of Global variables ----------------
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvStatus"]);
   if(CustId != "0000000000") { setCustInfo();  }
}
//==============================================================================
// validate cust info
//==============================================================================
function setCustInfo()
{
    document.all.FName.value = "<%=sFName%>";
    document.all.MName.value = "<%=sMName%>";
    document.all.LName.value = "<%=sLName%>";
    document.all.CardNum.value = "<%=sCard%>";
    document.all.Store.value = "<%=sStr%>";
    document.all.Commt.value = "<%=sComment%>";
}
//==============================================================================
// validate cust info
//==============================================================================
function validateCust()
{
   var error= false;
   var msg = "";

   var fname = document.all.FName.value.trim();
   if(fname==""){error=true; msg += "\nPlease enter customer First Name.";}

   var mname = document.all.MName.value.trim();

   var lname = document.all.LName.value.trim();
   if(lname==""){error=true; msg += "\nPlease enter customer Last Name.";}

   var cardnum = document.all.CardNum.value.trim();
   if(cardnum==""){error=true; msg += "\nPlease enter last 4 digits of customer Card Number.";}
   else if(isNaN(cardnum)){error=true; msg += "\nCard Number is not numeric.";}
   else if(eval(cardnum) <= 0){error=true; msg += "\nCard Number must be grater than 0.";}

   var store = document.all.Store.value.trim();
   if(store==""){error=true; msg += "\nPlease enter Store Number.";}
   else if(isNaN(store)){error=true; msg += "\nStore Number is not numeric.";}
   else if(eval(store) <= 0){error=true; msg += "\nStore Number must be grater than 0.";}

   var action = "UPD_CUST";
   if(CustId == "0000000000"){ action = "ADD_CUST";}

   if(error){alert(msg);}
   else{ sbmCustInfo(fname, mname, lname, cardnum, store, action);}
}

//==============================================================================
// submit customer info
//==============================================================================
function sbmCustInfo(fname, mname, lname, cardnum, store, action)
{
    var commt = document.all.Commt.value;
    commt = commt.replace(/\n\r?/g, '<br />');

    var nwelem = window.frame1.document.createElement("div");
    nwelem.id = "dvSbmCommt"

    var html = "<form name='frmAddComment'"
       + " METHOD=Post ACTION='BchSave.jsp'>"
       + "<input class='Small' name='CustId'>"
       + "<input class='Small' name='FName'>"
       + "<input class='Small' name='MName'>"
       + "<input class='Small' name='LName'>"
       + "<input class='Small' name='CardNum'>"
       + "<input class='Small' name='Store'>"
       + "<input class='Small' name='Commt'>"
       + "<input class='Small' name='Action'>"
     + "</form>"

   nwelem.innerHTML = html;
   frmcommt = document.all.frmEmail;
   window.frame1.document.appendChild(nwelem);

   window.frame1.document.all.CustId.value = CustId;
   window.frame1.document.all.FName.value = fname;
   window.frame1.document.all.MName.value = mname;
   window.frame1.document.all.LName.value = lname;
   window.frame1.document.all.CardNum.value = cardnum;
   window.frame1.document.all.Store.value = store;
   window.frame1.document.all.Commt.value=commt;
   window.frame1.document.all.Action.value = action;

   //alert(html)
   window.frame1.document.frmAddComment.submit();
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
// restart
//==============================================================================
function restart(cust)
{
   var url="BchCustInfo.jsp?CustId=" + cust
   window.location.href = url;
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
<div id="dvStatus" class="dvStatus"></div>
<!-------------------------------------------------------------------->

    <table border="0" cellPadding="0"  cellSpacing="0" width="100%">
     <tr>
      <td ALIGN="left" VALIGN="TOP" width="30%" nowrap>
         <b>
            User: <%=sUser%>&nbsp;
            <br>Customer#: <%=sSelCustId%>
            </font></b>
      </td>
      <td ALIGN="center" VALIGN="TOP" nowrap>
        <b>Missing Customer Information

      </td>
      <td ALIGN="right" VALIGN="TOP" width="30%" nowrap>
         <b><font size="-1">Date: <%=sToday%>
         <br>Time: <%=sCurTime%>
         </font></b></td>
    </tr>

    <tr>
      <td ALIGN="center" VALIGN="TOP" colspan=3 nowrap>
      <a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;
      <a href="BchCustLstSel.jsp"><font color="red" size="-1">Selection</font></a>&#62;This Page. &nbsp; &nbsp; &nbsp;
      &nbsp; &nbsp; <a href="http://www.gemoney.com">GE Access</a>
      <br>

      <br>
  <!-------------------------- Contract Info ------------------------------------>
    <br>
  <!------------------------- New Skiers Info entry panel --------------------->
     <div  style="border-width:3px; border-style:ridge; border-color:lightgray; width:100%;">
     <table cellPadding="0" cellSpacing="0" id="tbDept" width="100%">
       <tr class="DataTable">
         <td class="DataTable">
           First Name &nbsp; <input class='Small2' name="FName" maxlength=30 size=30 onFocus="this.select()"> &nbsp;
           Middle Name &nbsp; <input class='Small2' name="MName" maxlength=30 size=30 onFocus="this.select()" > &nbsp;
           Last Name &nbsp; <input class='Small2' name="LName" maxlength=30 size=30 onFocus="this.select()">
           &nbsp; &nbsp;
           <input type="hidden" name="Cust" readOnly>
           <input name="Action" type="hidden">
         </td>
       </tr>
       <tr class="DataTable">
         <td class="DataTable">
           Last 4 digits of Card Number &nbsp; <input class='Small2' name="CardNum" maxlength=4 size=4 onFocus="this.select()"> &nbsp;
           &nbsp; &nbsp; &nbsp; &nbsp;
           Store &nbsp; <input class='Small2' name="Store" maxlength=2 size=2 onFocus="this.select()"> &nbsp;
         </td>
       </tr>
       <tr class="DataTable">
         <td class="DataTable">
           Comments: <br> &nbsp; &nbsp;  &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp;
           <textArea class='Small2' name="Commt" cols=150 rows=5 onFocus="this.select()"></textArea> &nbsp;
         </td>
       </tr>
           </table>
         </td>
       </tr>
    <tr>
      <td ALIGN="center" VALIGN="TOP" colspan=3 nowrap>
    </div>
  <!----------------------- end of new skier entry table ---------------------->
  <button onClick="validateCust()">Save</button>

   </tr>
  </table>
 </body>
</html>


<%}%>










