<%@ page import="posend.POPrint, posend.PDFRender, java.io.*"%>
<%@ page contentType="application/pdf"%>
<%
  try {
            System.out.println("<h1>Test PDF Rendering by FOP</h1><br>");
            System.out.println("FOP PDFRender<br>");
            System.out.println("Preparing...");

            PDFRender app = new PDFRender();

            //Setup input stream
            String xmlfo = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
            + "<fo:root xmlns:fo=\"http://www.w3.org/1999/XSL/Format\">"
            + "<fo:layout-master-set>"
            + "<fo:simple-page-master master-name=\"simpleA4\" page-height=\"29.7cm\" page-width=\"21cm\" margin-top=\"2cm\" margin-bottom=\"2cm\" margin-left=\"2cm\" margin-right=\"2cm\">"
            + "<fo:region-body/>"
            + "</fo:simple-page-master>"
            + "</fo:layout-master-set>"
            + "<fo:page-sequence master-reference=\"simpleA4\">"
            + "<fo:flow flow-name=\"xsl-region-body\">"
            + "<fo:block>Hello World!</fo:block>"
            + "</fo:flow>"
            + "</fo:page-sequence>"
            + "</fo:root>";

            System.out.println("<br>Input: XSL-FO (" + xmlfo + ")");
            System.out.println("<br>Transforming...<br><br>");

            app.convertFO2PDF(xmlfo, response.getOutputStream());

            System.out.println("<br>Success!");
        } catch (Exception e) {
            System.out.println("<br> ---- Error:\n");
            e.printStackTrace();
        }
        System.out.println("<br>End of Transfers");
        out.flush();
%>

