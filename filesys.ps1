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

#create, copy, move, deletes files and directories
Function Directory-management
{
    #adds 4 folders in the selected location
    1..4 | ForEach-Object {New-Item -ItemType Directory -Name "Folder$_"}

    #creates 3 file in each folders
    1..4 | ForEach-Object {   
        set-location ".\Folder$_"
        1..3 | ForEach-Object {
            New-Item -ItemType File -Name "file$_"
        }
        set-location ..
    }  

    # asks user to enter the desired path to copy files from
    $path = Read-Host "Enter desired path to copy files from: "

    # asks user to enter the destination path to copy files to
    $destination = Read-Host "Enter destination path to copy files to: "

    1..3 | ForEach-Object {
        # Construct the source and destination paths for the current file
        $sourceFile = Join-Path -Path $path -ChildPath "file$_"
        $newFileName = "newfile$_"  # Rename the file
        $destinationFile = Join-Path -Path $destination -ChildPath $newFileName

        # Rename the file before copying it and get the new file path
        $newSourceFile = Rename-Item -Path $sourceFile -NewName $newFileName -PassThru

        # Copy the renamed file from the source to the destination with -Force to replace existing files
        Copy-Item -Path $newSourceFile.FullName -Destination $destinationFile -Force -PassThru
    }

    #copies Folder3 and move to Folder2

    #delete a file of user choice
    $removeFile = Read-Host "Enter file path to remove that file"
    Remove-Item $removeFile
    Write-Host "File deleted"

    #delete a folder of user choice
    $deleteFile = Read-Host "Enter folder path to reove that folder" 
    Remove-Item $deleteFile -Recurse
    Write-Host "Folder deleted"

}

#file content Handling
Function FileContentHandling {
    $readFile = Read-Host "Enter path to file to modify and read the file"
    $newContent = Read-Host "Enter new content to add"
    
    #modifies/replace content to the selected file
    Set-Content $readFile -Value $newContent

    #reads the selected file
    Get-Content $readFile

    #append new content
    Add-Content $readFile -Value "this is new content"
}

#handles a file attributes and permission
Function Permission {
    $file = Read-host "Enter the file path:"
    Get-Item $file | Select-Object Attributes
    Set-ItemProperty $file -Name IsReadOnly $true
    Get-Item $file | Select-Object Attributes
}

#Search sepcific (file2) content within files
Function search {
    $file = "C:\Users\sshak\OneDrive\Desktop\ASSIGNMENT\WINTER 2024\COMP3410\trial\Folder2\file3"
    Select-String -Path $file -Pattern "new"
}

#compresses a file and decompresses a file and retrieve meta information
Function AdditionalFunction {
$file = "C:\Users\sshak\OneDrive\Desktop\ASSIGNMENT\WINTER 2024\COMP3410\trial\Folder2"
Compress-Archive -Path $file\file3 -DestinationPath $file\Archive.zip 
Expand-Archive -Path $file\Archive.zip -DestinationPath $file\Extracted\ 
Get-Item $file | Select-Object *
}

#sets up password
Function Security {
    $pathlocation = read-host "Enter the path"
    $password = "bob"
    $enterPassword = Read-host "Enter password"
    if ($enterPassword -eq $password){
        Get-Content $pathlocation
    } else {
        Write-Host "incorrect password"
    }
}

#calling functions
$desiredDirectory = Read-Host "Enter desired directory path"
Set-Desired-Location $desiredDirectory
Directory-management
FileContentHandling
Permission
search
AdditionalFunction
Security



