package com.nhom06.dao;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

import com.nhom06.model.Product;
import com.mysql.cj.jdbc.Blob;
import com.nhom06.model.Cart;

public class ProductDao {
	private Connection con;

	private String query;
	private PreparedStatement pst;
	private ResultSet rs;

	public ProductDao(Connection con) {
		super();
		this.con = con;
	}

	public List<Product> getAllProducts() {
		List<Product> productList = new ArrayList<>();
		try {

			query = "select * from products";
			pst = this.con.prepareStatement(query);
			rs = pst.executeQuery();

			while (rs.next()) {
				Product product = new Product();
				product.setId(rs.getInt("id"));
				product.setName(rs.getString("name"));
				product.setDescription(rs.getString("description"));
				product.setDetail(rs.getString("details"));
				product.setCategory(rs.getString("category"));
				product.setPrice(rs.getDouble("price"));
				product.setStatus(rs.getString("status"));

				Blob blob = (Blob) rs.getBlob("image");
				InputStream inputStream = blob.getBinaryStream();
				ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
				byte[] buffer = new byte[4096];
				int bytesRead = -1;
				while ((bytesRead = inputStream.read(buffer)) != -1) {
					outputStream.write(buffer, 0, bytesRead);
				}
				byte[] imageBytes = outputStream.toByteArray();
				String base64Image = Base64.getEncoder().encodeToString(imageBytes);
				inputStream.close();
				outputStream.close();

				product.setImage(base64Image);

				productList.add(product);
			}

		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		} catch (IOException e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}

		return productList;
	}

