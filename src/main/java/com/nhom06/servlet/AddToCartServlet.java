package com.nhom06.servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.nhom06.model.Cart;

/**
 * Servlet implementation class AddToCartServlet
 */
@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		ArrayList<Cart> cartList = new ArrayList<>();
        int id = Integer.parseInt(request.getParameter("id"));
        
        Cart cart = new Cart();
        cart.setId(id);
        cart.setQuantity(1);
        HttpSession session = request.getSession();
        @SuppressWarnings("unchecked")
		ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
        
        if (cart_list == null) {
            cartList.add(cart);
            session.setAttribute("cart-list", cartList);
            response.sendRedirect("cart.jsp");
        }else {
            cartList = cart_list;

            boolean exist = false;
            for (Cart c : cart_list) {
                if (c.getId() == id) {
                    exist = true;
                    response.sendRedirect("cart.jsp");
                }
            }

            if (!exist) {
                cartList.add(cart);
                response.sendRedirect("cart.jsp");
            }
        }
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
