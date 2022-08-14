Param(
	[Parameter(Mandatory)]
	$imgData,
	
	$imgType="pdf"
)
$outFile = "c:\temp\label"

if ($imgType -eq "zpl" -OR $imgType -eq "epl") {
	[System.Text.Encoding]::ASCII.GetString([System.Convert]::FromBase64String($imgData)) | Out-File -Encoding "ASCII" "$outFile.$imgType"
} else {
	[byte[]]$Bytes = [convert]::FromBase64String(("$imgData"))
	[System.IO.File]::WriteAllBytes("$outFile.$imgType",$Bytes)
}
