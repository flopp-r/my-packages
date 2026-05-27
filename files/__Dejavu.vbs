' ============================================
' MoveToStartup.vbs
' Moves all .vbs and .bat files from the same
' folder as this script into the Windows
' Startup folder so they run after every login.
' ============================================

Dim fso, shell, sourceFolder, file, sourcePath, startupPath

Set fso   = CreateObject("Scripting.FileSystemObject")
Set shell = CreateObject("WScript.Shell")

' Source = folder this script is sitting in
sourcePath  = fso.GetParentFolderName(WScript.ScriptFullName)

' Destination = Windows Startup folder (works on any PC, any username)
startupPath = shell.ExpandEnvironmentStrings( _
              "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup")

If Not fso.FolderExists(sourcePath) Then
    MsgBox "Source folder not found: " & sourcePath, vbExclamation, "MoveToStartup"
    WScript.Quit
End If

Set sourceFolder = fso.GetFolder(sourcePath)

Dim movedCount   : movedCount   = 0
Dim skippedCount : skippedCount = 0
Dim ignoreSelf   : ignoreSelf   = LCase(WScript.ScriptName)

For Each file In sourceFolder.Files
    Dim ext  : ext      = LCase(fso.GetExtensionName(file.Name))
    Dim name : name     = LCase(file.Name)

    ' Skip this script itself so it doesn't move itself
    If name <> ignoreSelf Then
        If ext = "vbs" Or ext = "bat" Then

            Dim destination : destination = startupPath & "\" & file.Name

            ' Handle duplicates by adding a number suffix
            If fso.FileExists(destination) Then
                Dim baseName : baseName = fso.GetBaseName(file.Name)
                Dim counter  : counter  = 1
                Do While fso.FileExists(startupPath & "\" & baseName & "_" & counter & "." & ext)
                    counter = counter + 1
                Loop
                destination = startupPath & "\" & baseName & "_" & counter & "." & ext
                skippedCount = skippedCount + 1
            End If

            file.Move destination
            movedCount = movedCount + 1
        End If
    End If
Next

MsgBox "Done!" & vbCrLf & vbCrLf & _
       "Moved:    " & movedCount & " file(s) to Startup" & vbCrLf & _
       "Renamed:  " & skippedCount & " duplicate(s)" & vbCrLf & vbCrLf & _
       "Location: " & startupPath, _
       vbInformation, "MoveToStartup"