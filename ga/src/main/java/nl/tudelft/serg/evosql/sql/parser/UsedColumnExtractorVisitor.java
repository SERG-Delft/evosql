package nl.tudelft.serg.evosql.sql.parser;

import java.util.HashMap;
import java.util.Map;
import java.util.NoSuchElementException;
import java.util.Set;
import java.util.Stack;

import net.sf.jsqlparser.expression.*;
import net.sf.jsqlparser.expression.operators.arithmetic.*;
import net.sf.jsqlparser.expression.operators.conditional.AndExpression;
import net.sf.jsqlparser.expression.operators.conditional.OrExpression;
import net.sf.jsqlparser.expression.operators.relational.*;
import net.sf.jsqlparser.schema.Column;
import net.sf.jsqlparser.schema.Table;
import net.sf.jsqlparser.statement.select.*;
import net.sf.jsqlparser.statement.values.ValuesStatement;
import nl.tudelft.serg.evosql.EvoSQLConfiguration;
import nl.tudelft.serg.evosql.EvoSQLException;
import nl.tudelft.serg.evosql.fixture.type.DBDate;
import nl.tudelft.serg.evosql.fixture.type.DBDateTime;
import nl.tudelft.serg.evosql.fixture.type.DBString;
import nl.tudelft.serg.evosql.fixture.type.DBTime;
import nl.tudelft.serg.evosql.sql.ColumnSchema;
import nl.tudelft.serg.evosql.sql.TableSchema;

public class UsedColumnExtractorVisitor implements ExpressionVisitor, FromItemVisitor, ItemsListVisitor, SelectVisitor, SelectItemVisitor {
	Map<String, TableSchema> tableSchemas;
	Set<ColumnSchema> outputColumns;
	
	private State currentState;
	private Stack<State> stateStack;
	
	public int stringEqs, dateEqs;
	
	private enum SelectPhase {
		NONE,
		SELECT,
		FROM,
		WHERE,
		JOIN,
		HAVING
	}
	
	private class State {
		SelectPhase phase;
		Map<String, TableSource> visibleTableSources;
		Map<String, TableSource> stateLevelTableSources;
		TableSource stateSource;
		ColumnSource columnSource;
		boolean isOuterState;
		
		private State() {
			phase = SelectPhase.NONE;
			visibleTableSources = new HashMap<String, TableSource>();
			stateLevelTableSources = new HashMap<String, TableSource>();
			stateSource = null;
			columnSource = null;
			isOuterState = false;
		}
		
		/** Copy the tableSources to this state, so that they are still usable **/
		private State(State copyState) {
			phase = SelectPhase.NONE;
			visibleTableSources = new HashMap<String, TableSource>(copyState.visibleTableSources);
			stateLevelTableSources = new HashMap<String, TableSource>();
			isOuterState = false;
		}
		
		void storeTableSource(TableSource source) {
			visibleTableSources.put(source.alias, source);
			stateLevelTableSources.put(source.alias, source);
		}
	}
	
	private class TableSource {
		String name, alias;
		Map<String, ColumnSource> columnSources;

		TableSource(String tableName, String tableAlias) {
			if (tableName != null)
				this.name = tableName.replaceAll("^\"|\"$", "");
			if (tableAlias == null)
				alias = this.name;
			else
				alias = tableAlias.replaceAll("^\"|\"$", "");;
			
			columnSources = new HashMap<String, ColumnSource>();
		}
		
		void add(ColumnSource source) {
			columnSources.put(source.name, source);
		}
		
		ColumnSource get(String columnName) {
			return columnSources.get(columnName);
		}
		
		boolean contains(String columnName) {
			return columnSources.containsKey(columnName);
		}
	}
	
	/** Resembles a column with its schema and parent table's schema attached
	 *  
	 **/
	private class ColumnSource {
		String name;
		TableSource tableSource;
		
