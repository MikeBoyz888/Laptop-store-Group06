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
	Product product = (Product) request.getSession().getAttribute("single-product");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><%=product.getName()%></title>
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
				
			<%if(product!=null){ %>
				<div class="col-md-8">
					<div class="product-content-right">
						<div class="product-breadcroumb">
							<a href="index.jsp">Home</a> <a href="CategoryServlet?name=<%=product.getCategory()%>"><%=product.getCategory()%></a> <a href="single-product.jsp"><%=product.getName()%></a>
						</div>

						<div class="row">
							<div class="col-sm-6">
								<div class="product-images">
									<div class="product-main-img">
										<img src="data:image/jpg;base64,<%=product.getImage()%>" alt="image">
									</div>
								</div>
							</div>

							<div class="col-sm-6">
								<div class="product-inner">
									<h2 class="product-name"><%=product.getName()%></h2>
									<div class="product-inner-price">
										<ins>$<%=product.getPrice()%></ins>
									</div>

									<a href="AddToCartServlet?id=<%=product.getId()%>"><button class="add_to_cart_button" type="submit">Add
											to cart</button></a> <br></br>

									<div class="product-inner-category">
										<p>
											Category: <a href="CategoryServlet?name=<%=product.getCategory()%>"><%=product.getCategory()%></a>
										</p>
									</div>

									<div role="tabpanel">
										<ul class="product-tab" role="tablist">
											<li role="presentation" class="active"><a href="#home"
												aria-controls="home" role="tab" data-toggle="tab">Description</a></li>
											<li role="presentation"><a href="#profile"
												aria-controls="profile" role="tab" data-toggle="tab">Details</a></li>
										</ul>
										<div class="tab-content">
											<div role="tabpanel" class="tab-pane fade in active"
												id="home">
												<h2>Product Description</h2>
												<p><%=product.getDescription()%></p>
											</div>
											<div role="tabpanel" class="tab-pane fade" id="profile">
												<h2>Product Details</h2>
												<div class="submit-review">
													<p><%=product.getDetail()%></p>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<%}%>
			</div>
		</div>
	</div>

	<%@include file="includes/footer.jsp"%>
</body>
</html>