package h2sqlconnecton;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class H2SQLConnection {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		Connection con = null;
		
		try {
//			String driver = "com.mysql.cj.jdbc.Driver";
//			String url = "jdbc:mysql://localhost:3306/world";
			String driver = "org.h2.Driver";
			String url = "jdbc:h2:~/telephone";
			String username = "scott";
			String password = "tiger";
			
			// Step 1
			Class.forName(driver); // 드라이버를 메모리에 로드
			// Step 2
			// connection 객체를 가져옴
			con = DriverManager.getConnection(url, username, password);
			
			System.out.println("Connection Success");
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}

	}

}