		ColumnSource(TableSource tableSource, String name) {
			this.tableSource = tableSource;
			this.name = name;
		}
	}
	
	UsedColumnExtractorVisitor(Map<String, TableSchema> tableSchemas, Set<ColumnSchema> outputColumns) {
		this.tableSchemas = tableSchemas;
		this.outputColumns = outputColumns;
		this.stringEqs = 0;
		currentState = new State();
		currentState.isOuterState = true;
		stateStack = new Stack<State>();
		stateStack.push(currentState);
	}
	
	private void sourceTable(String tableName, String tableAlias) {
		// Find TableSchema
		tableName = tableName.replaceAll("^\"|\"$", "");
		tableAlias = tableAlias.replaceAll("^\"|\"$", "");
		TableSchema schema = tableSchemas.get(tableName);
		
		if (schema == null)
			throw new EvoSQLException("Could not find table schema for table " + tableName);
		
		// Create a new TableSource
		TableSource tableSource = new TableSource(tableName, tableAlias);
		
		// Add all columns
		for (ColumnSchema cs : schema.getColumns()) {
			ColumnSource columnSource = new ColumnSource(tableSource, cs.getName());
			tableSource.add(columnSource);
		}
		
		// Store the source
		currentState.storeTableSource(tableSource);
	}
	
	/**  
	 * 	 Extract all ColumnSources from the current levels tables (FROM + JOINs) into the currentState.stateSource 
	 *   
	 *   If tableName is provided, only source the tables columns.
	 *   
	 **/
	private void sourceAllColumns(String tableName) {
		if (tableName != null)
			tableName = tableName.replaceAll("^\"|\"$", "");
		
		for (TableSource ts : currentState.stateLevelTableSources.values()) {
			if (tableName == null || tableName.equals(ts.alias)) {
				for (ColumnSource cs : ts.columnSources.values()) {
					ColumnSource newSource = new ColumnSource(currentState.stateSource, cs.name);
					currentState.stateSource.add(newSource);
				}
			}
		}
	}

	private void addUsedColumn(String columnName, String tableName) {
		if (tableName != null)
			tableName = tableName.replaceAll("^\"|\"$", "");
		columnName = columnName.replaceAll("^\"|\"$", "");
		
		ColumnSource source = getColumnSource(columnName, tableName);
		
		addColumnSourceToOutput(source);
	}
	
	/**
	 * Add all columns (from a given table name or all state visible tables)
	 */
	private void useAllColumns(String tableName) {
		if (tableName != null)
			tableName = tableName.replaceAll("^\"|\"$", "");
		
		for (TableSource ts : currentState.stateLevelTableSources.values()) {
			if (tableName == null || tableName.equals(ts.alias)) {
				for (ColumnSource cs : ts.columnSources.values()) {
					addColumnSourceToOutput(cs);
				}
			}
		}
	}
	
	private void linkColumns(String column1Name, String table1Name, String column2Name, String table2Name) {
		if (table1Name != null)
			table1Name = table1Name.replaceAll("^\"|\"$", "");
		column1Name = column1Name.replaceAll("^\"|\"$", "");

		if (table2Name != null)
			table2Name = table2Name.replaceAll("^\"|\"$", "");
		column2Name = column2Name.replaceAll("^\"|\"$", "");
		
		// Get sources
		ColumnSource source1 = getColumnSource(column1Name, table1Name);
		ColumnSource source2 = getColumnSource(column2Name, table2Name);
		
		// No column schema for at least one of them, so don't link
		if (source1 == null || source2 == null)
			return;
		
		// Get tables
		TableSchema tableSchema1 = tableSchemas.get(source1.tableSource.name);
		TableSchema tableSchema2 = tableSchemas.get(source2.tableSource.name);

		// No column schema for at least one of them, so don't link
		if (tableSchema1 == null || tableSchema2 == null)
			return;
		
		// Get column schemas
		ColumnSchema cs1 = tableSchema1.getColumn(source1.name);
		ColumnSchema cs2 = tableSchema2.getColumn(source2.name);
		
		// Add references to eachother
		cs1.addSeedSourceColumn(cs2);
		cs2.addSeedSourceColumn(cs1);
	}
	
