all:
	@echo "To install the weekly mirrorlist updater, run"
	@echo "   sudo make install"
	@echo " "


install:
	install ./update-mirrors.sh /usr/local/bin/
	install ./update-mirrors.timer /etc/systemd/system/
	install ./update-mirrors.service /etc/systemd/system/
	systemctl daemon-reload
	systemctl enable update-mirrors.timer
	systemctl start update-mirrors.timer
	systemctl status update-mirrors.timer
