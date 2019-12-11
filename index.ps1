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