<%@ page import="java.io.*, java.text.*,  java.util.*"%>
<%

if (session.getAttribute("USER")==null )
   {
     response.sendRedirect("SignOn1.jsp?TARGET=Outsider.jsp&APPL=ALL");
   }
else
{


    Enumeration en = session.getAttributeNames();
    Vector vAppl = new Vector();

    // save all session attributes in vector
    while(en.hasMoreElements()) { vAppl.add(en.nextElement()); }

    // remove found attributes
    Iterator itrAppl = vAppl.iterator();
    while(itrAppl.hasNext())
    {
       String sAppl = itrAppl.next().toString();
       //System.out.print("|" + sAppl);
       session.removeAttribute(sAppl);
    }

    System.out.println("");
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
         <td class="sep2" ><h2>Main Menu</h2></td>
        </tr>


        <tr>
          <td class="sep1"><br>
              1. <a class="blue" href="FlashSalesSel.jsp">Flash Sales</a><br/><br/>

              2. <a class="blue" href="ClsSlsRepSel.jsp">GM Data Download</a><br><br/>

              3. <a class="blue" href="WkSlsTrendSel.jsp?mode=1">Sales Trend Comparison/Analysis</a><br>
          </td>
         </tr>
        </table>
    </td>
</tr>
</TABLE>
</BODY>
</HTML>


<%}%>