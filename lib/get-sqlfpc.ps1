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

# Define script parameters
param (
    [switch]$CICache = $false
)

# Define some variables
$cacheDir  = Join-Path $ENV:UserProfile '.evosql-libs-cache'
$cacheFile = Join-Path $cacheDir 'sqlrules-2018-03-09.jar'
$uri       = 'http://in2test.lsi.uniovi.es/sqltools/sqlrules/sqlrules.zip'

# First, check to see if we're running in CI and if it should be cached
if ($CICache) {

    Write-Output 'Running with cache...'
    
    # Check if a cached file exists
    if (![System.IO.File]::Exists($cacheFile)) {

        Write-Output 'Cached file not found, downloading zip file...'

        # Download the zip file
        Invoke-WebRequest -Uri $uri -OutFile 'sqlrules.zip'

        # Check if cache directory exists, create it if not
        if (![System.IO.Directory]::Exists($cacheDir)) {
            [System.IO.Directory]::CreateDirectory($cacheDir) | Out-Null
        }

        Write-Output 'Unzipping files...'

        # Extract *only* the jar
        # Add a date to the file so we can replace the cache
        Add-Type -Assembly System.IO.Compression.FileSystem
        $zip = [IO.Compression.ZipFile]::OpenRead((Join-Path (Get-Location) 'sqlrules.zip'))
        $zip.Entries |
            Where-Object {$_.Name -eq 'sqlrules.jar'} |
            ForEach-Object {[System.IO.Compression.ZipFileExtensions]::ExtractToFile($_, $cacheFile, $true)}
        $zip.Dispose()

        Write-Output 'Removing temporary zip file...'

        # Remove the downloaded zip
        Remove-Item 'sqlrules.zip'
    } else {
        Write-Output 'Found cached version of necessary file.'
    }

    Write-Output 'Copying cached file to local directory...'

    # Copy the cached file to local directory
    Copy-Item $cacheFile 'sqlrules.jar'

} else {

    Write-Output 'By executing this script you agree with the licenses of the respective software owners.'
    Write-Output 'Please review them if you have not.'

    Write-Output 'Downloading zip file...'

    # Download the zip file
    Invoke-WebRequest -Uri $uri -OutFile 'sqlrules.zip'

    Write-Output 'Unzipping files...'

    # Extract *only* the jar
    Add-Type -Assembly System.IO.Compression.FileSystem
    $zip = [IO.Compression.ZipFile]::OpenRead((Join-Path (Get-Location) 'sqlrules.zip'))
    $zip.Entries |
        Where-Object {$_.Name -eq 'sqlrules.jar'} |
        ForEach-Object {[System.IO.Compression.ZipFileExtensions]::ExtractToFile($_, (Join-Path (Get-Location) 'sqlrules.jar'), $true)}
    $zip.Dispose()

    Write-Output 'Removing temporary zip file...'

    # Remove the downloaded zip
    Remove-Item 'sqlrules.zip'
}

Write-Output 'All done!'
