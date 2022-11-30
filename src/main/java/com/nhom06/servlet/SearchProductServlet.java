package com.nhom06.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.nhom06.connection.DbCon;
import com.nhom06.dao.ProductDao;
import com.nhom06.model.Product;

/**
 * Servlet implementation class SearchProductServlet
 */
@WebServlet("/SearchProductServlet")
public class SearchProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name = request.getParameter("search");
		
		if(name!=null && name=="") {
			response.sendRedirect("shop.jsp");
		}

		request.setCharacterEncoding("UTF-8");
		try {
			ProductDao dao = new ProductDao(DbCon.getConnection());
			List<Product> products = new ArrayList<>();
			products = dao.searchProduct(name);
			
			request.setAttribute("search", name);
			request.setAttribute("searchP", products);
			request.getRequestDispatcher("search-product.jsp").forward(request, response);
			
		}catch (Exception e) {
			// TODO: handle exception
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
