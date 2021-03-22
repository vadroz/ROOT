<%@ page import="rental.RentClsAvlList ,java.util.*, java.text.*"%>
<%
   String sSrchCls = request.getParameter("Cls");
   String sSrchStr = request.getParameter("Str");
   String sFrDate = request.getParameter("FrDate");
   String sToDate = request.getParameter("ToDate");

   if(sToDate == null){ sToDate = "TWOWEEKS"; }

   String sUser = session.getAttribute("USER").toString();
   RentClsAvlList rentinv = new RentClsAvlList(sSrchCls, sSrchStr, sFrDate, sToDate, sUser);
   int iNumOfDat = rentinv.getNumOfDat();
   String [] sDate = rentinv.getDate();
   String [] sMonth = rentinv.getMonth();
   String [] sDay = rentinv.getDay();
   String [] sWkDay = rentinv.getWkDay();

   String [] sMonNm = new String[]{ "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"};
%>

     <table id="tbClsDtl" border=1 class="DataTable" cellPadding="0" width="100%" cellSpacing="0">
       <tr class="DataTable">
           <th class="DataTable" style="border:none; background:white; text-align:left;" colspan="<%=sDate.length + 4%>">
              <span style="background:OrangeRed">Orange</span> - Open
              &nbsp; &nbsp;
              <span style="background:#ff9933">Ochre</span> - Ready
               &nbsp; &nbsp;
              <span style="background:lightblue">Blue</span> - Picked Up
              &nbsp; &nbsp;
              <span style="background:green">Green</span> - Returned
           </th>
       <tr class="DataTable">
          <th class="DataTable" rowspan=3>Item</th>
          <th class="DataTable" rowspan=3>Size</th>
          <th class="DataTable">
             <button style="background:gold; font-size:12px; font-weight:bold;" name="Down" onClick="setDate('14','DOWN')">&#60;&#60;&#60;</button>
             <button style="background:gold; font-size:12px; font-weight:bold;" name="Down" onClick="setDate('7','DOWN')">&#60;&#60;</button>
             <button style="background:gold; font-size:12px; font-weight:bold;" name="Down" onClick="setDate('1','DOWN')">&#60;</button>
          </th>
          <%for(int i=0; i < sDate.length; i++){%>
             <th class="DataTable" nowrap>
                <%=sMonNm[Integer.parseInt(sMonth[i].trim()) - 1]%>
             </th>
          <%}%>
          <th class="DataTable">
             <button style="background:gold; font-size:12px; font-weight:bold;" name="Up" onClick="setDate('1','UP')">&#62;</button>
             <button style="background:gold; font-size:12px; font-weight:bold;" name="Up" onClick="setDate('7','UP')">&#62;&#62;</button>
             <button style="background:gold; font-size:12px; font-weight:bold;" name="Up" onClick="setDate('14','UP')">&#62;&#62;&#62;</button>
          </th>
       </tr>
       <tr class="DataTable">
          <th class="DataTable">Date</th>
          <%for(int i=0; i < sDate.length; i++){%>
             <th class="DataTable" width=30><%=sDay[i]%></th>
          <%}%>
          <th class="DataTable">&nbsp;</th>
       </tr>
       <tr class="DataTable">
          <th class="DataTable">&nbsp</th>
          <%for(int i=0; i < sDate.length; i++){%>
             <th class="DataTable" width=30><%=sWkDay[i]%></th>
          <%}%>
          <th class="DataTable">&nbsp;</th>
       </tr>
  <!-------------------------- Order List ------------------------------->
     <%
       String svCls = "";
       String svVen = "";
       String svSty = "";
       int iRow = 0;

       while(rentinv.getNext())
       {
         rentinv.getItemList();

         String sCls = rentinv.getCls();
         String sVen = rentinv.getVen();
         String sSty = rentinv.getSty();
         String sClr = rentinv.getClr();
         String sSiz = rentinv.getSiz();
         String sSku = rentinv.getSku();
         String sDesc = rentinv.getDesc();
         String sVenSty = rentinv.getVenSty();
         String sClsNm = rentinv.getClsNm();
         String sClrNm = rentinv.getClrNm();
         String sSizNm = rentinv.getSizNm();
         String sTotQty = rentinv.getTotQty();

         rentinv.getItemDtl();
         String [] sDateQty = rentinv.getDateQty();
         String [] sDateAvlQty = rentinv.getDateAvlQty();
     %>
         <tr class="DataTable1" id="trRow<%=iRow%>">
           <td class="DataTable">
              <%if(sCls.equals(svCls) && sVen.equals(svVen) && sSty.equals(svSty)){%>&nbsp;
              <%} else {%>
                <%=sDesc%>
              <%}%>
              <input type="hidden" id="Cls<%=iRow%>" value="<%=sCls%>">
              <input type="hidden" id="Ven<%=iRow%>" value="<%=sVen%>">
              <input type="hidden" id="Sty<%=iRow%>" value="<%=sSty%>">
              <input type="hidden" id="Clr<%=iRow%>" value="<%=sClr%>">
              <input type="hidden" id="Siz<%=iRow%>" value="<%=sSiz%>">
              <input type="hidden" id="Desc<%=iRow%>" value="<%=sDesc%>">
              <input type="hidden" id="ClrNm<%=iRow%>" value="<%=sClrNm%>">
              <input type="hidden" id="SizNm<%=iRow%>" value="<%=sSizNm%>">
            </td>
           <td class="DataTable"><a href="javascript: getTagAvl('<%=sCls%>','<%=sVen%>','<%=sSty%>','<%=sClr%>','<%=sSiz%>','<%=sDesc%>','<%=sClrNm%>','<%=sSizNm%>', '<%=iRow%>')"><%=sSizNm%></a></td>

           <th class="DataTable">&nbsp;</th>

           <%for(int i=0; i < sDate.length; i++){%>
             <td class="DataTable2" width=30><%=sDateAvlQty[i]%></td>
          <%}%>
          <th class="DataTable">&nbsp;</th>
         </tr>
     <%
        iRow++;
        svCls = sCls;
        svVen = sVen;
        svSty = sSty;
       }%>
    </table>

<SCRIPT language="JavaScript1.2">
    parent.dvClsDtl.innerHTML = document.all.tbClsDtl.outerHTML
    parent.showTagAgain()
</SCRIPT>

<%
   rentinv.disconnect();
%>