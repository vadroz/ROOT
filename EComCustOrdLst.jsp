<%@ page import="ecommerce.EComCstOrdLst, java.util.*, java.text.*"%>
<%
   String sFrom = request.getParameter("From");
   if (sFrom==null)
   {
      Calendar calend = Calendar.getInstance();
      calend.add( Calendar.DATE, -1);

      SimpleDateFormat sdfmt = new SimpleDateFormat("MM/dd/yyyy");
      sFrom = sdfmt.format(calend.getTime());
      System.out.println(sFrom);
   }

    EComCstOrdLst cstordl = new EComCstOrdLst(sFrom, "scheduler");
    String sOrd = cstordl.getOrd();
    cstordl.disconnect();
%>
<HTML>
<HEAD>
<title>E-Commerce Last Customer Order</title>
<META content="RCI, Inc." name="E-Commerce"></HEAD>
<style>
  body {background:ivory;}
</style>

<script name="javascript1.2">
var Orders = [<%=sOrd%>];

var formNum = 0;
var CreateFrame = true;
var toId = null;
var OrdArg = 0;
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{
  if (Orders != null)
  {
     document.all.spOrd.innerHTML = "Number of Orders: " + Orders.length
     + "&nbsp; &nbsp; From Order number: " + Orders[0] + " Through: " + Orders[Orders.length-1];

     sbmXmlToELab();
  }
  else
  {
     alert("Orders are not found.")

  }
  //window.location.href="EComCustOrdLstSel.jsp"
}
//==============================================================================
// submit page that will send XML string to EmailLab
//==============================================================================
function sbmXmlToELab()
{
   if(OrdArg < Orders.length)
   {
      if(formNum == 300 ){ formNum = 0; CreateFrame = false; }
      var frm = "frame" + formNum

      if (CreateFrame)
      {
         var frameel = document.createElement("IFRAME");
         frameel.id = frm;
         frameel.height = 0;
         frameel.width = 0;
         document.body.appendChild(frameel);
      }

      formNum++;
      var url = "EComSndCustOrd.jsp?" + "&Ord=" + Orders[OrdArg] + "&Frame=" + frm;
      window[frm].location.href=url;
      OrdArg++;
   }
   else
   {
      window.close();
   }
}
//==============================================================================
// re-submit
//==============================================================================
</script>

<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>

<body onload="bodyLoad()">
<!-------------------------------------------------------------------->

<!-------------------------------------------------------------------->

<font size = +2>Wait while orders are downloading...</font>
<br><span id="spOrd" style="font-size:16px"></span>
<br><span id="spSts" style="font-size:16px"></span>
</body>



