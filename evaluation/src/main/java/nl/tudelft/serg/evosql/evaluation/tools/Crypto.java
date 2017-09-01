package nl.tudelft.serg.evosql.evaluation.tools;

import net.sf.jsqlparser.JSQLParserException;
import net.sf.jsqlparser.parser.CCJSqlParserUtil;
import net.sf.jsqlparser.statement.select.Select;
import nl.tudelft.serg.evosql.sql.parser.SqlSecurer;

public class Crypto {
	NameEncrypter ne = null;
	
	public Crypto() {
		try {
			ne = new NameEncrypter();
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}
	
	public void renewKey() {
		try {
			ne = new NameEncrypter();
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}
	
	public String encryptSQLSelect(String query) { 
		Select stmt = null;
		try {
			stmt = (Select) CCJSqlParserUtil.parse(query);
		} catch (JSQLParserException e) {
			throw new RuntimeException(e);
		}

		stmt.getSelectBody().accept(new CryptoVisitor(ne, true));

		return stmt.toString();
	}
	
	public String encryptName(String name) {
		try {
			return ne.transform(true, name);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}
	
	public String decryptSQLSelect(String query) { 
		Select stmt = null;
		try {
			stmt = (Select) CCJSqlParserUtil.parse(query);
		} catch (JSQLParserException e) {
			throw new RuntimeException(e);
		}

		stmt.getSelectBody().accept(new CryptoVisitor(ne, false));

		return stmt.toString();
	}
	
	public String decryptName(String name) {
		try {
			return ne.transform(false, name);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}
	
	public static void main (String[] args) {
		Crypto c = new Crypto();
		String sql = new SqlSecurer("SELECT col FROM table").getSecureSql();
		String enc = c.encryptSQLSelect(sql);
		System.out.println(enc);
		String dec = c.decryptSQLSelect(enc);
		System.out.println(dec);
	}
}
