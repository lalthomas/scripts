FasdUAS 1.101.10   ��   ��    k             l     ��  ��    ~ x Thanks:http://mac.appstorm.net/how-to/applescript/applescript-automatically-create-screenshots-from-a-list-of-websites/     � 	 	 �   T h a n k s : h t t p : / / m a c . a p p s t o r m . n e t / h o w - t o / a p p l e s c r i p t / a p p l e s c r i p t - a u t o m a t i c a l l y - c r e a t e - s c r e e n s h o t s - f r o m - a - l i s t - o f - w e b s i t e s /   
  
 l     ��  ��     	Variables     �    V a r i a b l e s      l     ��������  ��  ��        l     ����  r         m     ����   o      ���� 0 whichurl whichUrl��  ��        l    ����  r        m       �    w e b s h o t  o      ���� 0 	filenames 	fileNames��  ��        l     ��������  ��  ��         l     �� ! "��   !  Get Number of URLs    " � # # $ G e t   N u m b e r   o f   U R L s    $ % $ l    &���� & O     ' ( ' r     ) * ) l    +���� + I   �� ,��
�� .corecnte****       **** , n     - . - 2   ��
�� 
cpar . 4   �� /
�� 
docu / m    ���� ��  ��  ��   * o      ���� 0 thecount theCount ( m    	 0 0�                                                                                  ttxt  alis    V  Macintosh HD               ʹ��H+   �g�TextEdit.app                                                    ����i8U        ����  	                Applications    ʹ7T      �h��     �g�  'Macintosh HD:Applications: TextEdit.app     T e x t E d i t . a p p    M a c i n t o s h   H D  Applications/TextEdit.app   / ��  ��  ��   %  1 2 1 l     ��������  ��  ��   2  3 4 3 l     �� 5 6��   5  Repeat this for every URL    6 � 7 7 2 R e p e a t   t h i s   f o r   e v e r y   U R L 4  8�� 8 l   � 9���� 9 U    � : ; : k   !  < <  = > = l  ! !��������  ��  ��   >  ? @ ? l  ! !�� A B��   A  Get the next URL    B � C C   G e t   t h e   n e x t   U R L @  D E D O   ! 1 F G F r   % 0 H I H c   % . J K J n   % , L M L 4   ) ,�� N
�� 
cpar N o   * +���� 0 whichurl whichUrl M 4  % )�� O
�� 
docu O m   ' (����  K m   , -��
�� 
ctxt I o      ���� 0 
currenturl 
currentUrl G m   ! " P P�                                                                                  ttxt  alis    V  Macintosh HD               ʹ��H+   �g�TextEdit.app                                                    ����i8U        ����  	                Applications    ʹ7T      �h��     �g�  'Macintosh HD:Applications: TextEdit.app     T e x t E d i t . a p p    M a c i n t o s h   H D  Applications/TextEdit.app   / ��   E  Q R Q l  2 2��������  ��  ��   R  S T S l  2 2�� U V��   U  Open the URL in Safari    V � W W , O p e n   t h e   U R L   i n   S a f a r i T  X Y X O   2 y Z [ Z k   6 x \ \  ] ^ ] I  6 ;������
�� .miscactvnull��� ��� null��  ��   ^  _ ` _ r   < D a b a o   < =���� 0 
currenturl 
currentUrl b l      c���� c n       d e d 1   A C��
�� 
pURL e 4   = A�� f
�� 
docu f m   ? @���� ��  ��   `  g h g l  E E��������  ��  ��   h  i j i l  E E�� k l��   k 1 +Wait until it loads, then take a screenshot    l � m m V W a i t   u n t i l   i t   l o a d s ,   t h e n   t a k e   a   s c r e e n s h o t j  n o n I  E J�� p��
�� .sysodelanull��� ��� nmbr p m   E F���� ��   o  q r q r   K h s t s c   K d u v u l  K ` w���� w b   K ` x y x b   K \ z { z b   K Z | } | b   K V ~  ~ l  K T ����� � n   K T � � � 1   P T��
�� 
psxp � l  K P ����� � I  K P�� ���
�� .earsffdralis        afdr � m   K L��
�� afdrdesk��  ��  ��  ��  ��    o   T U���� 0 	filenames 	fileNames } m   V Y � � � � �  - { o   Z [���� 0 whichurl whichUrl y m   \ _ � � � � �  . j p g��  ��   v m   ` c��
�� 
TEXT t o      ���� 0 picpath picPath r  ��� � I  i x�� ���
�� .sysoexecTEXT���     TEXT � b   i t � � � m   i l � � � � � ( s c r e e n c a p t u r e   - t j p g   � n   l s � � � 1   o s��
�� 
strq � o   l o���� 0 picpath picPath��  ��   [ m   2 3 � ��                                                                                  sfri  alis    N  Macintosh HD               ʹ��H+   �g�
Safari.app                                                      ����OL�        ����  	                Applications    ʹ7T      �N�d     �g�  %Macintosh HD:Applications: Safari.app    
 S a f a r i . a p p    M a c i n t o s h   H D  Applications/Safari.app   / ��   Y  � � � l  z z��������  ��  ��   �  � � � l  z z�� � ���   � ( "Increase the counter for next time    � � � � D I n c r e a s e   t h e   c o u n t e r   f o r   n e x t   t i m e �  ��� � r   z  � � � [   z } � � � o   z {���� 0 whichurl whichUrl � m   { |����  � o      ���� 0 whichurl whichUrl��   ; o    ���� 0 thecount theCount��  ��  ��       �� � ���   � ��
�� .aevtoappnull  �   � **** � �� ����� � ���
�� .aevtoappnull  �   � **** � k     � � �   � �   � �  $ � �  8����  ��  ��   �   � �� �� 0������������ ��������������� � ����� ������� 0 whichurl whichUrl�� 0 	filenames 	fileNames
�� 
docu
�� 
cpar
�� .corecnte****       ****�� 0 thecount theCount
�� 
ctxt�� 0 
currenturl 
currentUrl
�� .miscactvnull��� ��� null
�� 
pURL�� 
�� .sysodelanull��� ��� nmbr
�� afdrdesk
�� .earsffdralis        afdr
�� 
psxp
�� 
TEXT�� 0 picpath picPath
�� 
strq
�� .sysoexecTEXT���     TEXT�� �kE�O�E�O� *�k/�-j E�UO i�kh� *�k/��/�&E�UO� D*j O�*�k/�,FO�j O�j a ,�%a %�%a %a &E` Oa _ a ,%j UO�kE�[OY��ascr  ��ޭ