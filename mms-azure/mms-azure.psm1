#Get public and private function definition files.
$Public = Get-ChildItem $PSScriptRoot\Public\*.ps1 -ErrorAction SilentlyContinue
$Private = Get-ChildItem $PSScriptRoot\Private\*.ps1 -ErrorAction SilentlyContinue

# Dot source the files
Foreach ($import in @($Public) + @($Private)) {
    Try {
        . $import.fullname
    }
    Catch {
        Write-Error "Failed to import function $($import.fullname): $_"
    }
}

Export-ModuleMember -Function $Public.Basename
