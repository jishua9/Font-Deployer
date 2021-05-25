$FontsFolder = "$PSScriptroot\fonts"

try {
    foreach ($font in Get-ChildItem -Path $fontsFolder -File) {
        $dest = "C:\Windows\Fonts"
        $fontname = split-path $font -leaf
        $fontreg = $fontname -replace ".ttf", " (trueType)"
            try{
                write-host "copying font $fontreg" -ForegroundColor Green
                write-host "to destination $destreg" -ForegroundColor Green
                $font | Copy-Item -Destination $dest
            }
            catch{
                write-error "unable to copy file $fontreg"
            }

            try{
                Write-Host "copying $fontreg" -ForegroundColor Green
                New-ItemProperty -path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts" -Name $fontreg -value $fontname
            }
            catch{
                write-host "unable to create registry file for $fontreg" -ForegroundColor Green
            }
        }
}
catch{
    write-error "General Failure"
}
