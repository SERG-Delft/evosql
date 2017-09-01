package nl.tudelft.serg.evosql.evaluation.query;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.print.attribute.standard.MediaSize.ISO;

import net.sf.jsqlparser.expression.AllComparisonExpression;
import net.sf.jsqlparser.expression.AnalyticExpression;
import net.sf.jsqlparser.expression.AnyComparisonExpression;
import net.sf.jsqlparser.expression.CaseExpression;
import net.sf.jsqlparser.expression.CastExpression;
import net.sf.jsqlparser.expression.DateTimeLiteralExpression;
import net.sf.jsqlparser.expression.DateValue;
import net.sf.jsqlparser.expression.DoubleValue;
import net.sf.jsqlparser.expression.ExpressionVisitor;
import net.sf.jsqlparser.expression.ExtractExpression;
import net.sf.jsqlparser.expression.Function;
import net.sf.jsqlparser.expression.HexValue;
import net.sf.jsqlparser.expression.IntervalExpression;
import net.sf.jsqlparser.expression.JdbcNamedParameter;
import net.sf.jsqlparser.expression.JdbcParameter;
import net.sf.jsqlparser.expression.JsonExpression;
import net.sf.jsqlparser.expression.KeepExpression;
import net.sf.jsqlparser.expression.LongValue;
import net.sf.jsqlparser.expression.MySQLGroupConcat;
import net.sf.jsqlparser.expression.NullValue;
import net.sf.jsqlparser.expression.NumericBind;
import net.sf.jsqlparser.expression.OracleHierarchicalExpression;
import net.sf.jsqlparser.expression.OracleHint;
import net.sf.jsqlparser.expression.Parenthesis;
import net.sf.jsqlparser.expression.RowConstructor;
import net.sf.jsqlparser.expression.SignedExpression;
import net.sf.jsqlparser.expression.StringValue;
import net.sf.jsqlparser.expression.TimeKeyExpression;
import net.sf.jsqlparser.expression.TimeValue;
import net.sf.jsqlparser.expression.TimestampValue;
import net.sf.jsqlparser.expression.UserVariable;
import net.sf.jsqlparser.expression.WhenClause;
import net.sf.jsqlparser.expression.WithinGroupExpression;
import net.sf.jsqlparser.expression.operators.arithmetic.Addition;
import net.sf.jsqlparser.expression.operators.arithmetic.BitwiseAnd;
import net.sf.jsqlparser.expression.operators.arithmetic.BitwiseOr;
import net.sf.jsqlparser.expression.operators.arithmetic.BitwiseXor;
import net.sf.jsqlparser.expression.operators.arithmetic.Concat;
import net.sf.jsqlparser.expression.operators.arithmetic.Division;
import net.sf.jsqlparser.expression.operators.arithmetic.Modulo;
import net.sf.jsqlparser.expression.operators.arithmetic.Multiplication;
import net.sf.jsqlparser.expression.operators.arithmetic.Subtraction;
import net.sf.jsqlparser.expression.operators.conditional.AndExpression;
import net.sf.jsqlparser.expression.operators.conditional.OrExpression;
import net.sf.jsqlparser.expression.operators.relational.Between;
import net.sf.jsqlparser.expression.operators.relational.EqualsTo;
import net.sf.jsqlparser.expression.operators.relational.ExistsExpression;
import net.sf.jsqlparser.expression.operators.relational.ExpressionList;
import net.sf.jsqlparser.expression.operators.relational.GreaterThan;
import net.sf.jsqlparser.expression.operators.relational.GreaterThanEquals;
import net.sf.jsqlparser.expression.operators.relational.InExpression;
import net.sf.jsqlparser.expression.operators.relational.IsNullExpression;
import net.sf.jsqlparser.expression.operators.relational.ItemsListVisitor;
import net.sf.jsqlparser.expression.operators.relational.LikeExpression;
import net.sf.jsqlparser.expression.operators.relational.Matches;
import net.sf.jsqlparser.expression.operators.relational.MinorThan;
import net.sf.jsqlparser.expression.operators.relational.MinorThanEquals;
import net.sf.jsqlparser.expression.operators.relational.MultiExpressionList;
import net.sf.jsqlparser.expression.operators.relational.NotEqualsTo;
import net.sf.jsqlparser.expression.operators.relational.RegExpMatchOperator;
import net.sf.jsqlparser.expression.operators.relational.RegExpMySQLOperator;
import net.sf.jsqlparser.schema.Column;
import net.sf.jsqlparser.schema.Table;
import net.sf.jsqlparser.statement.select.AllColumns;
import net.sf.jsqlparser.statement.select.AllTableColumns;
import net.sf.jsqlparser.statement.select.FromItemVisitor;
import net.sf.jsqlparser.statement.select.LateralSubSelect;
import net.sf.jsqlparser.statement.select.PlainSelect;
import net.sf.jsqlparser.statement.select.SelectBody;
import net.sf.jsqlparser.statement.select.SelectExpressionItem;
import net.sf.jsqlparser.statement.select.SelectItem;
import net.sf.jsqlparser.statement.select.SelectItemVisitor;
import net.sf.jsqlparser.statement.select.SelectVisitor;
import net.sf.jsqlparser.statement.select.SetOperationList;
import net.sf.jsqlparser.statement.select.SubJoin;
import net.sf.jsqlparser.statement.select.SubSelect;
import net.sf.jsqlparser.statement.select.TableFunction;
import net.sf.jsqlparser.statement.select.ValuesList;
import net.sf.jsqlparser.statement.select.WithItem;