	private void addColumnSourceToOutput(ColumnSource source) {
		// Add this if it is a real column
		TableSchema tableSchema;
		try {
			tableSchema = tableSchemas.get(source.tableSource.name);
		} catch (Exception e) {
			tableSchema = null;
		}
		if (tableSchema != null) {
			outputColumns.add(tableSchema.getColumn(source.name));
		}
	}
	
	private ColumnSource getColumnSource(String columnName, String tableName) {
		if (tableName != null)
			tableName = tableName.replaceAll("^\"|\"$", "");
		columnName = columnName.replaceAll("^\"|\"$", "");
		
		TableSource tableSource;
		if (tableName != null) {
			// Find column with known table alias
			tableSource = currentState.visibleTableSources.get(tableName);
		} else {
			// Find column without knowing the table
			final String finalColumnName = new String(columnName);
			// First search the current level, otherwise all visible
			try {
				tableSource = currentState.stateLevelTableSources.values().stream().filter(x -> x.contains(finalColumnName)).findFirst()
						.orElse(currentState.visibleTableSources.values().stream().filter(x -> x.contains(finalColumnName)).findFirst().get());
			} catch (NoSuchElementException e) {
				tableSource = null;
			}
		}

		// If there is no table source then it is a derived column and should already be added
		if (tableSource == null)
			return null;//throw new RuntimeException("Could not find table source for column " + columnName);
		ColumnSource cs = tableSource.get(columnName);
		if (cs == null)
			return null;//throw new RuntimeException("Could not find column source for column " + columnName + " in table " + tableName);
		return cs;
	}
	
	private boolean isStringType(ColumnSource cs) {
		// No column schema for at least one of them, so don't link
		if (cs == null)
			return false;
		
		// Get tables
		TableSchema tableSchema1 = tableSchemas.get(cs.tableSource.name);

		// No column schema for at least one of them, so don't link
		if (tableSchema1 == null)
			return false;
		
		// Get column schemas
		ColumnSchema cs1 = tableSchema1.getColumn(cs.name);
		
		return cs1.getType() instanceof DBString;
	}
	
	private boolean isDateType(ColumnSource cs) {
		// No column schema for at least one of them, so don't link
		if (cs == null)
			return false;
		
		// Get tables
		TableSchema tableSchema1 = tableSchemas.get(cs.tableSource.name);

		// No column schema for at least one of them, so don't link
		if (tableSchema1 == null)
			return false;
		
		// Get column schemas
		ColumnSchema cs1 = tableSchema1.getColumn(cs.name);
		
		return cs1.getType() instanceof DBDate || cs1.getType() instanceof DBDateTime || cs1.getType() instanceof DBTime;
	}

	@Override
	public void visit(BitwiseRightShift aThis) {
		aThis.getLeftExpression().accept(this);
		aThis.getRightExpression().accept(this);
	}

	@Override
	public void visit(BitwiseLeftShift aThis) {
		aThis.getLeftExpression().accept(this);
		aThis.getRightExpression().accept(this);
	}

	@Override
	public void visit(NullValue arg0) {

	}

	@Override
	public void visit(Function arg0) {
		if (arg0.getParameters() != null)
			arg0.getParameters().accept(this);
	}

	@Override
	public void visit(SignedExpression arg0) {
		arg0.getExpression().accept(this);
	}

	@Override
	public void visit(JdbcParameter arg0) {
		// TODO Auto-generated method stub

	}

	@Override
	public void visit(JdbcNamedParameter arg0) {
		// TODO Auto-generated method stub

	}

	@Override
	public void visit(DoubleValue arg0) {
	}

