# https://gist.github.com/Myrddraal/f5a84cf3242e3b3804fa727005ed2786
[CmdletBinding()]
param (
  $authorisation,
  $pathFilter,
  $collectionUri,
  $project,
  $buildId
)

$changesUrl = "$collectionUri/$project/_apis/build/builds/$buildId/changes?api-version=6.0"
$changesResponse = Invoke-RestMethod -Uri $changesUrl -Headers @{Authorization = $authorisation } -Method Get
$commits = @($changesResponse.value | ForEach-Object { $_.id })

Write-Host "##vso[task.setvariable variable=filesUpdated;isOutput=true]False"
Write-Host "Checking $($commits.Length) commits for changes matching path $pathFilter"
for ($j = 0; $j -lt $commits.Length; $j++) {
  Write-Host "Checking commit: $($commits[$j]) with its parent"
  $files = $(git diff "$($commits[$j])~" $commits[$j] --name-only)
  Write-Host $files
  if ($files -like "*$pathFilter/*") {
    Write-Host "Found file matching path filter in commit $($commits[$j])"
    Write-Host "##vso[task.setvariable variable=filesUpdated]True"
    break
  }
}