USER_NAME=recipelab
VNC_PASSWORD=1q2w3e
DISPLAY=0
SESSION=/usr/bin/startxfce4
IP_PORT=300${DISPLAY}
VNC_DIR=/home/${USER_NAME}/.vnc

run:
	@echo USER_NAME=${USER_NAME}
	/home/${USER_NAME}/catkin_ws/src/setting/novncd/systemd/novncd.sh

jinja2:
	../jinja2-cli/jinja2 systemd/novncd.service.tmpl -D daemon=novncd -o systemd/novncd@${USER_NAME}.service
	../jinja2-cli/jinja2 systemd/novncd.sh.tmpl -D user_name=${USER_NAME} -D display=${DISPLAY} -D ip_port=${IP_PORT} -o systemd/novncd.sh
	chmod 775 systemd/novncd.sh
	../jinja2-cli/jinja2 systemd/xstartup.tmpl -D session=${SESSION} -o systemd/xstartup.sh
	chmod 775 systemd/xstartup.sh
	mkdir -p ${VNC_DIR}
	ln -sf /home/${USER_NAME}/catkin_ws/src/setting/novncd/systemd/xstartup.sh ${VNC_DIR}/xstartup

install_jinja2:
	sudo apt update
	sudo apt install -y python3-jinja2

install_vnc:
	sudo apt update
	sudo apt install -y xfce4 xfce4-goodies
	sudo apt install -y tigervnc-standalone-server
	mkdir -p ${VNC_DIR}
	/bin/bash -c "vncpasswd -f <<< \"${VNC_PASSWORD}\" > ${VNC_DIR}/passwd"

install: install_jinja2 install_vnc

list_vnc:
	vncserver -list

enable_service:
	sudo ln -sf /home/${USER_NAME}/catkin_ws/src/setting/novncd/systemd/novncd@${USER_NAME}.service /etc/systemd/system
	sudo systemctl enable --now novncd@${USER_NAME}
	# sudo systemctl [enable|start|restart|stop|status|disable] novncd@${USER_NAME}

clean:
	rm -rf systemd/*.service systemd/*.sh