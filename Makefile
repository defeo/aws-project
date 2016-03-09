# Scripts d'installation, à lancer uniquement à la création de l'espace de travail
install-silex:
	composer config -g github-oauth.github.com fa7525e8f9e94549c13607b6cd110b9e3a3f1460
	composer install

install-node:
	npm install

# Administration de la BD
.mysql-init:
	mysql-ctl start && phpmyadmin-ctl install && touch .mysql-init

mysql: .mysql-init
	sudo service apache2 restart

mysql-stop:
	sudo service apache2 stop

# Reproduction d'un espace de travail:
#     make recover W=<login>/<workspace>
recover: .crawl .ungzip

.crawl:
	wget -nv -nH -r -np -R ".*,php_errors.log,composer.*,vendor,node_modules" "https://preview.c9users.io/$W"

.ungzip:
	echo '(zcat -f $$1 > $$1.tmp) && mv $$1.tmp $$1' > .ungzip
	find $W -type f -exec /bin/sh .ungzip {} \;
	rm .ungzip

.PHONY: install-silex install-node mysql mysql-stop recover crawl .ungzip
