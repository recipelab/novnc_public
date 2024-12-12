USER_NAME=recipelab
DISPLAY=0
SESSION=/usr/bin/startxfce4
IP_PORT=300${DISPLAY}

run:
	@echo USER_NAME=${USER_NAME}
	/home/${USER_NAME}/catkin_ws/src/setting/novncd/systemd/novncd.sh

jinja2:
	../jinja2-cli/jinja2 systemd/novncd.service.tmpl -D daemon=novncd -o systemd/novncd@${USER_NAME}.service
	../jinja2-cli/jinja2 systemd/novncd.sh.tmpl -D user_name=${USER_NAME} -D display=${DISPLAY} -D ip_port=${IP_PORT} -o systemd/novncd.sh
	chmod 775 systemd/novncd.sh
	../jinja2-cli/jinja2 systemd/xstartup.tmpl -D session=${SESSION} -o systemd/xstartup
	chmod 775 systemd/xstartup
	mkdir -p /home/${USER_NAME}/.vnc
	mv /home/${USER_NAME}/.vnc/xstartup /home/${USER_NAME}/.vnc/xstartup.bak
	ln -s /home/${USER_NAME}/catkin_ws/src/setting/novncd/systemd/xstartup /home/${USER_NAME}/.vnc

install_vnc:
	sudo apt install xfce4 xfce4-goodies
	sudo apt install tigervnc-standalone-server
	vncpasswd

list_vnc:
	vncserver -list

enable_service:
	sudo ln -sf /home/${USER_NAME}/catkin_ws/src/setting/novncd/systemd/novncd@${USER_NAME}.service /etc/systemd/system
	sudo systemctl enable --now novncd@${USER_NAME}
	# sudo systemctl [enable|start|restart|stop|status|disable] novncd@${USER_NAME}

clean:
	rm -rf systemd/*.service systemd/*.sh