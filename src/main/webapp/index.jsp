<%@page import="java.util.ArrayList"%>
<%@page import="com.nhom06.connection.DbCon"%>
<%@page import="java.util.List"%>
<%@page import="com.nhom06.model.*"%>
<%@page import="com.nhom06.dao.*"%>
<%
	User auth = (User) request.getSession().getAttribute("auth");
	if(auth!=null){
		request.setAttribute("auth", auth);
	}
	
	ProductDao dao = new ProductDao(DbCon.getConnection());
	List<Product> products = dao.getAllProducts();
	
	ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
	if (cart_list != null) {
		double total = dao.getTotalCartPrice(cart_list);
		request.setAttribute("total", total);
		request.setAttribute("cart_list", cart_list);
	}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Laptop Store</title>
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

	<div class="site-branding-area">
		<div class="container">
			<div class="row">
				<div class="col-sm-6">
					<div class="logo">
						<h1>
							<a href="./"><img src="img/logo.jpg"></a>
						</h1>
					</div>
				</div>
				
				<div class="logo" align="justify">
						<form action="SearchProductServlet" method="get">
							<input name="search" type="text" placeholder="Search products..."> <input
								type="submit" value="Search">
						</form>
				</div>

				<div class="col-sm-6">
					<div class="shopping-item">
						<a href="cart.jsp">Cart - <span class="cart-amunt">$${total}</span>
							<i class="fa fa-shopping-cart"></i> <span class="product-count">${cart_list.size()}</span></a>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- End site branding area -->

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
						<li class="active"><a href="index.jsp">Home</a></li>
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

	<div class="slider-area">
		<!-- Slider -->
		<div class="block-slider block-slider4">
			<ul class="" id="bxslider-home4">
				<li><img src="img/slide-1.jpg" alt="Slide">
					<div class="caption-group">
						<h2 class="caption title">
							iPhone <span class="primary">6 <strong>Plus</strong></span>
						</h2>
						<h4 class="caption subtitle">Dual SIM</h4>
						<a class="caption button-radius" href="#"><span class="icon"></span>Shop
							now</a>
					</div></li>
				<li><img src="img/slide-2.jpg" alt="Slide">
					<div class="caption-group">
						<h2 class="caption title">
							by one, get one <span class="primary">50% <strong>off</strong></span>
						</h2>
						<h4 class="caption subtitle">school supplies backpacks.*</h4>
						<a class="caption button-radius" href="#"><span class="icon"></span>Shop
							now</a>
					</div></li>
			</ul>
		</div>
		<!-- ./Slider -->
	</div>
	<!-- End slider area -->

	<div class="maincontent-area">
		<div class="zigzag-bottom"></div>
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<div class="latest-product">
						<h2 class="section-title">Latest Products</h2>
						<div class="product-carousel">

							<%if(!products.isEmpty()){
							if(products.size() < 10){
            					for(Product p:products){%>
							<div class="single-product">
								<div class="product-f-image">
									<a href="SingleProductServlet?id=<%=p.getId()%>"><img src="data:image/png;base64,<%=p.getImage()%>" alt="image"></a>
									
								</div>

								<h2>
									<a href="SingleProductServlet?id=<%=p.getId()%>"><%=p.getName()%></a>
								</h2>

								<div class="product-carousel-price">
									<ins>
										$<%=p.getPrice()%></ins>
									<del>
										$<%=p.getPrice()+99%></del>
								</div>
							</div>
							<%}}
							else{
								for(int i=products.size()-1; i<=products.size()-10; i--){
									%>
							<div class="single-product">
								<div class="product-f-image">
									<a href="SingleProductServlet?id=<%=products.get(i).getId()%>"><img src="data:image/png;base64,<%=products.get(i).getImage()%>" alt=""></a>
									
								</div>

								<h2>
									<a href="SingleProductServlet?id=<%=products.get(i).getId()%>"><%=products.get(i).getName()%></a>
								</h2>

								<div class="product-carousel-price">
									<ins>
										$<%=products.get(i).getPrice()%></ins>
									<del>
										$<%=products.get(i).getPrice()+99%></del>
								</div>
							</div>
							<%}}}%>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- End main content area -->

	<%@include file="includes/footer.jsp"%>
</body>
</html>