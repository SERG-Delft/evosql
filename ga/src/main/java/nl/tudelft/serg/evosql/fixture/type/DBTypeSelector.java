package nl.tudelft.serg.evosql.fixture.type;

import nl.tudelft.serg.evosql.EvoSQLConfiguration;

import java.sql.Types;

/**
 * A class for instantiating an appropriate DBType subclass.
 */
public class DBTypeSelector {
    /**
     * Instantiates an instance of an appropriate DBType subclass.
     *
     * @param dataType The Java SQL type.
     * @param length   The length of the type. Does not apply to all types.
     * @return An instance of an appropriate DBType subclass.
     */
    public DBType create(int dataType, int length) {
        switch (dataType) {
            // Floating-point numbers
            case Types.DOUBLE:
                return new DBDouble();
            case Types.REAL:
                return new DBDouble("REAL");
            case Types.DECIMAL:
                return new DBDouble("DECIMAL");
            // Integer numbers
            case Types.INTEGER:
                return new DBInteger();
            case Types.SMALLINT:
                return new DBInteger("SMALLINT");
            case Types.TINYINT:
                return new DBInteger("TINYINT"); // HSQLDB doesn't support tinyint
            case Types.BIGINT:
                return new DBInteger(); // we don't need bigint in our evaluations
            // Strings
            case Types.VARCHAR:
                return new DBString(length);
            case Types.NVARCHAR:
                return new DBString(length, "NVARCHAR");
            case Types.LONGVARCHAR:
                return new DBString(EvoSQLConfiguration.MAX_STRING_LENGTH, "LONGVARCHAR");
            case Types.LONGNVARCHAR:
                return new DBString(EvoSQLConfiguration.MAX_STRING_LENGTH, "LONGNVARCHAR");
            case Types.CHAR:
                return new DBString(length, "CHAR");
            case Types.NCHAR:
                return new DBString(length, "NCHAR");
            // Boolean values
            case Types.BIT:
                return new DBBoolean(); // HSQLDB doesn't support bit
            case Types.BOOLEAN:
                return new DBBoolean("BOOLEAN");
            // Dates and times
            case Types.DATE:
                return new DBDate();
            case Types.TIME:
                return new DBTime();
            case Types.TIMESTAMP:
                return new DBDateTime("TIMESTAMP");
            // Other types
            case Types.ARRAY:
                throw new UnsupportedOperationException("The ARRAY data type is currently not supported by EvoSQL.");
            default:
                throw new UnsupportedOperationException("This database type is not currently supported: " + dataType);
        }
    }
}
