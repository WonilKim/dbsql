package h2sqlconnecton;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class H2SQLConnection1 {
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		Connection con = null;
		Statement st = null;
		ResultSet rs = null;

		try {
			String driver = "org.h2.Driver";
			String url = "jdbc:h2:~/telephone";
			String username = "scott";
			String password = "tiger";
						
			Class.forName(driver); // 드라이버를 메모리에 로드
			con = DriverManager.getConnection(url, username, password);
			
			st = con.createStatement();
			rs = st.executeQuery("select * from dept order by dno");
			
			while(rs.next()) {
				System.out.println(String.format("%s,%s,%d", 
						rs.getString("dno"), rs.getString("dname"), 
						rs.getInt("budget")));
				
			}

		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(st != null) st.close();
				if(con != null) con.close();
				
			} catch(Exception e) {
				e.printStackTrace();
			}
		}


	}

}
