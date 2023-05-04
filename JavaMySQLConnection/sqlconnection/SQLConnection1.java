package sqlconnection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class SQLConnection1 {
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		Connection con = null;
		Statement st = null;
		ResultSet rs = null;

		try {
			String driver = "com.mysql.cj.jdbc.Driver";
			String url = "jdbc:mysql://localhost:3306/warehouse";
			String username = "scott";
			String password = "tiger";
						
			Class.forName(driver); // 드라이버를 메모리에 로드
			con = DriverManager.getConnection(url, username, password);
			
			st = con.createStatement();
			rs = st.executeQuery("select sno, pno, jno, qty from spj order by sno");
			
			while(rs.next()) {
				System.out.println(String.format("%s,%s,%s,%d", 
						rs.getString("sno"), rs.getString("pno"), 
						rs.getString("jno"), rs.getInt("qty")));
				
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
