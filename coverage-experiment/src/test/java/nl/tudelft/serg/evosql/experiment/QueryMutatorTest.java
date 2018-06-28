package nl.tudelft.serg.evosql.experiment;

import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.charset.Charset;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Arrays;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertTrue;

public class QueryMutatorTest {

    private String mutatorXMLFile;

    @BeforeEach
    public void setup() {
        String fileName = "MutatorXMLTest.xml";
        ClassLoader classLoader = ClassLoader.getSystemClassLoader();
        File file = new File(classLoader.getResource(fileName).getFile());
        try {
            mutatorXMLFile = new String(Files.readAllBytes(Paths.get(file.getAbsolutePath())), Charset.defaultCharset());
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @Test
    public void parseMutantsTest1() {
        List<String> expected = Arrays.asList("SELECT empname FROM staff WHERE empnum = 'E1'",
                "SELECT DISTINCT empname FROM staff WHERE empnum = 'E1'",
                "SELECT STAFF.EMPNUM FROM staff WHERE empnum = 'E1'");

        QueryMutator queryMutator = new QueryMutator();
        assertTrue(expected.equals(queryMutator.parseMutations(mutatorXMLFile)));
    }
}
