<%@ page import=" itemtransfer.ItemTrfBachList, java.util.*"%>
<%
    String sSts = request.getParameter("Sts");
    String sUser = session.getAttribute("USER").toString();
    if(sSts==null){sSts = "O";}

    ItemTrfBachList itrfbatch = new ItemTrfBachList(sSts, "Batch", sUser);
    int iNumOfBch = itrfbatch.getNumOfBch();
    String sBatch = itrfbatch.getBatchJsa();
    String sBComment = itrfbatch.getBCommentJsa();
    String sBCrtDate = itrfbatch.getBCrtDateJsa();
    String sBCrtByUser = itrfbatch.getBCrtByUserJsa();
    String sBWrhse = itrfbatch.getBWrhseJsa();
%>

<script name="javascript1.2">
var Batch = [<%=sBatch%>];
var BComment = [<%=sBComment%>];
var BCrtDate = [<%=sBCrtDate%>];
var BCrtByUser = [<%=sBCrtByUser%>];
var BWhse = [<%=sBWrhse%>];

parent.showBatch(Batch, BWhse, BComment, BCrtDate, BCrtByUser);

//==============================================================================
// run on loading
//==============================================================================

</script>