public class FunctionClassifierVisitor implements ExpressionVisitor, FromItemVisitor, ItemsListVisitor, SelectVisitor, SelectItemVisitor {
	public int aggregateFunctions;
	public int otherFunctions;
	private boolean isOuterSelect;
	public Map<String, Integer> functionMap;
	
	public FunctionClassifierVisitor() {
		aggregateFunctions = 0;
		otherFunctions = 0;
		isOuterSelect = true;
		functionMap = new HashMap<String, Integer>();
	}
	
	private boolean isAggregate(Function arg0) {
		String funName = arg0.getName();
		if (funName.equalsIgnoreCase("COUNT") ||
			funName.equalsIgnoreCase("AVG")||
			funName.equalsIgnoreCase("MAX")||
			funName.equalsIgnoreCase("MIN")||
			funName.equalsIgnoreCase("SUM")||
			funName.equalsIgnoreCase("MEDIAN")) {
			return true;
		}
		return false;
	}
	
	@Override
	public void visit(NullValue arg0) {
	}

	@Override
	public void visit(Function arg0) {
		if (!isOuterSelect ) {// Not outer select
			String key = arg0.getName().toUpperCase();
			functionMap.put(key, 1 + functionMap.getOrDefault(key, 0));
			
			if (isAggregate(arg0))
				aggregateFunctions++;
			else
				otherFunctions++;
		}
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
		arg0.getLeftExpression().accept(this);
		arg0.getBetweenExpressionStart().accept(this);
		arg0.getBetweenExpressionEnd().accept(this);
	}

	@Override
	public void visit(EqualsTo arg0) {
		arg0.getLeftExpression().accept(this);
		arg0.getRightExpression().accept(this);
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
	}

	@Override
	public void visit(SubSelect arg0) {
		boolean startIsOuter = isOuterSelect;
		
		isOuterSelect = false;
		arg0.getSelectBody().accept(this);
		
		isOuterSelect = startIsOuter;
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
	public void visit(WithinGroupExpression arg0) {
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
	public void visit(Table arg0) {
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
	public void visit(ExpressionList arg0) {
		arg0.getExpressions().stream().forEach(x -> x.accept(this));
	}

	@Override
	public void visit(MultiExpressionList arg0) {
		arg0.getExprList().stream().forEach(x -> x.accept(this));
	}

	@Override
	public void visit(PlainSelect arg0) {
		if(arg0.getSelectItems()!=null) {
			for (SelectItem si : arg0.getSelectItems())
				si.accept(this);
		}
		isOuterSelect = false;
		if(arg0.getFromItem()!=null) arg0.getFromItem().accept(this);
		if(arg0.getHaving()!=null) arg0.getHaving().accept(this);
		if(arg0.getJoins()!=null) arg0.getJoins().stream().forEach(x -> { 
			if (x.getOnExpression() != null)
				x.getOnExpression().accept(this);
			x.getRightItem().accept(this);
		});
		if(arg0.getWhere()!=null) arg0.getWhere().accept(this);
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
