package com.nhom06.servlet;

import java.io.IOException;
import java.io.InputStream;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.nhom06.connection.DbCon;
import com.nhom06.dao.ProductDao;
import com.nhom06.model.Product;

/**
 * Servlet implementation class AddProductServlet
 */
@WebServlet("/AddProductServlet")
@MultipartConfig(
		fileSizeThreshold   = 1024 * 1024 * 1,  // 1 MB
        maxFileSize         = 1024 * 1024 * 10, // 10 MB
        maxRequestSize      = 1024 * 1024 * 15 // 15 MB
        //location            = "D:/Uploads"
)
public class AddProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String add_product_message = "";
		String name = request.getParameter("product_name");
		String price = request.getParameter("product_price");
		String details = request.getParameter("product_details");
		String category = request.getParameter("product_categorie");
		String descript = request.getParameter("product_description");
		InputStream img = request.getPart("filebutton").getInputStream();
		
		//String image = request.getParameter("filebutton");
		
		try {
			ProductDao dao = new ProductDao(DbCon.getConnection());
			Product product = new Product();
			
			product.setName(name);
			product.setDescription(descript);
			product.setDetail(details);
			product.setCategory(category);
			product.setPrice(Double.parseDouble(price));
			//product.setImage(image);
			boolean result = dao.addProduct(product, img);
			
			if(result) {
				add_product_message = "Add successful";
				request.getSession().setAttribute("add_product_message", add_product_message);
				response.sendRedirect("product_management.jsp");
			}
			else {
				add_product_message = "Add fail";
				request.getSession().setAttribute("add_product_message", add_product_message);
				response.sendRedirect("product_management.jsp");
			}
			
		}catch (Exception e) {
			add_product_message = "Add fail";
			request.getSession().setAttribute("add_product_message", add_product_message);
			response.sendRedirect("product_management.jsp");
		}
	}

}
