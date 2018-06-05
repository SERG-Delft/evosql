package nl.tudelft.serg.evosql.experiment;

import java.io.File;
import java.nio.file.Paths;

/**
 * Main runner class. Implementation depends on whether it will be used as a client for
 * a web server which hands out jobs or whether it should be autonomous and read a portion
 * of the queries.
 */
public class Runner {

    public static void main(String[] args) {
        // 1. Read in queries
        // 2. Build schema's for DB
        // 3. For each query:
        //     3a. Execute GA on given query
        //     3b. Store fixture that GA outputs
        //     3c. Construct test class with fixture for original query
        //     3d. Mutate query
        //     3e. Construct test class with fixture for mutated query
        // 4. Execute all tests that should pass and store results
        // 5. Execute all tests that shouldn't pass and store results
        // 6. Output final results
    }

    public QueryExperimentResult runForQuery(String filePath, int lineNo) {
        QueryReader queryReader = new QueryReader();
        String query = queryReader.readQuery(new File(filePath), lineNo);


        return null;
    }

}
