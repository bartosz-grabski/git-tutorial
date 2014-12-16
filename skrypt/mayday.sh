 #!/bin/bash 

. ./config.sh

shopt -s dotglob  # match 

function ApplyStep {
	cp -rf ../../mayday_files_unix/$1/* .
}

function SetUser {
	cd "gitlabs/$1"
}

function ChangeToUser {
	cd "../$1"
}


function CleanUpAfterMerge {
	rm -f *.orig
}

function CreateRepos {

	rm -rf gitlabs

	mkdir -p gitlabs/1
	mkdir -p gitlabs/2
	mkdir -p gitlabs/temp_repo
	
	cd gitlabs/temp_repo

	git --bare init 

	# git remote add origin $github_url
	# git push -u -f origin master

	cd ../..

	# Remove-Item gitlabs\temp_repo -recurse -force

	SetUser 1
}

function PushAndCleanup {
	if [ $1 -ge 1 ]; then
		ChangeToUser 1
		git remote rm origin
		git remote add origin $github_url
		ChangeToUser 2
		git remote rm origin
		git remote add origin $github_url
		
		cd ../temp_repo
		git remote add origin $github_url
		#git push -u -f origin master

		cd ../..
		#rm -rf gitlabs/temp_repo
	else
		cd ../..
		rm -rf gitlabs/temp_repo
		mkdir gitlabs/fake_repo
		cd gitlabs/fake_repo
		git init
		git remote add origin $github_url
		touch README
		git add README
		git commit -m "clean1"
		rm -f README
		git commit -a -m "clean2"
		git push -f origin master
		# git push -u -f origin master
		cd ../..
		rm -rf gitlabs/fake_repo
	fi
}

############ 0 #############

function Step1 {
	ChangeToUser 1
	git init

	ApplyStep "1"

	git add converter.py
	git commit -m "Szablon konwertera"

	# git remote add origin $github_url
	git remote add origin ../temp_repo

	git push -u -f origin master
}

############ 1 #############

function Step2 {
	ChangeToUser 2

	# git clone $github_url .
	git clone ../temp_repo .

	ApplyStep "2_1"

	git add converter.py
	git commit -m "Mock funkcji getText"

	ApplyStep "2_2"

	git add converter.py
	git commit -m "mocki klas odpowiedzialnych za czcionki"

	ApplyStep "2_3"

	git commit -a -m "mock klasy konwertujacej"

	git pull
	git push
}

function Step3 {
 	ChangeToUser 1

 	ApplyStep "2_4"

 	git add converter.py
 	git commit -m "bardziej czytelne nazwy zmiennych"

 	git pull

	ApplyStep "2_5" 
	
	CleanUpAfterMerge

	git add converter.py
	git commit -m "Merge"

	git push

	ChangeToUser 2
	git pull
}


############ 3 #############
function Step4 {
	ChangeToUser 1

	git pull
	ApplyStep "3"

	git add converter.py
	git commit -m "Wydzielony modul czcionek"

	git add font.py
	git commit --amend -m "Wydzielony modul czcionek"

	git pull
	git push

	ChangeToUser 2
	git pull
}

############ 4 #############

function Step5 {
	ChangeToUser 1
	ApplyStep "4_2"

	ChangeToUser 2
	ApplyStep "4_1"

	ChangeToUser 1
	git commit -a -m "Konstruktor czcionki"
	git pull
	git push

	ChangeToUser 2
	git commit -a -m "Interfejs czcionki"
	git pull

	# merge
	ApplyStep "4_3"
	CleanUpAfterMerge

	git commit -a -m "Merge"
	git pull
	git push

	ChangeToUser 1
	git pull
}

######### 5 ###########

function Step6 {
	ChangeToUser 1
	ApplyStep "5_1"

	git commit -a -m "Glowna czesc programu wrzucona do main"
	git pull
	git push

	ChangeToUser 2
	ApplyStep "5_2"

	git add converter.py
	git commit -m "Wydzielony moduł textdrawer"

	git add textdrawer.py
	git commit --amend -m "Wydzielony modul textdrawer"
	git pull

	ApplyStep "5_3"
	git commit -a -m "Merge"
	git pull
	git push

	ChangeToUser 1
	git pull
}

######## 6 ##########

function Step7 {
	ChangeToUser 1

	ApplyStep "6_1"
	git commit -a -m "Czcionka dla G"

	ApplyStep "6_2"
	git commit -a -m "Czcionka dla I"

	ApplyStep "6_3"
	git commit -a -m "Czcionka dla T"

	git pull
	git push

	ChangeToUser 2

	ApplyStep "6_4"
	git commit -a -m "ustawianie czcionki w konwerterze"

	ApplyStep "6_5"
	git commit -a -m "prosta implementacja drukowania czcionek"

	git pull
	git push

	ChangeToUser 1
	git pull
}

######### 7 #########

function Step8 {
	ChangeToUser 2
	ApplyStep "7"

	git add .gitignore
	git commit -m ".gitignore"
	git pull
	git push

	ChangeToUser 1
	git pull


	### ???
	git checkout -- font.py
}

######### 8 ###########

function Step9 {

	ChangeToUser 1
	git branch file-font-loader
	git checkout file-font-loader

	ApplyStep "10_1"
	git add fancyFont/*
	git commit -m "czcionki wydzielone do plikow"

	ApplyStep "10_2"
	git commit -a -m "Czcionki wczytywane z plikow"

	ApplyStep "10_3"
	git add fancyFont/*
	git commit -a -m "Czcionki dla liter E, J i S"

	ChangeToUser 2
	git branch horizontal-text-drawer
	git checkout horizontal-text-drawer

	ApplyStep "10_4"
	git commit -a -m "Funkcja sklejajaca literki poziomo"

	ApplyStep "10_5"
	git commit -a -m "Dzielenie czcionki na linijki"

	ApplyStep "10_6"
	git commit -a -m "Rysowanie horyzontalne"
}

########### 9 #########

function Step10 {
	ChangeToUser 1
	git checkout master
	git pull
	git merge file-font-loader
	git pull
	git push

	ChangeToUser 2
	git checkout master
	git pull
	git merge horizontal-text-drawer
	git pull
	git push

	ChangeToUser 1
	git pull
}

######## 10 ##########

function Step11 {
	ChangeToUser 2
	ApplyStep "12_1"
	git commit -a -m "Obsluga pustego napisu w textdrawerze"

	ApplyStep "12_2"
	git commit -a -m "Pobieranie tekstu z argumentu programu"
	git pull
	git push

	ChangeToUser 1
	git pull
}

######## 11 #########

function Step12 {
	ChangeToUser 1
	git checkout master

	ApplyStep "13"
	git add fancyFont/*
	git commit -a -m "Czcionka dla spacji"
	git pull
	git push

	git branch -d file-font-loader

	ChangeToUser 2
	git pull
}

######## 12 #########

function Step13 {
	ChangeToUser 2
	git branch -d horizontal-text-drawer

	ApplyStep "14_1"

	git commit -a -m "Sprawdzanie liczby argumentow"
	git pull
	git push

	git revert HEAD --no-edit

	ApplyStep "14_2"
	git commit -a -m "Poprawne sprawdzanie liczby argumentow"
	git pull
	git push

	ChangeToUser 1
	git pull
}

######### 13 ##########

function Step14 {
	ChangeToUser 2
	ApplyStep "15"
	git commit -a -m "Poprawne sprawdzanie liczby argumentow"
	git pull
	git push

	ChangeToUser 1
	git pull
}

######## 14 #########


##############################
## main

if [ $# -ne 1 ];  then
	echo "Liczba parametrow rozna od 1";
	exit 1
fi

step=$1

if [ $step -lt 0 -o $step -gt 14 ]; then
	echo "Zly argument";
	exit 1
fi

CreateRepos

if [ $step -ge 1 ]; then 
	Step1 
fi
if [ $step -ge 2 ]; then 
	Step2 
fi
if [ $step -ge 3 ]; then 
	Step3 
fi
if [ $step -ge 4 ]; then 
	Step4 
fi
if [ $step -ge 5 ]; then 
	Step5 
fi
if [ $step -ge 6 ]; then 
	Step6 
fi
if [ $step -ge 7 ]; then 
	Step7 
fi
if [ $step -ge 8 ]; then 
	Step8 
fi
if [ $step -ge 9 ]; then 
	Step9 
fi
if [ $step -ge 10 ]; then 
	Step10 
fi
if [ $step -ge 11 ]; then 
	Step11 
fi
if [ $step -ge 12 ]; then 
	Step12 
fi
if [ $step -ge 13 ]; then 
	Step13 
fi
if [ $step -ge 14 ]; then 
	Step14 
fi


PushAndCleanup $step

