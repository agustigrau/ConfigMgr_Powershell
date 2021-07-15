param (
    [ValidateLength(3,3)]
    [string]$SiteCode = 'PRO'
)
 
$TSEnv = New-Object -ComObject 'Microsoft.SMS.TSEnvironment'
try {
    $allVars = $TSEnv.GetVariables() | ForEach-Object {
        [pscustomobject]@{
            Name = $_
            Value = $TSEnv.Value($_)
        }
    }
    $DPvalue = @($allVars | Where-Object { $_.Name -like "_SMSTSHTTP$($SiteCode)*" })[0].Value
    $startIndex = $DPValue.IndexOf('://') + 3
    $endIndex = $DPValue.IndexOf('/', $startIndex)
    $DPName = $DPvalue.Substring($startIndex, $endIndex-$startIndex)
    $TSEnv.Value('DPName') = $DPName
} catch {
    $TSEnv.Value('DPName') = 'ERROR'
}
