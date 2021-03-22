<%@ page import="menu.StrIncomingShip, rciutility.StoreSelect, java.util.*"%>
<%
if (session.getAttribute("USER") !=null && session.getAttribute("STORE") != null)
{
     String sStrAllowed = session.getAttribute("STORE").toString();
     String sUser = session.getAttribute("USER").toString();
     String [] sAuthStr = null;

     StrIncomingShip incship = new StrIncomingShip();
     String sStore = incship.getStore();
     String sShip_To_Str = incship.getShip_To_Str();
     String sDC_To_Str = incship.getDC_To_Str();
     String sStr_To_Str = incship.getStr_To_Str();
     String sStrTotal = incship.getStrTotal();

     incship.disconnect();
     incship = null;

     StoreSelect StrSelect = null;
     String sStrLst = null;
     String sStrLstName = null;

     int iStrAlwLst = 0;
     if (sStore==null && sStrAllowed != null && sStrAllowed.startsWith("ALL"))
     {
        response.sendRedirect("index.jsp");
     }

      if (sStrAllowed != null && sStrAllowed.startsWith("ALL"))
      {
        StrSelect = new StoreSelect(4);
      }
      else
      {
        Vector vStr = (Vector) session.getAttribute("STRLST");
        String [] sStrAlwLst = new String[ vStr.size()];
        Iterator iter = vStr.iterator();

        while (iter.hasNext()){ sStrAlwLst[iStrAlwLst] = (String) iter.next(); iStrAlwLst++; }
        if (vStr.size() > 1) { StrSelect = new StoreSelect(sStrAlwLst); }
        else StrSelect = new StoreSelect(new String[]{sStrAllowed});
      }

      sStrLst = StrSelect.getStrNum();
      sStrLstName = StrSelect.getStrName();
%>
<html>
<head>
<style>
 body {background:ivory;}
</style>
</head>

<SCRIPT language="JavaScript1.2">
var Store = [<%=sStore%>];
var Ship_To_Str = [<%=sShip_To_Str%>];
var DC_To_Str = [<%=sDC_To_Str%>];
var Str_To_Str = [<%=sStr_To_Str%>]
var StrTotal = [<%=sStrTotal%>]

var StrLst = [<%=sStrLst%>];

var AuthStr = "<%=sStrAllowed%>";
SendIncShip();

//==============================================================================
// send incoming shipments
//==============================================================================
function SendIncShip()
{
  var html = popTable();
  // document.write(html);
  parent.setStrIncShip(html);
}
// ------------------------------------------------------
// populate new mesage table
// ------------------------------------------------------
function popTable()
{
  var html = "<table class='msg'>"
             + "<tr>"
               + "<td nowrap class='msg1' colspan=5 nowarp >Stores Incoming Shipments</td>"
             + "</tr>"
             + "<tr>"
               + "<td nowrap class='msg1' colspan=5 nowarp >Number of Cartons</td>"
             + "</tr>"
             + "<tr>"
               + "<td class='msg1'>Str</td>"
               + "<td class='msg1' >Ship To Store</td>"
               + "<td class='msg1' >From DC</td>"
               + "<td class='msg1'>From Other Store</td>"
               + "<td class='msg1'>Total</td>"
             + "</tr>";

  for(i=0; i < Store.length; i++)
  {
    html += "<tr>"
           + "<td class='msg2'>" + Store[i] + "</td>"

    var allow = false;
    for(j=0; j < StrLst.length; j++)
    {
       if(StrLst[j] == Store[i]){ allow = true; }
    }

    if(AuthStr == "ALL" || AuthStr == Store[i] || allow)
    {
       html += "<td class='msg2'><a href='MozuOrSTSList.jsp?Store=" + Store[i] + "' target=_blank>" + Ship_To_Str[i] + "</a></td>"
    }
    else { html += "<td class='msg2'>" + Ship_To_Str[i] + "</td>" }

    html += "<td class='msg2'>" + DC_To_Str[i] + "</td>"
           + "<td class='msg2'>" + Str_To_Str[i] + "</td>"
           + "<td class='msg2'>" + StrTotal[i] + "</td>"
           + "</tr>"
  }
  html += "</table>";
  return html;
}
</SCRIPT>

</html>

<%}%>