	@Override
	public void visit(LongValue arg0) {
	}

	@Override
	public void visit(HexValue arg0) {
	}

	@Override
	public void visit(DateValue arg0) {
	}

	@Override
	public void visit(TimeValue arg0) {
	}

	@Override
	public void visit(TimestampValue arg0) {
	}

	@Override
	public void visit(Parenthesis arg0) {
		arg0.getExpression().accept(this);
	}

	@Override
	public void visit(StringValue arg0) {
	}

	@Override
	public void visit(Addition arg0) {
		arg0.getLeftExpression().accept(this);
		arg0.getRightExpression().accept(this);
	}

	@Override
	public void visit(Division arg0) {
		arg0.getLeftExpression().accept(this);
		arg0.getRightExpression().accept(this);
	}

	@Override
	public void visit(Multiplication arg0) {
		arg0.getLeftExpression().accept(this);
		arg0.getRightExpression().accept(this);
	}

	@Override
	public void visit(Subtraction arg0) {
		arg0.getLeftExpression().accept(this);
		arg0.getRightExpression().accept(this);
	}

	@Override
	public void visit(AndExpression arg0) {
		arg0.getLeftExpression().accept(this);
		arg0.getRightExpression().accept(this);
	}

	@Override
	public void visit(OrExpression arg0) {
		arg0.getLeftExpression().accept(this);
		arg0.getRightExpression().accept(this);
	}

	@Override
	public void visit(Between arg0) {
		arg0.getLeftExpression().accept(this);
		arg0.getBetweenExpressionStart().accept(this);
		arg0.getBetweenExpressionEnd().accept(this);
	}

	@Override
	public void visit(EqualsTo arg0) {
		arg0.getLeftExpression().accept(this);
		arg0.getRightExpression().accept(this);
		
		boolean isStringEq = false;
		if (arg0.getLeftExpression() instanceof StringValue || arg0.getRightExpression() instanceof StringValue)
			isStringEq = true;

		if (!isStringEq && arg0.getLeftExpression() instanceof Column) {
			// Check if column is string type
			Column col1 = (Column)arg0.getLeftExpression();
			String table1Name = null;
			if (col1.getTable() != null) {
				if (col1.getTable().getAlias() != null)
					table1Name = col1.getTable().getAlias().getName();
				else 
					table1Name = col1.getTable().getName();
			}
			
			ColumnSource cs = getColumnSource(col1.getColumnName(), table1Name);
			if (isStringType(cs)) 
				isStringEq = true;
		}
		
		if (!isStringEq && arg0.getRightExpression() instanceof Column) {
			// Check if column is string type
			Column col1 = (Column)arg0.getRightExpression();
			String table1Name = null;
			if (col1.getTable() != null) {
				if (col1.getTable().getAlias() != null)
					table1Name = col1.getTable().getAlias().getName();
				else 
					table1Name = col1.getTable().getName();
			}
			
			ColumnSource cs = getColumnSource(col1.getColumnName(), table1Name);
			if (isStringType(cs)) 
				isStringEq = true;
		}
		
		boolean isDateEq = false;
		if (arg0.getLeftExpression() instanceof DateValue || arg0.getLeftExpression() instanceof TimeValue || arg0.getLeftExpression() instanceof TimestampValue 
				|| arg0.getRightExpression() instanceof DateValue || arg0.getRightExpression() instanceof TimeValue || arg0.getRightExpression() instanceof TimestampValue)
			isDateEq = true;

		if (!isDateEq && arg0.getLeftExpression() instanceof Column) {
			// Check if column is string type
			Column col1 = (Column)arg0.getLeftExpression();
			String table1Name = null;
			if (col1.getTable() != null) {
				if (col1.getTable().getAlias() != null)
					table1Name = col1.getTable().getAlias().getName();
				else 
					table1Name = col1.getTable().getName();
			}
			
			ColumnSource cs = getColumnSource(col1.getColumnName(), table1Name);
			if (isDateType(cs)) 
				isDateEq = true;
		}
		
		if (!isDateEq && arg0.getRightExpression() instanceof Column) {
			// Check if column is string type
			Column col1 = (Column)arg0.getRightExpression();
			String table1Name = null;
			if (col1.getTable() != null) {
				if (col1.getTable().getAlias() != null)
					table1Name = col1.getTable().getAlias().getName();
				else 
					table1Name = col1.getTable().getName();
			}
			
			ColumnSource cs = getColumnSource(col1.getColumnName(), table1Name);
			if (isDateType(cs)) 
				isDateEq = true;
		}
		
		if (EvoSQLConfiguration.USE_DYNAMIC_JOIN_SEEDING && 
				arg0.getLeftExpression() instanceof Column && arg0.getRightExpression() instanceof Column) {
			// Column equals comparison, link the column schemas
			Column col1 = (Column)arg0.getLeftExpression();
			String table1Name = null;
			if (col1.getTable() != null) {
				if (col1.getTable().getAlias() != null)
					table1Name = col1.getTable().getAlias().getName();
				else 
					table1Name = col1.getTable().getName();
			}
			Column col2 = (Column)arg0.getRightExpression();
			String table2Name = null;
			if (col2.getTable() != null) {
				if (col1.getTable().getAlias() != null)
					table2Name = col2.getTable().getAlias().getName();
				else 
					table2Name = col2.getTable().getName();
			}
			
			// Link them
			linkColumns(col1.getColumnName(), table1Name, col2.getColumnName(), table2Name);
		}
		
		if (isStringEq)
			this.stringEqs++;
		if (isDateEq)
			this.dateEqs++;
	}

