package com.nhom06.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.nhom06.connection.DbCon;
import com.nhom06.dao.ProductDao;

/**
 * Servlet implementation class DeleteProductServlet
 */
@WebServlet("/DeleteProductServlet")
public class DeleteProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String delete_product_message="";
		int id = Integer.parseInt(request.getParameter("id"));
		
		try {
			ProductDao dao = new ProductDao(DbCon.getConnection());
			
			boolean result = dao.deleteProduct(id);
			if(result) {
				delete_product_message = "Delete successful";
				request.setAttribute("delete_product_message", delete_product_message);
			}
			else {
				delete_product_message = "Delete fail";
				request.setAttribute("delete_product_message", delete_product_message);
			}
			request.getRequestDispatcher("product_management.jsp").forward(request, response);
			response.sendRedirect("product_management.jsp");
		}catch (Exception e) {
			// TODO: handle exception
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
