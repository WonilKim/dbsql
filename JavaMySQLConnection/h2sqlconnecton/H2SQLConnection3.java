package h2sqlconnecton;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Random;

public class H2SQLConnection3 {
	
	Connection con = null;
	
	private boolean connectDB() {
		try {
			String driver = "org.h2.Driver";
			String url = "jdbc:h2:~/telephone";
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
//		System.out.println("sql2 = " + sql2);
		
		try {
			
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
			
			int cnt = con.createStatement().executeUpdate(sql2);
			
			System.out.println(cnt + "개의 레코드가 수정되었습니다.");
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	private int createContactTable() {
		String query = 
				"CREATE TABLE IF NOT EXISTS `contact` (" +
					"`cid` INT NOT NULL AUTO_INCREMENT," +
					"`name` VARCHAR(20) NOT NULL," +
					"`category` ENUM('friend', 'company', 'family', 'etc') NULL DEFAULT 'friend'," +
					"`address` VARCHAR(50) NULL DEFAULT ''," +
					"`company` VARCHAR(50) NULL DEFAULT ''," +
					"`birthday` DATE NULL," +
					"PRIMARY KEY (`cid`))";
		
		try {
			
			int cnt = con.createStatement().executeUpdate(query);
			
			System.out.println(cnt + " 개 테이블이 생성되었습니다.");
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	
		return 0;
	}

	private int createPhoneTable() {
		String query = 
				"CREATE TABLE IF NOT EXISTS `phone` (" + 
					"`cid` INT NOT NULL," + 
					"`seq` INT NOT NULL," + 
					"`number` VARCHAR(20) NULL DEFAULT ''," +
					"`type` ENUM('mobile', 'home', 'company', 'fax', 'etc') NULL DEFAULT 'mobile'," +
//					"INDEX `fk_phone_contact_idx` (`cid` ASC) VISIBLE," +
					"PRIMARY KEY (`seq`)," +
//					"CONSTRAINT `fk_phone_contact`" +
					"FOREIGN KEY (`cid`)" + 
					"REFERENCES `contact` (`cid`)" + 
					"ON DELETE NO ACTION " + 
					"ON UPDATE NO ACTION)";
		try {
			
			int cnt = con.createStatement().executeUpdate(query);
			
			System.out.println(cnt + " 개 테이블이 생성되었습니다.");
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	
		return 0;
	}
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		H2SQLConnection3 db = new H2SQLConnection3();
		if(db.connectDB()) {
//			db.insertDept("d2", "temp2", 9500000);
//			db.insertDeptStatement("d3", "temp3", 9500000);
//			db.deleteDeptTrigger(3, 4);
//			db.deleteDeptTriggerStatement(8, 10);		
//			db.updateDept("d35", "temp35", 5500000);
//			db.updateDeptStatement("d36", "temp36", 5500000);

			
//			Random r = new Random(System.currentTimeMillis());
//			
//			int count = 100;
//			int offset = 104;
//			String dno;
//			String dname;
//			int budget;
//			
//			for (int i = 0; i < count; i++) {
//				// data[i] = r.nextInt(100);
//				dno = String.format("d%d", i + offset);
//				dname = String.format("dept%d", i + offset);
//				budget = 100000 * (i + offset);
//				
//				db.insertDept(dno, dname, budget);
//			}

			db.createContactTable();
			db.createPhoneTable();
			
			//
			db.closeDB();
		}
	}

	
}