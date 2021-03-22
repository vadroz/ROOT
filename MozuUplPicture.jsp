<%@ page import="com.test.api.MozuUplPicture,com.test.api.CreateParent
   , mozu_com.MozuImageSave, java.util.*"%>
<%
   String sSite = request.getParameter("Site");
   String sCls = request.getParameter("Cls");
   String sVen = request.getParameter("Ven");
   String sSty = request.getParameter("Sty");
   String [] sSeq = request.getParameterValues("Seq");   
   String [] sFile = request.getParameterValues("File"); 
   String [] sName = request.getParameterValues("Name");
   String [] sComment = request.getParameterValues("Comment");   
   String [] sClrId = request.getParameterValues("ClrId");
   String [] sType = request.getParameterValues("Type");
   String sKiboProd = request.getParameter("KiboProd");
   String sAction = request.getParameter("Action");
  
//--------------------------------
// Application Authorization
//----------------------------------
if  (session.getAttribute("USER")!=null && session.getAttribute("ECOMMERCE")!=null)
{ 	
	String sUser = session.getAttribute("USER").toString();
	
	try 
	{
		MozuImageSave imgsv = new MozuImageSave();
		String sProd = sCls + sVen + sSty;
		if(sAction.equals("UPLOAD"))
		{
			System.out.println("Start Upload");
			System.out.println(sFile[0] + "|" + sKiboProd + "|" + sName[0] + "|" + sComment[0]);
			try
			{
				MozuUplPicture uplpic = new MozuUplPicture(sFile, sKiboProd, sName, sComment, sSeq);
				System.out.println("End Upload");
			}
			catch(Exception e)
			{
				System.out.println("Error - MozuUplPicture.jsp(load): ");
				e.printStackTrace();
			}
			// remove wait to upload flag 
			for(int i=0; i < sSeq.length; i++)		
			{	
				imgsv.saveImage(sCls,  sVen,  sSty, sSeq[i], sFile[i], sComment[i]
						, sClrId[i], sType[i], sAction, sUser);
			}
		}
		else if(sAction.equals("DLT"))
		{
			System.out.println(sAction + "  Type=" + sType);
			MozuUplPicture uplpic = new MozuUplPicture();
			uplpic.deletePic(sName[0], sProd);
			imgsv.saveImage(sCls,  sVen,  sSty, sSeq[0], sFile[0], sComment[0], sClrId[0]
					, sType[0], sAction, sUser);
		}
		else if(sAction.equals("UPD"))
		{
			MozuUplPicture uplpic = new MozuUplPicture();
			uplpic.updatePic(sName[0], sProd, sComment[0]);
			imgsv.saveImage(sCls,  sVen,  sSty, sSeq[0], sFile[0], sComment[0]
					, sClrId[0], sType[0], sAction, sUser);
		}
		else if(sAction.equals("UPDIMGMAP"))
		{
			String sClrImgMap = "";
			String sSizImgMap = "";
			String sClrSep = "";
			String sSizSep = "";
			boolean bColor = false;
			boolean bSize = false;
			
			System.out.println(sAction + " len=" + sSeq.length);
			// remove wait to upload flag 
			for(int i=0; i < sSeq.length; i++)
			{ 
				//System.out.println("|" + sType[i] + "|");
				if(sType[i].equals("Color"))
				{ 
					sClrImgMap += sClrSep + sClrId[i] + ":" + sName[i];
					bColor = true;
					sClrSep = "|";
				}
				if( sType[i].equals("Size"))
				{ 					
					sSizImgMap += sSizSep + sClrId[i] + ":" + sName[i];
					bSize = true;
					sSizSep = "|";					
				}
			}
			System.out.println("sClrImgMap=" + sClrImgMap + "| Date=" + (new Date()) + "| user=" + sUser);
			System.out.println("sSizImgMap=" + sSizImgMap + "| Date=" + (new Date()) + "| user=" + sUser);
			
			CreateParent crtpar = new CreateParent(sSite);
			System.out.println("MozuUplPicture" + sKiboProd);
			if(crtpar.getExistProduct(sKiboProd))
			{			
				if(bColor)
				{
					crtpar.setProdProp("tenant~product-image-map", new String[]{sClrImgMap});
				}
				if(bSize)
				{
					crtpar.setProdProp("tenant~product-size-image-map", new String[]{sSizImgMap});
				}
				
				crtpar.updProd();
			}
			crtpar = null;
		}		
		imgsv.disconnect();
		imgsv = null;
	} catch (Exception e)    
	{
		System.out.print("Error - MozuUplPicture.jsp(end):");
		e.printStackTrace();
		System.out.println("|");
	}
		
%>
<SCRIPT language="JavaScript1.2">
   goBack();
//==============================================================================
// send employee availability to schedule
//==============================================================================
   function goBack()
   {
	   parent.location.reload(); 
   }
   </SCRIPT>  
<%}
  else {%>
  <SCRIPT language="JavaScript1.2">
     alert("Your internet session is expired.\nPlease refresh the screen and enter your ID and pasword.\nThe data you entered was not saved.");
     </SCRIPT>
<%}%>








