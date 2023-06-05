$features = Get-WindowsCapability -Online | Where-Object { $_.Name -like "Rsat.*" }

$totalFeatures = $features.Count
$completedCount = 0

foreach ($feature in $features) {
    $featureName = $feature.Name
    $featureDisplayName = $feature.DisplayName

    try {
        Write-Progress -Activity "Adding RSAT features" -Status "Adding $featureDisplayName" -PercentComplete (($completedCount / $totalFeatures) * 100)

        Add-WindowsCapability -Online -Name $featureName -ErrorAction Stop

        Write-Host "Successfully added $featureDisplayName" -ForegroundColor Green
    } catch {
        Write-Host "Failed to add $featureDisplayName" -ForegroundColor Red
        Write-Host "Error: $_"
    }

    $completedCount++
}

Write-Progress -Activity "Adding RSAT features" -Completed
