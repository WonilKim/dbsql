package mysqlconnection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Random;

public class SQLConnection3 {
	
	Connection con = null;
	
	private boolean connectDB() {
		try {
			String driver = "com.mysql.cj.jdbc.Driver";
			String url = "jdbc:mysql://localhost:3306/telephone";
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

	private void insertContactStatement(int totcnt) {
		try {
			
			String cates[] = {"friend", "company", "family", "etc"};
			Random rand = new Random(System.currentTimeMillis());
			
			long startTime = System.currentTimeMillis();
			
			for (int i = 1; i <= totcnt; i++) {
				String name = "name" + i;
				String category = cates[rand.nextInt(4)];
				String address = "addr" + i;
				String company = "company" + i;
				String birthday = String.format("%4d-%02d-%02d", 
						rand.nextInt(1950, 2022), rand.nextInt(1, 13), rand.nextInt(1, 29));
					
				String sql = String.format(
						"insert into contact (name, category, address, company, birthday) "
						+ "values ('%s', '%s', '%s', '%s', '%s')",
						name, category, address, company, birthday);
	
				con.createStatement().executeUpdate(sql);
				
				System.out.println(String.format("%.2f %% : %d / %d", i*100/(double)totcnt, i, totcnt ));
				
			}
			
			long elapsedTime = System.currentTimeMillis() - startTime;
			System.out.println("Elapsed time = " + elapsedTime + "ms");		
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	private void insertContact(String name, String category, String address, String company, String birthday) {
		try {
			
			long startTime = System.currentTimeMillis();
						
			String sql = String.format(
					"insert into contact (name, category, address, company, birthday) "
					+ "values (?, ?, ?, ?, ?)",
					name, category, address, company, birthday);
			
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, name);
			ps.setString(2, category);
			ps.setString(3, address);
			ps.setString(4, company);
			ps.setString(5, birthday);
			
			int cnt = ps.executeUpdate();
			
			System.out.println(String.format("%d data inserted", cnt));
				
			long elapsedTime = System.currentTimeMillis() - startTime;
			System.out.println("Elapsed time = " + elapsedTime + "ms");		
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	private void insertContactStatement(String name, String category, String address, String company, String birthday) {
		try {
			
			long startTime = System.currentTimeMillis();
						
			String sql = String.format(
					"insert into contact (name, category, address, company, birthday) "
					+ "values ('%s', '%s', '%s', '%s', '%s')",
					name, category, address, company, birthday);

			int cnt = con.createStatement().executeUpdate(sql);
			
			System.out.println(String.format("%d data inserted", cnt));
				
			long elapsedTime = System.currentTimeMillis() - startTime;
			System.out.println("Elapsed time = " + elapsedTime + "ms");		
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}


	private void deleteContactTrigger(int from, int to) {
		
		String sql = "delete from contact where ? <= cid and cid <= ?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, from);
			ps.setInt(2, to);
			
			int cnt = ps.executeUpdate();
			
			System.out.println(cnt + " data deleted");
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	private void deleteContactStatement(int from, int to) {
		
		String sql = String.format(
				"delete from contact where %d <= cid and cid <= %d",
				from, to);
//		System.out.println("sql = " + sql);
		
		try {
			
			int cnt = con.createStatement().executeUpdate(sql);
			
			System.out.println(cnt + " data deleted");
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	private void updateDept(int cid, String name, String category, String address, String company, String birthday) {
		
		String sql = "update contact set name = ?, category = ?, address = ?, company = ?, birthday = ? where cid = ?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, name);
			ps.setString(2, category);	
			ps.setString(3, address);	
			ps.setString(4, company);	
			ps.setString(5, birthday);	
			ps.setInt(6, cid);
			
			int cnt = ps.executeUpdate();
			
			System.out.println(cnt + " data updated");
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	private void updateDeptStatement(int cid, String name, String category, String address, String company, String birthday) {
		
		String sql = String.format("update contact set name = '%s', category = '%s', address = '%s', company = '%s', birthday = '%s' where cid = %d",
				name, category, address, company, birthday, cid);
//		System.out.println("sql = " + sql);
		
		try {
			
			int cnt = con.createStatement().executeUpdate(sql);
			
			System.out.println(cnt + " data updated");
			
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
		SQLConnection3 db = new SQLConnection3();
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
//
//			db.createContactTable();
//			db.createPhoneTable();
			
			db.insertContactStatement(1000000);
			
			//
			db.closeDB();
		}
	}

	
}