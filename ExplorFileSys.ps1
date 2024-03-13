#checks location of the path and list contents in the directory, if does not exist, termiate
Function Set-Desired-Location {
    param([string]$desiredDirectory)

    if (Test-path $desiredDirectory -PathType Container ) 
    {
        Set-Location $desiredDirectory
        Write-Host "Path exist: Displayig Content in the Directory"
        Get-ChildItem -Path $desiredDirectory 


    } else {
        Write-Host "Path doesn't exist."
        return
    }
}

Function Directory-management
{
    #adds 4 folders in the selected location
    1..4 | ForEach-Object {New-Item -ItemType Directory -Name "Folder$_"}

    #creates 3 file in each folders
    1..4 | ForEach-Object {
        #keep tracks of folder no to use in file for easier to distinguish files
        $index = $_
        set-location ".\Folder$_"
        1..3 | ForEach-Object {
            New-Item -ItemType File -Name "file{$index}$_"
        }
        set-location ..
    }
}

$desiredDirectory = Read-Host "Enter desired directory path"
Set-Desired-Location $desiredDirectory
Directory-management
