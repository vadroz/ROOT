<%@ page import=" rciutility.ClassSelect, rciutility.StoreSelect"%>
<% ClassSelect select = null;
   String sMode = request.getParameter("mode");
   if(sMode==null) sMode="1";

   String sDiv = null;
   String sDivName = null;
   String sDpt = null;
   String sDptName = null;
   String sDptGroup = null;
   String sCls = null;
   String sClsName = null;
   String sWkDate = null;
   String sWkDateDsc = null;
   String sMnDate = null;
   String sMnDateDsc = null;
   String sYrDate = null;
   String sYrDateDsc = null;


   if (sMode.equals("1")) {
     select = new ClassSelect();
     sDiv = select.getDivNum();
     sDivName = select.getDivName();
     sDpt = select.getDptNum();
     sDptName = select.getDptName();
     sDptGroup = select.getDptGroup();
     sWkDate = select.getWkDate();
     sWkDateDsc = select.getWkDateDsc();
     sMnDate = select.getMnDate();
     sMnDateDsc = select.getMnDateDsc();
     sYrDate = select.getYrDate();
     sYrDateDsc = select.getYrDateDsc();
   }

   // select class
   if (sMode.equals("2")) {
     select = new ClassSelect(request.getParameter("DIVISION"),
                            request.getParameter("DEPARTMENT"));
     sCls = select.getClsNum();
     sClsName = select.getClsName();
   }

   StoreSelect StrSelect = null;
   String sStr = null;
   String sStrName = null;

   StrSelect = new StoreSelect();
   sStr = StrSelect.getStrNum();
   sStrName = StrSelect.getStrName();
%>

<script name="javascript">
setDivDptCls();
//==============================================================================
// run on loading
//==============================================================================
function setDivDptCls(){
  var mode= <%=sMode%>;
  var str = [<%=sStr%>];
  var strNames = [<%=sStrName%>];

  var div = null;
  var divNames = null;
  var dpt = null;
  var dptNames = null;
  var dpt_div = null;
  var cls = null;
  var clsNames = null;

  if (mode =='1')
  {
     div = [<%=sDiv%>];
     divNames = [<%=sDivName%>];
     dpt = [<%=sDpt%>];
     dptNames = [<%=sDptName%>];
     dpt_div = [<%=sDptGroup%>];
  }
  else
  {
     cls= [<%=sCls%>];
     clsNames = [<%=sClsName%>];
  }


  parent.popDivDptCls(mode, div, divNames, dpt, dptNames, dpt_div, cls, clsNames, str, strNames);

}

</script>