	public Product getSingleProduct(int id) {
		Product product = null;
		try {
			query = "select * from products where id=? ";

			pst = this.con.prepareStatement(query);
			pst.setInt(1, id);
			ResultSet rs = pst.executeQuery();

			while (rs.next()) {
				product = new Product();
				product.setId(rs.getInt("id"));
				product.setName(rs.getString("name"));
				product.setDescription(rs.getString("description"));
				product.setDetail(rs.getString("details"));
				product.setCategory(rs.getString("category"));
				product.setPrice(rs.getDouble("price"));
				product.setStatus(rs.getString("status"));

				Blob blob = (Blob) rs.getBlob("image");
				InputStream inputStream = blob.getBinaryStream();
				ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
				byte[] buffer = new byte[4096];
				int bytesRead = -1;
				while ((bytesRead = inputStream.read(buffer)) != -1) {
					outputStream.write(buffer, 0, bytesRead);
				}
				byte[] imageBytes = outputStream.toByteArray();
				String base64Image = Base64.getEncoder().encodeToString(imageBytes);
				inputStream.close();
				outputStream.close();

				product.setImage(base64Image);
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}

		return product;
	}

	public List<Product> searchProduct(String name) {
		List<Product> productList = new ArrayList<>();
		try {

			query = "select * from products where name like ?";
			pst = this.con.prepareStatement(query);
			pst.setString(1, "%"+name+"%");
			rs = pst.executeQuery();

			while (rs.next()) {
				Product product = new Product();
				product.setId(rs.getInt("id"));
				product.setName(rs.getString("name"));
				product.setDescription(rs.getString("description"));
				product.setDetail(rs.getString("details"));
				product.setCategory(rs.getString("category"));
				product.setPrice(rs.getDouble("price"));
				product.setStatus(rs.getString("status"));

				Blob blob = (Blob) rs.getBlob("image");
				InputStream inputStream = blob.getBinaryStream();
				ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
				byte[] buffer = new byte[4096];
				int bytesRead = -1;
				while ((bytesRead = inputStream.read(buffer)) != -1) {
					outputStream.write(buffer, 0, bytesRead);
				}
				byte[] imageBytes = outputStream.toByteArray();
				String base64Image = Base64.getEncoder().encodeToString(imageBytes);
				inputStream.close();
				outputStream.close();

				product.setImage(base64Image);

				productList.add(product);
			}

		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		} catch (IOException e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
		return productList;
	}

	public boolean addProduct(Product product, InputStream in) {
		try {
			query = "insert into products (name, price, description, details, category, image) value (?, ?, ?, ?, ?, ?)";
			pst = this.con.prepareStatement(query);

			pst.setString(1, product.getName());
			pst.setDouble(2, product.getPrice());
			pst.setString(3, product.getDescription());
			pst.setString(4, product.getDetail());
			pst.setString(5, product.getCategory());
			//InputStream in = new FileInputStream(product.getImage());
			pst.setBlob(6, in);

			int rowCount = pst.executeUpdate();

			if (rowCount == 0) {
				return false;
			}

		} catch (SQLException e) {
			System.out.print(e.getMessage());
		} /*
			 * catch (FileNotFoundException e) { System.out.print(e.getMessage()); }
			 */
		return true;
	}
	
	public boolean deleteProduct(int id) {
		try {
			query = "delete from products where id=?";
			pst = this.con.prepareStatement(query);

			pst.setInt(1, id);

			int rowCount = pst.executeUpdate();

			if (rowCount == 0) {
				return false;
			}

		} catch (SQLException e) {
			System.out.print(e.getMessage());
		}
		return true;
	}

	public boolean updateProduct(Product product, InputStream in, int id) {
		try {
			query = "update products set name=?, price=?, description=?, details=?, category=?, image=? where id=?";
			pst = this.con.prepareStatement(query);

			pst.setString(1, product.getName());
			pst.setDouble(2, product.getPrice());
			pst.setString(3, product.getDescription());
			pst.setString(4, product.getDetail());
			pst.setString(5, product.getCategory());
			//InputStream in = new FileInputStream(product.getImage());
			pst.setBlob(6, in);
			pst.setInt(7, id);

			int rowCount = pst.executeUpdate();

			if (rowCount == 0) {
				return false;
			}

		} catch (SQLException e) {
			System.out.print(e.getMessage());
		} /*
			 * catch (FileNotFoundException e) { System.out.print(e.getMessage()); }
			 */
		return true;
	}
	
	public boolean updateProductVer2(Product product, int id) {
		try {
			query = "update products set name=?, price=?, description=?, details=?, category=? where id=?";
			pst = this.con.prepareStatement(query);

			pst.setString(1, product.getName());
			pst.setDouble(2, product.getPrice());
			pst.setString(3, product.getDescription());
			pst.setString(4, product.getDetail());
			pst.setString(5, product.getCategory());
			pst.setInt(6, id);

			int rowCount = pst.executeUpdate();

			if (rowCount == 0) {
				return false;
			}

		} catch (SQLException e) {
			System.out.print(e.getMessage());
		} /*
			 * catch (FileNotFoundException e) { System.out.print(e.getMessage()); }
			 */
		return true;
	}

	public List<Cart> getCartProducts(ArrayList<Cart> cartList) {
		List<Cart> book = new ArrayList<>();
		try {
			if (cartList.size() > 0) {
				for (Cart item : cartList) {
					query = "select * from products where id=?";
					pst = this.con.prepareStatement(query);
					pst.setInt(1, item.getId());
					rs = pst.executeQuery();
					while (rs.next()) {
						Cart cart = new Cart();
						cart.setId(rs.getInt("id"));
						cart.setName(rs.getString("name"));
						cart.setCategory(rs.getString("category"));
						cart.setPrice(rs.getDouble("price"));
						cart.setQuantity(item.getQuantity());

						Blob blob = (Blob) rs.getBlob("image");
						InputStream inputStream = blob.getBinaryStream();
						ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
						byte[] buffer = new byte[4096];
						int bytesRead = -1;
						while ((bytesRead = inputStream.read(buffer)) != -1) {
							outputStream.write(buffer, 0, bytesRead);
						}
						byte[] imageBytes = outputStream.toByteArray();
						String base64Image = Base64.getEncoder().encodeToString(imageBytes);
						inputStream.close();
						outputStream.close();

						cart.setImage(base64Image);
						book.add(cart);
					}
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		} catch (IOException e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
		return book;
	}

	public List<Product> getCategoryProducts(String name) {
		List<Product> products = new ArrayList<>();
		try {
			query = "select * from products where category=?";
			pst = this.con.prepareStatement(query);
			pst.setString(1, name);
			rs = pst.executeQuery();

			while (rs.next()) {
				Product product = new Product();
				product.setId(rs.getInt("id"));
				product.setName(rs.getString("name"));
				product.setDescription(rs.getString("description"));
				product.setDetail(rs.getString("details"));
				product.setCategory(rs.getString("category"));
				product.setPrice(rs.getDouble("price"));
				product.setStatus(rs.getString("status"));

				Blob blob = (Blob) rs.getBlob("image");
				InputStream inputStream = blob.getBinaryStream();
				ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
				byte[] buffer = new byte[4096];
				int bytesRead = -1;
				while ((bytesRead = inputStream.read(buffer)) != -1) {
					outputStream.write(buffer, 0, bytesRead);
				}
				byte[] imageBytes = outputStream.toByteArray();
				String base64Image = Base64.getEncoder().encodeToString(imageBytes);
				inputStream.close();
				outputStream.close();

				product.setImage(base64Image);

				products.add(product);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		} catch (IOException e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
		return products;
	}
	
	public boolean addCategory(String name) {
		try {
			query = "insert into category (name) value (?)";
			pst = this.con.prepareStatement(query);

			pst.setString(1, name);

			int rowCount = pst.executeUpdate();

			if (rowCount == 0) {
				return false;
			}

		} catch (SQLException e) {
			System.out.print(e.getMessage());
		} /*
			 * catch (FileNotFoundException e) { System.out.print(e.getMessage()); }
			 */
		return true;
	} 

	public double getTotalCartPrice(ArrayList<Cart> cartList) {
		double sum = 0;
		try {
			if (cartList.size() > 0) {
				for (Cart item : cartList) {
					query = "select price from products where id=?";
					pst = this.con.prepareStatement(query);
					pst.setInt(1, item.getId());
					rs = pst.executeQuery();
					while (rs.next()) {
						sum += rs.getDouble("price") * item.getQuantity();
					}

				}
			}

		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
		return sum;
	}

	public List<String> getAllCategories() {
		List<String> categories = new ArrayList<>();
		try {

			query = "select * from category";
			pst = this.con.prepareStatement(query);
			rs = pst.executeQuery();

			while (rs.next()) {
				// category.add(Integer.toString(rs.getInt("id")));
				categories.add(rs.getString("name"));
			}

		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
		return categories;
	}
}
