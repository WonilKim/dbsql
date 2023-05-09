package mission;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.util.Scanner;
import java.util.function.Function;

class MysqlConnector {

	private String schema;

	MysqlConnector(String schema) {
		this.schema = schema;
	}

	Connection con = null;
	Statement st = null;
	ResultSet rs = null;

	Function[] funcList = new Function[34];

	private ResultSet executeSelectQuery(String query) {

		try {
			st = con.createStatement();
			return st.executeQuery(query);

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

	}

	private void showResultSet(ResultSet rs) {

		try {
			StringBuffer sqlString;
			ResultSetMetaData rsmd = rs.getMetaData();
			int columnCount = rsmd.getColumnCount();
			String[] columnNames = new String[columnCount];
			for (int i = 0; i < columnNames.length; i++) {
				columnNames[i] = rsmd.getColumnName(i + 1);
			}

			System.out.println("-".repeat(columnCount * 19));
			System.out.print("| ");
			for (String col : columnNames) {
				// System.out.print(col + "\t");
				System.out.print(String.format("%-17s", col));
				System.out.print("| ");
			}
			System.out.println();
			System.out.println("-".repeat(columnCount * 19));

			if (rs != null) {
				while (rs.next()) {
					sqlString = new StringBuffer();
					sqlString.append("| ");

					for (int i = 1; i <= columnCount; i++) {
						Object obj = rs.getObject(i);

						if (obj == null) {
							sqlString.append("null");
							sqlString.append("\t| ");
						} else {
							int sqlTypes = rsmd.getColumnType(i);
							String temp = "";

							switch (sqlTypes) {
								case Types.VARCHAR:
								case Types.CHAR:
									temp = String.format("\"%s\"", rs.getString(i));
									sqlString.append(String.format("%-17s", temp));
									sqlString.append("| ");
									break;
								case Types.NULL:
									temp = "null";
									sqlString.append(String.format("%-17s", temp));
									sqlString.append("| ");
									break;
								case Types.TIMESTAMP:
									temp = String.format("\"%s\"", rs.getTimestamp(i));
									sqlString.append(String.format("%-17s", temp));
									sqlString.append("| ");
									break;

								case Types.DOUBLE:
									temp = String.format("%s", rs.getDouble(i));
									sqlString.append(String.format("%-17s", temp));
									sqlString.append("| ");
									break;

								case Types.INTEGER:
								case Types.BIGINT:
								case Types.SMALLINT:
									temp = String.format("%s", rs.getInt(i));
									sqlString.append(String.format("%-17s", temp));
									sqlString.append("| ");
									break;
								case Types.DECIMAL:
									temp = String.format("%s", rs.getBigDecimal(i));
									sqlString.append(String.format("%-17s", temp));
									sqlString.append("| ");
									break;

								/*
								 * default:
								 * if (obj != null)
								 * sqlString.append(obj.toString());
								 * 
								 * sqlString.append(",");
								 * break;
								 */
							} // switch

						} // else

					} // for

					System.out.println(sqlString);

				}
				System.out.println("-".repeat(columnNames.length * 19));

			} // if (rs != null)

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	private String[] getColumnNamesFromQuery(String query) {
		String temp = query.substring(query.indexOf("select") + "select".length() + 1, query.indexOf("from")).trim();
		// System.out.println(temp);

		String[] arr = temp.split(",");

		for (int i = 0; i < arr.length; i++) {
			arr[i] = arr[i].trim();
		}

		return arr;
	}

	private void func1() {
		// System.out.println("func1");

		System.out.println("# 1. 런던에 있는 프로젝트 이름을 찾아라");
		String query = "select jname from j where city='London'";

		rs = executeSelectQuery(query);
		showResultSet(rs);

	}

	private void func2() {
		// System.out.println("func2");

		System.out.println("# 2. 프로젝트 j1에 참여하는 공급자의 이름을 찾아라");
		String query = "select sno, sname, jno from s join spj using(sno) where jno='j1'";

		rs = executeSelectQuery(query);
		showResultSet(rs);
	}

	private void func3() {
		// System.out.println("func3");

		System.out.println("# 3. 공급 수량이 300 이상 750 이하인 모든 공급의 sno, pno, qty 를 찾아라.");
		String query = "select sno, pno, qty from spj where 300 <= qty and qty <= 750";

		rs = executeSelectQuery(query);
		showResultSet(rs);
	}

	private void func4() {
		// System.out.println("func4");

		System.out.println("# 4. 부품의 color 와 city 의 모든 쌍을 찾아라. 같은 쌍은 한번만 검색되어야 한다.");
		String query = "select distinct p1.color, p1.city from p as p1, p as p2";

		rs = executeSelectQuery(query);
		showResultSet(rs);
	}

	private void func5() {
		// System.out.println("func5");

		System.out.println("# 5. 같은 도시에 있는 공급자, 부품, 프로젝트의 모든 sno, pno, jno 쌍을 찾아라.\n" +
				"#	찾아진 sno, pno, jno 의 city 들은 모두 같아야 한다.");
		String query = "select sno, pno, jno, s.city, p.city, j.city from s, p, j where s.city = p.city and p.city = j.city;";

		rs = executeSelectQuery(query);
		showResultSet(rs);
	}

	private void func6() {
		// System.out.println("func6");

		System.out.println("# 6. 같은 도시에 있지 않은 공급자, 부품, 프로젝트의 모든 sno, pno, jno 쌍을 찾아라.\n" +
				"#	찾아진 sno, pno, jno 의 city 들은 모두 같아야 한다.");
		String query = "select sno, pno, jno, s.city, p.city, j.city from s, p, j where s.city != p.city and p.city != j.city and j.city != s.city;";

		rs = executeSelectQuery(query);
		showResultSet(rs);
	}

	private void func7() {
		// System.out.println("func7");

		System.out.println("# 7. London에 있는 공급자에 의해 공급된 부품의 번호, 이름을 찾아라.");
		String query = "select pno, pname " +
				"from p " +
				"where pno in ( " +
				"select pno " +
				"from spj " +
				"where spj.sno in (select sno from s where city='London') " +
				");";

		rs = executeSelectQuery(query);
		showResultSet(rs);
	}

	private void func8() {
		// System.out.println("func8");

		System.out.println("8. London 에 있는 공급자가 London 의 프로젝트에 공급한 부품의 부품 번호와 이름을 찾아라.");
		String query = "select p.pno, p.pname " +
				"from s, p, spj " +
				"where s.sno=spj.sno and p.pno = spj.pno " +
				"and p.city='London' and s.city='London';";

		rs = executeSelectQuery(query);
		showResultSet(rs);
	}

	private void func9() {
		// System.out.println("func9");

		System.out.println("# 9. 한 도시에 있는 공급자가 다른 도시에 있는 프로젝트에 공급할 때\n" +
				"#	공급자 도시, 프로젝트 도시 쌍을 모두 구하라.");
		String query = "select distinct s.city, j.city " +
				"from s, j, spj " +
				"where s.sno=spj.sno and j.jno = spj.jno " +
				"and s.city != j.city " +
				"order by s.city, j.city;";

		rs = executeSelectQuery(query);
		showResultSet(rs);
	}

	private void func10() {
		// System.out.println("func10");

		System.out.println("# 10. 한 도시에 있는 공급자가 같은 도시에 있는 프로젝트에 공급하는 부품의 부품 번호와 이름을 찾아라.");
		String query = "select p.pno, p.pname, s.city, j.city " +
				"from s, j, p, spj " +
				"where s.sno=spj.sno and p.pno = spj.pno and j.jno = spj.jno " +
				"and s.city = j.city;";

		rs = executeSelectQuery(query);
		showResultSet(rs);
	}

	private void func11() {
		// System.out.println("func11");

		System.out.println("# 11. 같은 도시에 있지 않은, 적어도 한 명 이상의 공급자들에 의해 공급되고 있는 프로젝트의 번호와 이름을 찾아라.");
		String query = "select temp.jno, temp.jname, count(temp.sno) " +
				"from ( " +
				"select s.sno, j.jno, j.jname " +
				"from s, j, spj " +
				"where s.sno=spj.sno and j.jno = spj.jno " +
				"and s.city != j.city " +
				") as temp " +
				"group by jno " +
				"order by temp.jno;";

		rs = executeSelectQuery(query);
		showResultSet(rs);
	}

	private void func12() {
		// System.out.println("func12");

		System.out.println("12. 어떤 공급자가 2개 이상의 부품을 공급할 때 공급된 부품 sno의 리스트를 찾아라.\n" +
				"#	부품이 1개 공급한 경우는 제외한다.");
		String query = "select s.sno, p.pno " +
				"from s, p, spj " +
				"where s.sno = spj.sno and p.pno = spj.pno " +
				"and s.sno in " +
				"( " +
				"select sno " +
				"from( " +
				"select temp.sno, count(temp.pno) as part_cnt " +
				"from( " +
				"select distinct s.sno, p.pno " +
				"from s, p, spj " +
				"where s.sno = spj.sno and p.pno = spj.pno " +
				"order by sno, pno " +
				") as temp " +
				"group by temp.sno " +
				"having part_cnt > 1 " +
				") as temp2 " +
				") " +
				"order by s.sno;";

		rs = executeSelectQuery(query);
		showResultSet(rs);
	}

	private void func13() {
		// System.out.println("func13");

		System.out.println("# 13. 공급자 s1이 공급한 프로젝트 개수를 찾아라.");
		String query = "select count(*) " +
				"from s, j, spj " +
				"where s.sno=spj.sno and j.jno = spj.jno " +
				"and s.sno='s1';";

		rs = executeSelectQuery(query);
		showResultSet(rs);
	}

	private void func14() {
		// System.out.println("func14");

		System.out.println("# 14. 공급자 s1이 공급한 부품 p1 의 전체 수량을 찾아라.");
		String query = "select sum(qty) " +
				"from s, p, spj " +
				"where s.sno=spj.sno and p.pno = spj.pno " +
				"and s.sno='s1' and p.pno='p1';";

		rs = executeSelectQuery(query);
		showResultSet(rs);
	}

	private void func15() {
		// System.out.println("func15");

		System.out.println("# 15. 프로젝트에 공급된 각 부품에 대하여, 각 부품 번호, 공급된 프로젝트 번호, 각 프로젝트에 공급된 수량을 찾아라.");
		String query = "select p.pno, j.jno, sum(spj.qty) " +
				"from p, j, spj " +
				"where p.pno=spj.pno and j.jno = spj.jno " +
				"group by p.pno, j.jno " +
				"order by p.pno, j.jno;";

		rs = executeSelectQuery(query);
		showResultSet(rs);
	}

	private void func16() {
		// System.out.println("func16");

		System.out.println("# 16. any 프로젝트에 공급된 부품의 수량 평균이 350 이상인 부품의 번호를 찾아라.\n" +
				"#	부품이 여러 프로젝트 공급되는데 공급된 부품 수량의 평균(부품 수량을 프로젝트 개수로 나눈)이 350 이상 되는 것을 말한다.");
		String query = "select j.jno, p.pno, avg(spj.qty) as avg_qty " +
				"from p, j, spj " +
				"where p.pno=spj.pno and j.jno = spj.jno " +
				"group by j.jno, p.pno " +
				"having avg_qty >= 350 " +
				"order by j.jno, p.pno;";

		rs = executeSelectQuery(query);
		showResultSet(rs);
	}

	private void func17() {
		// System.out.println("func17");

		System.out.println("# 17. 공급자 s1이 공급한 프로젝트 번호와 이름을 찾아라.");
		String query = "select s.sno, j.jno, j.jname " +
				"from s, j, spj " +
				"where s.sno=spj.sno and j.jno = spj.jno " +
				"and s.sno='s1' " +
				"order by s.sno;";

		rs = executeSelectQuery(query);
		showResultSet(rs);
	}

	private void func18() {
		// System.out.println("func18");

		System.out.println("# 18. 공급자 s1이 공급한 부품의 color 를 찾아라");
		String query = "select distinct s.sno, p.pno, p.color " +
				"from s, p, spj " +
				"where s.sno=spj.sno and p.pno = spj.pno " +
				"and s.sno='s1' " +
				"order by s.sno;";

		rs = executeSelectQuery(query);
		showResultSet(rs);
	}

	private void func19() {
		// System.out.println("func19");

		System.out.println("# 19. London에 있는 프로젝트에 공급한 부품의 번호와 이름을 찾아라.");
		String query = "select j.jno, p.pno, p.pname " +
				"from j, p, spj " +
				"where j.jno=spj.jno and p.pno = spj.pno " +
				"and j.city='London' " +
				"order by j.jno, p.pno, p.pname;";

		rs = executeSelectQuery(query);
		showResultSet(rs);
	}

	private void func20() {
		// System.out.println("func20");

		System.out.println("# 20. 공급자 s1 이 공급한 anny 부품을 적어도 한 개 이상 사용하는 프로젝트의 번호와 이름을 찾아라");
		String query = "select j.jno, s.sno, p.pno " +
				"from s, p, j, spj " +
				"where s.sno=spj.sno and j.jno=spj.jno and p.pno = spj.pno " +
				"and s.sno='s1' " +
				"and j.jno in (    " +
				"select temp.jno " +
				"from( " +
				"select j.jno, count(p.pno) as part_cnt " +
				"from s, p, j, spj " +
				"where s.sno=spj.sno and j.jno=spj.jno and p.pno = spj.pno " +
				"and s.sno='s1' " +
				"group by j.jno " +
				"having part_cnt >= 1 " +
				") as temp " +
				");";

		rs = executeSelectQuery(query);
		showResultSet(rs);
	}

	private void func21() {
		// System.out.println("func21");

		System.out.println("# 21. 적어도 한 개 이상의 red 부품을 공급하는 적어도 한 명 이상의 공급자들이 공급하는 \n" +
				"#	적어도 한개 이상의 부품을 공급하는 공급자의 번호와 이름을 찾아라");
		String query = "";

		// rs = executeSelectQuery(query);
		// showResultSet(rs);

		System.out.println("# 질문 이해 안됨");
	}

	private void func22() {
		// System.out.println("func22");

		System.out.println("# 22. 공급자 s1의 status 값보다 더 낮은 status 를 갖는 공급자의 번호와 이름을 찾아라");
		String query = "select sno, sname, status from s where status < (select status from s where sno='s1');";

		rs = executeSelectQuery(query);
		showResultSet(rs);
	}

	private void func23() {
		// System.out.println("func23");

		System.out.println("# 23. 프로젝트의 city 목록에서 알파벳 순서에서 첫번째 도시의 프로젝트 번호와 이름을 찾아라");
		String query = "select * from j order by city limit 1;";

		rs = executeSelectQuery(query);
		showResultSet(rs);
	}

	private void func24() {
		// System.out.println("func24");

		System.out.println("# 24. 부품 p1의 프로젝트 공급 수량의 평균이 프로젝트 j1에 공급된\n" +
				"#	any 부품의 최대 수량보다 더 큰 프로젝트의 번호와 이름을 찾아라.\n" +
				"#	부품 p1은 공급자 s1, s2, ..., sn 에 의하여 각프로젝트에 공급될 때 각 공급자의 공급 수량의 평균을 구한다.");
		String query = "";

		// rs = executeSelectQuery(query);
		// showResultSet(rs);

		System.out.println("# 질문 이해 안됨");
	}

	private void func25() {
		// System.out.println("func25");

		System.out.println("# 25. 부품 p1을 어던 프로젝트에 공급하는 수량이 그 프로젝트를 위한 부품 p1의 평균 공급 수량\n" +
				"#	(평균 공급 수량은 각 공급자가 공급하는 수량의 평균이다)보다 더 큰 공급자의 번호와 이름을 찾아라. ");
		String query = "";

		// rs = executeSelectQuery(query);
		// showResultSet(rs);

		System.out.println("# 질문 이해 안됨");
	}

	private void func26() {
		// System.out.println("func26");

		System.out.println("# 26. London 에 있는 공급자에 의해 어떠한 red 부품도 공급받지 않는 프로젝트의 번호와 이름을 찾아라.");
		String query = "select * " +
				"from j " +
				"where j.jno not in ( " +
				"select j.jno " +
				"from s, p, j, spj " +
				"where s.sno=spj.sno and j.jno=spj.jno and p.pno = spj.pno and s.city='London' " +
				");";

		rs = executeSelectQuery(query);
		showResultSet(rs);
	}

	private void func27() {
		// System.out.println("func27");

		System.out.println("# 27. 공급자 s1에 의해서만 부품을 공급받는 프로젝트의 번호와 이름을 찾아라.");
		String query = "select j.jno, count(s.sno) as cnt " +
				"from s, p, j, spj " +
				"where s.sno=spj.sno and j.jno=spj.jno and p.pno = spj.pno " +
				"group by j.jno " +
				"having cnt = 1;";

		rs = executeSelectQuery(query);
		showResultSet(rs);
	}

	private void func28() {
		// System.out.println("func28");

		System.out.println("# 28. London 에 있는 모든 프로젝트에 공급되는 부품의 번호와 이름을 찾아라");
		String query = "select p.pno, p.pname, j.city " +
				"from p, j, spj " +
				"where p.pno=spj.pno and j.jno = spj.jno " +
				"and j.city = 'London';";

		rs = executeSelectQuery(query);
		showResultSet(rs);
	}

	private void func29() {
		// System.out.println("func29");

		System.out.println("# 29. 모든 프로젝트에 같은 부품들을 공급하는 공급자의 번호와 이름을 찾아라.");
		String query = "select j.jno, p.pno, s.sno " +
				"from s, p, j, spj " +
				"where s.sno=spj.sno and j.jno=spj.jno and p.pno = spj.pno  " +
				"and j.jno in( " +
				"select j.jno " +
				"from s, p, j, spj " +
				"where s.sno=spj.sno and j.jno=spj.jno and p.pno = spj.pno " +
				"group by j.jno, p.pno " +
				"having count(s.sno) >= 2 " +
				"order by j.jno, p.pno " +
				") " +
				"and p.pno in( " +
				"select p.pno " +
				"from s, p, j, spj " +
				"where s.sno=spj.sno and j.jno=spj.jno and p.pno = spj.pno " +
				"group by j.jno, p.pno " +
				"having count(s.sno) >= 2 " +
				"order by j.jno, p.pno " +
				") " +
				"order by j.jno, p.pno, s.sno;";

		rs = executeSelectQuery(query);
		showResultSet(rs);

		System.out.println("# 결과가 정확하지 않음");
	}

	private void func30() {
		// System.out.println("func30");

		System.out.println("# 30. 공급자 s1이 공급하는 모든 부품을 적어도 그 이상 공급받는 프로젝트의 번호와 이름을 찾아라.");
		String query = "";

		// rs = executeSelectQuery(query);
		// showResultSet(rs);

		System.out.println("# 구현하지 않음");
	}

	private void func31() {
		// System.out.println("func31");

		System.out.println("# 31. 적어도 한 공급자가 있는 city 이거나, 적어도 한 부품의 city 이거나,\n" +
				"#	적어도 한 프로젝트의 city 인 모든 city 이름을 찾아라.");
		String query = "";

		// rs = executeSelectQuery(query);
		// showResultSet(rs);

		System.out.println("# 구현하지 않음");
	}

	private void func32() {
		// System.out.println("func32");

		System.out.println("# 32. London 에 있는 공급자에 의해서 공급되거나 London 에 있는 프로젝트에 공급된 부품의 번호와 이름을 찾아라.");
		String query = "";

		// rs = executeSelectQuery(query);
		// showResultSet(rs);

		System.out.println("# 구현하지 않음");
	}

	private void func33() {
		// System.out.println("func33");

		System.out.println("# 33. 어떤 부품을 공급하지 않는 공급자 또는 어떤 고급자에 의해서도 공급되지 않는 부품의 공급자 번호, 부품 번호 쌍을 찾아라.");
		String query = "";

		// rs = executeSelectQuery(query);
		// showResultSet(rs);

		System.out.println("# 구현하지 않음");
	}

	private void func34() {
		// System.out.println("func34");

		System.out.println("# 34. 같은 종류의 부품들을 공급하는 고급자 쌍을 공급자 번호의 쌍으로 찾아라.");
		String query = "";

		// rs = executeSelectQuery(query);
		// showResultSet(rs);

		System.out.println("# 구현하지 않음");
	}

	interface QueryRunner {
		void Run();
	}

	private QueryRunner[] runner = new QueryRunner[] { new QueryRunner() {
		public void Run() {
			func1();
		}
	}, new QueryRunner() {
		public void Run() {
			func2();
		}
	}, new QueryRunner() {
		public void Run() {
			func3();
		}
	}, new QueryRunner() {
		public void Run() {
			func4();
		}
	}, new QueryRunner() {
		public void Run() {
			func5();
		}
	}, new QueryRunner() {
		public void Run() {
			func6();
		}
	}, new QueryRunner() {
		public void Run() {
			func7();
		}
	}, new QueryRunner() {
		public void Run() {
			func8();
		}
	}, new QueryRunner() {
		public void Run() {
			func9();
		}
	}, new QueryRunner() {
		public void Run() {
			func10();
		}
	}, new QueryRunner() {
		public void Run() {
			func11();
		}
	}, new QueryRunner() {
		public void Run() {
			func12();
		}
	}, new QueryRunner() {
		public void Run() {
			func13();
		}
	}, new QueryRunner() {
		public void Run() {
			func14();
		}
	}, new QueryRunner() {
		public void Run() {
			func15();
		}
	}, new QueryRunner() {
		public void Run() {
			func16();
		}
	}, new QueryRunner() {
		public void Run() {
			func17();
		}
	}, new QueryRunner() {
		public void Run() {
			func18();
		}
	}, new QueryRunner() {
		public void Run() {
			func19();
		}
	}, new QueryRunner() {
		public void Run() {
			func20();
		}
	}, new QueryRunner() {
		public void Run() {
			func21();
		}
	}, new QueryRunner() {
		public void Run() {
			func22();
		}
	}, new QueryRunner() {
		public void Run() {
			func23();
		}
	}, new QueryRunner() {
		public void Run() {
			func24();
		}
	}, new QueryRunner() {
		public void Run() {
			func25();
		}
	}, new QueryRunner() {
		public void Run() {
			func26();
		}
	}, new QueryRunner() {
		public void Run() {
			func27();
		}
	}, new QueryRunner() {
		public void Run() {
			func28();
		}
	}, new QueryRunner() {
		public void Run() {
			func29();
		}
	}, new QueryRunner() {
		public void Run() {
			func30();
		}
	}, new QueryRunner() {
		public void Run() {
			func31();
		}
	}, new QueryRunner() {
		public void Run() {
			func32();
		}
	}, new QueryRunner() {
		public void Run() {
			func33();
		}
	}, new QueryRunner() {
		public void Run() {
			func34();
		}
	}, };

	protected void Run(int command) {
		runner[command - 1].Run();
	}

	protected boolean connectDB() {
		try {
			String driver = "com.mysql.cj.jdbc.Driver";
			String url = "jdbc:mysql://localhost:3306/" + this.schema;
			String username = "scott";
			String password = "tiger";

			Class.forName(driver); // 드라이버를 메모리에 로드
			con = DriverManager.getConnection(url, username, password);
			System.out.println("데이터베이스가 연결되었습니다.");
			return true;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	protected void closeDB() {
		try {
			con.close();
			System.out.println("데이터베이스가 닫혔습니다.");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public int getFunctionCount() {
		return runner.length;
	}

}

public class Mission {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		MysqlConnector db = new MysqlConnector("warehouse");
		if (db.connectDB()) {

			Scanner sc = new Scanner(System.in);

			int functionCount = db.getFunctionCount();

			while (true) {
				System.out.println();
				System.out.println("실행을 원하는 과제의 번호를 입력하세요. ( 1 ~ " + functionCount + " / 종료:엔터)");
				String c = sc.nextLine();
				// System.out.println("c = " + c);
				int command = 0;
				if (c == "") {
					System.out.println("프로그램을 종료합니다.");
					break;
				} else {
					try {
						command = Integer.parseInt(c);
					} catch (NumberFormatException e) {
						command = -1;
					}
				}

				if ((command < 1) || (functionCount < command)) {
					System.out.println("잘못된 과제 번호를 입력하셨습니다.");
					continue;
				}

				// System.out.println("command = " + command);
				db.Run(command);

			}

			sc.close();

			//
			db.closeDB();
		}
	}

}
