#!/bin/bash

rm -rf unix_steps
mkdir unix_steps

for STEP in {1..14}
do
	./mayday.sh $STEP
	mkdir unix_steps/$STEP
	mv gitlabs unix_steps/$STEP
done


