<%@ page import="classreports.ClsSlsFor1Year, java.util.*"%>
<%@ page contentType="application/vnd.ms-excel"%>
<%
    String sYear = request.getParameter("Year");
    String sRepFld = request.getParameter("RepFld");
    session.setMaxInactiveInterval(1200);


//-------------------- populate class/store arrays -----------------------------
     ClsSlsFor1Year sls1Year = new ClsSlsFor1Year(sYear);

     int iNumOfCol = sls1Year.getNumOfCol();
     int iNumOfGrp = sls1Year.getNumOfGrp();
     String [] sColHdg = sls1Year.getColHdg();

     //==========================================================================
     String [] sSelFld = new String[]{ "SLSRET", "SLSCST", "SLSUNT", "GMRAMT", "GMRPRC", "ENDRET",
         "ENDCST", "ENDUNT", "AGERET", "AGECST", "AGEUNT", "AGPRET", "AGPCST", "AGPUNT"};
    //==========================================================================
    String [] sSelFldName = new String[]{"Sales Retail", "Sales Cost", "Sales Unit",
                                      "Gross Margin", "GM %",
                                      "Ending Inv Retail", "Ending Inv Cost", "Ending Inv Unit",
                                      "Aged Inv Retail", "Aged Inv Cost", "Aged Inv Unit",
                                      "Aged Inv Retail %", "Aged Inv Cost %", "Aged Inv Unit %"};
    //==========================================================================
    // check selected data field
    int iSelFld = 0;
    for(int i=0; i < sSelFld.length; i++)
    {
       if(sSelFld[i].equals(sRepFld)){ iSelFld = i; }
    }

    // selected store
    out.print( "Store: ALL\n");
    out.print( "Year: " + sYear + "\n");
    out.print( sSelFldName[iSelFld] + "\n");

    // Column name
    out.print( "\nDiv\tDiv Name");

    for (int i=0; i < iNumOfCol ;i++)
    {
      out.print("\t" + sColHdg[i]);
    }
    out.print("\n");

    String [] sData = null;
    //======================================================================
    // Data
    //======================================================================
    for(int i=0; i < iNumOfGrp; i++)
    {
       sls1Year.getGMData();
       String sGroup = sls1Year.getGrp();
       String sGrpName = sls1Year.getGrpName();

       String [] sRet = sls1Year.getRet();
       String [] sCost = sls1Year.getCost();
       String [] sUnit = sls1Year.getUnit();
       String [] sGrsMrg = sls1Year.getGrsMrg();
       String [] sGrsMrgPrc = sls1Year.getGrsMrgPrc();
       String [] sNetRet = sls1Year.getNetRet();
       String [] sEIRet = sls1Year.getEIRet();
       String [] sEICost = sls1Year.getEICost();
       String [] sEIUnit = sls1Year.getEIUnit();
       String [] sAIRet = sls1Year.getAIRet();
       String [] sAICost = sls1Year.getAICost();
       String [] sAIUnit = sls1Year.getAIUnit();
       String [] sAPRet = sls1Year.getAPRet();
       String [] sAPCost = sls1Year.getAPCost();
       String [] sAPUnit = sls1Year.getAPUnit();

       if(iSelFld==0){ sData = sRet; }
       else if(iSelFld == 1){ sData = sCost; }
       else if(iSelFld == 2){ sData = sUnit; }
       else if(iSelFld == 3){ sData = sGrsMrg; }
       else if(iSelFld == 4){ sData = sGrsMrgPrc; }
       else if(iSelFld == 5){ sData = sNetRet; }
       else if(iSelFld == 6){ sData = sEIRet; }
       else if(iSelFld == 7){ sData = sEICost; }
       else if(iSelFld == 8){ sData = sEIUnit; }
       else if(iSelFld == 9){ sData = sAIRet; }
       else if(iSelFld == 10){ sData = sAICost; }
       else if(iSelFld == 11){ sData = sAIUnit; }
       else if(iSelFld == 12){ sData = sAPRet; }
       else if(iSelFld == 13){ sData = sAPCost; }
       else if(iSelFld == 14){ sData = sAPUnit; }

       out.print("\n" + sGroup + "\t" + sGrpName);
       for(int j=0; j < sColHdg.length; j++)
       {
          out.print("\t" + sData[j] );
       }
    }
    //======================================================================
    sls1Year.disconnect();
    sls1Year = null;
%>

