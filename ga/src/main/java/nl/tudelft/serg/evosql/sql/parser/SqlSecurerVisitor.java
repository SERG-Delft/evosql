package nl.tudelft.serg.evosql.sql.parser;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.TimeZone;

import net.sf.jsqlparser.expression.*;
import net.sf.jsqlparser.expression.operators.arithmetic.*;
import net.sf.jsqlparser.expression.operators.conditional.AndExpression;
import net.sf.jsqlparser.expression.operators.conditional.OrExpression;
import net.sf.jsqlparser.expression.operators.relational.*;
import net.sf.jsqlparser.schema.Column;
import net.sf.jsqlparser.schema.Table;
import net.sf.jsqlparser.statement.select.*;
import net.sf.jsqlparser.statement.values.ValuesStatement;

public class SqlSecurerVisitor implements ExpressionVisitor, FromItemVisitor, ItemsListVisitor, SelectVisitor, SelectItemVisitor, OrderByVisitor {
	private SimpleDateFormat wrongDatetimeFormat = new SimpleDateFormat("EEE MMM dd HH:mm:ss z yyyy");
	private SimpleDateFormat rightDatetimeFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	private boolean isOuter = true;
	
	private String secureName(String name) {
		name = name.replaceAll("`", "");
		if (!name.matches("^\".*$")) {
			name = "\"" + name;
		}
		if (!name.matches("^.*\"$")) {
			name = name + "\"";
		}
		return name;
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
		// TODO Auto-generated method stub

	}

	@Override
	public void visit(DateValue arg0) {
		// TODO Auto-generated method stub

	}

	@Override
	public void visit(TimeValue arg0) {
		// TODO Auto-generated method stub

	}

	@Override
	public void visit(TimestampValue arg0) {
		// TODO Auto-generated method stub

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
		// Check if it is a column
		if (arg0.getLeftExpression() instanceof Column) {
			EqualsTo newExp = new EqualsTo();
			newExp.setLeftExpression(arg0.getLeftExpression());
			newExp.setRightExpression(new LongValue(1));
			arg0.setLeftExpression(newExp);
		}
		arg0.getLeftExpression().accept(this);
		// Check if it is a column
		if (arg0.getRightExpression() instanceof Column) {
			EqualsTo newExp = new EqualsTo();
			newExp.setLeftExpression(arg0.getRightExpression());
			newExp.setRightExpression(new LongValue(1));
			arg0.setRightExpression(newExp);
		}
		arg0.getRightExpression().accept(this);
	}

	@Override
	public void visit(OrExpression arg0) {
		// Check if it is a column
		if (arg0.getLeftExpression() instanceof Column) {
			EqualsTo newExp = new EqualsTo();
			newExp.setLeftExpression(arg0.getLeftExpression());
			newExp.setRightExpression(new LongValue(1));
			arg0.setLeftExpression(newExp);
		}
		arg0.getLeftExpression().accept(this);
		// Check if it is a column
		if (arg0.getRightExpression() instanceof Column) {
			EqualsTo newExp = new EqualsTo();
			newExp.setLeftExpression(arg0.getRightExpression());
			newExp.setRightExpression(new LongValue(1));
			arg0.setRightExpression(newExp);
		}
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
		Table table = arg0.getTable();
		if (table != null) {
			table.accept(this);
		}
		arg0.setColumnName(secureName(arg0.getColumnName()));
	}

	@Override
	public void visit(SubSelect arg0) {
		arg0.getSelectBody().accept(this);
		if (arg0.getAlias() != null) {
			arg0.getAlias().setName(secureName(arg0.getAlias().getName()));
		}
		
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
		aThis.getLeftExpression().accept(this);
	}

	@Override
	public void visit(SimilarToExpression aThis) {
		aThis.getLeftExpression().accept(this);
		aThis.getRightExpression().accept(this);
	}

	@Override
	public void visit(Table arg0) {
		if (arg0.getName() == null) return;
		
		arg0.setName(secureName(arg0.getName()));
		
		// Handle alias
		if (arg0.getAlias() != null) {
			arg0.getAlias().setName(secureName(arg0.getAlias().getName()));
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
		namedExpressionList.getExpressions().forEach(x -> x.accept(this));
	}

	@Override
	public void visit(MultiExpressionList arg0) {
		arg0.getExprList().stream().forEach(x -> x.accept(this));
	}

	@Override
	public void visit(PlainSelect arg0) {
		boolean scopeIsOuter = isOuter;
		isOuter = false;
		
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
			// Check if it is a column
			Expression where = arg0.getWhere();
			if (where instanceof Column) {
				EqualsTo newWhere = new EqualsTo();
				newWhere.setLeftExpression(where);
				newWhere.setRightExpression(new LongValue(1));
				arg0.setWhere(newWhere);
			}
			
			arg0.getWhere().accept(this);
		}
		if(arg0.getGroupBy() != null) arg0.getGroupBy().getGroupByExpressions().stream().forEach(x -> x.accept(this));
		// Remove limit & order by if outer select
		if (scopeIsOuter) {
			arg0.setOrderByElements(null);
			arg0.setLimit(null);
		} else {
			if(arg0.getOrderByElements() != null) {
				for (OrderByElement obe : arg0.getOrderByElements()) {
					obe.accept(this);
				}
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
		aThis.getExpressions().forEach(x -> x.accept(this));
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

		// Handle alias
		if (arg0.getAlias() != null) {
			arg0.getAlias().setName(secureName(arg0.getAlias().getName()));
		}
	}

	@Override
	public void visit(OrderByElement arg0) {
		arg0.getExpression().accept(this);
	}

}
