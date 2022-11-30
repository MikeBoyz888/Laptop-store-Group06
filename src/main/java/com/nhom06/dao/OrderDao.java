package com.nhom06.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import com.nhom06.model.Order;
import com.nhom06.model.Product;

public class OrderDao {
	
	private Connection con;

	private String query;
    private PreparedStatement pst;
    private ResultSet rs;      

	public OrderDao(Connection con) {
		super();
		this.con = con;
	}

	public boolean insertOrder(Order model) {
        boolean result = false;
        try {
            query = "insert into orders (product_id, user_id, quantity, order_date) values(?,?,?,?)";
            pst = this.con.prepareStatement(query);
            pst.setInt(1, model.getId());
            pst.setInt(2, model.getUid());
            pst.setInt(3, model.getQuantity());
            pst.setString(4, model.getDate());
            pst.executeUpdate();
            result = true;	
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return result;	
    }
	public List<Order> userOrders(int id) {
        List<Order> list = new ArrayList<>();
        try {
            query = "select * from orders where user_id=? order by orders.id desc";
            pst = this.con.prepareStatement(query);
            pst.setInt(1, id);
            rs = pst.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                ProductDao productDao = new ProductDao(this.con);
                int pId = rs.getInt("product_id");
                Product product = productDao.getSingleProduct(pId);
                order.setOrderId(rs.getInt("id"));
                order.setId(pId);
                order.setName(product.getName());
                order.setCategory(product.getCategory());
                order.setPrice(product.getPrice()*rs.getInt("quantity"));
                order.setQuantity(rs.getInt("quantity"));
                order.setDate(rs.getString("order_date"));
                list.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        return list;
    }
	public void cancelOrder(int id) {
        //boolean result = false;
        try {
            query = "delete from orders where order_id=?";
            pst = this.con.prepareStatement(query);
            pst.setInt(1, id);
            pst.execute();
            //result = true;
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.print(e.getMessage());
        }
        //return result;
    }
}
