param
(
    # Parameter help description
    [Parameter(Mandatory =$false)]
    [string]$service="SplunkForwarder",
    [Parameter(Mandatory =$false)]
    [string]$process="splunkd",
    [Parameter(Mandatory =$false)]
    [string]$directorypath,
    [Parameter(Mandatory =$false)]
    [string]$registrypath

)
$serviceexists=get-service $service -ErrorAction SilentlyContinue
 if($serviceexists)
 {
    try{
            stop-service $service
            $process=Get-Process $process -ErrorAction SilentlyContinue
            if($process){
                Stop-Process -Id $process -Force -Confirm:$false
            }
            & sc.exe delete $service
            $output=@("$service=Stopped")
            $output +=("$service=deleted")

    }
catch{

}


 }
 else{
    Write-Host "$service does not exists"

 }

 if($directorypath)
 {
    if(Test-Path -Path $directorypath){
        Remove-Item -Path $directorypath -Recurse -Force -Confirm:$false
        $output+=("$directorypath=removed")
    }
 }

 if($registrypath){
    if(Test-Path -Path $registrypath){
        Remove-Item -Path $registrypath -Recurse -Force -Confirm:$false
        $output+=("$registrypath=removed")

    }

 }
 Return $output | ConvertTo-Json