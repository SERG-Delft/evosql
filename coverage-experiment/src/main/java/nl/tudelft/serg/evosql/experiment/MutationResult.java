package nl.tudelft.serg.evosql.experiment;

import lombok.NonNull;
import lombok.Value;

import java.util.List;

@Value
public class MutationResult {
    @NonNull
    private final String query;
    @NonNull
    private final List<String> mutants;

    public void print() {
        System.out.println("Original:");
        System.out.print("\t");
        System.out.println(query);
        System.out.println("Mutations:");
        for (String mutant : mutants) {
            System.out.print("\t");
            System.out.println(mutant);
        }
    }

    @Override
    public String toString() {
        return query + "\n" + String.join("\n", mutants);
    }
}
