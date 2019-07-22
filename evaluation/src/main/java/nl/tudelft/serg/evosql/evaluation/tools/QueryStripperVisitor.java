package nl.tudelft.serg.evosql.evaluation.tools;

import net.sf.jsqlparser.expression.*;
import net.sf.jsqlparser.expression.operators.arithmetic.*;
import net.sf.jsqlparser.expression.operators.conditional.AndExpression;
import net.sf.jsqlparser.expression.operators.conditional.OrExpression;
import net.sf.jsqlparser.expression.operators.relational.*;
import net.sf.jsqlparser.schema.Column;
import net.sf.jsqlparser.schema.Table;
import net.sf.jsqlparser.statement.select.*;
import net.sf.jsqlparser.statement.values.ValuesStatement;

import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

public class QueryStripperVisitor implements ExpressionVisitor, FromItemVisitor, ItemsListVisitor, SelectVisitor, SelectItemVisitor, OrderByVisitor {
	private SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd"),
			tf = new SimpleDateFormat("HH:mm:ss"),
			tsf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	private boolean isFormat(SimpleDateFormat format, String value) {
		try {
			format.parse(value);
			return true;
		} catch (ParseException e) {
			return false;
		}
	}
	
	private Expression visitExpression(Expression expression) {
		if (expression instanceof DoubleValue) {
			return new DoubleValue("0");
		}
		expression.accept(this);
		return null;
	}

	@Override
	public void visit(BitwiseRightShift arg0) {
		Expression e = visitExpression(arg0.getLeftExpression());
		if (e != null) arg0.setLeftExpression(e);
		e = visitExpression(arg0.getRightExpression());
		if (e != null) arg0.setRightExpression(e);
	}

	@Override
	public void visit(BitwiseLeftShift arg0) {
		Expression e = visitExpression(arg0.getLeftExpression());
		if (e != null) arg0.setLeftExpression(e);
		e = visitExpression(arg0.getRightExpression());
		if (e != null) arg0.setRightExpression(e);
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
		Expression e = visitExpression(arg0.getExpression());
		if (e != null) arg0.setExpression(e);
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
		arg0.setValue(0);
	}

	@Override
	public void visit(LongValue arg0) {
		arg0.setValue(0);
		arg0.setStringValue("0");
	}

	@Override
	public void visit(HexValue arg0) {
	}

	@Override
	public void visit(DateValue arg0) {
		arg0.setValue(Date.valueOf("2000-01-01"));
	}

	@Override
	public void visit(TimeValue arg0) {
		arg0.setValue(Time.valueOf("12:00:00"));
	}

	@Override
	public void visit(TimestampValue arg0) {
		arg0.setValue(Timestamp.valueOf("2000-01-01 12:00:00"));
	}

	@Override
	public void visit(Parenthesis arg0) {
		Expression e = visitExpression(arg0.getExpression());
		if (e != null) arg0.setExpression(e);
	}

	@Override
	public void visit(StringValue arg0) {
		String value = arg0.getValue();
		if (isFormat(tsf, value)) {
			arg0.setValue("2000-01-01 12:00:00");
		} else if (isFormat(df, value)) {
			arg0.setValue("2000-01-01");
		} else if (isFormat(tf, value)) {
			arg0.setValue("12:00:00");
		} else {
			arg0.setValue("");
		}
	}

	@Override
	public void visit(Addition arg0) {
		Expression e = visitExpression(arg0.getLeftExpression());
		if (e != null) arg0.setLeftExpression(e);
		e = visitExpression(arg0.getRightExpression());
		if (e != null) arg0.setRightExpression(e);
	}

	@Override
	public void visit(Division arg0) {
		Expression e = visitExpression(arg0.getLeftExpression());
		if (e != null) arg0.setLeftExpression(e);
		e = visitExpression(arg0.getRightExpression());
		if (e != null) arg0.setRightExpression(e);
	}

	@Override
	public void visit(Multiplication arg0) {
		Expression e = visitExpression(arg0.getLeftExpression());
		if (e != null) arg0.setLeftExpression(e);
		e = visitExpression(arg0.getRightExpression());
		if (e != null) arg0.setRightExpression(e);
	}

