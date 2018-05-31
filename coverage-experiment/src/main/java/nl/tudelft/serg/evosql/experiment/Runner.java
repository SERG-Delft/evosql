package nl.tudelft.serg.evosql.experiment;

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
}
