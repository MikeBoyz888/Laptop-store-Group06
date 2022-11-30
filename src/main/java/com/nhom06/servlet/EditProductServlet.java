package com.nhom06.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.nhom06.connection.DbCon;
import com.nhom06.dao.ProductDao;
import com.nhom06.model.Product;

/**
 * Servlet implementation class EditProductServlet
 */
@WebServlet("/EditProductServlet")
public class EditProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String action = request.getParameter("action");
		
		String edit_product_message = "";
		try {
			ProductDao dao = new ProductDao(DbCon.getConnection());
			
			if(action!=null && action.equals("get")) {
				int id = Integer.parseInt(request.getParameter("id"));
				Product product = dao.getSingleProduct(id);
				request.setAttribute("product", product);
				request.getRequestDispatcher("edit-product.jsp").forward(request, response);
				//response.sendRedirect("edit-product.jsp");
			}
			else if(action!=null && action.equals("edit")) {
				
				int id = Integer.parseInt(request.getParameter("id_product"));
				System.out.println(request.getParameter("id_product"));
				String name = request.getParameter("product_name");
				String price = request.getParameter("product_price");
				String details = request.getParameter("product_details");
				String category = request.getParameter("product_categorie");
				String descript = request.getParameter("product_description");
				//InputStream img = request.getPart("filebutton").getInputStream();
				
				Product product = new Product();
				
				product.setName(name);
				product.setDescription(descript);
				product.setDetail(details);
				product.setCategory(category);
				product.setPrice(Double.parseDouble(price));
				//product.setImage(image);
				boolean result = dao.updateProductVer2(product, id);
				
				if(result) {
					edit_product_message = "Edit successful";
					request.getSession().setAttribute("edit_product_message", edit_product_message);
					response.sendRedirect("product_management.jsp");
				}
				else {
					edit_product_message = "Edit fail";
					request.getSession().setAttribute("edit_product_message", edit_product_message);
					response.sendRedirect("edit-product.jsp");
				}
			}
		}catch (Exception e) {
			edit_product_message = "Edit fail";
			request.getSession().setAttribute("edit_product_message", edit_product_message);
			response.sendRedirect("edit-product.jsp");
		}
	}

}
