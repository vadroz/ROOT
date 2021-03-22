<%@ page import="rciutility.RunSQLStmt, discountcard.CouponSave, rciutility.StoreSelect, java.sql.*, java.util.*, java.text.*"%>
<%
      String sCode = request.getParameter("Code");
      String sName = request.getParameter("Name");
      String sOrg = request.getParameter("Org");
      String sOrgt = request.getParameter("Orgt");
      String sMed = request.getParameter("Med");
      String sCost = request.getParameter("Cost");
      String sDati = request.getParameter("Dati");
      String sCby = request.getParameter("Cby");
      String sRef = request.getParameter("Ref");
      String sCon = request.getParameter("Con");
      String sTit = request.getParameter("Tit");
      String sCbus = request.getParameter("Cbus");
      String sChm = request.getParameter("Chm");
      String sCfax = request.getParameter("Cfax");
      String sRmb = request.getParameter("Rmb");
      String sDuei = request.getParameter("Duei");
      String sPmt1 = request.getParameter("Pmt1");
      String sPmt2 = request.getParameter("Pmt2");
      String sPmt3 = request.getParameter("Pmt3");
      String sPmt4 = request.getParameter("Pmt4");
      String sGrp = request.getParameter("Grp");
      String sAdd1 = request.getParameter("Add1");
      String sAdd2 = request.getParameter("Add2");
      String sCty = request.getParameter("Cty");
      String sSta = request.getParameter("Sta");
      String sZip = request.getParameter("Zip");
      String sPhn = request.getParameter("Phn");
      String sFax = request.getParameter("Fax");
      String sTrpi = request.getParameter("Trpi");
      String sReso = request.getParameter("Reso");
      String sStri = request.getParameter("Stri");
      String sEndi = request.getParameter("Endi");
      String sGrpn = request.getParameter("Grpn");
      String sMar = request.getParameter("Mar");
      String sSchs = request.getParameter("Schs");
      String sEdti = request.getParameter("Edti");
      String sEtmi = request.getParameter("Etmi");
      String sCom = request.getParameter("Com");
      String sCom1 = request.getParameter("Com1");
      String sCom2 = request.getParameter("Com2");
      String sDsc = request.getParameter("Dsc");
      String sCpsi = request.getParameter("Cpsi");
      String sCpei = request.getParameter("Cpei");
      String sCtxt = request.getParameter("Ctxt");
      String sHost = request.getParameter("Host");
      String sAnsw01 = request.getParameter("Answ01");
      String sAnsw02 = request.getParameter("Answ02");
      String sAnsw03 = request.getParameter("Answ03");
      String sAnsw04 = request.getParameter("Answ04");
      String sAnsw05 = request.getParameter("Answ05");
      String sAnsw06 = request.getParameter("Answ06");
      String sAnsw07 = request.getParameter("Answ07");
      String sAnsw08 = request.getParameter("Answ08");
      String sAnsw09 = request.getParameter("Answ09");
      String sAnsw10 = request.getParameter("Answ10");
      String sFedEx = request.getParameter("FedEx");
      String sAction = request.getParameter("Action");

      if(sName == null){ sName = " "; }
      if(sOrg == null){ sOrg = " "; }
      if(sOrgt == null){sOrgt = " "; }
      if(sMed == null){ sMed = " "; }
      if(sCost == null){ sCost = " "; }
      if(sDati == null || sDati.trim().equals("")){ sDati = "01/01/0001"; }
      if(sCby == null){ sCby = " "; }
      if(sRef == null){ sRef = " "; }
      if(sCon == null){ sCon = " "; }
      if(sTit == null){ sTit = " "; }
      if(sCbus == null){ sCbus = " "; }
      if(sChm == null){ sChm = " "; }
      if(sCfax == null){ sCfax = " "; }
      if(sRmb == null){ sRmb = " "; }
      if(sDuei == null || sDuei.trim().equals("")){ sDuei = "01/01/0001"; }
      if(sPmt1 == null){ sPmt1 = " "; }
      if(sPmt2 == null){ sPmt2 = " "; }
      if(sPmt3 == null){ sPmt3 = " "; }
      if(sPmt4 == null){ sPmt4 = " "; }
      if(sGrp == null){ sGrp = " ";}
      if(sAdd1 == null){ sAdd1 = " ";}
      if(sAdd2 == null){ sAdd2 = " ";}
      if(sCty == null){ sCty = " ";}
      if(sSta == null){ sSta = " ";}
      if(sZip == null){ sZip = " ";}
      if(sPhn == null){ sPhn = " ";}
      if(sFax == null){ sFax = " ";}
      if(sTrpi == null || sTrpi.trim().equals("")){ sTrpi = "01/01/0001";}
      if(sReso == null){ sReso = " ";}
      if(sStri == null || sStri.trim().equals("")){ sStri = "01/01/0001";}
      if(sEndi == null || sEndi.trim().equals("")){ sEndi = "01/01/0001";}
      if(sGrpn == null){ sGrpn = " ";}
      if(sMar == null){ sMar = " ";}
      if(sSchs == null){ sSchs = " ";}
      if(sEdti == null || sEdti.trim().equals("")){ sEdti = "01/01/0001";}
      if(sEtmi == null || sEtmi.trim().equals("")){ sEtmi = "00:00:00";}
      if(sCom == null){ sCom = " ";}
      if(sCom1 == null){ sCom1 = " ";}
      if(sCom2 == null){ sCom2 = " "; }
      if(sDsc == null){ sDsc = " "; }
      if(sCpsi == null || sCpsi.trim().equals("")){ sCpsi = "01/01/0001"; }
      if(sCpei == null || sCpei.trim().equals("")){ sCpei = "01/01/0001"; }
      if(sCtxt == null){ sCtxt = " "; }
      if(sHost == null){ sHost = " "; }
      
      if(sAnsw01 == null){ sAnsw01 = " "; }
      if(sAnsw02 == null){ sAnsw02 = " "; }
      if(sAnsw03 == null){ sAnsw03 = " "; }
      if(sAnsw04 == null){ sAnsw04 = " "; }
      if(sAnsw05 == null){ sAnsw05 = " "; }
      if(sAnsw06 == null){ sAnsw06 = " "; }
      if(sAnsw07 == null){ sAnsw07 = " "; }
      if(sAnsw08 == null){ sAnsw08 = " "; }
      if(sAnsw09 == null){ sAnsw09 = " "; }
      if(sAnsw10 == null){ sAnsw10 = " "; }
      if(sFedEx == null){ sFedEx = " "; }

   //----------------------------------
   // Application Authorization
   //----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=CouponSv.jsp&APPL=ALL&" + request.getQueryString());
}
else
{
      String sUser = session.getAttribute("USER").toString();

      /*System.out.print(sCode + "|" + sName + "|" + sOrg + "|" + sOrgt + "|" + sMed + "|" + sCost + "|"
         + sDati
         + "|" + sCby + "|" + sRef + "|" + sCon + "|" + sTit + "|" + sCbus + "|" + sChm + "|" + sCfax + "|"
         + "|" + sRmb + "|" + sDuei + "|" + sPmt1 + "|" + sPmt2 + "|" + sPmt3 + "|" + sPmt4 + "|" + sGrp + "|" + sAdd1
         + "|" + sAdd2 + "|" + sCty + "|" + sSta + "|" + sZip + "|" + sPhn + "|" + sFax + "|" + sTrpi
         + "|" + sReso + "|" + sStri + "|" + sEndi + "|" + sGrpn + "|" + sMar + "|" + sSchs + "|" + sEdti + "|"
         + sEtmi + "|" + sCom + "|" + sCom1 + "|" + sCom2 + "|" + sDsc + "|" + sCpsi + "|" + sCpei + "|" + sCtxt
         + "|" + sHost + "|" + sAction + "|" + sUser);
       */

      CouponSave cpnsave = new CouponSave();
      cpnsave.saveCoupon(sCode,sName,sOrg,sOrgt,sMed,sCost,sDati,sCby,sRef,sCon,sTit,sCbus,sChm
        ,sCfax,sRmb,sDuei,sPmt1,sPmt2,sPmt3,sPmt4,sGrp,sAdd1,sAdd2,sCty,sSta,sZip,sPhn,sFax,sTrpi
        ,sReso,sStri,sEndi,sGrpn,sMar,sSchs,sEdti,sEtmi,sCom,sCom1,sCom2,sDsc,sCpsi,sCpei,sCtxt
        ,sHost
        ,sAnsw01,sAnsw02,sAnsw03,sAnsw04,sAnsw05,sAnsw06,sAnsw07,sAnsw08,sAnsw09,sAnsw10
        ,sFedEx
        , sAction, sUser);
      if(sAction.equals("ADD"))
      {
        sCode = cpnsave.getCode();
      }
%>

<br><%=sCode%>
<br><%=sName%>
<br><%=sOrg%>
<br><%=sOrgt%>
<br><%=sMed%>
<br><%=sCost%>
<br>Dati = <%=sDati%>
<br><%=sCby%>
<br><%=sRef%>
<br><%=sCon%>
<br><%=sTit%>
<br><%=sCbus%>
<br><%=sChm%>
<br><%=sCfax%>
<br><%=sRmb%>
<br>sDuei = <%=sDuei%>
<br><%=sPmt1%>
<br><%=sPmt2%>
<br><%=sPmt3%>
<br><%=sPmt4%>
<br><%=sGrp%>
<br><%=sAdd1%>
<br><%=sAdd2%>
<br><%=sCty%>
<br><%=sSta%>
<br><%=sZip%>
<br><%=sPhn%>
<br><%=sFax%>
<br><%=sTrpi%>
<br><%=sReso%>
<br>sStri = <%=sStri%>
<br>Endi = <%=sEndi%>
<br><%=sGrpn%>
<br><%=sMar%>
<br><%=sSchs%>
<br>Edti = <%=sEdti%>
<br>Etmi = <%=sEtmi%>
<br><%=sCom%>
<br><%=sCom1%>
<br><%=sCom2%>
<br><%=sDsc%>
<br>Cpsi = <%=sCpsi%>
<br>Cpei = <%=sCpei%>
<br><%=sCtxt%>
<br><%=sHost%>


<SCRIPT language="JavaScript1.2">
  parent.refresh("<%=sCode%>");
</script>
<%
cpnsave.disconnect();
cpnsave = null;
  }%>










