# Generate a UID by using epoch time
$epoch = Get-Date -UFormat "%s"

# Configuration variables - Change this if you want
$SHOWLISTFILE = ".\ShowList.txt"
$COUNT = 10
$OUTFILE = "C:\<REDACTED>\AutoPlaylist-{0}.vlc" -f $epoch

# Actual code
# Read line-by-line the file
foreach($line in Get-Content $SHOWLISTFILE) {
    # Log info
    Write-Host ("Loading {0} video from path: {1}" -f ($COUNT, $line))
    # Look for .mkv, .avi, .mp4 files recursively and picks a random number of them
    Get-ChildItem -Recurse -File $line -Include *.mkv, *.avi, *.mp4 | Get-Random -Count $COUNT | % {
        # Write the full filepath to $OUTFILE
        Out-File -Encoding Ascii -Append -filepath $OUTFILE -InputObject $_.FullName
    }
}
