<%@page import="com.nhom06.dao.OrderDao"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.nhom06.connection.DbCon"%>
<%@page import="com.nhom06.dao.ProductDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.nhom06.model.*"%>
<%
DecimalFormat format = new DecimalFormat("#.###");
request.setAttribute("format", format);

User auth = (User) request.getSession().getAttribute("auth");
List<Order> orders = null;
if (auth != null) {
	request.setAttribute("auth", auth);
	orders = new OrderDao(DbCon.getConnection()).userOrders(auth.getId());
}else{
	response.sendRedirect("login.jsp");
}

ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Order</title>
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
							<li><a href="cart.jsp"><i class="fa fa-user"></i> My
									Cart</a></li>
							<li><a href="checkout.jsp"><i class="fa fa-user"></i>
									Checkout</a></li>
							<%if (auth != null) {%>
							<li><a href="LogoutServlet"><i class="fa fa-user"></i>
									Logout</a></li>
							<%if(auth.getUsername().equals("admin")){%>
							<li><a href="product_management.jsp"><i
									class="fa fa-user"></i> Product Management</a></li>
							<%}%>
							<%} else {%>
							<li><a href="login.jsp"><i class="fa fa-user"></i> Login</a></li>
							<%}%>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- End header area -->

	<div class="mainmenu-area">
		<div class="container">
			<div class="row">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle" data-toggle="collapse"
						data-target=".navbar-collapse">
						<span class="sr-only">Toggle navigation</span> <span
							class="icon-bar"></span> <span class="icon-bar"></span> <span
							class="icon-bar"></span>
					</button>
				</div>
				<div class="navbar-collapse collapse">
					<ul class="nav navbar-nav">
						<li><a href="index.jsp">Home</a></li>
						<li><a href="shop.jsp">Shop page</a></li>
						<li><a href="cart.jsp">Cart</a></li>
						<li><a href="checkout.jsp">Checkout</a></li>
						<li><a href="category.jsp">Category</a></li>
						<li><a href="order.jsp">Order</a></li>
						<li><a href="#">Contact</a></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<!-- End mainmenu area -->

	<div class="product-big-title-area">
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<div class="product-bit-title text-center">
						<h2>Order List</h2>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- End Page title area -->


	<div class="single-product-area">
		<div class="zigzag-bottom"></div>
		<div class="container">
			<div class="row">
				<div class="col-md-8">
					<div class="product-content-right">
						<div class="woocommerce">
							<form method="post" action="#">
								<table class="shop_table cart">
									<thead>
										<tr>
											<th class="product-remove">Date</th>
											<th class="product-name">Name</th>
											<th class="product-price">Price</th>
											<th class="product-quantity">Quantity</th>
											<th class="product-subtotal">Total</th>
										</tr>
									</thead>
									<tbody>
										<%
										if (orders != null) {
											for (Order o : orders) {
										%>
										<tr class="cart_item">																										
												
											<td class="product-name"><a href="single-product.jsp"><%=o.getDate()%></a></td>																				

											<td class="product-name"><a href="single-product.jsp"><%=o.getName()%></a></td>

											<td class="product-name"><span class="amount"><%=format.format(o.getPrice())%></span></td>

											<td class="product-name"><a href="single-product.jsp"><%=o.getQuantity()%></a></td>

											<td class="product-name"><span class="amount"><%=format.format(o.getPrice() * o.getQuantity())%></span>
											</td>
										</tr>
										<%}
									}%>
									</tbody>
								</table>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<%@include file="includes/footer.jsp"%>
</body>
</html>