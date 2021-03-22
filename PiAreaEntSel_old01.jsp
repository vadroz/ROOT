<%@ page import=" rciutility.StoreSelect, inventoryreports.PiCalendar, java.util.*"%>
<%
   String sSelStr = request.getParameter("Str");
   String sSelSku = request.getParameter("Sku");
   String sSelDate = request.getParameter("Date");

    //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=PiAreaEntSel.jsp&APPL=ALL");
   }
   else
   {
   String sStrAllowed = session.getAttribute("STORE").toString();
   String sUser = session.getAttribute("USER").toString();
   
   StoreSelect strlst = null;
   if (sStrAllowed != null && sStrAllowed.startsWith("ALL"))
   {
     strlst = new StoreSelect(20);
   }
   else if (sStrAllowed != null && sStrAllowed.trim().equals("70"))
   {
     strlst = new StoreSelect(21);
   }
   else
   {
     Vector vStr = (Vector) session.getAttribute("STRLST");
     String [] sStrAlwLst = new String[ vStr.size()];
     Iterator iter = vStr.iterator();

     int iStrAlwLst = 0;
     while (iter.hasNext()){ sStrAlwLst[iStrAlwLst] = (String) iter.next(); iStrAlwLst++; }

     if (vStr.size() > 1) { strlst = new StoreSelect(sStrAlwLst); }
     else strlst = new StoreSelect(new String[]{sStrAllowed});
  }
   
   String sStrJsa = strlst.getStrNum();
   String sStrNameJsa = strlst.getStrName();
   int iNumOfStr = strlst.getNumOfStr();
   String [] sStr = strlst.getStrLst();
   
   strlst = null;

   // get PI Calendar
   PiCalendar setcal = new PiCalendar();
   String sYear = setcal.getFullYear();
   String sMonth = setcal.getMonth();
   String sDesc = setcal.getDesc();
   setcal.disconnect();
%>

<script LANGUAGE="JavaScript1.2" src="Calendar.js">
</script>


<script name="javascript">
var PiYear = [<%=sYear%>];
var PiMonth = [<%=sMonth%>];
var PiDesc =  [<%=sDesc%>];

var ArrStr = [<%=sStrJsa%>];
var ArrStrNm = [<%=sStrNameJsa%>];

var SelStr = null;
var SelSku = null;
var SelDate = null;
<%if(sSelSku != null){%>
  SelStr = "<%=sSelStr%>"
  SelSku = "<%=sSelSku%>"
  SelDate = "<%=sSelDate%>"
<%}%>
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad(){
  var df = document.forms[0];
  var sel_Str= "<%=request.getParameter("STORE")%>";
  var str_opt;

  doStrSelect();
   
  popPICal();

  if(SelSku != null){ document.forms[0].Sku.value = SelSku }
  
  if(document.all.SvSku.value != ""){ setOldVal(); }  
}
//==============================================================================
// set selection fileds with previously enterd values
//==============================================================================
function setOldVal()
{
	var str = document.all.SvStr.value;	
	var pical = document.all.SvPICal.value;
	
	document.all.Sku.value = document.all.SvSku.value;
	 	
	for(var i=0; i < document.all.Store.length;i++)
	{
		if(str == document.all.Store[i].value)
		{
			document.all.Store.selectedIndex = i;
			break;
		}
	}
	
	for(var i=0; i < document.all.PICal.length;i++)
	{
		if(pical == document.all.PICal[i].value)
		{
			document.all.PICal.selectedIndex = i;
			break;
		}
	}
}
//==============================================================================
// Load Stores
//==============================================================================
function doStrSelect() 
{    
	var df = document.all;
    var j = 0;
    j=1;

	for (var i=0; j < ArrStr.length; i++, j++)
    {
      df.Store.options[i] = new Option(ArrStr[j] + " - " + ArrStrNm[j], ArrStr[j]);
    }
    document.all.Store.selectedIndex=0;
}
//==============================================================================
// change Store selection
//==============================================================================
function popPICal()
{
   for(var i=0; i < PiYear.length; i++)
   {
      document.all.PICal.options[i] = new Option(PiDesc[i], PiYear[i] + PiMonth[i]);
   }
}
//==============================================================================
// Validate form
//==============================================================================
  function Validate(){
  var form = document.forms[0];
  var error = false;
  var msg = " ";
  var id_str = form.Store.selectedIndex;
  var sel_Str = form.Store.options[id_str].value;
  var pcidx = form.PICal.selectedIndex;
  var pc = form.PICal.options[pcidx].value;
  
  var from = form.From.value.trim();
  if(from == ""){error = true; msg += "\nPlease enter From Area"; }
  else if(isNaN(from)){error = true; msg += "\nFrom Area is not numeric."; }
  else if(eval(from) <= 0){error = true; msg += "\nFrom Area is not positive number."; }
  
  var size = form.Size.value.trim();
  if(size == ""){error = true; msg += "\nPlease enter Page Size"; }
  else if(isNaN(size)){error = true; msg += "\nPage Size is not numeric."; }
  else if(eval(size) <= 0){error = true; msg += "\nPage Size is not positive number."; }
  
  if (error) alert(msg);
  else
  {
	  form.SvStr.value = sel_Str;
	  form.SvPICal.value = pc;
  } 
  return error == false;
}

</script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>



<HTML><HEAD>
<title>PI Entry Sel</title>
<META content="Microsoft FrontPage 4.0" name=GENERATOR></HEAD>
<BODY onload="bodyLoad();">
<div id="tooltip2" style="position:absolute;visibility:hidden;background-color:LemonChiffon; z-index:10"></div>

<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR>
    <TD height="20%"><IMG
    src="Sun_ski_logo1.jpg"></TD></TR>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>PI Store Area Entry - Selection</B>
        <br><a href="/"><font color="red" size="-1">Home</font></a>

   <FORM  method="GET" action="PiAreaEnt.jsp" onSubmit="return Validate(this)">
      <TABLE>
       <TBODY>
        <!-- =============================================================== -->
        <TR>
          <TD align=right >Store:</TD>
          <TD align=left>
             <SELECT name="Store"></SELECT>
          </TD>
        </TR>
        
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
          <TD class="Cell" nowrap>Display counts from PI Calendar:</td>
          <TD align=left>
          <select name="PICal"></select>          
          </td>
        </tr>
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
          <TD class="Cell" nowrap>From Area:</td>
          <TD align=left>
           <input name="From" value="1">          
          </td>
        </tr>
        <TR>
          <TD class="Cell" nowrap>Page Size:</td>
          <TD align=left>
           <input name="Size" value="20">          
          </td>
        </tr>
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="2" >&nbsp;</TD></TR>
        <TR>
        <TR>
            <TD></TD>
            <TD align=left colSpan=5>
               <INPUT type=submit value=Submit name=SUBMIT>
               <br><input type="hidden" name="SvSku">
               <br><input type="hidden" name="SvStr">
               <br><input type="hidden" name="SvPICal">
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
<%} %>