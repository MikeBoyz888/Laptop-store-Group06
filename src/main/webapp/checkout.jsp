<%@page import="java.util.ArrayList"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.nhom06.connection.DbCon"%>
<%@page import="java.util.List"%>
<%@page import="com.nhom06.model.*"%>
<%@page import="com.nhom06.dao.*"%>
<%
DecimalFormat format = new DecimalFormat("#.###");
request.setAttribute("format", format);

User auth = (User) request.getSession().getAttribute("auth");
if(auth!=null){
	request.setAttribute("auth", auth);
}
	
ProductDao dao = new ProductDao(DbCon.getConnection());
	
ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
List<Cart> cartProduct = null;
if (cart_list != null) {
	cartProduct = dao.getCartProducts(cart_list);
	double total = dao.getTotalCartPrice(cart_list);
	request.setAttribute("cart_list", cart_list);
	request.setAttribute("total", total);
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Check Out</title>
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
						<h2>Check Out</h2>
					</div>
				</div>
			</div>
		</div>
	</div>


	<div class="single-product-area">
		<div class="zigzag-bottom"></div>
		<div class="container">
			<div class="row">
				

				<div class="col-md-8">
					<div class="product-content-right">
						<div class="woocommerce">
							

							<form enctype="multipart/form-data" action="CheckOutServlet" method="get" class="checkout"
								method="post" name="checkout">

								<div id="customer_details" class="col2-set">
									<div class="col-1">
										<div class="woocommerce-billing-fields">
											<h3>Billing Details</h3>
											
											<%if(auth != null){%>
											<p id="billing_first_name_field"
												class="form-row form-row-first validate-required">
												<label class="" for="billing_first_name">Full Name
													<abbr title="required" class="required">*</abbr>
												</label> <input type="text" value="<%=auth.getFullname()%>" placeholder=""
													id="billing_first_name" name="billing_first_name"
													class="input-text ">
											</p>

											<p id="billing_last_name_field"
												class="form-row form-row-last validate-required">
												<label class="" for="billing_last_name">Address <abbr
													title="required" class="required">*</abbr>
												</label> <input type="text" value="<%=auth.getAddress()%>" placeholder=""
													id="billing_last_name" name="billing_last_name"
													class="input-text ">
											</p>
											<div class="clear"></div>

											<div class="clear"></div>

											<p id="billing_email_field"
												class="form-row form-row-first validate-required validate-email">
												<label class="" for="billing_email">Email Address <abbr
													title="required" class="required">*</abbr>
												</label> <input type="text" value="<%=auth.getEmail()%>" placeholder=""
													id="billing_email" name="billing_email" class="input-text ">
											</p>

											<p id="billing_phone_field"
												class="form-row form-row-last validate-required validate-phone">
												<label class="" for="billing_phone">Phone <abbr
													title="required" class="required">*</abbr>
												</label> <input type="text" value="<%=auth.getPhone()%>" placeholder=""
													id="billing_phone" name="billing_phone" class="input-text ">
											</p>
											<%}else{%>
											<p id="billing_first_name_field"
												class="form-row form-row-first validate-required">
												<label class="" for="billing_first_name">Full Name
													<abbr title="required" class="required">*</abbr>
												</label> <input type="text" value="" placeholder=""
													id="billing_first_name" name="billing_first_name"
													class="input-text ">
											</p>

											<p id="billing_last_name_field"
												class="form-row form-row-last validate-required">
												<label class="" for="billing_last_name">Address <abbr
													title="required" class="required">*</abbr>
												</label> <input type="text" value="" placeholder=""
													id="billing_last_name" name="billing_last_name"
													class="input-text ">
											</p>
											<div class="clear"></div>

											<div class="clear"></div>

											<p id="billing_email_field"
												class="form-row form-row-first validate-required validate-email">
												<label class="" for="billing_email">Email Address <abbr
													title="required" class="required">*</abbr>
												</label> <input type="text" value="" placeholder=""
													id="billing_email" name="billing_email" class="input-text ">
											</p>

											<p id="billing_phone_field"
												class="form-row form-row-last validate-required validate-phone">
												<label class="" for="billing_phone">Phone <abbr
													title="required" class="required">*</abbr>
												</label> <input type="text" value="" placeholder=""
													id="billing_phone" name="billing_phone" class="input-text ">
											</p>
											<%}%>
											<div class="clear"></div>
										</div>
									</div>
								</div>

								<h3 id="order_review_heading">Your order</h3>

								<div id="order_review" style="position: relative;">
									<table class="shop_table">
										<thead>
											<tr>
												<th class="product-name">Product</th>
												<th class="product-total">Total</th>
											</tr>
										</thead>
										<tbody>
										<%if (cart_list != null) {
											for (Cart c : cartProduct) {%>
											<tr class="cart_item">
												<td class="product-name"><%=c.getName()%><strong
													class="product-quantity"> - Q:<%=c.getQuantity()%></strong>
												</td>
												<td class="product-total"><span class="amount"><%=format.format(c.getPrice()*c.getQuantity())%></span>
												</td>
											</tr>
											<%}
											}%>
										</tbody>
										<tfoot>

											<tr class="cart-subtotal">
												<th>Cart Subtotal</th>
												<td><span class="amount">${(total>0)?format.format(total):0}</span></td>
											</tr>

											<tr class="shipping">
												<th>Shipping and Handling</th>
												<td>Free Shipping <input type="hidden"
													class="shipping_method" value="free_shipping"
													id="shipping_method_0" data-index="0"
													name="shipping_method[0]">
												</td>
											</tr>


											<tr class="order-total">
												<th>Order Total</th>
												<td><strong><span class="amount">${(total>0)?format.format(total):0}</span></strong>
												</td>
											</tr>

										</tfoot>
									</table>


									<div id="payment">
										<ul class="payment_methods methods">
											<li class="payment_method_bacs"><input type="radio"
												data-order_button_text="" checked="checked" value="bacs"
												name="payment_method" class="input-radio"
												id="payment_method_bacs"> <label
												for="payment_method_bacs">Direct Bank Transfer </label>
												<div class="payment_box payment_method_bacs">
													<p>Make your payment directly into our bank account.
														Please use your Order ID as the payment reference. Your
														order won’t be shipped until the funds have cleared in
														our account.</p>
												</div></li>
											<li class="payment_method_cheque"><input type="radio"
												data-order_button_text="" value="cheque"
												name="payment_method" class="input-radio"
												id="payment_method_cheque"> <label
												for="payment_method_cheque">Cheque Payment </label>
												<div style="display: none;"
													class="payment_box payment_method_cheque">
													<p>Please send your cheque to Store Name, Store Street,
														Store Town, Store State / County, Store Postcode.</p>
												</div></li>
											<li class="payment_method_paypal"><input type="radio"
												data-order_button_text="Proceed to PayPal" value="paypal"
												name="payment_method" class="input-radio"
												id="payment_method_paypal"> <label
												for="payment_method_paypal">PayPal <img
													alt="PayPal Acceptance Mark"
													src="https://www.paypalobjects.com/webstatic/mktg/Logo/AM_mc_vs_ms_ae_UK.png"><a
													title="What is PayPal?"
													onclick="javascript:window.open('https://www.paypal.com/gb/webapps/mpp/paypal-popup','WIPaypal','toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=yes, resizable=yes, width=1060, height=700'); return false;"
													class="about_paypal"
													href="https://www.paypal.com/gb/webapps/mpp/paypal-popup">What
														is PayPal?</a>
											</label>
												<div style="display: none;"
													class="payment_box payment_method_paypal">
													<p>Pay via PayPal; you can pay with your credit card if
														you don’t have a PayPal account.</p>
												</div></li>
										</ul>

										<div class="form-row place-order">

											<input type="submit" data-value="Place order"
												value="Place order" id="place_order"
												name="woocommerce_checkout_place_order" class="button alt">


										</div>

										<div class="clear"></div>

									</div>
								</div>
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