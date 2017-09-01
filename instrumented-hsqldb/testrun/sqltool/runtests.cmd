
:: $Id: runtests.cmd 4697 2011-11-04 13:32:05Z unsaved $
:: Distribution is permitted under the terms of the HSQLDB license.
:: (c) 2011 The HSQL Development Group
::
:: Wrapper that serves two purposes:
:: (1) Takes traditional parameters in format: command -switches... filenames...
::     and converts to a Gradle command of format: Gradle -P x=y...  taskname
:: (2) Invokes the 'gradlew' wrapper script supplied by the HyperSQL
::     distribution.
:: This script automatically 'cd's to directory .../testrun/sqltool in which
:: it resides, so that it may be safely executed from desktop managers, etc.
:: The main work script, "runtests.groovy" does not have this limitation.
::
:: author: Blaine Simpson, unsaved@users.sourceforge.net
:: since: HSQLDB 1.8.0.8 / 1.9.x
:: see:  README.txt in this same directory.
:: In November 2011 this script converted from the sole test runner script, to
:: one wrapper for Gradle (w/ "build.gradle") + runtests.groovy.

@echo off

if "%OS%"=="Windows_NT" setlocal 
set ERRORLEVEL=
ver > nul

set DIRNAME=%~dp0
if "%DIRNAME%" == "" set DIRNAME=.
cd "%DIRNAME%"

if "%1" == "-h" (
    set VERBOSE=-Phelp=true
    shift
) else if "%1" == "-v" (
    set VERBOSE=-Pverbose=true
    shift
) else if "%1" == "-n" (
    set NORUN=-Pnorun=true
    shift
) else if "%1" == "-nv" (
    set VERBOSE=-Pverbose=true
    set NORUN=-Pnorun=true
    shift
) else if "%1" == "-vn" (
    set VERBOSE=-Pverbose=true
    set NORUN=-Pnorun=true
    shift
)

set SCRIPTLIST=
:moreArgs
    if "%1" == "" goto noMoreArgs
    if not "%SCRIPTLIST%" == "" (
        set SCRIPTLIST=%SCRIPTLIST%,%1
    ) else (
        set SCRIPTLIST=-Pscripts=%1
    )
    shift
goto moreArgs

:noMoreArgs

if "%VERBOSE%" == "true" echo ..\..\build\gradlew %HELP% %VERBOSE% %NORUN% %SCRIPTLIST%
..\..\build\gradlew %HELP% %VERBOSE% %NORUN% %SCRIPTLIST%
:: People who have a real, local Gradl installation can use the following:
::gradle %HELP% %VERBOSE% %NORUN% %SCRIPTLIST%
