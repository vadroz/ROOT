<%@ page import="java.util.*, java.text.*, java.io.* ,ecommerce.EComShopOrdLst, ecommerce.EcShopCrtXmlFile"%>
<%@ page contentType="text/xml"%>
<%
    EComShopOrdLst shopord = new EComShopOrdLst();
    String sBatch = shopord.getBatch();

    System.out.println("Shopotron Ready Order Request. Batch: " + sBatch);

    EcShopCrtXmlFile popXmlFile = new EcShopCrtXmlFile(sBatch);

    BufferedReader br = request.getReader();
    String sLine = null;
    String sXml = "";
    while ((sLine = br.readLine()) != null)
    {
      shopord.saveXML(sLine);
      popXmlFile.writeData(sLine);
    }
    shopord.endProcess();
    shopord.disconnect();
    shopord = null;

    popXmlFile.closeFile();
    popXmlFile = null;

    //EComShopParseItems shopparse = new EComShopParseItems(sBatch);
    //shopparse.disconnect();
    //shopparse = null;
%>
