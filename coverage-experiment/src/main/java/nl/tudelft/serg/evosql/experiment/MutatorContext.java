package nl.tudelft.serg.evosql.experiment;

import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

public class MutatorContext {
    @Getter
    private StringBuilder cleanBuffer;
    @Getter
    private List<StringBuilder> buffers;
    @Getter @Setter
    private boolean writeToCleanOnly;

    public MutatorContext(StringBuilder cleanBuffer, List<StringBuilder> buffers) {
        this.cleanBuffer = cleanBuffer;
        this.buffers = buffers;
    }

    /**
     * Appends the given clause to all buffers.
     *
     * @param clause clause to append
     */
    public MutatorContext write(String clause) {
        cleanBuffer.append(clause);
        if (!writeToCleanOnly) {
            for (StringBuilder buffer : buffers) {
                buffer.append(clause);
            }
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

    @Override
    public String toString() {
        return cleanBuffer.toString();
    }
}
