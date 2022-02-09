$ComputerName=hostname
$AdminUsers=Get-LocalGroupMember Administrators | select Name
$localadmins=(($AdminUsers -replace "\@{Name=$ComputerName\\", "")-replace '\}',',')
$strfact=Write-output "localadmins=$localadmins"
Write-output $strfact.TrimEnd(",") 
