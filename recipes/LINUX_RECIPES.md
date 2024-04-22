# linux display howto

J'ai trouvé comment ne plus se griller les yeux sous VNC qd on passe d'un ecran FHD à un ecran QHD regulierement.
 
Voici le ptit tuto du creudi de Flo si ca peut vous servir:
- demarrer votre session vnc sans l'option -geometry:   
  > vncserver -name <ZEBESTNAMEYOUPREFERFOREVER> 
- ensuite, pour configurer la resolution FHD dans un 1er temps dans la session vnc, lancer un terminal et executer la cmd 
  > cvt 1920 1080
  > # 1920x1080 59.96 Hz (CVT 2.07M9) hsync: 67.16 kHz; pclk: 173.00 MHz
  > Modeline "1920x1080_60.00"  173.00  1920 2048 2248 2576  1080 1083 1088 1120 -hsync +vsync
- ajouter a xrandr un nouveau mode en copiant la sortie de la cmd precedente:
  > xrandr --newmode "1920x1080_60.00"  173.00  1920 2048 2248 2576  1080 1083 1088 1120 -hsync +vsync
- executer la cmd xrandr pour connaitre le nom du moniteur virtuel VNC
  > 
  ```
  xrandr
  Screen 0: minimum 32 x 32, current 1024 x 768, maximum 32768 x 32768
  VNC-0 connected primary 1024x768+0+0 0mm x 0mm
   1024x768      60.00*+
   1920x1200     60.00  
   1920x1080     60.00  
   1600x1200     60.00  
   1680x1050     60.00  
   1400x1050     60.00  
   1360x768      60.00  
   1280x1024     60.00  
   1280x960      60.00  
   1280x800      60.00  
   1280x720      60.00  
   800x600       60.00  
   640x480       60.00  
   ```
Associer le nouveau mode xrandr au moniteur virtuel VNC-0
xrandr --addmode VNC-0 "1920x1080_60.00"
Refaire la meme sequence pour le QHD 2560x1440
dans la session vnc, lancer un terminal et executer la cmd 
cvt 2560 1440
> # 2560x1440 59.96 Hz (CVT 3.69M9) hsync: 89.52 kHz; pclk: 312.25 MHz
Modeline "2560x1440_60.00"  312.25  2560 2752 3024 3488  1440 1443 1448 1493 -hsync +vsync
ajouter a xrandr un nouveau mode en copiant la sortie de la cmd precedente:
xrandr --newmode "2560x1440_60.00"  312.25  2560 2752 3024 3488  1440 1443 1448 1493 -hsync +vsync
Associer le nouveau mode xrandr au moniteur virtuel VNC-0
xrandr --addmode VNC-0 "2560x1440_60.00"
pour choisir ensuite la resolution en fonction de la caract FHD ou QHD de l'ecran utilisé: 
xrandr -s 1920x1080_60.00
ou
xrandr -s 2560x1440_60.00