	@Override
	public void visit(Subtraction arg0) {
		Expression e = visitExpression(arg0.getLeftExpression());
		if (e != null) arg0.setLeftExpression(e);
		e = visitExpression(arg0.getRightExpression());
		if (e != null) arg0.setRightExpression(e);
	}

	@Override
	public void visit(AndExpression arg0) {
		Expression e = visitExpression(arg0.getLeftExpression());
		if (e != null) arg0.setLeftExpression(e);
		e = visitExpression(arg0.getRightExpression());
		if (e != null) arg0.setRightExpression(e);
	}

	@Override
	public void visit(OrExpression arg0) {
		Expression e = visitExpression(arg0.getLeftExpression());
		if (e != null) arg0.setLeftExpression(e);
		e = visitExpression(arg0.getRightExpression());
		if (e != null) arg0.setRightExpression(e);
	}

	@Override
	public void visit(Between arg0) {
		Expression e = visitExpression(arg0.getLeftExpression());
		if (e != null) arg0.setLeftExpression(e);
		e = visitExpression(arg0.getBetweenExpressionStart());
		if (e != null) arg0.setBetweenExpressionStart(e);
		e = visitExpression(arg0.getBetweenExpressionEnd());
		if (e != null) arg0.setBetweenExpressionEnd(e);
	}

	@Override
	public void visit(EqualsTo arg0) {
		Expression e = visitExpression(arg0.getLeftExpression());
		if (e != null) arg0.setLeftExpression(e);
		e = visitExpression(arg0.getRightExpression());
		if (e != null) arg0.setRightExpression(e);
	}

	@Override
	public void visit(GreaterThan arg0) {
		Expression e = visitExpression(arg0.getLeftExpression());
		if (e != null) arg0.setLeftExpression(e);
		e = visitExpression(arg0.getRightExpression());
		if (e != null) arg0.setRightExpression(e);
	}

	@Override
	public void visit(GreaterThanEquals arg0) {
		Expression e = visitExpression(arg0.getLeftExpression());
		if (e != null) arg0.setLeftExpression(e);
		e = visitExpression(arg0.getRightExpression());
		if (e != null) arg0.setRightExpression(e);
	}

	@Override
	public void visit(InExpression arg0) {
		Expression e = visitExpression(arg0.getLeftExpression());
		if (e != null) arg0.setLeftExpression(e);
		arg0.getRightItemsList().accept(this);

	}

	@Override
	public void visit(IsNullExpression arg0) {
		Expression e = visitExpression(arg0.getLeftExpression());
		if (e != null) arg0.setLeftExpression(e);
	}

	@Override
	public void visit(LikeExpression arg0) {
		Expression e = visitExpression(arg0.getLeftExpression());
		if (e != null) arg0.setLeftExpression(e);
		e = visitExpression(arg0.getRightExpression());
		if (e != null) arg0.setRightExpression(e);
	}

	@Override
	public void visit(MinorThan arg0) {
		Expression e = visitExpression(arg0.getLeftExpression());
		if (e != null) arg0.setLeftExpression(e);
		e = visitExpression(arg0.getRightExpression());
		if (e != null) arg0.setRightExpression(e);
	}

	@Override
	public void visit(MinorThanEquals arg0) {
		Expression e = visitExpression(arg0.getLeftExpression());
		if (e != null) arg0.setLeftExpression(e);
		e = visitExpression(arg0.getRightExpression());
		if (e != null) arg0.setRightExpression(e);
	}

	@Override
	public void visit(NotEqualsTo arg0) {
		Expression e = visitExpression(arg0.getLeftExpression());
		if (e != null) arg0.setLeftExpression(e);
		e = visitExpression(arg0.getRightExpression());
		if (e != null) arg0.setRightExpression(e);
	}

	@Override
	public void visit(Column arg0) {
		arg0.getTable().accept(this);
	}

	@Override
	public void visit(SubSelect arg0) {
		arg0.getSelectBody().accept(this);		
	}

