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
 * Servlet implementation class CategoryServlet
 */
@WebServlet("/CategoryServlet")
public class CategoryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String name = request.getParameter("name");

		try {

			ProductDao dao = new ProductDao(DbCon.getConnection());
			List<Product> cProduct = new ArrayList<>();
			cProduct = dao.getCategoryProducts(name);
			request.getSession().setAttribute("cProduct", cProduct);
			request.setAttribute("name", name);
			request.getRequestDispatcher("category_product.jsp").forward(request, response);

			response.sendRedirect("category_product.jsp");

		} catch (Exception e) {
			// TODO: handle exception
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String category = request.getParameter("new_category");
		try {
			ProductDao dao = new ProductDao(DbCon.getConnection());
			if (category != null && category != "") {
				boolean result = dao.addCategory(category);
				if (result) {
					response.sendRedirect("add-product.jsp");
				}
			}
		} catch (Exception e) {
			// TODO: handle exception
		}

	}

}
