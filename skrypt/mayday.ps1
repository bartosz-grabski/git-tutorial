. '.\config.ps1'

Function ApplyStep ($x) {
	Copy-Item ("..\..\mayday_files\{0}\*" -f $x) . -recurse -force
}

Function SetUser($x) {
	Set-Location -Path ("gitlabs\{0}" -f $x)
}

Function ChangeToUser($x) {
	Set-Location -Path ("..\{0}" -f $x)
}


Function CleanUpAfterMerge() {
	IF (Test-Path *.orig){
		Remove-Item  *.orig -force
	}
}

Function CreateRepos() {
	IF (Test-Path gitlabs){
		Remove-Item gitlabs -recurse -force
	}

	New-Item -ItemType directory -Path gitlabs\1
	New-Item -ItemType directory -Path gitlabs\2

	New-Item -ItemType directory -Path gitlabs\temp_repo
	Set-Location -Path gitlabs\temp_repo

	git --bare init 

	Set-Location -Path ..\..
	SetUser(1)
}

Function PushAndCleanup($step) {
	IF($step -ge 1) {
		ChangeToUser(1)
		IF (Test-Path .git){
			git remote rm origin
			git remote add origin "$github_url"
		}
		
		ChangeToUser(2)
		IF (Test-Path .git){
			git remote rm origin
			git remote add origin "$github_url"
		}
		
		Set-Location -Path ..\temp_repo
		git remote add origin "$github_url"
		git push -u -f origin master

		Set-Location -Path ..\..
		Remove-Item gitlabs\temp_repo -recurse -force
	}
	ELSE {
		Set-Location -Path ..\..
		Remove-Item gitlabs\temp_repo -recurse -force

		New-Item -ItemType directory -Path gitlabs\fake_repo
		Set-Location -Path gitlabs\fake_repo

		git init
		git remote add origin "$github_url"
		New-Item -ItemType file -Path README
		git add README
		git commit -m "clean1"
		git revert HEAD --no-edit
		git push -f origin master
		
		Set-Location -Path ..\..
		Remove-Item gitlabs\fake_repo -recurse -force
	}
}

############ 0 #############

Function Step1() {
	ChangeToUser(1)
	git init

	ApplyStep("1")

	git add converter.py
	git commit -m "Szablon konwertera"

	git remote add origin ..\temp_repo
	git push -u origin master
}

############ 1 #############

Function Step2() {
	ChangeToUser(2)

	git clone ..\temp_repo .

	ApplyStep("2_1")

	git add converter.py
	git commit -m "Mock funkcji getText()"

	ApplyStep("2_2")

	git add converter.py
	git commit -m "mocki klas odpowiedzialnych za czcionki"

	ApplyStep("2_3")

	git commit -a -m "mock klasy konwertujacej"

	git pull
	git push
}

Function Step3() {
	ChangeToUser(1)

	ApplyStep("2_4")

	git add converter.py
	git commit -m "bardziej czytelne nazwy zmiennych"

	git pull

	ApplyStep("2_5") 
	
	CleanUpAfterMerge

	git add converter.py
	git commit -m "Merge"

	git push

	ChangeToUser(2)
	git pull
}

############ 3 #############

Function Step4() {
	ChangeToUser(1)

	git pull
	ApplyStep("3")

	git add converter.py
	git commit -m "Wydzielony modul czcionek"

	git add font.py
	git commit --amend -m "Wydzielony modul czcionek"

	git pull
	git push

	ChangeToUser(2)
	git pull
}

############ 4 #############

Function Step5() {
	ChangeToUser(1)
	ApplyStep("4_2")

	ChangeToUser(2)
	ApplyStep("4_1")

	ChangeToUser(1)
	git commit -a -m "Konstruktor czcionki"
	git pull
	git push

	ChangeToUser(2)
	git commit -a -m "Interfejs czcionki"
	git pull

	# merge
	ApplyStep("4_3")
	IF (Test-Path *.orig){
		Remove-Item  *.orig -force
	}

	git commit -a -m "Merge"
	git pull
	git push

	ChangeToUser(1)
	git pull
}

######### 5 ###########

Function Step6() {
	ChangeToUser(1)
	ApplyStep("5_1")

	git commit -a -m "Glowna czesc programu wrzucona do main()"
	git pull
	git push

	ChangeToUser(2)
	ApplyStep("5_2")

	git add converter.py
	git commit -m "Wydzielony moduł textdrawer"

	git add textdrawer.py
	git commit --amend -m "Wydzielony modul textdrawer"
	git pull

	ApplyStep("5_3")
	git commit -a -m "Merge"
	git pull
	git push

	ChangeToUser(1)
	git pull
}

