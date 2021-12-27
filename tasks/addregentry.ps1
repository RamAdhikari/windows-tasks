param
(
    # Parameter help description
    [Parameter(Mandatory =$false)]
    [string]$regkeypath,
    [Parameter(Mandatory =$false)]
    [string]$regkeyname,
    [Parameter(Mandatory =$false)]
    [string]$regkeyvalue

)

$key = try {
    Get-Item -Path $regkeypath -ErrorAction Stop
}
catch {
    New-Item -Path $regkeypath-Force
}

New-ItemProperty -Path $key.PSPath -Name $regkeyname -PropertyType 'REG_DWORD' -Value $regkeyvalue 

$result= Get-Item -Path $regkeypath
return $result