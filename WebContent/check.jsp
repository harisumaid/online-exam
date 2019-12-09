<%@page import="java.sql.*"%>
<%
int uid=Integer.parseInt(request.getParameter("uid"));
Class.forName("com.mysql.jdbc.Driver");
Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/data","root","1234");
int c=0;
try
{
	String sql="select * from `creport` where `uid`="+uid;
	//String sql="select * from member_id"+uid;
	PreparedStatement ps=con.prepareStatement(sql);
	ResultSet rs=ps.executeQuery();
	if(!rs.next()){
		%>
		<jsp:forward page="startctest.jsp">
			<jsp:param value="<%= uid%>" name="uid"/>
		</jsp:forward>
		<%	
	}
	else{
		%>
		<jsp:forward page="NewFile.jsp">
			<jsp:param value="<%= uid%>" name="uid"/>
		</jsp:forward>
		<%
	}
}
catch(Exception e)
{
	System.out.println("Exception:   "+e);
}

%>