	@Override
	public void visit(CaseExpression arg0) {
		if (arg0.getSwitchExpression() != null) {
			Expression e = visitExpression(arg0.getSwitchExpression());
			if (e != null) arg0.setSwitchExpression(e);
		}
		
		if (arg0.getWhenClauses() != null)
			arg0.getWhenClauses().forEach(e -> e.accept(this));
		
		if (arg0.getElseExpression() != null) {
			Expression e = visitExpression(arg0.getElseExpression());
			if (e != null) arg0.setElseExpression(e);
		}
	}

	@Override
	public void visit(WhenClause arg0) {
		Expression e = visitExpression(arg0.getWhenExpression());
		if (e != null) arg0.setWhenExpression(e);
	}

	@Override
	public void visit(ExistsExpression arg0) {
		if (arg0.getRightExpression() != null) {
			Expression e = visitExpression(arg0.getRightExpression());
			if (e != null) arg0.setRightExpression(e);
		}
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
	}

	@Override
	public void visit(Matches arg0) {
		// TODO Auto-generated method stub

	}

	@Override
	public void visit(BitwiseAnd arg0) {
		Expression e = visitExpression(arg0.getLeftExpression());
		if (e != null) arg0.setLeftExpression(e);
		e = visitExpression(arg0.getRightExpression());
		if (e != null) arg0.setRightExpression(e);
	}

	@Override
	public void visit(BitwiseOr arg0) {
		Expression e = visitExpression(arg0.getLeftExpression());
		if (e != null) arg0.setLeftExpression(e);
		e = visitExpression(arg0.getRightExpression());
		if (e != null) arg0.setRightExpression(e);
	}

	@Override
	public void visit(BitwiseXor arg0) {
		Expression e = visitExpression(arg0.getLeftExpression());
		if (e != null) arg0.setLeftExpression(e);
		e = visitExpression(arg0.getRightExpression());
		if (e != null) arg0.setRightExpression(e);
	}

	@Override
	public void visit(CastExpression arg0) {
	}

	@Override
	public void visit(Modulo arg0) {
		// TODO Auto-generated method stub

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
	public void visit(ValueListExpression valueList) {
		valueList.getExpressionList().accept(this);
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
	public void visit(SimilarToExpression arg0) {
		Expression e = visitExpression(arg0.getLeftExpression());
		if (e != null) arg0.setLeftExpression(e);
		e = visitExpression(arg0.getRightExpression());
		if (e != null) arg0.setRightExpression(e);
	}

	@Override
	public void visit(Table arg0) {
		if (arg0.getName() == null) return;
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
		List<Expression> expList = arg0.getExpressions();
		for (int i = 0; i < expList.size(); i++) {
			Expression e = visitExpression(expList.get(i));
			if (e != null) expList.set(i, e);
		}
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
		if(arg0.getSelectItems()!=null) {
			for (SelectItem si : arg0.getSelectItems())
				si.accept(this);
		}
		if(arg0.getFromItem()!=null) arg0.getFromItem().accept(this);
		if(arg0.getHaving()!=null) arg0.getHaving().accept(this);
		if(arg0.getJoins()!=null) arg0.getJoins().stream().forEach(x -> {
			x.getRightItem().accept(this);
			if (x.getOnExpression() != null)
				x.getOnExpression().accept(this);
		});
		if(arg0.getWhere()!=null) {		
			arg0.getWhere().accept(this);
		}
		if(arg0.getGroupBy() != null) arg0.getGroupBy().getGroupByExpressions().stream().forEach(x -> x.accept(this));
		if(arg0.getOrderByElements() != null) {
			for (OrderByElement obe : arg0.getOrderByElements()) {
				obe.accept(this);
			}
		}
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
		Expression e = visitExpression(arg0.getExpression());
		if (e != null) arg0.setExpression(e);
	}

	@Override
	public void visit(OrderByElement arg0) {
		Expression e = visitExpression(arg0.getExpression());
		if (e != null) arg0.setExpression(e);
	}

}
