 #!/bin/bash 

. ./config.sh

if [ $# -ne 2 ];  then
	echo "Liczba parametrow rozna od 2";
	exit 1
fi

step=$1

if [ $step -lt 0 -o $step -gt 14 ]; then
	echo "Zly stan";
	exit 1
fi

update=$2
if [ $update -lt 0 -o $update -gt 1 ]; then
	echo "tylko 0 lub 1 do wyboru w drugim parametrze";
	exit 1
fi


rm -rf gitlabs/
cp -r unix_steps/$step/gitlabs .

cd gitlabs/1

if [ -d .git ]
then
	git remote set-url origin $github_url
fi

cd ../2

if [ -d .git ]
then
	git remote set-url origin $github_url
fi

if [ $step -gt 0 ] 
then
	if [ $update -eq 1 ]
	then
		cd ../temp_repo
		git remote set-url origin $github_url
		git push -f origin master
	fi 
fi

cd ../..

