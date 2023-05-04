package sqlconnection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class SQLConnection2 {
	
	Connection con = null;
	
	private boolean connectDB() {
		try {
			String driver = "com.mysql.cj.jdbc.Driver";
			String url = "jdbc:mysql://localhost:3306/warehouse";
			String username = "scott";
			String password = "tiger";
						
			Class.forName(driver); // 드라이버를 메모리에 로드
			con = DriverManager.getConnection(url, username, password);
			System.out.println("데이터베이스가 연결되었습니다.");
			return true;

		} catch(Exception e) {
			e.printStackTrace();
		} 
		return false;
	}
	
	private void closeDB() {
		try {
			con.close();
			System.out.println("데이터베이스가 닫혔습니다.");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	private void insertDept(String dno, String dname, int budget) {
		
		String sql = "insert into dept (dno, dname, budget) values (?, ?, ?)";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, dno);
			ps.setString(2, dname);
			ps.setInt(3, budget);
			
			// executeQuery 는 ResultSet 을 리턴, select
			// executeUpdate 는 적용 받는 레코드 수 리턴 (int), insert / delete / update
			ps.executeUpdate();
			
			System.out.println("데이터가 입력되었습니다.");
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	private void insertDeptStatement(String dno, String dname, int budget) {
		
		String sql2 = String.format(
				"insert into dept (dno, dname, budget) values ('%s', '%s', %d)",
				dno, dname, budget);
		System.out.println("sql2 = " + sql2);
		
		try {
			PreparedStatement ps = con.prepareStatement(sql2);
			
			con.createStatement().executeUpdate(sql2);
			
			System.out.println("데이터가 입력되었습니다.");
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	private void deleteDeptTrigger(int from, int to) {
		
		String sql = "delete from depttrigger where ? <= id and id <= ?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, from);
			ps.setInt(2, to);
			
			// executeQuery 는 ResultSet 을 리턴, select
			// executeUpdate 는 적용 받는 레코드 수 리턴 (int), insert / delete / update
			int cnt = ps.executeUpdate();
			
			System.out.println(cnt + " 개 레코드가 삭제되었습니다.");
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	private void deleteDeptTriggerStatement(int from, int to) {
		
		String sql2 = String.format(
				"delete from depttrigger where %d <= id and id <= %d",
				from, to);
		System.out.println("sql2 = " + sql2);
		
		try {
			PreparedStatement ps = con.prepareStatement(sql2);
			
			int cnt = con.createStatement().executeUpdate(sql2);
			
			System.out.println(cnt + " 개 레코드가 삭제되었습니다.");
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	private void updateDept(String dno, String dname, int budget) {
		
		String sql = "update dept set dname = ?, budget = ? where dno = ?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, dname);
			ps.setInt(2, budget);
			ps.setString(3, dno);	
			
			// executeQuery 는 ResultSet 을 리턴, select
			// executeUpdate 는 적용 받는 레코드 수 리턴 (int), insert / delete / update
			int cnt = ps.executeUpdate();
			
			System.out.println(cnt + "개의 레코드가 수정되었습니다.");
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	private void updateDeptStatement(String dno, String dname, int budget) {
		
		String sql2 = String.format(
				"update dept set dname = '%s', budget = %d where dno ='%s'",
				dname, budget, dno);
		System.out.println("sql2 = " + sql2);
		
		try {
			PreparedStatement ps = con.prepareStatement(sql2);
			
			int cnt = con.createStatement().executeUpdate(sql2);
			
			System.out.println(cnt + "개의 레코드가 수정되었습니다.");
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		SQLConnection2 db = new SQLConnection2();
		if(db.connectDB()) {
//			db.insertDept("d35", "temp35", 9500000);
//			db.insertDeptStatement("d36", "temp36", 9500000);
//			db.deleteDeptTrigger(3, 4);
//			db.deleteDeptTriggerStatement(8, 10);
			
			db.updateDept("d35", "temp35", 5500000);
			db.updateDeptStatement("d36", "temp36", 5500000);

			
			//
			db.closeDB();
		}
	}
}
