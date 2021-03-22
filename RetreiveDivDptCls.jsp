<%@ page import=" rciutility.ClassSelect, java.util.*"%>
<%
     String sDivision = request.getParameter("Division");
     String sDepartment = request.getParameter("Department");
     String sInfo = request.getParameter("Info");
     if(sInfo==null) sInfo = "CLASS";


     String sCls = null;
     String sClsName = null;
     String sDiv = null;
     String sDivName = null;
     String sDpt = null;
     String sDptName = null;
     String sDptGroup = null;

     if(sInfo.equals("CLASS"))
     {
        ClassSelect select = new ClassSelect(sDivision, sDepartment);
        sCls = select.getClsNum();
        sClsName = select.getClsName();
     }
     else
     {
        ClassSelect  select = new ClassSelect();
        sDiv = select.getDivNum();
        sDivName = select.getDivName();
        sDpt = select.getDptNum();
        sDptName = select.getDptName();
        sDptGroup = select.getDptGroup();
     }
%>

<script name="javascript1.2">
var Info = "<%=sInfo%>";
var classes = null;
var clsNames = null;
var Div = null;
var DivName = null;
var Dpt = null;
var DptName = null;
var DptGroup = null;

if(Info=="CLASS")
{
   classes = [<%=sCls%>];
   clsNames = [<%=sClsName%>];
   parent.showClasses(classes, clsNames);
}
else
{
   Div = [<%=sDiv%>];
   DivName = [<%=sDivName%>];
   Dpt = [<%=sDpt%>];
   DptName = [<%=sDptName%>];
   DptGroup = [<%=sDptGroup%>];
   parent.showDivDpt(Div, DivName, Dpt, DptName, DptGroup);
}

//==============================================================================
// run on loading
//==============================================================================

</script>