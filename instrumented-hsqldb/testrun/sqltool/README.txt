$Id: README.txt 5304 2013-10-20 19:34:25Z unsaved $

SqlTool Unit Tests
since:  HSQLDB 1.8.0.8
author:  Blaine Simpson (unsaved@users.sourceforge.net)

************************************************************
Sun Jan 18 21:52:58 EST 2009
The dsv-constcols.sql and dsv-trimming.sql unit tests are failing
now, due to known issues with the inability to apply DST (Daylight
Savings Time) offsets to JDBC DATE objects.
************************************************************

The test runners depend on the hsqldb.jar and sqltool.jar being in place in the ../../lib directory.


HOW TO RUN

    Typical usage (executes all tests).
    From UNIX shell

        cd .../testrun/sqltool
        ../../build/gradlew
    
    or

        cd .../testrun/sqltool
        ./runtests.bash

    From Windows shell

        cd ...\testrun\sqltool
        ..\..\build\gradlew

    or

        cd ...\testrun\sqltool
        runtests

    Run tests on any subset of SQL files:

        cd .../testrun/sqltool
        .../testrun/sqltool/runtests.bash file1.sql file2.nsql...
    or
        cd .../testrun/sqltool
        .../testrun/sqltool/runtests file1.sql file2.nsql...

    If you have Grooy installed, you can run tests on SQL files that reside
    anywhere:

        groovy .../testrun/sqltool/runtests.groovy file1.sql file2.nsql...

    If there are any test failures, the failed SQL scripts will be listed
    at the end of the results.  To get details about the failure, re-run the
    same command with just one of the failed SQL scripts at a time, and
    with the Verbose option, like

        ../../build/gradlew -Pverbose=true -Pscripts=failedscript.sql
        (to execute multiple files, delimit the scripts with just commas).

    or

        ./runtests.bash -v failedscript.sql...
    or
        runtests -v failedscript.sql...
    or
        groovy .../testrun/sqltool/runtests.groovy -v failedscript.sql...

    To see all available invocation methods:

        ./runtests.bash -h
    or
        runtests -h


FILE NAMING AND ASCII/BINARY CONVENTIONS

    You can name SQL scripts anything that you want, except that the
    filename suffixes ".nsql"  and ".inter" are reserved for negative
    and interactive SQL scripts, correspondingly (see the next section
    about that).

    If you plan to run runtests.bash with no filename arguments, it
    will execute all *.sql, *.nsql, an d*.inter scripts in the current
    directory.
    So, if you plan to run runtests.bash this way, you must take care
    to name only scripts **which you want executed at the top level**
    with extensions sql, nsql, inter.  By "at the top level", I mean
    that if you are nesting SQL scripts with the \i command, you can't 
    name the nested script with suffix .sql, .nsql, or .inter or the
    script will accidentally be executed directly when you run
    runtests.bash without script arguments.  It's a simple concept, but,
    as you can see, it's a little difficult to explain, so here's an
    example.

    You have a script name "top.sql" which contains

         \i nested.sql

    You can run "./runtests.bash top.sql" and everything will work
    fine-- runtests.bash will execute "top.sql" which will nest
    "nested.sql".  But if you run just "./runtests.bash",
    runtests.bash will run "top.bash", which will nest "nested.bash"
    just like before, but runtests.bash will also execute
    "nested.bash" directly, since it executes all files with extensions
    sql and nsql (and inter).  Just use any filename suffix other than
    .sql, .nsql, and .inter for your nested SQL scripts and everything
    will work fine.

    If you are a HSQLDB developer and will be committing test scripts,
    then please use the following filename and type conventions:

        purpose                 suffix  filetype
        --------------------    ------  ----------------------------
        top-level SQL script    .sql    ASCII (mime-type text/plain)
        top-level neg. SQL      .nsql   ASCII (mime-type text/plain)
        interactive SQL script  .inter  ASCII (mime-type text/plain)
        nested \i SQL script*   .isql   ASCII (mime-type text/plain)*
        delimiter-sep-values*   .dsv    Binary (no mime-type)*

    * If you run any 'runtests' command without specifying any script files,
      all of the *.sql, *.nsql, and *.inter scripts will be executed directly.
      Any other files, including *.isql and *.dsv, will only be used if
      pulled in from the directly executed scripts.
      Therefore, if you add a script named say 'alpha.isql' or 'beta.custom',
      they will not be used unless you specify the filename to your 'testrun'
      command explicitly, or if you reference them from a file that is
      executed directly.

    If you will be adding new files to HSQLDB, please configure these
    extensions in for CVS or Subversion client accordingly.


    FINE POINT JUSTIFYING Binary TYPE FOR DSV FILES

        (Only read if you give a damned).
        The reason we're storing DSV files as binaries is because if 
        CVS or Subversion saved them as ASCII, the line delimiters would
        be determined by the platform performing the check-out, and 
        imports would fail if the computer executing nested.bash happened 
        to be of different EOL type from the computer that checked out.
        (This would be the case any time that somebody built a 
        distributable of any type which includes the .dsv files).


NEGATIVE TESTS

    runtests.bash determines if a test script succeeds by checking if
    the exit status of SqlTool is zero.  But we also need to test that
    scripts fail out when they should.  I.e., we need to verify that if
    \c (continue-on-error) is false, and there is a syntax error, or
    a runtime SQL failure, that SqlTool exits with non-zero exit status,
    as it should.  For this, I have invented the convention that SQL
    scripts named with suffix ".nsql" are just like normal SQL files,
    except that they are expected to fail.

    Here's an example to confirm that you understand.

        ./runtests.bash 1.sql 2.sql 3.nsql 4.nsql 5.sql
        or runtests 1.sql 2.sql 3.nsql 4.nsql 5.sql    (on Windows)

    This test run will report test failures for 1.sql, 2.sql, and 5.sql
    only if SqlTool fails when executing them.  It will report test
    failures for 3.nsql and 4.nsql only if SqlTool succeeds when 
    executing them.  I.e., runtests.bash _expects_ SqlTool to fail 
    when executing *.nsql files.

    Negative test scripts should be small and should fail out as
    early as possible.  The reason for this is that if there is an
    accidental error before the point of your test, the script will
    fail out early providing a false negative SqlTool exit code,
    thereby silently missing your test completely.


INTERACTIVE TESTS

    Interactive test are invoked like

        java... SqlTool... mem < scriptname.inter

    in order to test interactive ":" commands.  The : commands are
    disabled if an SQL script path(s) is given directly as an SqlTool
    parameter.  I.e., SqlTool runs non-interactively if an SQL script
    path is given as a pareter; therefore, to test interactive
    commands, we invoke SqlTool without a script name, and instead
    pipe the script into SqlTool as stdin.  (Using script name of
    "-" would do the reverse, it would run in interactive mode even
    though getting input from stdin).

    Remember to put "\c false" at the top of your interacive scripts,
    or errors will be ignored.  Account for this command when counting
    command numbers in the command history.
