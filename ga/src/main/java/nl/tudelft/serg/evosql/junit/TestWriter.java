package nl.tudelft.serg.evosql.junit;

import java.util.Map;

import nl.tudelft.serg.evosql.fixture.Fixture;
import nl.tudelft.serg.evosql.fixture.FixtureRow;
import nl.tudelft.serg.evosql.fixture.FixtureTable;

public class TestWriter {

	private StringBuilder test;
	private int indent;
	
	public TestWriter() {
		this.test = new StringBuilder();
		indent = 0;
	}
	
	public String create(Fixture fixture) {
		
		addLine("public class SQLTest extends EvoSQLDBTestBase {");
		addLine("@Test");
		addLine("public void test1() {");
		
		writeInsert(fixture);
		writeInvocation();
		writeAsserts();
		
		addLine("}\n");
		addLine("}\n");
		
		return test.toString();
	}

	private void writeInvocation() {
		addLine();
		addLine("// TODO: in here, you should invoke your SQL");
		/*for(SimpleLogicalCondition condition : path.getConditions()) {
			addLine("// replace " + condition.getColumn().getName() + " by " + condition.getValue());
		}*/
	}

	private void writeInsert(Fixture fixture) {
		for(FixtureTable table : fixture.getTables()) {
			for(FixtureRow row : table.getRows()) {
				addLine("insert(\"" + table.getName() + "\", " + inlineMap(row.getValues()) + ");");
			}
		}
	}

	private void writeAsserts() {
		addLine();
		addLine("// TODO: in here you should do the assert.");
		addLine("// you should expect the following rows to be returned:");
	}

	private String inlineMap(Map<String, String> values) {
		StringBuilder map = new StringBuilder();
		map.append("new HashMap<String, String>() {{ ");
		for(Map.Entry<String, String> kv : values.entrySet()) {
			map.append("put(\"" + kv.getKey() + "\", \"" + kv.getValue() + "\"); " );
		}
		map.append("}}");
		
		return map.toString();
		
	}

	private void addLine() {
		addLine("");
	}
	
	private void addLine(String line) {
		if(line.trim().equals("}")) indent--;
		for(int i = 0; i < indent; i++) test.append("\t");
		test.append(line + "\n");
		if(!line.trim().equals("}") && line.contains("}")) indent--;
		if(line.contains("{")) indent++;
		
	}
}
