<%@ page import="java.io.*, java.text.*,  java.util.*"%>
<%
    String sKioskStr = request.getParameter("utm_medium");
    String sKioskSrc = request.getParameter("utm_source");

    Enumeration en = session.getAttributeNames();
    Vector vAppl = new Vector();

    // save all session attributes in vector
    while(en.hasMoreElements()) { vAppl.add(en.nextElement()); }

    // remove found attributes
    Iterator itrAppl = vAppl.iterator();
    while(itrAppl.hasNext())
    {
       String sAppl = itrAppl.next().toString();
       //System.out.print("\n" + sAppl);
       session.removeAttribute(sAppl);
    }

    //=========================================
    // get store number if calls from Kiosk
    //=========================================
    if(sKioskStr != null && sKioskSrc != null)
    {
       String str = sKioskStr.substring(sKioskStr.indexOf("_") + 1);
       sKioskStr = str;
    }
    else
    {
      sKioskStr = "NONE";
      sKioskSrc = "NONE";
    }

    session.setAttribute("KIOSK", "KIOSK");
%>
<HTML>
<TITLE>RCI Intranet Home Page</TITLE>
 <HEAD>
     <style type="text/css">
       body {background:ivory;}
       th.sep1 { background: lightsalmon; border-bottom: black solid 1px; text-align:center; font-family:Verdanda; font-size:18px }
       td.sep1 { text-align:left;}
       td.sep2 { text-align:center; font-size:18px}
     </style>
 </HEAD>
<BODY>

<Table Border=0 CELLSPACING="5" CELLPADDING="0" width="100%"
height="100%">
<tr><td height="20%"><img src="Sun_ski_logo4.png" width="80%"></td></tr>
<tr>
    <td nowrap valign="top" bgColor="moccasin">
        <table border=0 width="100%" CELLSPACING="0" CELLPADDING="0">
        <tr>
         <td class="sep2" ><h2>On-Hand Search Menu</h2></td>
        </tr>

        <tr><th class="sep1">On Hand</th></tr>
        <tr>
          <td class="sep1"><br>
              1. <a class="blue" href="OnHands03.jsp?KioskStr=<%=sKioskStr%>&KioskSrc=<%=sKioskSrc%>">Quick Inventory Lookup</a><br/><br/>

              2. <a class="blue" href="UpcSearch.jsp?KioskStr=<%=sKioskStr%>&KioskSrc=<%=sKioskSrc%>">Search for Items by SKU/UPC or Div/Dpt/Class</a><br>
          </td>
         </tr>
        </table>
    </td>
</tr>
</TABLE>
</BODY>
</HTML>


