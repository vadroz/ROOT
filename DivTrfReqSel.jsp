<%@ page import=" rciutility.ClassSelect, rciutility.StoreSelect, java.util.*"%>
<%
   ClassSelect select = null;
   String sDiv = null;
   String sDivName = null;
   StoreSelect StrSelect = null;
   String sStr = null;
   String sStrName = null;
   String sStrAllowed = "";
   //----------------------------------
   // Application Authorization
   //----------------------------------
   String sAppl = "TRANSFER";

   if (session.getAttribute("USER")==null
    || session.getAttribute("APPLICATION") !=null
    && !session.getAttribute("APPLICATION").equals(sAppl))
   {
     Enumeration  en = request.getParameterNames();
     String sParam =null;
     String sPrmValue = null;
     String sTarget = "PayrollSignOn.jsp?TARGET=DivTrfReqSel.jsp&APPL=" + sAppl;
     StringBuffer sbQuery = new StringBuffer() ;

     while (en.hasMoreElements())
      {
        sParam = en.nextElement().toString();
        sPrmValue = request.getParameter(sParam);
          sbQuery.append("&" + sParam + "=" + sPrmValue);
      }
     response.sendRedirect(sTarget + sbQuery.toString());
   }
   else
   {

     select = new ClassSelect();
     sDiv = select.getDivNum();
     sDivName = select.getDivName();

     sStrAllowed = session.getAttribute("STORE").toString();
     String sUser = session.getAttribute("USER").toString();


     if (sStrAllowed != null && sStrAllowed.startsWith("ALL"))
     {
       StrSelect = new StoreSelect(8);
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

     sStr = StrSelect.getStrNum();
     sStrName = StrSelect.getStrName();
   }
%>


<script name="javascript">
//----------------------------------------------------
// Global variables
//----------------------------------------------------
var StrAllowed = "<%=sStrAllowed.trim()%>";
var stores = [<%=sStr%>];
var storeNames = [<%=sStrName%>];

//----------------------------------------------------
// on body load
//----------------------------------------------------
function bodyLoad()
{
   if(StrAllowed == "ALL") doDivSelect();
   doStrSelect();
}

function doDivSelect() {
    var df = document.forms[0];
    var divisions = [<%=sDiv%>];
    var divisionNames = [<%=sDivName%>];

    for (idx = 0; idx < divisions.length; idx++)
    {
      df.DIVISION.options[idx] = new Option(divisionNames[idx],divisions[idx]);
    }

    df.DIVNAME.value = df.DIVISION.options[0].text;

}
//----------------------------------------------------
// Load Stores
//----------------------------------------------------
function doStrSelect(id) {
    var df = document.forms[0];
    var idy = 0;
    if(StrAllowed != "ALL") idy = 1

    for (var idx = 0; idy < stores.length; idx++, idy++)
    {
      df.STORE.options[idx] = new Option(stores[idy] + " - " + storeNames[idy],stores[idy]);
    }
    if(StrAllowed == "ALL") { df.STORE.selectedIndex=1 }
}

//----------------------------------------------------
// get division name and pass it to hidden parametr
//----------------------------------------------------
function getDivName()
{
  var df = document.forms[0];
  var idx = df.DIVISION.selectedIndex;
  df.DIVNAME.value = df.DIVISION.options[idx].text;
}
//----------------------------------------------------
// do not allow user have both division and store be "ALL"
//----------------------------------------------------
function chgSelect(fld, idx)
{
  var df = document.forms[0];
  var maxSt = df.STORE.length;
  if(fld=="D" && idx==0 && maxSt > 1) { df.STORE.selectedIndex=1; }
  else if(fld=="D" && idx > 0) { df.STORE.selectedIndex=0; }
  else if(fld=="S" && idx==0) { df.DIVISION.selectedIndex=1; }
  else if(fld=="S" && idx > 0) { df.DIVISION.selectedIndex=0; }
}


</script>


<HTML><HEAD>

<BODY onload="bodyLoad();">

<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR>
    <TD colSpan=2 height="20%"><IMG
    src="Sun_ski_logo4.png"></TD></TR>
  <TR bgColor=moccasin>
    <TD vAlign=top width="15%" bgColor=#a7b5e8><FONT face=Arial color=#445193
      size=2>&nbsp;&nbsp;<A class=blue
      href="/">Home</A></FONT><FONT
      face=Arial color=#445193 size=1>
      <H5>&nbsp;&nbsp;Miscellaneous</H5>&nbsp;&nbsp;<A class=blue
      href="mailto:">Send e-mail</A> <BR>&nbsp;&nbsp;<A
      class=blue href="http://sunandski.com/">Our Internet</A> <BR></FONT></TD>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Manage Transfer Requests - Selection</B>

      <FORM  method="GET" action="DivTrfGrpSum.jsp">
      <TABLE>
        <TBODY>
        <TR>
          <TD align=right>Division:</TD>
          <TD align=left>
             <SELECT name="DIVISION" onchange="chgSelect('D', this.selectedIndex)">
               <OPTION value="ALL" onchange="getDivName()">All Division</OPTION>
             </SELECT>
             <input name="DIVNAME" type="hidden">
          </TD>
        </TR>
        <TR>
          <TD align=right>Store:</TD>
          <TD align=left>
             <SELECT name="STORE" onchange="chgSelect('S', this.selectedIndex)"></SELECT>
          </TD>
        </TR>
        <TR>
            <TD></TD>
            <TD align=left colSpan=5>
               <INPUT type=submit value=Submit name=SUBMIT>
               &nbsp;&nbsp;&nbsp;&nbsp;
           </TD>
          </TR>
         </TBODY>
        </TABLE>
       </FORM>
       <a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;
         <font size="-1">This Page.</font>
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
