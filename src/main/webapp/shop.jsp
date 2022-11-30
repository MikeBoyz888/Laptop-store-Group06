<%@page import="com.nhom06.connection.DbCon"%>
<%@page import="java.util.*"%>
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
<html>
<head>
<meta charset="UTF-8">
<title>Shop Page</title>
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
						<li><a href="index.jsp">Home</a></li>
						<li class="active"><a href="shop.jsp">Shop page</a></li>
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
						<h2>Shop</h2>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="single-product-area">
		<div class="zigzag-bottom"></div>
		<div class="container">
			<div class="row">
				<%if(!products.isEmpty()){ 
            	for(Product p:products){%>
				<div class="col-md-3 col-sm-6">
					<div class="single-shop-product">
						<div class="product-upper">
							<a href="SingleProductServlet?id=<%=p.getId()%>"><img src="data:image/jpg;base64,<%=p.getImage()%>" alt="image"></a>
						</div>
						<h2>
							<a href="SingleProductServlet?id=<%=p.getId()%>"><%=p.getName()%></a>
						</h2>
						<div class="product-carousel-price">
							<ins><%=p.getPrice()%></ins>
							<del>$999.00</del>
						</div>
						<div class="product-option-shop">
							<a class="add_to_cart_button" data-quantity="1"
								data-product_sku="" data-product_id="70" rel="nofollow"
								href="AddToCartServlet?id=<%=p.getId()%>">Add to cart</a>
						</div>
					</div>
				</div>
				<%}
            	}%>
			</div>

			<!-- <div class="row">
				<div class="col-md-12">
					<div class="product-pagination text-center">
						<nav>
							<ul class="pagination">
								<li><a href="#" aria-label="Previous"> <span
										aria-hidden="true">&laquo;</span>
								</a></li>
								<li><a href="#">1</a></li>
								<li><a href="#">2</a></li>
								<li><a href="#">3</a></li>
								<li><a href="#">4</a></li>
								<li><a href="#">5</a></li>
								<li><a href="#" aria-label="Next"> <span
										aria-hidden="true">&raquo;</span>
								</a></li>
							</ul>
						</nav>
					</div>
				</div>
			</div> -->
		</div>
	</div>

	<%@include file="includes/footer.jsp"%>
</body>
</html>