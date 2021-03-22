<%@ page import="org.apache.poi.hssf.usermodel.HSSFWorkbook, java.util.*"%>
<%
   response.setContentType("application/vnd.ms-excel");

   //InputStream myxls = new FileInputStream("workbook.xls");
   HSSFWorkbook wb = new HSSFWorkbook();

   //HSSFSheet sheet = wb.getSheetAt(0);       // first sheet
   //HSSFRow row     = sheet.getRow(2);        // third row
   //HSSFCell cell   = row.getCell((short)3);  // fourth cell
%>