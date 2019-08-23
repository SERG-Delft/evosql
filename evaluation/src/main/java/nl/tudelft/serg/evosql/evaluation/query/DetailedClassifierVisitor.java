package nl.tudelft.serg.evosql.evaluation.query;

import net.sf.jsqlparser.expression.*;
import net.sf.jsqlparser.expression.operators.arithmetic.*;
import net.sf.jsqlparser.expression.operators.conditional.AndExpression;
import net.sf.jsqlparser.expression.operators.conditional.OrExpression;
import net.sf.jsqlparser.expression.operators.relational.*;
import net.sf.jsqlparser.schema.Column;
import net.sf.jsqlparser.schema.Table;
import net.sf.jsqlparser.statement.select.*;
import net.sf.jsqlparser.statement.values.ValuesStatement;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class DetailedClassifierVisitor implements ExpressionVisitor, FromItemVisitor, ItemsListVisitor, SelectVisitor, SelectItemVisitor {
	private Map<String, Integer> dict;
	private List<String> visitedTables;
	private boolean outerSelect;
	
	public DetailedClassifierVisitor(Map<String, Integer> dict) {
		this.dict = dict;
		visitedTables = new ArrayList<String>();
		dict.clear();
		outerSelect = true;
		
		// Initialize values
		dict.put(DetailedClassification.TABLES, 0);
		dict.put(DetailedClassification.PREDICATES, 0);
		dict.put(DetailedClassification.JOINS, 0);
		dict.put(DetailedClassification.SUBQUERIES, 0);
		dict.put(DetailedClassification.EXISTS, 0);
		dict.put(DetailedClassification.LIKES, 0);
		dict.put(DetailedClassification.AGGFUNCTIONS, 0);
		dict.put(DetailedClassification.OTHFUNCTIONS, 0);
		dict.put(DetailedClassification.CASES, 0);
		dict.put(DetailedClassification.IFNULLS, 0);
		dict.put(DetailedClassification.LEFTJ, 0);
		dict.put(DetailedClassification.RIGHTJ, 0);
		dict.put(DetailedClassification.INNERJ, 0);
		dict.put(DetailedClassification.WHERE, 0);
		dict.put(DetailedClassification.GROUPBY, 0);
		dict.put(DetailedClassification.HAVING, 0);
		dict.put(DetailedClassification.CDGTx, 0);
		dict.put(DetailedClassification.xGTCD, 0);
		
	}

	
	private boolean isAggregate(Function arg0) {
		String funName = arg0.getName();
		return "COUNT".equalsIgnoreCase(funName)
				|| "AVG".equalsIgnoreCase(funName)
				|| "MAX".equalsIgnoreCase(funName)
				|| "MIN".equalsIgnoreCase(funName)
				|| "SUM".equalsIgnoreCase(funName)
				|| "MEDIAN".equalsIgnoreCase(funName);
	}
	
	private void increment(String metricName) {
		dict.put(metricName, dict.get(metricName)+ 1);
	}

	@Override
	public void visit(NullValue arg0) {
	}

	@Override
	public void visit(Function arg0) {
		String key = arg0.getName().toUpperCase();
		if (key.equals("IFNULL"))
			increment(DetailedClassification.IFNULLS);
		if (isAggregate(arg0))
			increment(DetailedClassification.AGGFUNCTIONS);
		else
			increment(DetailedClassification.OTHFUNCTIONS);
		if (arg0.getParameters() != null)
			arg0.getParameters().accept(this);
	}

	@Override
	public void visit(SignedExpression arg0) {
	}

	@Override
	public void visit(JdbcParameter arg0) {
	}

	@Override
	public void visit(JdbcNamedParameter arg0) {
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
		increment(DetailedClassification.PREDICATES);
		arg0.getLeftExpression().accept(this);
		arg0.getBetweenExpressionStart().accept(this);
		arg0.getBetweenExpressionEnd().accept(this);
	}

	@Override
	public void visit(EqualsTo arg0) {
		increment(DetailedClassification.PREDICATES);

		arg0.getLeftExpression().accept(this);
		arg0.getRightExpression().accept(this);
	}

	@Override
	public void visit(GreaterThan arg0) {
		increment(DetailedClassification.PREDICATES);
		if (arg0.getLeftExpression() instanceof Function) {
			Function f = (Function) arg0.getLeftExpression();
			if (f.getName().equalsIgnoreCase("COUNT") || f.isDistinct()) {
				increment(DetailedClassification.CDGTx);
			}
		}
		if (arg0.getRightExpression() instanceof Function) {
			Function f = (Function) arg0.getRightExpression();
			if (f.getName().equalsIgnoreCase("COUNT") || f.isDistinct()) {
				increment(DetailedClassification.xGTCD);
			}
		}
		arg0.getLeftExpression().accept(this);
		arg0.getRightExpression().accept(this);
	}

	@Override
	public void visit(GreaterThanEquals arg0) {
		increment(DetailedClassification.PREDICATES);
		arg0.getLeftExpression().accept(this);
		arg0.getRightExpression().accept(this);
	}

	@Override
	public void visit(InExpression arg0) {
		increment(DetailedClassification.PREDICATES);
		arg0.getLeftExpression().accept(this);
		arg0.getRightItemsList().accept(this);

	}

	@Override
	public void visit(IsNullExpression arg0) {
		increment(DetailedClassification.PREDICATES);
		arg0.getLeftExpression().accept(this);
	}

	@Override
	public void visit(LikeExpression arg0) {
		increment(DetailedClassification.PREDICATES);
		increment(DetailedClassification.LIKES);
		arg0.getLeftExpression().accept(this);
		arg0.getRightExpression().accept(this);
	}

	@Override
	public void visit(MinorThan arg0) {
		increment(DetailedClassification.PREDICATES);
		arg0.getLeftExpression().accept(this);
		arg0.getRightExpression().accept(this);
	}

	@Override
	public void visit(MinorThanEquals arg0) {
		increment(DetailedClassification.PREDICATES);
		arg0.getLeftExpression().accept(this);
		arg0.getRightExpression().accept(this);
	}

	@Override
	public void visit(NotEqualsTo arg0) {
		increment(DetailedClassification.PREDICATES);
		arg0.getLeftExpression().accept(this);
		arg0.getRightExpression().accept(this);
	}

	@Override
	public void visit(Column arg0) {
	}

	@Override
	public void visit(SubSelect arg0) {
		increment(DetailedClassification.SUBQUERIES);
		arg0.getSelectBody().accept(this);
	}

	@Override
	public void visit(CaseExpression arg0) {
		increment(DetailedClassification.CASES);
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
		increment(DetailedClassification.PREDICATES);
		increment(DetailedClassification.EXISTS);
		if (arg0.getRightExpression() != null)
			arg0.getRightExpression().accept(this);
	}

	@Override
	public void visit(AllComparisonExpression arg0) {
		arg0.getSubSelect().accept((ExpressionVisitor)this);
	}

	@Override
	public void visit(AnyComparisonExpression arg0) {
		arg0.getSubSelect().accept((ExpressionVisitor)this);
	}

	@Override
	public void visit(Concat arg0) {
	}

	@Override
	public void visit(Matches arg0) {
		// TODO Auto-generated method stub

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
	}

	@Override
	public void visit(Modulo arg0) {
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
		// FIXME: increment similar tos?
		increment(DetailedClassification.PREDICATES);
		aThis.getLeftExpression().accept(this);
		aThis.getRightExpression().accept(this);
	}

	@Override
	public void visit(Table arg0) {
		if (!visitedTables.contains(arg0.getName().toUpperCase())) {
			visitedTables.add(arg0.getName().toUpperCase());
			increment(DetailedClassification.TABLES);
		}
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
		namedExpressionList.getExpressions().forEach(expression -> expression.accept(this));
	}

	@Override
	public void visit(MultiExpressionList arg0) {
		arg0.getExprList().stream().forEach(x -> x.accept(this));
	}

	@Override
	public void visit(PlainSelect arg0) {
		if (!outerSelect) {
			if(arg0.getSelectItems()!=null) {
				for (SelectItem si : arg0.getSelectItems())
					si.accept(this);
			}
		}
		outerSelect = false;
		if(arg0.getFromItem()!=null) arg0.getFromItem().accept(this);
		if(arg0.getHaving()!=null) {
			arg0.getHaving().accept(this);
			increment(DetailedClassification.HAVING);
		}
		if(arg0.getJoins()!=null) arg0.getJoins().stream().forEach(x -> { 
			increment(DetailedClassification.JOINS);
			if (x.isRight()) 
				increment(DetailedClassification.RIGHTJ);
			if (x.isLeft()) 
				increment(DetailedClassification.LEFTJ);
			if (x.isInner()) 
				increment(DetailedClassification.INNERJ);
			if (x.getOnExpression() != null)
				x.getOnExpression().accept(this);
			x.getRightItem().accept(this);
		});
		if(arg0.getWhere()!=null) {
			arg0.getWhere().accept(this);
			increment(DetailedClassification.WHERE);
		}
		if(arg0.getGroupBy() != null)
			increment(DetailedClassification.GROUPBY);
	}

	@Override
	public void visit(SetOperationList arg0) {
        for (SelectBody plainSelect : arg0.getSelects()) {
            plainSelect.accept(this);
        }
	}

	@Override
	public void visit(WithItem arg0) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void visit(ValuesStatement aThis) {

	}

	@Override
	public void visit(AllColumns arg0) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void visit(AllTableColumns arg0) {
		arg0.getTable().accept(this);
	}

	@Override
	public void visit(SelectExpressionItem arg0) {
		arg0.getExpression().accept(this);
	}
}
