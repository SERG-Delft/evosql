package nl.tudelft.serg.evosql.experiment;

import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.ArrayList;
import java.util.List;

@AllArgsConstructor
public class MutatorContext {
    @Getter
    private StringBuilder cleanBuffer;
    private List<StringBuilder> buffers;

    /**
     * Appends the given clause to all buffers.
     *
     * @param clause clause to append
     */
    public MutatorContext write(String clause) {
        cleanBuffer.append(clause);
        for (StringBuilder buffer : buffers) {
            buffer.append(clause);
        }
        return this;
    }

    public MutatorContext write(List<String> clauses) {
        for (String clause : clauses) {
            write(clause);
        }
        return this;
    }

    /**
     * Adds the new buffer to the list of buffer, thus a branch is performed.
     *
     * @param buffer buffer to add
     */
    public MutatorContext branch(StringBuilder buffer) {
        buffers.add(buffer);
        return this;
    }

    public List<String> exportMutants() {
        List<String> mutants = new ArrayList<>();
        for (StringBuilder buffer : buffers) {
            mutants.add(buffer.toString());
        }
        return mutants;
    }

}
