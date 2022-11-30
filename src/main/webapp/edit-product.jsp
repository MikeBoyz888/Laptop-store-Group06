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
	
	ProductDao dao = new ProductDao(DbCon.getConnection());
	
	List<String> categories = dao.getAllCategories();
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Product</title>
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

<form method="post" action="EditProductServlet?action=edit" class="form-horizontal">
<fieldset>

<input type="hidden" name="id_product" value="${product.getId()}">

<div class="product-big-title-area">
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<div class="product-bit-title text-center">
						<h2>EDIT PRODUCT</h2>
					</div>
				</div>
			</div>
		</div>
	</div>
	<br></br>

<!-- Text input-->
<div class="form-group">
  <label class="col-md-4 control-label" for="product_name">PRODUCT NAME</label>  
  <div class="col-md-4">
  <input id="product_name" name="product_name" value="${product.getName()}" placeholder="PRODUCT NAME" class="form-control input-md" required type="text">
  </div>
</div>

<!-- Text input-->
<div class="form-group">
  <label class="col-md-4 control-label" for="product_name">PRODUCT PRICE</label>  
  <div class="col-md-4">
  <input id="product_price" name="product_price" value="${product.getPrice()}" placeholder="PRODUCT PRICE" class="form-control input-md" required type="text">
    
  </div>
</div>


<!-- Select Basic -->
<div class="form-group">
  <label class="col-md-4 control-label" for="product_categorie">PRODUCT CATEGORY</label>
  <div class="col-md-4">
    <select id="product_categorie" name="product_categorie" class="form-control" required>
    <%if(!categories.isEmpty()){
    for(String c:categories){%>
    <option value="<%=c%>"><%=c%></option>
    <%}}%>
    </select>
  </div>
</div>

<!-- Textarea -->
<div class="form-group">
  <label class="col-md-4 control-label" for="product_description">PRODUCT DETAILS</label>
  <div class="col-md-4">                     
    <textarea class="form-control" id="product_details" name="product_details" required>${product.getDetail()}</textarea>
  </div>
</div>

<!-- Textarea -->
<div class="form-group">
  <label class="col-md-4 control-label" for="product_description">PRODUCT DESCRIPTION</label>
  <div class="col-md-4">                     
    <textarea class="form-control" id="product_description" name="product_description" required>${product.getDescription()}</textarea>
  </div>
</div>

 <!-- File Button --> 
<div class="form-group">
  <label class="col-md-4 control-label" for="filebutton">IMAGE</label>
  <div class="col-md-4">
    <img id="output" width="180" height="200" alt="image" src="data:image/png;base64,${product.getImage()}"/>
  </div>
</div>


<!-- Button -->
<div class="form-group">
  <label class="col-md-4 control-label" for="singlebutton"></label>
  <div class="col-md-4">
    <button type="submit" id="singlebutton" name="singlebutton" class="btn btn-primary">Save</button>
  </div>
  </div>
</fieldset>
</form>

<%@include file="includes/footer.jsp"%>
</body>
</html>
<%if(request.getSession().getAttribute("edit_product_message")!= null) {
		request.getSession().removeAttribute("edit_product_message");
}%>