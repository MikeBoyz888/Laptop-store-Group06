package com.nhom06.servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.nhom06.connection.DbCon;
import com.nhom06.dao.ProductDao;
import com.nhom06.model.Product;

/**
 * Servlet implementation class SingleProductServlet
 */
@WebServlet("/SingleProductServlet")
public class SingleProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int id = Integer.parseInt(request.getParameter("id"));
		
		try {
			ProductDao dao = new ProductDao(DbCon.getConnection());
			Product product = dao.getSingleProduct(id);
			request.getSession().setAttribute("single-product", product);
			response.sendRedirect("single-product.jsp");
			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
