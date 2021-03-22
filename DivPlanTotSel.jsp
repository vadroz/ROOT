<%@ page import=" rciutility.ClassSelect, rciutility.StoreSelect"%>
<%
   String sDiv = null;
   String sDivName = null;

   ClassSelect select = new ClassSelect();
   sDiv = select.getDivNum();
   sDivName = select.getDivName();

   StoreSelect strSelect = new StoreSelect();
   String sStr = strSelect.getStrNum();
   String sStrName = strSelect.getStrName();
%>


<script name="javascript">
function bodyLoad(){
  doStrSelect();
  doDivSelect();
}


// Load Stores
function doStrSelect() {
  var df = document.forms[0];
  var stores = [<%=sStr%>];
  var storeNames = [<%=sStrName%>];

  df.STORE.options[0] = new Option("ALL - Display Totals by Chain", "CMB");

  for (idx = 0; idx < stores.length; idx++)
  {
    df.STORE.options[idx + 1] = new Option(stores[idx] + " - " + storeNames[idx],stores[idx]);
  }

}


function doDivSelect() {
    var df = document.forms[0];
    var divisions = [<%=sDiv%>];
    var divisionNames = [<%=sDivName%>];
    var allowed;

    for (idx = 0; idx < divisions.length; idx++)
    {
      df.DIVISION.options[idx] = new Option(divisionNames[idx],divisions[idx]);
    }
}


// if Store Changed from all to any valid store change division to all
function chgDivSel(strIdx)
{
  var df = document.forms[0];
  if (strIdx < 1)
  {
    df.DIVISION.selectedIndex = 0;
  }
}

// if SDivision Changed from all to any - change store to all
function chgStrSel(divIdx)
{
  var df = document.forms[0];
  var strIdx = df.STORE.selectedIndex;
  if (divIdx != 0)
  {
    df.STORE.selectedIndex = 1;
  }
}

// Validate form
function Validate(){
  var error = false;
  var msg = " ";

  if (error) alert(msg);
  return error == false;
}

function isNum(str) {
  if(!str) return false;
  for(var i=0; i < str.length; i++){
    var ch=str.charAt(i);
    if ("0123456789".indexOf(ch) ==-1) return false;
  }
  return true;
}

</script>


<HTML><HEAD>

<META content="Microsoft FrontPage 4.0" name=GENERATOR></HEAD>
<BODY onload="bodyLoad();">
<div id="tooltip2" style="position:absolute;visibility:hidden;background-color:LemonChiffon; z-index:10"></div>

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
        <BR>Division Plan Totals vs TY Sales - Select</B>

      <FORM  method="GET" onSubmit="return Validate(this)" action = "DivPlanTot.jsp">
      <TABLE>
        <TBODY>
        <TR>
          <TD align=right>Division:</TD>
          <TD align=left>
             <SELECT name="DIVISION" onChange="chgStrSel(this.selectedIndex)">
               <OPTION value="ALL">All Division</OPTION>
             </SELECT>
          </TD>
        </TR>
        <TR>
          <TD align=right >Store:</TD>
          <TD align=left>
             <SELECT name="STORE" onChange="chgDivSel(this.selectedIndex)"></SELECT>
          </TD>
        </TR>

        <TR>
            <TD></TD>
            <TD align=left colSpan=5>
               <INPUT type=submit value=Submit name=SUBMIT>
           </TD>
          </TR>
         </TBODY>
        </TABLE>
       </FORM>
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
