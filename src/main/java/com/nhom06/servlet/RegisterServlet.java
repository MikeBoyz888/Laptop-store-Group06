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
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("username");
		String email = request.getParameter("email");
		String password = request.getParameter("pass");
		String fullname = request.getParameter("fullname");
		String address = request.getParameter("address");
		String contact = request.getParameter("contact");
		
		String message = "";
		
		try {
			UserDao userDao = new UserDao(DbCon.getConnection());
			User user = new User();
			//user.setId();
			user.setUsername(username);
			user.setEmail(email);
			user.setPassword(password);
			user.setAddress(address);
			user.setFullname(fullname);
			user.setPhone(contact);
			boolean result = userDao.userRegister(user);
			
			if(result) {
				message = "Register successful";
				request.getSession().setAttribute("message", message);
			}
			else {
				message = "Register fail";
				request.getSession().setAttribute("message", message);
			}
			response.sendRedirect("registration.jsp");
		}catch (Exception e) {
			e.printStackTrace();
		}
	}

}
