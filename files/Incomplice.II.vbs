Randomize

Dim oShell, oFSO
Set oShell = CreateObject("WScript.Shell")
Set oFSO   = CreateObject("Scripting.FileSystemObject")

Dim sTempPath
sTempPath = oShell.ExpandEnvironmentStrings("%TEMP%") & "\rare_popup.hta"

' Write the HTA popup file once
Dim oFile
Set oFile = oFSO.CreateTextFile(sTempPath, True)
oFile.WriteLine "<html>"
oFile.WriteLine "<head>"
oFile.WriteLine "<title>You found it</title>"
oFile.WriteLine "<HTA:APPLICATION BORDER=""thin"" CAPTION=""yes"" SCROLL=""no"" SINGLEINSTANCE=""no"" SYSMENU=""yes""/>"
oFile.WriteLine "<bgsound src='https://www.myinstants.com/media/sounds/minecraftgirl11-fnaf-2-death-screamfoxy.mp3' loop='1'>"
oFile.WriteLine "<style>"
oFile.WriteLine "  body { margin:0; padding:0; background:#111; overflow:hidden; }"
oFile.WriteLine "  #gif { position:fixed; }"
oFile.WriteLine "  #label { position:fixed; bottom:20px; width:100%; text-align:center; font-size:22px; color:#fff; font-family:sans-serif; opacity:0.7; }"
oFile.WriteLine "</style>"
oFile.WriteLine "<script>"
oFile.WriteLine "  window.resizeTo(screen.width, screen.height);"
oFile.WriteLine "  window.moveTo(0, 0);"
oFile.WriteLine "  function sizeGif() {"
oFile.WriteLine "    var s = Math.min(screen.width, screen.height);"
oFile.WriteLine "    var img = document.getElementById('gif');"
oFile.WriteLine "    img.style.width = s + 'px';"
oFile.WriteLine "    img.style.height = s + 'px';"
oFile.WriteLine "    img.style.left = Math.round((screen.width - s) / 2) + 'px';"
oFile.WriteLine "    img.style.top = Math.round((screen.height - s) / 2) + 'px';"
oFile.WriteLine "  }"
oFile.WriteLine "  setTimeout(function(){ window.close(); }, 6000);"
oFile.WriteLine "</script>"
oFile.WriteLine "</head>"
oFile.WriteLine "<body onload='sizeGif()'>"
oFile.WriteLine "  <img id='gif' src='https://media3.giphy.com/media/v1.Y2lkPTc5MGI3NjExdjhudDBkZDdhaXNkMnNieGZiZTRxeWpuZXltcjVnOWZ2ZTdoa2h0biZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/QsgJi30B9ByH7tRhGV/giphy.gif'>"
oFile.WriteLine "  <p id='label'>you found the 1 in 676 chance</p>"
oFile.WriteLine "</body>"
oFile.WriteLine "</html>"
oFile.Close

' Main loop: every second, 1/676 chance
Do
    WScript.Sleep 1000
    If Int(Rnd() * 676) = 0 Then
        ' Max volume before popup
        oShell.Run "powershell -WindowStyle Hidden -Command ""$o = New-Object -ComObject WScript.Shell; 1..50 | ForEach-Object { $o.SendKeys([char]175) }""", 0, True
        oShell.Run "mshta.exe """ & sTempPath & """"
    End If
Loop
