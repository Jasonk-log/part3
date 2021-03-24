<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.sql.ResultSet" %>
<%@ page import = "java.sql.ResultSetMetaData" %>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.DatabaseMetaData" %>
<%@ page import = "java.sql.SQLException" %>

<%@ page import = "org.json.simple.JSONArray" %>
<%@ page import = "org.json.simple.JSONObject" %>
<%@ page import = "org.json.simple.parser.JSONParser" %>
<%@ page import = "org.json.simple.parser.ParseException" %>
<%
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
		JSONObject jo = null;
		ResultSetMetaData rmd = null;
		//JSONArray jary = new JSONArray();
		
        try{
        String url = "jdbc:mysql://mysql:3306/mydb";
        String id = "root";
        String pw = "root";
        Class.forName("com.mysql.jdbc.Driver");
        conn=DriverManager.getConnection(url,id,pw);
        String sql = "select name, unitprice from parts where name='part3'";
        DatabaseMetaData meta = conn.getMetaData();
        pstmt = conn.prepareStatement(sql);
        pstmt.executeQuery();
        rs = pstmt.executeQuery();
        while (rs.next()){
		jo = new JSONObject();
		rmd = rs.getMetaData();
		for (int i=1; i<=rmd.getColumnCount(); i++) {
			jo.put(rmd.getColumnName(i),rs.getString(rmd.getColumnName(i)));
		}
		//jary.put(jo);
                //out.print(rs.getString(1));
        }
        out.print("<b><i>Query("+sql+") Result</b><br><br>");
		out.print("JSON: <br>" + jo.toString());
        }catch(Exception e){
			e.printStackTrace();
		}
		finally{
        if(pstmt != null) try{pstmt.close();}catch(SQLException sqle){}
        if(conn != null) try{conn.close();}catch(SQLException sqle){}
        }
%>