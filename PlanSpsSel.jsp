<%@ page import="rciutility.SetDivDptCls, rciutility.StoreSelect"%>
<%
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null || session.getAttribute("PLAN") == null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=PlanSpsSel.jsp&APPL=ALL");
   }
   else
   {
      SetDivDptCls ddcSel = new  SetDivDptCls();
      String sDiv = ddcSel.getDivJsa();
      String sDivName = ddcSel.getDivNameJsa();
      String sDpt = ddcSel.getDptJsa();
      String sDptName = ddcSel.getDptNameJsa();
      String sCls = ddcSel.getClsJsa();
      String sClsName = ddcSel.getClsNameJsa();

      StoreSelect strSel = new  StoreSelect();
      int iNumOfStr = strSel.getNumOfStr();
      String [] sStr = strSel.getStrLst();
%>

<script LANGUAGE="JavaScript1.2" src="Calendar.js">
</script>


<script name="javascript">
//==============================================================================
// Global variables
//==============================================================================
var Div = [<%=sDiv%>];
var DivName = [<%=sDivName%>];
var Dpt = [<%=sDpt%>];
var DptName = [<%=sDptName%>];
//var Cls = [<%=sCls%>];
//var ClsName = [<%=sClsName%>];

//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   setDivSel();
   setDptSel("ALL");
   setClsSel("ALL", "ALL");
}

//==============================================================================
// populate division selection
//==============================================================================
function setDivSel()
{

}

//==============================================================================
// popilate department selection
//==============================================================================
function setDptSel(div)
{
}
//==============================================================================
// popilate class selection
//==============================================================================
function setClsSel(div, dpt)
{
}
//==============================================================================
// change Store selection
//==============================================================================
function chgStrSel(str)
{
  var stores =  document.all.STORE;
  // unselect other store if ALL selected
  if(str.value=="ALL" && str.checked)
  {
     for(var i=1; i < stores.length; i++ ) { stores[i].checked=false; }
  }
  else if(str.value!="ALL") stores[0].checked=false;
}

//==============================================================================
// Validate form
//==============================================================================
function Validate(){

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
        <BR>Planning - Selection</B>

      <FORM  method="GET" action="PlanSps.jsp" onSubmit="return Validate(this)">
      <TABLE>
        <TBODY>
        <!-- ------------- Division  --------------------------------- -->
        <TR>
          <TD align=right>Division:</TD>
          <TD align=left colspan="3">
             <SELECT name="DIVISION" onchange="doDivSelect(this.selectedIndex);">
               <OPTION value="ALL">All Division</OPTION>
             </SELECT>
             <INPUT type=hidden  name=DIVNAME>
          </TD>
        </TR>
        <TR>
          <TD align=right>Department:</TD>
          <TD align=left colspan="3">
             <SELECT name=DEPARTMENT >
                <OPTION value="ALL">All Department</OPTION>
             </SELECT>
             <INPUT type=hidden  name=DPTNAME>
          </TD>
        </TR>
        <TR>
            <TD align=right >Class:</TD>
            <TD align=left colspan="3">
               <SELECT name=CLASS>
                  <OPTION value="ALL">All Classes</OPTION>
                </SELECT>
            </TD>
        </TR>
        <!-- =============================================================== -->
        <TR>
          <TD align=right >Store:</TD>
          <TD align=left colspan="3">
             <input name="STORE" type="checkbox" value="ALL" onclick="chgStrSel(this)" checked>All&nbsp;&nbsp;
             <%for(int i=0; i<iNumOfStr; i++) {%>
               <input name="STORE" type="checkbox" onclick="chgStrSel(this)" value="<%=sStr[i]%>"><%=sStr[i]%>x&nbsp;&nbsp;
               <%if(i == 10) {%><br><%}%>
             <%}%>
          </TD>
        </TR>
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
          <TD align=right > <br>Change Plan:</TD>
           <TD>
              <br><input name="AlwChg" type="radio" value="R" checked>Retail<br>
              <input name="AlwChg" type="radio" value="C" >Cost<br>
              <input name="AlwChg" type="radio" value="U" >Unit
          </TD>
        </TR>
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
          <TD align=right > <br>Show Result in:</TD>
           <TD>
              <br><Select name="Result">
                  <option value="1">Ones</option>
                  <option value="2">100</option>
                  <option value="3">1k</option>
                  <option value="4">10k</option>
                  </Select><br>
          </TD>
        </TR>
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
        <TR>
            <TD></TD>
            <TD align=left colSpan=5>
               <INPUT type=submit value=Submit name=SUBMIT onClick="setAction(1)">
               &nbsp;&nbsp;&nbsp;&nbsp;

           <% if(session.getAttribute("PLNAPPROVE") != null) {%>&nbsp;&nbsp;&nbsp;&nbsp;
                <INPUT type=submit value=Approve name=SUBMIT onClick="setAction(2)">
           <%}%>

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
<%}%>