<%@page import="java.sql.*"%>
<jsp:useBean id="i" class="exam.info" scope="session"/>
<jsp:setProperty name="i" property="*" /> 
<%
String name=request.getParameter("uname");
String pass=request.getParameter("upass");
String email=request.getParameter("uemail");
String mobno=request.getParameter("uno");
String city=request.getParameter("ucity");
String access=request.getParameter("acc");
//out.println(name+"\n"+pass+"\n"+mobno+"\n"+city+"\n"+email);
try
{
	Class.forName("com.mysql.cj.jdbc.Driver");
Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/data","root","1234");
Statement stmt=con.createStatement();  
//String sql="insert into member values('haris','haris@123.com','1234','9876543210','city')";
//PreparedStatement stmt=con.prepareStatement(sql);
//int num=stmt.executeUpdate();
if(access.equals("student")){
	int num = stmt.executeUpdate("INSERT INTO `member` (`name`, `email`, `pass`, `mbno`, `city`) VALUES ('"+name+"', '"+email+"', '"+pass+"', '"+mobno+"', '"+city+"');");	
	if(num!=0)
	{
		i.setAccess("student");
		%>
		<jsp:forward page="index.html"/>
		<%
	}
}
else if(access.equals("admin")){
	int num = stmt.executeUpdate("INSERT INTO `admin` (`name`, `email`, `pass`, `mbno`, `city`) VALUES ('"+name+"', '"+email+"', '"+pass+"', '"+mobno+"', '"+city+"');");	
	if(num!=0)
	{
		i.setAccess("admin");
		%>
		<jsp:forward page="index.html"/>
		<%
	}	
}
else
{
	%>
	Sorry Try Again!!
	<jsp:forward page="signup.html"/>
	<%
}
//<jsp:include page="home.jsp"/>
//<jsp:forward page="home.jsp"/>
con.close();
}
catch(Exception e)
{
	out.println(e);
}
%>