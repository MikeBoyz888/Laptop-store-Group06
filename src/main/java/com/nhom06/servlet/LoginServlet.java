package com.nhom06.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.nhom06.connection.DbCon;
import com.nhom06.dao.UserDao;
import com.nhom06.model.User;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.sendRedirect("login.jsp");
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String message = "";
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
		try {
			UserDao userDao = new UserDao(DbCon.getConnection());
			User user = userDao.userLogin(username, password);
			
			if(user!= null) {
				request.getSession().setAttribute("auth", user);
				response.sendRedirect("index.jsp");
			}else {
				message = "Account doesn't exist";
				request.getSession().setAttribute("message", message);
				response.sendRedirect("login.jsp");
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
	}

}
