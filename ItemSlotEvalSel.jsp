<%@ page import="rciutility.DivDptClsSelect"%>
<%
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=ItemSlotEvalSel.jsp&APPL=ALL&");
   }
   else
   {
      DivDptClsSelect DivSelect = new DivDptClsSelect();
      String sDiv = DivSelect.getDivNum();
      String sDivName = DivSelect.getDivName();
%>

<style>body {background:ivory;}
        a:link { color:blue; font-size:12px} a:visited { color:blue; font-size:12px}  a:hover { color:red; font-size:12px}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       text-align:center; font-family:Verdanda; font-size:12px }
        tr.DataTable { background: #E7E7E7; font-family:Arial; font-size:10px }
        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; white-space: nowrap;}
        td.DataTable1{ padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right; white-space: nowrap;}
        .Small{font-size:10px}
</style>


<script name="javascript">
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   popDivSelect();
}
//==============================================================================
// Load Division
//==============================================================================
function popDivSelect() {
    var div = [<%=sDiv%>];
    var divnm = [<%=sDivName%>];

    for (i = 0; i < div.length; i++)
    {
      document.all.Division.options[i] = new Option(divnm[i],div[i]);
    }
}
//==============================================================================
// Validate form
//==============================================================================
function Validate()
{
  var error = false;
  var msg = "";
  var dividx = document.all.Division.selectedIndex;
  var div = document.all.Division.options[dividx].value;
  var divnm = document.all.Division.options[dividx].text;

  var sku = document.all.Sku.value;
  if(isNaN(sku)){ error = true; msg="\nSku is invalid";}

  var minqty = document.all.MinQty.value;
  if(isNaN(minqty)){ error = true; msg="\nMinimum Quantity is invalid";}

  if(error) alert(msg);
  else sbmItemSlotEval(div, divnm, sku, minqty);
}
//-------------------------------------------------------------
// Prompt for Media populate media list
//-------------------------------------------------------------
function sbmItemSlotEval(div, divnm, sku, minqty)
{
   var url = "ItemSlotEval.jsp?"
    + "Div=" + div
    + "&Sku=" + sku
    + "&MinQty=" + minqty

   //alert(url);
   window.location.href = url;
}

</script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>


<HTML><HEAD>

<META content="Microsoft FrontPage 4.0" name=GENERATOR></HEAD>
<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Item Slotting Evaluation - Selection</B>
       <p>
       <a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;<font size="-1">This Page.</font>
       &nbsp;&nbsp;&nbsp;
       <a href="OnHands03.jsp" class="blue" target="_blank">Item Lookup</a>

      <TABLE>
        <TBODY>

        <!-- =============================================================== -->
        <TR>
          <TD align=right>Division:<br><br></TD>
          <TD align=left colspan="3">
             <SELECT name="Division" class="Small"></SELECT><br><br>
          </TD>
        </TR>

        <!-- =============================================================== -->
        <TR style="background: darkred;"><TD colspan=4 ></TD></TR><TR><TD colspan=4 >&nbsp;</TD></TR>
        <TR>
          <TD align=right>SKU:<br><br></TD>
          <TD align=left colspan="3">
             <input name="Sku"  class="Small" maxlength=10 size=10><br><br>
          </TD>
        </TR>

        <!-- =============================================================== -->
        <TR style="background: darkred;"><TD colspan=4 ></TD></TR><TR><TD colspan=4 >&nbsp;</TD></TR>
        <TR>
          <TD align=right>Minimum Quantity:<br><br></TD>
          <TD align=left colspan="3">
             <input name="MinQty"  class="Small" maxlength=5 size=5 value=200><br><br>
          </TD>
        </TR>

        <!-- =============================================================== -->
        <TR style="background: darkred;"><TD colspan=4 ></TD></TR><TR><TD colspan=4 >&nbsp;</TD></TR>

        <TR>
          <TD align=center colspan="4">
             <input name=SUBMIT type="Submit" onClick="Validate()" value="Submit"> &nbsp;&nbsp
          </TD>
        </TR>
        </TBODY>
       </TABLE>

      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
<%}%>