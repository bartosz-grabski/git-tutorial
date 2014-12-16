
. '.\config.ps1'

IF($args.length -ne 2) {
	Echo "Liczba parametrow rozna od 2"
	exit
}

$step = $args[0]
$update = $args[1]

IF(($step -lt 0) -or ($step -gt 14)) {
	Echo "Zly argument step"
	exit
}


IF(($update -lt 0) -or ($update -gt 1)) {
	Echo "Zly argument update"
	exit
}

Remove-Item gitlabs -recurse -force
Copy-Item ("unix_steps/{0}/gitlabs" -f $step) . -recurse -force

Set-Location -Path gitlabs/1

IF (Test-Path .git){
	git remote set-url origin "$github_url"
}

Set-Location -Path ../2

IF (Test-Path .git){
	git remote set-url origin "$github_url"
}

IF ($step -gt 0) {
	IF ( $update -eq 1 ) {
		Set-Location -Path ../temp_repo
		git remote set-url origin "$github_url"
		git push -f origin master
	} 
}

Set-Location -Path ../..

