function Start-Parallel {
    $jobs = @();
    $jobResults = @();
    foreach ($arg in $args) {
        $jobs += start-job $arg
    }
    foreach ($job in $jobs) {
        wait-job $job;
        $jobResults += receive-job $job
    }
    return $jobResults;
}

function Restart {
    Start-Process pwsh -ArgumentList "-noexit", "-command 'cd $(Get-Location)';clear;";
    exit;
}

function Update-Bluun {
    $location = Get-Location
    Set-Location $PSScriptRoot
    $gitString = git pull;
    if (!($gitString -eq "Already up to date.")) {
        Restart
    }
    else {
        Write-Host "already up to date"
    }
    Set-Location $location;
}

function Get-EnvVar([string]$name) {
    return [System.Environment]::GetEnvironmentVariable($name)
}

function Set-EnvVar([string]$name, [string]$value) {
    [System.Environment]::SetEnvironmentVariable($name, $value)
}

function Remove-EnvVar([string]$name) {
    Set-EnvVar $name $null
} 

if (!(Get-EnvVar BLUUN_CONFIG)) {
    $Global:BLUUN_CONFIG = @{

    }
    Set-EnvVar "BLUUN_CONFIG" (ConvertTo-Json $BLUUN_CONFIG)
}
else {
    $Global:BLUUN_CONFIG = ConvertFrom-Json (Get-EnvVar "BLUUN_CONFIG")
}