package nl.tudelft.serg.evosql.experiment;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

public class GradleUtil {

    /**
     * Creates a new Gradle project based on the given settings.
     *
     * @param projectPath The directory to place the project in.
     * @param rootPackage The root package to use.
     * @return A path to the root test directory.
     * @throws IOException if something goes wrong while creating filesystem objects.
     */
    public static Path setupGradleTestProject(Path projectPath, String rootPackage) throws IOException {
        // Create directories
        Files.createDirectories(projectPath);

        // Copies sample gradle file to new project folder
        InputStream gradleTemplate = GradleUtil.class.getClassLoader()
                .getResourceAsStream("gradle/sample_build.gradle");
        Files.copy(gradleTemplate,
                Paths.get(projectPath.toString(), "build.gradle"));

        // Create a path to output test classes to
        Path testClassPath = Paths.get(projectPath.toString(), "src", "test", "java", rootPackage);
        if (!Files.exists(testClassPath)) {
            try {
                Files.createDirectories(testClassPath);
            } catch (IOException e) {
                System.err.println(e);
            }
        }

        return testClassPath;
    }

    /**
     * Runs a test class using Gradle.
     *
     * @param projectPath The path to the Gradle project.
     * @param className   The name of the class to run.
     * @return The exit code of the Gradle process.
     * @throws InterruptedException if the operation is interrupted.
     * @throws IOException          if the directory cannot be found.
     */
    public static int runTestClass(Path projectPath, String className) throws InterruptedException, IOException {
        final Process gradleProcess;
        final ProcessBuilder gradleProcessBuilder =
                new ProcessBuilder("gradle", "test", "--tests", "*." + className);
        gradleProcessBuilder.directory(projectPath.toFile());
        gradleProcess = gradleProcessBuilder.start();
        gradleProcess.waitFor();

        return gradleProcess.exitValue();
    }

    /**
     * Saves a test result at a secure location.
     *
     * @param projectPath   The path to the project.
     * @param fullClassName The fully qualified class name of the test.
     * @return The path to the securely stored file.
     * @throws IOException if a file operation fails.
     */
    public static Path saveTestResult(Path projectPath, String fullClassName) throws IOException {
        String fileName = "TEST-" + fullClassName + ".xml";
        Path testResult = Paths.get(projectPath.toString(),
                "build", "test-results", "test", fileName);
        Path resultDirectory = Paths.get(projectPath.toString(), "result");
        Path savedResult = Paths.get(resultDirectory.toString(), fileName);

        Files.createDirectories(resultDirectory);
        Files.copy(testResult, savedResult);

        return savedResult;
    }
}
