<%@ page import="java.util.*"%>
<%
   //----------------------------------
   // Application Authorization
   //----------------------------------
   String sAppl = "PATIO";
   if (session.getAttribute("USER")==null || session.getAttribute(sAppl)==null
   && !session.getAttribute("APPLICATION").equals(sAppl))
   {
     response.sendRedirect("SignOn1.jsp?TARGET=PfOpnInvSel.jsp&APPL=ALL");
   }
   else
   {
   int iSpace = 6;
%>

<style>
  .Small {font-family: times; font-size:10px }
  .Small1 {font-family: times; font-size:10px; text-transform:uppercase; }

  td.Cell {font-size:12px; text-align:right; vertical-align:bottom}
  td.Cell1 {font-size:12px; text-align:left; vertical-align:middle}
  td.Cell2 {font-size:12px; text-align:center; vertical-align:middle;}

  div.dvVendor { position:absolute; visibility:hidden; border: gray solid 1px;
                 width:300; height:250;background-color:white; z-index:10; text-align:left; font-size:10px}
  div.dvInternal { overflow: auto;border: none; width:300; height:220;
                   background-color:white; z-index:10; text-align:left; font-size:10px}
  </style>

<script LANGUAGE="JavaScript1.2" src="Calendar.js">
</script>


<script name="javascript">
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
  
}

//==============================================================================
// Validate form
//==============================================================================
function Validate(excel)
{
  var error = false;
  var msg = "";

  var stores = document.all.Store;
  var str = new Array();
  var action;

  // at least 1 store must be selected
  var strsel = false;
  for(var i=0, j=0; i < stores.length; i++ )
  {
     if(stores[i].checked)
     {
        strsel=true;
        str[j] = stores[i].value;
        j++;
     }
  }

  if(!strsel)
  {
    msg += "\n Please, check at least 1 store";
    error = true;
  }
  
  var inclobj = document.all.Incl;
  var incl = "";
  for(var i=0; i < inclobj.length; i++)
  {
	  if(inclobj[i].checked){ incl = inclobj[i].value; break;}
  } 
  
  var ord = document.all.Order.value.trim();

  if (error) alert(msg);
  else{ sbmReport( str, incl, ord ) }
  return error == false;
}
//==============================================================================
// Submit OTB Planning
//==============================================================================
function sbmReport( str, incl, ord )
{
  var url = "PfOpnInv.jsp?Ord=" + ord
	+ "&Incl=" + incl
	;
    
  // selected store
  for(var i=0; i < str.length; i++) { url += "&Str=" + str[i]; }
  
  //alert(url)
  window.location.href=url;
}
</script>

<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>

<HTML><HEAD><meta http-equiv="refresh">

</HEAD>
<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<div id="dvVendor" class="dvVendor"></div>
<!-------------------------------------------------------------------->
<iframe id="frame1" src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Patio Furniture Open Order Inventory - Selection</B>

        <br><a href="index.jsp"><font color="red" size="-1">Home</font></a>

      <TABLE border=0>
        <TBODY>

        <!-- ================== Store selections =========================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
          <TD class="Cell2"><b>Select Selling Stores:</b>
             <input name="Store" type="radio" value="35" >35 &nbsp;&nbsp;
             <input name="Store" type="radio" value="46" >46 &nbsp;&nbsp;
             <input name="Store" type="radio" value="50" >50 &nbsp;&nbsp;
             <input name="Store" type="radio" value="86" >86 &nbsp;&nbsp;
             <input name="Store" type="radio" value="63" >63 &nbsp;&nbsp;
             <input name="Store" type="radio" value="64" >64 &nbsp;&nbsp;
             <input name="Store" type="radio" value="68" >68 &nbsp;&nbsp;   
             <input name="Store" type="radio" value="55" >55 &nbsp;&nbsp;             
          </TD>
        </TR>
        <TR>
          <TD class="Cell2"> 
             <input name="Incl" type="radio" value="1" checked><b>All Open Orders</b>   &nbsp;&nbsp; 
             <input name="Incl" type="radio" value="2" ><b>Delivered(Completed) - This Week</b> &nbsp;&nbsp;
             <input name="Incl" type="radio" value="3" ><b>Delivered(Completed) - Last Week</b> &nbsp;&nbsp;                          
          </TD>
        </TR>
        <!-- ================== Store selections =========================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
          <TD class="Cell2"><b>Order:</b>
             <input name="Order" size=12 maxlength=10>&nbsp;(optional)&nbsp;                          
          </TD>
        </TR>
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
            <TD align=center colSpan=5>
               <INPUT type=submit value=Submit name=SUBMIT onClick="Validate(false)">
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