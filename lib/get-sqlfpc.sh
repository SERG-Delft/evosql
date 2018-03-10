###############################################################
#                                                             #
#   Script for downloading necessary dependencies of EvoSQL   #
#   that may not be distibuted under the same source code     #
#   license. By running this, you agree to all licenses of    #
#   the respective software packages.                         #
#                                                             #
###############################################################

# This script may be executed to get the required dependencies,
# or executed with '--ci-cache' to cache the file in a special
# directory known to the CI provider.

# Check if unzip is installed. Install otherwise
command -v unzip >/dev/null 2>&1 || {
    echo unzip is not installed. Installing...
    sudo apt install -y unzip
}

# Define some variables
CACHE_DIR=~/.evosql-libs-cache
CACHE_FILE=~/.evosql-libs-cache/sqlrules-2018-03-09.jar
ZIP_URI="http://in2test.lsi.uniovi.es/sqltools/sqlrules/sqlrules.zip"

# First, check to see if we're running in CI and if it should be cached
if [ "$1" == "--ci-cache" ]; then

    echo Running with cache...

    # Check if a chached file exists
    if [ ! -f "$CACHE_FILE" ]; then

        echo Cached file not found, downloading zip file...

        # Download the zip file
        wget "$ZIP_URI"

        # Check if cache directory exists, create it if not
        if [ ! -d "$CACHE_DIR" ]; then
            mkdir "$CACHE_DIR"
        fi

        echo Unzipping files...

        # Extract *only* the jar
        # Add a date to the file so we can replace the cache
        unzip -p sqlrules.zip sqlrules.jar > "$CACHE_FILE"

        echo Removing temporary zip file...

        # Remove the downloaded zip
        rm sqlrules.zip

    else
        echo Found cached version of necessary file.
    fi

    echo Copying cached file to local directory...

    # Copy the cached file to local directory
    cp "$CACHE_FILE" sqlrules.jar

else

    echo By executing this script you agree with the licenses of the respective software owners.
    echo Please review them if you have not.

    echo Downloading zip file...

    # Download the zip file
    wget http://in2test.lsi.uniovi.es/sqltools/sqlrules/sqlrules.zip

    echo Unzipping files...

    # Extract *only* the jar
    unzip -p sqlrules.zip sqlrules.jar > sqlrules.jar

    # Remove the downloaded zip
    rm sqlrules.zip

    echo Removing temporary zip file...

fi

echo All done!
