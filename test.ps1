$rootDirectory = "C:\Users\Shadow\Documents\GitHub\philexos\ARGUMENTER À PARTIR D’UN PHILOSOPHE"

# Get all subdirectories recursively
$subDirectories = Get-ChildItem -Path $rootDirectory -Directory -Recurse

foreach ($directory in $subDirectories) {
    $mdFiles = Get-ChildItem -Path $directory.FullName -Filter "*.md" -File
    $mdFileNames = $mdFiles.Name -join "`r`n"
    $readmeContent = "$mdFileNames"
    $readmePath = Join-Path -Path $directory.FullName -ChildPath "README.md"
    $readmeContent | Out-File -FilePath $readmePath -Encoding utf8
}
