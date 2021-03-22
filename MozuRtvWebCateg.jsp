<%@ page import="rciutility.RunSQLStmt, rciutility.CallAs400SrvPgmSup, java.sql.*,java.text.*, java.util.*"%>
<%   
	String sSite = request.getParameter("Site");
//----------------------------------
// Application Authorization
//----------------------------------
if  (session.getAttribute("USER")!=null)
{  	
	/*
	
	*/
	
	/*String sStmt = " with cat12f as (" 
		+ "	select casite, caid, cacode" 
		+ ", (select b.caid from rci.Mocateg b where a.caparid=b.caid  fetch first 1 row only) as categ2" 
		+ ", (select b.caparid from rci.Mocateg b where a.caparid=b.caid  fetch first 1 row only) as categ2par" 
		+ "	from rci.MOCATEG a where casite='" + sSite + "'"
		//+ "inner join table(select  cscat from rci.MoCatCls group by cscat)" 
		//+ " as catcls on a.caid=cscat"
		+ "), cat123f as ("
		+ "	select casite, caid, cacode, categ2"
		+ ", (select b.caid from rci.Mocateg b where a.casite = b.casite and a.categ2par=b.caid  fetch first 1 row only) as categ1"
		+ "	from cat12f a)"
		+ "	select caid"
		+ ", (select b.cacode from rci.Mocateg b where a.casite = b.casite and a.categ1=b.caid  fetch first 1 row only) as categ1"
		+ ", (select b.cacode from rci.Mocateg b where a.casite = b.casite and a.categ2=b.caid  fetch first 1 row only) as categ2"
		+ ", cacode"
		+ "	from cat123f a"
		+ " where caid not in (775,193) and (categ1 in (775,193) or categ2 in (775,193) )" 
		+ " and categ1 is not null"
		+ " order by categ1, categ2, cacode"
	;*/
	
	String sStmt = "with cat1f as (" 
	  + " select casite, caid, cacode as code1, caid as categ1, caparid as categ1par"
	  + " from rci.MOCATEG a where casite='" + sSite + "' and caid in (775,193,845) "
	  + "), cat2f as ("
	  + " select a.casite, a.categ1, a.categ1par, b.caid as categ2, b.caparid as categ2par"
	  + ", code1, b.cacode as code2"
	  + " from cat1f a left join rci.MOCATEG b on b.casite=a.casite and b.caparid=a.categ1"
	  + " where a.casite='" + sSite + "'" 
	  + ")  , cat3f as (" 
	  + " select a.casite, categ1par, categ1, categ2par,  categ2, code1, code2" 
	  + ", b.caid as categ3, b.caparid as categ3par, b.cacode as code3" 
	  + " from cat2f a left join rci.MOCATEG b on b.casite=a.casite and b.caparid=a.categ2" 
	  + " where a.casite='" + sSite + "'" 
	  + ")  , cat4f as (" 
	  + " select a.casite, categ1par, categ1, categ2par,  categ2, categ3par,  categ3, code1, code2, code3" 
	  + ", b.caid as categ4, b.caparid as categ4par, b.cacode as code4" 
	  + " from cat3f a left join rci.MOCATEG b on b.casite=a.casite and b.caparid=a.categ3" 
	  + " where a.casite='" + sSite + "'" 
	  + ")  , cat5f as (" 
	  + " select a.casite, categ1par, categ1, categ2par,  categ2, categ3par,  categ3, categ4par,  categ4, code1, code2, code3, code4" 
	  + ", b.caid as categ5, b.caparid as categ5par, b.cacode as code5" 
	  + " from cat4f a left join rci.MOCATEG b on b.casite=a.casite and b.caparid=a.categ4" 
	  + " where a.casite='" + sSite + "'" 
	  + ")" 
	  + " select casite, categ1par, categ1, categ2par,  categ2, categ3par, categ3, categ4par, categ4, categ5par, categ5, code1, code2, code3, code4, code5" 
	  //+ " from cat5f a where categ2 not in(802, 803, 804, 805)"
	  + " from cat5f a "
		;
	System.out.println(sStmt);
	RunSQLStmt sql_Categ = new RunSQLStmt();
	sql_Categ.setPrepStmt(sStmt);
	ResultSet rs_Categ = sql_Categ.runQuery();
	
	Vector<String> vCateg1 = new Vector<String>();
	Vector<String> vCateg2 = new Vector<String>();
	Vector<String> vCateg3 = new Vector<String>();
	Vector<String> vCateg4 = new Vector<String>();
	Vector<String> vCateg5 = new Vector<String>();
	
	Vector<String> vCode1 = new Vector<String>();
	Vector<String> vCode2 = new Vector<String>();
	Vector<String> vCode3 = new Vector<String>();
	Vector<String> vCode4 = new Vector<String>();
	Vector<String> vCode5 = new Vector<String>();
	
	while(sql_Categ.readNextRecord())
	{
		String categ1 = sql_Categ.getData("categ1");
		if(categ1 != null)
		{ 			
			categ1 = categ1.replace("'", "&quote;");
			vCateg1.add(categ1.toString().trim());
			vCode1.add(sql_Categ.getData("code1").trim());
		}
		else { vCateg1.add(""); vCode1.add("");}
		
		String categ2 = sql_Categ.getData("categ2");
		if(categ2 != null)
		{ 
			categ2 = categ2.replace("'", "&quote;");
			vCateg2.add(categ2.toString().trim()); 
			vCode2.add(sql_Categ.getData("code2").trim());
		}
		else { vCateg2.add(""); vCode2.add(""); }
		
		String categ3 = sql_Categ.getData("categ3");
		if(categ3 != null)
		{ 
			categ3 = categ3.replace("'", "&quote;");
			vCateg3.add(categ3.toString().trim());
			vCode3.add(sql_Categ.getData("code3").trim());
		}
		else { vCateg3.add(""); vCode3.add(""); }
		
		String categ4 = sql_Categ.getData("categ4");
		if(categ4 != null)
		{ 
			categ4 = categ4.replace("'", "&quote;");
			vCateg4.add(categ4.toString().trim());
			vCode4.add(sql_Categ.getData("code4").trim());
		}
		else { vCateg4.add("");  vCode4.add("");}

		String categ5 = sql_Categ.getData("categ5");
		if(categ5 != null)
		{ 
			categ5 = categ4.replace("'", "&quote;");
			vCateg5.add(categ5.toString().trim());
			vCode5.add(sql_Categ.getData("code5").trim());
		}
		else { vCateg5.add(""); vCode5.add("");}
	}
	sql_Categ.disconnect();
	
	String [] sCateg1 = new String[]{};
	String [] sCateg2 = new String[]{};
	String [] sCateg3 = new String[]{};
	String [] sCateg4 = new String[]{};
	String [] sCateg5 = new String[]{};
	
	String [] sCode1 = new String[]{};
	String [] sCode2 = new String[]{};
	String [] sCode3 = new String[]{};
	String [] sCode4 = new String[]{};
	String [] sCode5 = new String[]{};
		
	sCateg1 = vCateg1.toArray(new String[]{});
	sCateg2 = vCateg2.toArray(new String[]{});
	sCateg3 = vCateg3.toArray(new String[]{});
	sCateg4 = vCateg4.toArray(new String[]{});
	sCateg5 = vCateg5.toArray(new String[]{});
	
	sCode1 = vCode1.toArray(new String[]{});
	sCode2 = vCode2.toArray(new String[]{});
	sCode3 = vCode3.toArray(new String[]{});
	sCode4 = vCode4.toArray(new String[]{});
	sCode5 = vCode5.toArray(new String[]{});
	
	String [] sCateg = new String[sCateg1.length];
	String [] sCode = new String[sCateg1.length]; 
	
	String sep = "";
	for(int i=0; i < sCateg1.length; i++)
	{
		sCateg[i] = "";
		sep = "";
		if(!sCateg1[i].equals("")){ sCode[i] = sCode1[i]; sep = " > "; sCateg[i] = sCateg1[i]; }
		if(!sCateg2[i].equals("")){ sCode[i] += sep + sCode2[i]; sep = " > "; sCateg[i] = sCateg2[i];  }
		if(!sCateg3[i].equals("")){ sCode[i] += sep + sCode3[i]; sep = " > "; sCateg[i] = sCateg3[i];  }
		if(!sCateg4[i].equals("")){ sCode[i] += sep + sCode4[i]; sep = " > "; sCateg[i] = sCateg4[i];  }
		if(!sCateg5[i].equals("")){ sCode[i] += sep + sCode5[i]; sep = " > "; sCateg[i] = sCateg5[i];  }
	}
%>
	
<SCRIPT>	
   var categ = new Array();
   var code = new Array();
   
   <%for(int i=0; i < sCateg.length; i++){%>
   	   categ[categ.length] = "<%=sCateg[i]%>";
       code[code.length] = "<%=sCode[i]%>";
   <%}%>
   
   parent.showWebCateg(categ, code);
   
</SCRIPT>
<%}
  else {%>
  <SCRIPT language="JavaScript1.2">
      alert("Your internet session is expired.\nPlease refresh the screen and enter your ID and pasword.\nThe data you entered was not saved.");
  </SCRIPT>
  <%}%>

