<%@ page import="menu.*, java.util.*"%>
<%
  String sUser = session.getAttribute("USER").toString();

  boolean bSecure = false;

    if (sUser.length() == 7 && sUser.trim().substring(0, 5).equals("cashr")
       || session.getAttribute("BASIC")==null) { bSecure = true;  }

    MainMenu menu = new MainMenu(sUser);
    int iNumOfMenu = menu.getNumOfMenu();
    String [] sMenu = menu.getMenu();
    String [] sUrl = menu.getUrl();
    String [] sType = menu.getType();

    int [] iNumOfChild = menu.getNumOfChild();
    String [][] sChildMenu = menu.getChildMenu();
    String [][] sChildUrl = menu.getChildUrl();
    String [][] sChildType = menu.getChildType();

    menu.disconnect();

    // All menu options
    MenuTableOfContent menuAll = new MenuTableOfContent(sUser);
    int iNumOfAllMenu = menuAll.getNumOfMenu();
    String [] sAllMenu = menuAll.getMenu();
    int [] iAllLevel = menuAll.getLevel();
    String [] sAllUrl = menuAll.getUrl();
    String [] sAllType = menuAll.getType();
    menuAll.disconnect();
%>
<script>
var initNumMenu = <%=iNumOfMenu%>;
</script>

<!-------------------------------------------------------------------->
<!-------------------------------------------------------------------->
<!-------------------------------------------------------------------->
<!-- ================================================================ -->
<!--                 Main Panel -->
<!-- ================================================================ -->
<table class="panel" CELLSPACING="10" CELLPADDING="0">
 <tr>
  <td valign="top" id="tdMenu">
   <table class="panel"  id="tblMenu" CELLSPACING="10" CELLPADDING="0">
      <%int iTd = 0;%>
      <%for(int i=0; i < iNumOfMenu; i++){%>
        <%if(iTd == 0){%><tr><%}%>
           <td  class="panel<%if(i < 19){%><%=i%><%} else {%><%=(i - 20)%><%}%>">
             <span class="menu" onClick="switch_On_Off_SubMenu(<%=i%>)"><%=sMenu[i]%></span>

             <table id="tblMenu<%=i%>" class="menu" CELLSPACING="0" CELLPADDING="0">
               <!-- -----------  menu option ------------------------------  -->
               <!-- if main menu option is URL duplicate as menu option -->
               <%if(iNumOfChild[i]==0 && sType[i].equals("1")){%>
                   <tr><td class="menu1" onmouseover="hilightOpt(this, true, '<%=sUrl[i]%>');" onmouseout="hilightOpt(this, false)"
                    onClick="click_On_Menu('<%=sMenu[i]%>', '<%=sType[i]%>', '<%=sUrl[i]%>', this)" nowrap>
                     &nbsp;&nbsp;<%=sMenu[i]%></td><tr>
               <%}
               else if(iNumOfChild[i]==0 && sType[i].equals("0")){%>
                    <tr><td class="menu1" onmouseover="hilightOpt(this, true);" onmouseout="hilightOpt(this, false)"  nowrap>
                     &nbsp;&nbsp;<i>future use</i></td><tr>
               <%}%>

               <!-- -----------  2nd level menu option ------------------------------  -->
               <%for(int j=0; j < iNumOfChild[i]; j++) {%>
                  <tr><td class="menu1" onmouseover="hilightOpt(this, true, '<%=sChildUrl[i][j]%>');" onmouseout="hilightOpt(this, false)"
                    onClick="click_On_Menu('<%=sChildMenu[i][j]%>', '<%=sChildType[i][j]%>', '<%=sChildUrl[i][j]%>', this)"  nowrap>
                     &nbsp;&nbsp;<%=sChildMenu[i][j]%></td><tr>
               <%}%>
             </table>
         </td>
       <%if(iTd == 3){ iTd = 0;%></tr><%} else iTd++;%>
      <%}%>
     <!-- ================================================================ -->
    </table>
  </td>
 </tr>
 <!-- ================================================================ -->
 <!--                 Table of Contents -->
 <!-- ================================================================ -->
    <tr>
      <td valign="top" id="tdAllMenu">
       <u><b>Table of Contents</b></u>
       <table id="tblAllMenu" class="menu" CELLSPACING="0" CELLPADDING="0">
         <%for(int i=0; i < iNumOfAllMenu; i++) {%>
            <tr>
              <td class="menu1">
                <%if(iAllLevel[i]==0) {%><br><%}%>
                <%for(int j=0; j < iAllLevel[i] * 10; j++) {%>&nbsp;<%}%>&nbsp;
                <%if(sAllType[i].equals("1")){%><a href="javascript:runUrl('<%=sAllUrl[i]%>','<%=sAllMenu[i]%>')"><%=sAllMenu[i]%></a><%}
                  else {%><%=sAllMenu[i]%><%}%>
              </td>
            </tr>
         <%}%>
       </table>
    </td>
  </tr>
</table>