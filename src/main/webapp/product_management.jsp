<%@page import="java.util.ArrayList"%>
<%@page import="com.nhom06.connection.DbCon"%>
<%@page import="java.util.List"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.nhom06.model.*"%>
<%@page import="com.nhom06.dao.*"%>
<%
DecimalFormat format = new DecimalFormat("#.###");
request.setAttribute("format", format);

	User auth = (User) request.getSession().getAttribute("auth");
	if(auth!=null){
		request.setAttribute("auth", auth);
	}else{
		response.sendRedirect("login.jsp");
	}
	
	ProductDao dao = new ProductDao(DbCon.getConnection());
	
	List<Product> products = dao.getAllProducts();
	
	List<String> categories = dao.getAllCategories();
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Product Management</title>
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
							<li><a href="product_management.jsp"><i class="fa fa-user"></i>
									Product Management</a></li>
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
	
	<div class="product-big-title-area">
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<div class="product-bit-title text-center">
						<h2>PRODUCT MANAGEMENT</h2>
					</div>
				</div>
			</div>
		</div>
	</div>
	<br></br>
	<div class="container">
		<div class="row">
				<div class="col-md-12">
					<div class="product-bit-title text-center">
						<a href="add-product.jsp"><button id="singlebutton" name="singlebutton" class="btn btn-primary">Add Product</button></a>
					</div>
				</div>
			</div>
	</div>
	<br></br>
<table class="shop_table cart">
		<thead>
			<tr>
				<th class="product-thumbnail">&nbsp;</th>
				<th class="product-name">Product</th>
				<th class="product-price">Price</th>
				<!--	<th class="product-quantity">Quantity</th>   -->
				<th class="product-name">Category</th>
				<th class="product-name">Description</th>
				<th class="product-name">Details</th>
				<th class="product-subtotal">Edit</th>
				<th class="product-price">Remove</th>
			</tr>
		</thead>
		<tbody>
			<%if (products != null) {
				for (Product c : products) {%>
			<tr class="cart_item">

				<td class="product-thumbnail"><a href=""><img width="145"
						height="145" alt="poster_1_up" class="shop_thumbnail"
						src="data:image/jpg;base64,<%=c.getImage()%>"></a></td>

				<td class="product-name"><a href=""><%=c.getName()%></a></td>

				<td class="product-price"><span class="amount"><%=format.format(c.getPrice())%></span></td>
				<td class="product-name"><a href=""><%=c.getCategory()%></a></td>
				<td class="product-name"><a href=""><%=c.getDescription()%></a></td>
				<td class="product-name"><a href=""><%=c.getDetail()%></a></td>
				<td><a href="EditProductServlet?action=get&id=<%=c.getId()%>"><button id="singlebutton" name="singlebutton" class="btn btn-primary">Edit</button></a></td>
				<td><a href="DeleteProductServlet?id=<%=c.getId()%>"><button id="singlebutton" name="singlebutton" class="btn btn-primary">Delete</button></a></td>
			</tr>
			<%}
			}%>
		</tbody>
	</table>

<br></br>
	<%@include file="includes/footer.jsp"%>
</body>
</html>