	@Override
	public void visit(GreaterThan arg0) {
		arg0.getLeftExpression().accept(this);
		arg0.getRightExpression().accept(this);
	}

	@Override
	public void visit(GreaterThanEquals arg0) {
		arg0.getLeftExpression().accept(this);
		arg0.getRightExpression().accept(this);
	}

	@Override
	public void visit(InExpression arg0) {
		arg0.getLeftExpression().accept(this);
		arg0.getRightItemsList().accept(this);
	}

	@Override
	public void visit(IsNullExpression arg0) {
		arg0.getLeftExpression().accept(this);
	}

	@Override
	public void visit(LikeExpression arg0) {
		arg0.getLeftExpression().accept(this);
		arg0.getRightExpression().accept(this);
	}

	@Override
	public void visit(MinorThan arg0) {
		arg0.getLeftExpression().accept(this);
		arg0.getRightExpression().accept(this);
	}

	@Override
	public void visit(MinorThanEquals arg0) {
		arg0.getLeftExpression().accept(this);
		arg0.getRightExpression().accept(this);
	}

	@Override
	public void visit(NotEqualsTo arg0) {
		arg0.getLeftExpression().accept(this);
		arg0.getRightExpression().accept(this);
	}

	@Override
	public void visit(Column arg0) {
		String tableName = null;
		if (arg0.getTable() != null) {
			if (arg0.getTable().getAlias() != null)
				tableName = arg0.getTable().getAlias().getName();
			else 
				tableName = arg0.getTable().getName();
		}
		
		// If it is outer select, don't add, otherwise do add
		if (!(currentState.isOuterState && currentState.phase == SelectPhase.SELECT)) {
			addUsedColumn(arg0.getColumnName(), tableName);
		}
	}

	@Override
	public void visit(SubSelect arg0) {
		State newState = new State(currentState); // Copy visible tables
		stateStack.push(currentState);
		currentState = newState;
		currentState.stateSource = new TableSource(null, arg0.getAlias() != null ? arg0.getAlias().getName() : null);

		arg0.getSelectBody().accept(this);

		TableSource source = currentState.stateSource;
		currentState = stateStack.pop();
		
		if (currentState.phase == SelectPhase.FROM) // Source the data
			currentState.storeTableSource(source);
	}

