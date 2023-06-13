
m=$(shell date)

all:
	git add .
	git commit -m "$(m)"
	git push origin main

