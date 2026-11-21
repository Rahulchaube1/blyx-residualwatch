param([Parameter(Mandatory)][string]$Executable)
$ErrorActionPreference = 'Stop'
$PSNativeCommandUseErrorActionPreference = $false
$exe = (Resolve-Path $Executable).Path
$shift = Join-Path $PSScriptRoot 'fixtures/shift.csv'
$steady = Join-Path $PSScriptRoot 'fixtures/steady.csv'
if ((& $exe --version) -ne 'residualwatch 0.1.0') { throw 'Version mismatch' }
$out = & $exe $shift --reference 3 --limit 3
if ($LASTEXITCODE -ne 1) { throw 'Missed shift' }
$report = $out | ConvertFrom-Json
if (!$report.alert -or $report.first_alert_row -ne 5 -or $report.up_alerts -ne 1 -or $report.down_alerts -ne 1) { throw 'Wrong alert or row' }
$out = & $exe $steady --reference 3 --limit 3
if ($LASTEXITCODE -ne 0) { throw 'False alert in stable fixture' }
$report = $out | ConvertFrom-Json
if ($report.alert -or $null -ne $report.first_alert_row -or $report.monitored_rows -ne 3) { throw 'Wrong steady report' }
$null = & $exe $shift --reference 3.5 2>&1
if ($LASTEXITCODE -ne 2) { throw 'Noninteger reference accepted' }
$path = [IO.Path]::GetTempFileName()
try {
    [IO.File]::WriteAllText($path, "actual,predicted`r`n1,1`r`n1,1`r`n`r`n2,1`r`n")
    $null = & $exe $path --reference 2 2>&1
    if ($LASTEXITCODE -ne 2) { throw 'Zero reference scale accepted' }
    $out = & $exe $path --reference 2 --min-scale 0.25 --allowance 0 --limit 4
    if ($LASTEXITCODE -ne 1 -or ($out | ConvertFrom-Json).first_alert_row -ne 3) { throw 'Scale floor or blank-line handling failed' }
    [IO.File]::WriteAllText($path, "actual,predicted`n1,1`n2,NaN`n")
    $errText = & $exe $path --reference 2 2>&1
    if ($LASTEXITCODE -ne 2 -or "$errText" -notmatch 'CSV line 3') { throw 'Missing invalid-row diagnostic' }
} finally { [IO.File]::Delete($path) }
Write-Output 'ResidualWatch executable checks passed'
exit 0
