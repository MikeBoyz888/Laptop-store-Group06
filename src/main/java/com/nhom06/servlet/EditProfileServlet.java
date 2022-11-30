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
 * Servlet implementation class EditProfileServlet
 */
@WebServlet("/EditProfileServlet")
public class EditProfileServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int id = Integer.parseInt(request.getParameter("id"));
		String email = request.getParameter("email");
		String username = request.getParameter("username");
		String password = request.getParameter("pass");
		String fullname = request.getParameter("fullname");
		String address = request.getParameter("address");
		String contact = request.getParameter("contact");
		
		String message = "";
		
		try {
			UserDao userDao = new UserDao(DbCon.getConnection());
			User user = new User();
			user.setId(id);
			user.setEmail(email);
			user.setUsername(username);
			user.setPassword(password);
			user.setAddress(address);
			user.setFullname(fullname);
			user.setPhone(contact);
			System.out.println("id="+id);
			System.out.println("fullname="+fullname);
			System.out.println("password="+password);
			System.out.println("email="+email);
			System.out.println("address="+address);
			System.out.println("contact="+contact);
			boolean result = userDao.editProfile(user, id);
			
			if(result) {
				message = "Update Successful";
				request.getSession().setAttribute("auth", user);
				request.getSession().setAttribute("message", message);
			}
			else {
				message = "Update fail";
				request.getSession().setAttribute("message", message);
			}
			response.sendRedirect("user_profile.jsp");
		}catch (Exception e) {
			e.printStackTrace();
		}
	}

}