######## 6 ##########

Function Step7() {
	ChangeToUser(1)

	ApplyStep("6_1")
	git commit -a -m "Czcionka dla G"

	ApplyStep("6_2")
	git commit -a -m "Czcionka dla I"

	ApplyStep("6_3")
	git commit -a -m "Czcionka dla T"

	git pull
	git push

	ChangeToUser(2)

	ApplyStep("6_4")
	git commit -a -m "ustawianie czcionki w konwerterze"

	ApplyStep("6_5")
	git commit -a -m "prosta implementacja drukowania czcionek"

	git pull
	git push

	ChangeToUser(1)
	git pull
}

######### 7 #########

Function Step8() {
	ChangeToUser(2)
	ApplyStep("7")

	git add .gitignore
	git commit -m ".gitignore"
	git pull
	git push

	ChangeToUser(1)
	git pull


	### ???
	git checkout -- font.py
}

######### 8 ###########

Function Step9() {

	ChangeToUser(1)
	git branch file-font-loader
	git checkout file-font-loader

	ApplyStep("10_1")
	git add fancyFont/*
	git commit -m "czcionki wydzielone do plikow"

	ApplyStep("10_2")
	git commit -a -m "Czcionki wczytywane z plikow"

	ApplyStep("10_3")
	git add fancyFont/*
	git commit -a -m "Czcionki dla liter E, J i S"

	ChangeToUser(2)
	git branch horizontal-text-drawer
	git checkout horizontal-text-drawer

	ApplyStep("10_4")
	git commit -a -m "Funkcja sklejajaca literki poziomo"

	ApplyStep("10_5")
	git commit -a -m "Dzielenie czcionki na linijki"

	ApplyStep("10_6")
	git commit -a -m "Rysowanie horyzontalne"
}

########### 9 #########

Function Step10() {
	ChangeToUser(1)
	git checkout master
	git pull
	git merge file-font-loader
	git pull
	git push

	ChangeToUser(2)
	git checkout master
	git pull
	git merge horizontal-text-drawer
	git pull
	git push

	ChangeToUser(1)
	git pull
}

######## 10 ##########

Function Step11() {
	ChangeToUser(2)
	ApplyStep("12_1")
	git commit -a -m "Obsluga pustego napisu w textdrawerze"

	ApplyStep("12_2")
	git commit -a -m "Pobieranie tekstu z argumentu programu"
	git pull
	git push

	ChangeToUser(1)
	git pull
}

######## 11 #########

Function Step12() {
	ChangeToUser(1)
	git checkout master

	ApplyStep("13")
	git add fancyFont/*
	git commit -a -m "Czcionka dla spacji"
	git pull
	git push

	git branch -d file-font-loader

	ChangeToUser(2)
	git pull
}

######## 12 #########

Function Step13() {
	ChangeToUser(2)
	git branch -d horizontal-text-drawer

	ApplyStep("14_1")

	git commit -a -m "Sprawdzanie liczby argumentow"
	git pull
	git push

	git revert HEAD --no-edit

	ApplyStep("14_2")
	git commit -a -m "Poprawne sprawdzanie liczby argumentow"
	git pull
	git push

	ChangeToUser(1)
	git pull
}

######### 13 ##########

Function Step14() {
	ChangeToUser(2)
	ApplyStep("15")
	git commit -a -m "Poprawne sprawdzanie liczby argumentow"
	git pull
	git push

	ChangeToUser(1)
	git pull
}

######## 14 #########


##############################
## main

IF($args.length -ne 1) {
	Echo "Liczba parametrow rozna od 1"
	exit
}

$step = $args[0]

IF(($step -lt 0) -or ($step -gt 14)) {
	Echo "Zly argument"
	exit
}

CreateRepos

IF($step -ge 1) { Step1 }
IF($step -ge 2) { Step2 }
IF($step -ge 3) { Step3 }
IF($step -ge 4) { Step4 }
IF($step -ge 5) { Step5 }
IF($step -ge 6) { Step6 }
IF($step -ge 7) { Step7 }
IF($step -ge 8) { Step8 }
IF($step -ge 9) { Step9 }
IF($step -ge 10) { Step10 }
IF($step -ge 11) { Step11 }
IF($step -ge 12) { Step12 }
IF($step -ge 13) { Step13 }
IF($step -ge 14) { Step14 }

PushAndCleanup($step)
