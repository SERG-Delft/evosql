package nl.tudelft.serg.evosql.db;

import net.sf.jsqlparser.expression.*;
import net.sf.jsqlparser.expression.operators.arithmetic.*;
import net.sf.jsqlparser.expression.operators.conditional.AndExpression;
import net.sf.jsqlparser.expression.operators.conditional.OrExpression;
import net.sf.jsqlparser.expression.operators.relational.*;
import net.sf.jsqlparser.schema.Column;
import net.sf.jsqlparser.schema.Table;
import net.sf.jsqlparser.statement.select.*;
import net.sf.jsqlparser.statement.values.ValuesStatement;

public class SeedVisitor implements ExpressionVisitor, FromItemVisitor, ItemsListVisitor, SelectVisitor, SelectItemVisitor {

	private Seeds seeds;

	public SeedVisitor(Seeds seeds) {
		this.seeds = seeds;
	}

	@Override
	public void visit(ValuesStatement aThis) {

	}

	@Override
	public void visit(BitwiseRightShift aThis) {

	}

	@Override
	public void visit(BitwiseLeftShift aThis) {

	}

	@Override
	public void visit(NullValue arg0) {

	}

	@Override
	public void visit(NotExpression aThis) {

	}

	@Override
	public void visit(NextValExpression aThis) {

	}

	@Override
	public void visit(CollateExpression aThis) {

	}

	@Override
	public void visit(SimilarToExpression aThis) {

	}

	@Override
	public void visit(JsonOperator jsonExpr) {

	}

	@Override
	public void visit(ValueListExpression valueList) {

	}

	@Override
	public void visit(ParenthesisFromItem aThis) {

	}

	@Override
	public void visit(NamedExpressionList namedExpressionList) {

	}

	@Override
	public void visit(Function arg0) {
		// TODO Auto-generated method stub

	}

	@Override
	public void visit(SignedExpression arg0) {
		// TODO Auto-generated method stub

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
		seeds.addDouble(arg0.getValue());
	}

	@Override
	public void visit(LongValue arg0) {
		seeds.addLong(Long.parseLong(arg0.getStringValue()));
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
		seeds.addString(arg0.getValue());
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
		// TODO Auto-generated method stub

	}

	@Override
	public void visit(SubSelect arg0) {
		arg0.getSelectBody().accept(this);
	}

	@Override
	public void visit(CaseExpression arg0) {
		arg0.getSwitchExpression().accept(this);
	}

	@Override
	public void visit(WhenClause arg0) {
		arg0.getWhenExpression().accept(this);
	}

	@Override
	public void visit(ExistsExpression arg0) {

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
		// TODO Auto-generated method stub

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
		if(arg0.getFromItem()!=null) arg0.getFromItem().accept(this);
		if(arg0.getHaving()!=null) arg0.getHaving().accept(this);
		if(arg0.getJoins()!=null) arg0.getJoins().stream().forEach(x -> {
			if (x.getOnExpression() != null)
				x.getOnExpression().accept(this);
			if (x.getRightItem() != null)
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
		// TODO Auto-generated method stub
		
	}

	@Override
	public void visit(SelectExpressionItem arg0) {
		arg0.getExpression().accept(this);
	}

}
