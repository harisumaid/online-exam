<%@page import="exam.ques"%>
<%@page import="java.util.Vector"%>
<%@page import="java.sql.*"%>
<%@page import="exam.info"%>
<jsp:useBean id="i" class="exam.info" scope="session"/>
<jsp:include page="cques.jsp"/>
<%
String gemail=(String)session.getAttribute("uemail");
String gpass=(String)session.getAttribute("upass");
if(gemail.equals("null") && gpass.equals("null"))
{
	%>
	<jsp:forward page="index.html"/>
	<%	
}
try
{
Class.forName("com.mysql.jdbc.Driver");
Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/data","root","1234");


int uid=0;
if(i.getAccess().equals("admin"))
{
	uid=Integer.parseInt(request.getParameter("x"));
}
else
{
	uid=i.getId();	
}
//System.out.println(uid);

String sql1="select * from `creport` where `uid`=?";
PreparedStatement ps1=con.prepareStatement(sql1);
ps1.setInt(1,uid);
ResultSet rs1=ps1.executeQuery();


%>



<!DOCTYPE html>
<html lang="en">
<head>
  <title>REPORT CARD</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<style>
.jumbotron { 
  padding: 5px 0px 5px 0px;
  margin: 5% 0% 2% 0%;
    background-color: grey; /* Orange */
    color: #ffffff;
}
body {
    background-color: #222930;
    color: #ffffff;
}
.navbar-default {
    background-color: #AC2832;
    border-color: #AC2832;
}
 .navbar-default .navbar-nav > .active{
     color: #ffffff;
      background: #E3AE57;
 }
 .navbar-default .navbar-nav > .active > a, 
 .navbar-default .navbar-nav > .active > a:hover, 
 .navbar-default .navbar-nav > .active > a:focus {
      color: #ffffff;
      background: #E3AE57;
 }
.nav.navbar-nav li a {
   color: #fff;
 }

.navbar-default .navbar-brand {
    color: #d6d6d6;
}
.navbar-default .navbar-nav .open .dropdown-menu>li>a, .navbar-default .navbar-nav .open .dropdown-menu {
    background-color: #AC2832;
    color:#ffffff;
  }
</style>
<body>

<%
if(i.getAccess().equals("student"))
{

%>
    <nav class="navbar navbar-default">
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
      <a class="navbar-brand" href="#">WebSiteName</a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav">   
     
<li><a href="home.jsp">HOME</a></li>
                <li><a href="info.jsp">INFO</a></li>
        <li class="dropdown">
          <a class="dropdown-toggle" data-toggle="dropdown" href="#">TEST<span class="caret"></span></a>
          <ul class="dropdown-menu">
            <li><a href="check.jsp?uid=<%=uid%>">C</a></li>
            <li><a href="#">JAVA</a></li>
          </ul>
        </li>
        <li class="active"><a href="reportcques.jsp">REPORT</a></li>
      </ul>
      <ul class="nav navbar-nav navbar-right">
        <li><a href="logout.jsp"><span class="glyphicon glyphicon-log-out"></span>LOGOUT</a></li>
      </ul>
    </div>
  </div>
</nav>
<%
}
else
{
	%>
	
	<nav class="navbar navbar-default">
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
      <a class="navbar-brand" href="#">WebSiteName</a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav">
        <li><a href="adminhome.jsp">HOME</a></li>
                <li><a href="info.jsp">INFO</a></li>
                <li class="active"><a href="stuinfo.jsp">STUDENT</a></li>
        <li class="dropdown">
          <a class="dropdown-toggle" data-toggle="dropdown" href="#">QESTIONS<span class="caret"></span></a>
          <ul class="dropdown-menu">
            <li><a href="#>">C</a></li>
            <ul class="dropdown-submenu">
            <li><a href="createques.html"><small>CREATE QUESTION</small></a></li>
            <li><a href="showadques.jsp"><small>SHOW QUESTION</small></a></li>
            <li><a href="upques.jsp"><small>UPDATE QUESTION</small></a></li>
            <li><a href="delques.jsp"><small>DELETE QUESTION</small></a></li>
          </ul>
            <li><a href="#">JAVA</a></li>
          </ul>
        </li>
      </ul>
      <ul class="nav navbar-nav navbar-right">
        <li><a href="logout.jsp"><span class="glyphicon glyphicon-log-out"></span> LOGOUT</a></li>
      </ul>
    </div>
  </div>
</nav>
  
	
	
	<%
	
}
%>

<div class="container">
  <CENTER><h1>REPORT CARD</h1></CENTER><br><br>


<%







if(rs1.next())
{
	int right=rs1.getInt(2);
	int wrong=rs1.getInt(3);
	float per=rs1.getFloat(4);
	String status = rs1.getString(5);
	
	%>
	</tbody>
  </table>
	   <div class="jumbotron vertical-center">
	<%
	//out.println("Correct Answers="+right+"<br>");
	//out.println("Wrong Answers="+wrong+"<br>");
	//out.println("Percentage="+per+"%"+"<br>");
	
	%>
	
	<center><h3>Correct Answers:<%=right%></h3></center>
	<center><h3>Wrong Answers:<%=wrong%></h3></center>
	<center><h3>Percentage:<%=per%></h3></center>
		<center><h1><%= status %></h1></center><br>
	<%
}
else
{
	%>
	<div class="container">
    <div class="jumbotron vertical-center">
	    <center><h2>The Student has not Given Any Exam</h2></center>
	    <% System.out.println("In First else block"); %>
	  </div></div>
	<%
}
}
catch(Exception e)
{
	System.out.println("Exception:  "+e);
	int uid=0;
	if(i.getAccess().equals("admin"))
	{
		uid=Integer.parseInt(request.getParameter("x"));
	}
	else
	{
		uid=i.getId();	
	}
	
	%>
<div class="container">
    <div class="jumbotron vertical-center">
	    <center><h2>The Student has not Given Any Exam</h2></center>
	    	    <% System.out.println("In First catch block"); %>
	    
	  </div></div>  	
<%
}
%>
</div>
</div>
</body>
</html>