	@Override
	public void visit(CaseExpression arg0) {
		if (arg0.getSwitchExpression() != null)
			arg0.getSwitchExpression().accept(this);
		
		if (arg0.getWhenClauses() != null)
			arg0.getWhenClauses().forEach(e -> e.accept(this));
		
		if (arg0.getElseExpression() != null)
			arg0.getElseExpression().accept(this);
	}

	@Override
	public void visit(WhenClause arg0) {
		arg0.getWhenExpression().accept(this);
	}

	@Override
	public void visit(ExistsExpression arg0) {
		if (arg0.getRightExpression() != null) 
			arg0.getRightExpression().accept(this);
	}

	@Override
	public void visit(AllComparisonExpression arg0) {
		// TODO Auto-generated method stub

	}

	@Override
	public void visit(AnyComparisonExpression arg0) {
		// TODO Auto-generated method stub

	}

	@Override
	public void visit(Concat arg0) {
		arg0.getLeftExpression().accept(this);
		arg0.getRightExpression().accept(this);
	}

	@Override
	public void visit(Matches arg0) {
		// TODO Auto-generated method stub

	}

	@Override
	public void visit(BitwiseAnd arg0) {
		arg0.getLeftExpression().accept(this);
		arg0.getRightExpression().accept(this);
	}

	@Override
	public void visit(BitwiseOr arg0) {
		arg0.getLeftExpression().accept(this);
		arg0.getRightExpression().accept(this);
	}

	@Override
	public void visit(BitwiseXor arg0) {
		arg0.getLeftExpression().accept(this);
		arg0.getRightExpression().accept(this);
	}

	@Override
	public void visit(CastExpression arg0) {
		arg0.getLeftExpression().accept(this);
	}

	@Override
	public void visit(Modulo arg0) {
		arg0.getLeftExpression().accept(this);
		arg0.getRightExpression().accept(this);
	}

	@Override
	public void visit(AnalyticExpression arg0) {
		// TODO Auto-generated method stub

	}

	@Override
	public void visit(ExtractExpression arg0) {
		// TODO Auto-generated method stub

	}

	@Override
	public void visit(IntervalExpression arg0) {
		// TODO Auto-generated method stub

	}

	@Override
	public void visit(OracleHierarchicalExpression arg0) {
		// TODO Auto-generated method stub

	}

	@Override
	public void visit(RegExpMatchOperator arg0) {
		// TODO Auto-generated method stub

	}

	@Override
	public void visit(JsonExpression arg0) {
		// TODO Auto-generated method stub

	}

	@Override
	public void visit(JsonOperator jsonExpr) {

	}

	@Override
	public void visit(RegExpMySQLOperator arg0) {
		// TODO Auto-generated method stub

	}

	@Override
	public void visit(UserVariable arg0) {
		// TODO Auto-generated method stub

	}

	@Override
	public void visit(NumericBind arg0) {
		// TODO Auto-generated method stub

	}

	@Override
	public void visit(KeepExpression arg0) {
		// TODO Auto-generated method stub

	}

	@Override
	public void visit(MySQLGroupConcat arg0) {
		// TODO Auto-generated method stub

	}

	@Override
	public void visit(ValueListExpression valueList) {

	}

	@Override
	public void visit(RowConstructor arg0) {
		// TODO Auto-generated method stub

	}

	@Override
	public void visit(OracleHint arg0) {
		// TODO Auto-generated method stub

	}

	@Override
	public void visit(TimeKeyExpression arg0) {
		// TODO Auto-generated method stub

	}

	@Override
	public void visit(DateTimeLiteralExpression arg0) {
		// TODO Auto-generated method stub

	}

	@Override
	public void visit(NotExpression aThis) {
		aThis.getExpression().accept(this);
	}

