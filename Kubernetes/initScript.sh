#!/bin/bash
if [[ $1 == --delete ]]; then
	sudo kubectl delete -f Testing/
else
	sudo kubectl apply -f Testing/
fi
