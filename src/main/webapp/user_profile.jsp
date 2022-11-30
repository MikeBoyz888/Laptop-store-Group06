<%@page import="java.util.ArrayList"%>
<%@page import="com.nhom06.connection.DbCon"%>
<%@page import="java.util.List"%>
<%@page import="com.nhom06.model.*"%>
<%@page import="com.nhom06.dao.*"%>
<%
	User auth = (User) request.getSession().getAttribute("auth");
	if(auth!=null){
		request.setAttribute("auth", auth);
	}else{
		response.sendRedirect("login.jsp");
	}
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Profile</title>
<link rel="stylesheet" href="css/user_profile.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link
	href='https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-alpha1/dist/css/bootstrap.min.css'
	rel='stylesheet' type='text/css'>
	
	<!-- Google Fonts -->
<link
	href='http://fonts.googleapis.com/css?family=Titillium+Web:400,200,300,700,600'
	rel='stylesheet' type='text/css'>
<link
	href='http://fonts.googleapis.com/css?family=Roboto+Condensed:400,700,300'
	rel='stylesheet' type='text/css'>
<link href='http://fonts.googleapis.com/css?family=Raleway:400,100'
	rel='stylesheet' type='text/css'>

<!-- Bootstrap -->
<link rel="stylesheet" href="css/bootstrap.min.css">

<!-- Font Awesome -->
<link rel="stylesheet" href="css/font-awesome.min.css">

<!-- Custom CSS -->
<link rel="stylesheet" href="css/owl.carousel.css">
<link rel="stylesheet" href="style.css">
<link rel="stylesheet" href="css/responsive.css">
	
</head>
<body>
<div class="header-area">
		<div class="container">
			<div class="row">
				<div class="col-md-8">
					<div class="user-menu">
						<ul>
							<li><a href="user_profile.jsp"><i class="fa fa-user"></i> My Account</a></li>
							<li><a href="index.jsp"><i class="fa fa-user"></i>Home</a></li>				
							<li><a href="cart.jsp"><i class="fa fa-user"></i> My
									Cart</a></li>
							<li><a href="checkout.jsp"><i class="fa fa-user"></i>
									Checkout</a></li>
							<%if(auth != null){%>
							<li><a href="LogoutServlet"><i class="fa fa-user"></i>
									Logout</a></li>
							<%if(auth.getUsername().equals("admin")){%>
							<li><a href="product_management.jsp"><i
									class="fa fa-user"></i> Product Management</a></li>
							<%}%>
							<%}else{%>
							<li><a href="login.jsp"><i class="fa fa-user"></i> Login</a></li>
							<%}%>

						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- End header area -->
<div class="container rounded bg-white mt-5 mb-5">
    <div class="row">
    <%if(auth != null){%>
    <form action="EditProfileServlet?id=<%=auth.getId()%>" method="post">
        <div class="col-md-3 border-right">
            <div class="d-flex flex-column align-items-center text-center p-3 py-5"><img class="rounded-circle mt-5" width="150px" src="https://st3.depositphotos.com/15648834/17930/v/600/depositphotos_179308454-stock-illustration-unknown-person-silhouette-glasses-profile.jpg"><span class="font-weight-bold"><%=auth.getFullname()%></span><span class="text-black-50"><%=auth.getEmail()%></span><span> </span></div>
        </div>
        <div class="col-md-5 border-right">
            <div class="p-3 py-5">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h4 class="text-right">Profile Settings</h4>
                </div>
                <div class="row mt-2">
                    <div class="col-md-12"><label class="labels">Full Name</label><input name="fullname" type="text" class="form-control" placeholder="enter full name" value="<%=auth.getFullname()%>"></div>
                    <div class="col-md-12"><label class="labels">User Name</label><input name="username" readonly type="text" class="form-control" placeholder="enter username" value="<%=auth.getUsername()%>"></div>
                    <div class="col-md-12"><label class="labels">Password</label><input name="pass" type="text" class="form-control" placeholder="enter password" value="<%=auth.getPassword()%>"></div>
                </div>
                <div class="row mt-3">
                    <div class="col-md-12"><label class="labels">Mobile Number</label><input name="contact" type="text" class="form-control" placeholder="enter phone number" value="<%=auth.getPhone()%>"></div>
                    <div class="col-md-12"><label class="labels">Address</label><input name="address" type="text" class="form-control" placeholder="enter address" value="<%=auth.getAddress()%>"></div>
                    <div class="col-md-12"><label class="labels">Email</label><input name="email" type="text" class="form-control" placeholder="enter email" value="<%=auth.getEmail()%>"></div>
                </div>
                <h3>${message}</h3>
                <!-- <div class="row mt-3">
                    <div class="col-md-6"><label class="labels">Country</label><input type="text" class="form-control" placeholder="country" value=""></div>
                    <div class="col-md-6"><label class="labels">State/Region</label><input type="text" class="form-control" value="" placeholder="state"></div>
                </div> -->
                <div class="mt-5 text-center"><button class="btn btn-primary profile-button" type="submit">Save Profile</button></div>
            </div>
        </div>
    </form>
    <%}%>
    </div>
</div>
</body>
</html>
<%if(request.getSession().getAttribute("message")!= null) {
	request.getSession().removeAttribute("message");
}%>