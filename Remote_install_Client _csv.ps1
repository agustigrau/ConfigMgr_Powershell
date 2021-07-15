param($p1, $p2)
Import-Csv $p1 | ForEach-Object {
  Install-CMClient -Name $._pc -SiteCode $p2 -AlwaysInstallClient $True -IncludeDomainController $True
  }
