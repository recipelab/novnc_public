0. 준비
  가. Ubuntu 20.04.6 LTS
  나. 예시
    1) knu@192.168.104.20
      가) 사용자 이름 : knu
      나) DISPLAY : 3
      다) /home/knu/catkin_ws/src/setting/novncd 가 존재해야함

1. 시나리오
  가. service 설치
    1) $ cd /home/knu/catkin_ws/src/setting/novncd
    2) $ make install
    3) $ make clean
    4) $ make jinja2 USER_NAME=knu DISPLAY=3
    5) $ make enable_service USER_NAME=knu

2. recipelab 계정으로 정상 설치
  가. 설치
    1) $ cd /home/recipelab/catkin_ws/src/setting/novncd
    2) $ make install
    3) $ make clean
    4) $ make jinja2
    5) $ make enable_service