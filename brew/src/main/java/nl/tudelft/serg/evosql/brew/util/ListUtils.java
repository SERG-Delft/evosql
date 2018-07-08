package nl.tudelft.serg.evosql.brew.util;

import lombok.NonNull;

import java.util.ArrayList;
import java.util.InputMismatchException;
import java.util.Iterator;
import java.util.List;

/**
 * Provides utilities for lists.
 */
public class ListUtils {
    public static <T> List<T> interleaveSameLength(@NonNull List<T> a, @NonNull List<T> b) {
        if (a.size() != b.size()) {
            throw new InputMismatchException("The lists do not have the same size.");
        }

        List<T> result = new ArrayList<>();

        Iterator<T> itA = a.iterator();
        Iterator<T> itB = b.iterator();

        while (itA.hasNext()) {
            result.add(itA.next());
            result.add(itB.next());
        }

        return result;
    }
}