	@Override
	public void visit(NextValExpression aThis) {

	}

	@Override
	public void visit(CollateExpression aThis) {

	}

	@Override
	public void visit(SimilarToExpression aThis) {
		aThis.getLeftExpression().accept(this);
		aThis.getRightExpression().accept(this);
	}

	@Override
	public void visit(Table arg0) {
		// This can only happen in a FROM, source the table
		String tableName = arg0.getName();
		String tableAlias = tableName;
		
		// Handle alias
		if (arg0.getAlias() != null) {
			tableAlias = arg0.getAlias().getName();
		}
		
		sourceTable(tableName, tableAlias);
	}

	@Override
	public void visit(SubJoin arg0) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void visit(LateralSubSelect arg0) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void visit(ValuesList arg0) {
		arg0.getMultiExpressionList().accept(this);
	}

	@Override
	public void visit(TableFunction arg0) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void visit(ParenthesisFromItem aThis) {
		aThis.getFromItem().accept(this);
	}

	@Override
	public void visit(ExpressionList arg0) {
		arg0.getExpressions().stream().forEach(x -> x.accept(this));
	}

	@Override
	public void visit(NamedExpressionList namedExpressionList) {

	}

	@Override
	public void visit(MultiExpressionList arg0) {
		arg0.getExprList().stream().forEach(x -> x.accept(this));
	}

	@Override
	public void visit(PlainSelect arg0) {
		currentState.phase = SelectPhase.FROM;
		if(arg0.getFromItem()!=null) arg0.getFromItem().accept(this);
		
		currentState.phase = SelectPhase.JOIN;
		if(arg0.getJoins()!=null) arg0.getJoins().stream().forEach(x -> {
			x.getRightItem().accept(this);
			if (x.getOnExpression() != null)
				x.getOnExpression().accept(this);
		});
		
		currentState.phase = SelectPhase.SELECT;
		if(arg0.getSelectItems()!=null) {
			for (SelectItem si : arg0.getSelectItems())
				si.accept(this);
		}
		
		currentState.phase = SelectPhase.WHERE;
		if(arg0.getWhere()!=null) arg0.getWhere().accept(this);
		
		currentState.phase = SelectPhase.HAVING;
		if(arg0.getHaving()!=null) arg0.getHaving().accept(this);
	}

	@Override
	public void visit(SetOperationList arg0) {
        for (SelectBody plainSelect : arg0.getSelects()) {
            plainSelect.accept(this);
        }
	}

	@Override
	public void visit(WithItem arg0) {
        arg0.getSelectBody().accept(this);
	}

	@Override
	public void visit(ValuesStatement aThis) {

	}

	@Override
	public void visit(AllColumns arg0) {
		// Use them all if not outer select
		if (!currentState.isOuterState) {
			sourceAllColumns(null);
			useAllColumns(null);
		}
	}

	@Override
	public void visit(AllTableColumns arg0) {
		// Use them all if not outer select
		if (!currentState.isOuterState) {
			sourceAllColumns(arg0.getTable().getName());
			useAllColumns(arg0.getTable().getName());
		}
	}

	@Override
	public void visit(SelectExpressionItem arg0) {
		if (currentState.stateSource != null) {
			String columnName = null;
			if (arg0.getAlias() != null)
				columnName = arg0.getAlias().getName();
			else if (arg0.getExpression() instanceof Column) {
				columnName = ((Column)arg0.getExpression()).getColumnName();
			}
			// Strip quotes
			if (columnName != null)
				columnName = columnName.replaceAll("^\"|\"$", "");
			currentState.columnSource = new ColumnSource(currentState.stateSource, columnName);
		}
		
		arg0.getExpression().accept(this);
		
		// Get ColumnSource and store in the current state source
		if (currentState.stateSource != null) {
			currentState.stateSource.add(currentState.columnSource);
			currentState.columnSource = null;
		}
	}
}
