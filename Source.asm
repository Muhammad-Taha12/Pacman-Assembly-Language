Include irvine32.inc
Include macros.inc
includelib Winmm.lib
.386
.model flat,stdcall
.stack 4096

BUFFER_SIZE = 5000
PlaySound PROTO,
        pszSound:PTR BYTE, 
        hmod:DWORD, 
        fdwSound:DWORD

.data
Logo DB  " .----------------. .----------------. .----------------. .----------------. .----------------. .-----------------.", 10
  DB  "   | .--------------. | .--------------. | .--------------. | .--------------. | .--------------. | .--------------. |", 10
  DB  "   | |   ______     | | |      __      | | |    ______    | | | ____    ____ | | |      __      | | | ____  _____  | |", 10
  DB  "   | |  |_   __ \   | | |     /  \     | | |   / ____ \   | | ||_   \  /   _|| | |     /  \     | | ||_   \|_   _| | |", 10
  DB  "   | |    | |__) |  | | |    / /\ \    | | |  / /    \_|  | | |  |   \/   |  | | |    / /\ \    | | |  |   \ | |   | |", 10
  DB  "   | |    |  ___/   | | |   / ____ \   | | | | |      _   | | |  | |\  /| |  | | |   / ____ \   | | |  | |\ \| |   | |", 10
  DB  "   | |   _| |_      | | | _/ /    \ \_ | | |  \ \____/ |  | | | _| |_\/_| |_ | | | _/ /    \ \_ | | | _| |_\   |_  | |", 10
  DB  "   | |  |_____|     | | ||____|  |____|| | |   \______/   | | ||_____||_____|| | ||____|  |____|| | ||_____|\____| | |", 10
  DB  "   | |              | | |              | | |              | | |              | | |              | | |              | |", 10
  DB  "   | '--------------' | '--------------' | '--------------' | '--------------' | '--------------' | '--------------' |", 10
  DB  "    '----------------' '----------------' '----------------' '----------------' '----------------' '----------------' ", 10, 0
Menu           DB "                              ____  ____  ____  ____  ____   _", 10                                 
DB "                                            (  _ \(  _ \(  __)/ ___)/ ___) (_)", 10                                
DB "                                             ) __/ )   / ) _) \___ \\___ \  _ ", 10                                
DB "                                            (__)  (__\_)(____)(____/(____/ (_)", 10                               
DB "                 __               ____  ____   __   ____  ____         ___   __   _  _  ____ ", 10             
DB "                /  \  ___        / ___)(_  _) / _\ (  _ \(_  _)       / __) / _\ ( \/ )(  __)", 10              
DB "               (_/ / (___)       \___ \  )(  /    \ )   /  )(        ( (_ \/    \/ \/ \ ) _) ", 10              
DB "                (__)             (____/ (__) \_/\_/(__\_) (__)        \___/\_/\_/\_)(_/(____)", 10              
DB "                ____               __   __ _  ____  ____  ____  _  _   ___  ____   __    __   __ _  ____ ", 10  
DB "               (___ \ ___         (  ) (  ( \/ ___)(_  _)(  _ \/ )( \ / __)(_  _) (  )  /  \ (  ( \/ ___)", 10  
DB "                / __/(___)         )(  /    /\___ \  )(   )   /) \/ (( (__   )(    )(  (  O )/    /\___ \", 10  
DB "               (____)             (__) \_)__)(____/ (__) (__\_)\____/ \___) (__)  (__)  \__/ \_)__)(____/", 10
DB "                ____               ___  ____  ____  __  __  ____ ", 10
DB "               ( __ \ ___         / __)( ___)(_  _)(  )(  )(  _ \", 10
DB "                (__ ((___)        \__ \ )__)   )(   )(__)(  )___/", 10
DB "               (____/             (___/(____) (__) (______)(__)", 10 
DB "                 __               ____  _  _   __   ____ ", 10                                                 
DB "                /. |  ___        (  __)( \/ ) (  ) (_  _)", 10                                                 
DB "               (_  _)(___)        ) _)  )  (   )(    )(  ", 10                                                  
DB "                 (_)             (____)(_/\_) (__)  (__) ", 10, 0

NamePrompt DB      " _______ _      ________________ _______            _______         _______    _       _______ _______ _______", 10 
		   DB "     (  ____ ( (    /\__   __(  ____ (  ____ )  |\     /(  ___  )\     /(  ____ )  ( (    /(  ___  |       |  ____ \  ", 10 
		   DB "     | (    \/  \  ( |  ) (  | (    \/ (    )|  ( \   / ) (   ) | )   ( | (    )|  |  \  ( | (   ) | () () | (    \/_ ", 10 
		   DB "     | (__   |   \ | |  | |  | (__   | (____)|   \ (_) /| |   | | |   | | (____)|  |   \ | | (___) | || || | (__   (_)", 10 
		   DB "     |  __)  | (\ \) |  | |  |  __)  |     __)    \   / | |   | | |   | |     __)  | (\ \) |  ___  | |(_)| |  __)     ", 10 
		   DB "     | (     | | \   |  | |  | (     | (\ (        ) (  | |   | | |   | | (\ (     | | \   | (   ) | |   | | (      _ ", 10 
		   DB "     | (____/\ )  \  |  | |  | (____/\ ) \ \__     | |  | (___) | (___) | ) \ \__  | )  \  | )   ( | )   ( | (____/(_)", 10 
		   DB "     (_______//    )_)  )_(  (_______//   \__/     \_/  (_______|_______)/   \__/  |/    )_)/     \|/     \(_______/  ", 0

GameOver                               DB "  ___    __    __  __  ____    _____  _  _  ____  ____ /\", 10
           DB "                             / __)  /__\  (  \/  )( ___)  (  _  )( \/ )( ___)(  _ \)(", 10
           DB "                            ( (_-. /(__)\  )    (  )__)    )(_)(  \  /  )__)  )   /\/", 10
           DB "                             \___/(__)(__)(_/\/\_)(____)  (_____)  \/  (____)(_)\_)()", 10, 10, 10
           DB "                                  _  _    __    __  __  ____   ", 10                           
           DB "                                 ( \( )  /__\  (  \/  )( ___)()", 10                           
           DB "                                  )  (  /(__)\  )    (  )__)   ", 10                          
           DB "                                 (_)\_)(__)(__)(_/\/\_)(____)()", 10                          
           DB "                                  ___   ___  _____  ____  ____   ", 10                         
           DB "                                 / __) / __)(  _  )(  _ \( ___)()", 10                         
           DB "                                 \__ \( (__  )(_)(  )   / )__)   ", 10                         
           DB "                                 (___/ \___)(_____)(_)\_)(____)()", 0                        
Instruction DB                        " __   __ _  ____  ____  ____  _  _   ___  ____   __    __   __ _  ____ ", 10  
			DB "                       (  ) (  ( \/ ___)(_  _)(  _ \/ )( \ / __)(_  _) (  )  /  \ (  ( \/ ___)", 10  
			DB "                        )(  /    /\___ \  )(   )   /) \/ (( (__   )(    )(  (  O )/    /\___ \", 10  
			DB "                       (__) \_)__)(____/ (__) (__\_)\____/ \___) (__)  (__)  \__/ \_)__)(____/", 10, 10, 10, 10
			DB "                                    Use the WASD keys to move up, down, left and right", 10
			DB "                                               Press P to pause the game", 10
            DB "                                          Avoid the ghosts, they will chase you", 10
			DB "                       Collect pellets to gain Score. You need to get enough to go to the next level", 10
	        DB "                           From level 2 onwards, a berry will appear in the middle of the map", 10
	        DB "                                                 Good luck and have fun", 0

Setup DB												    " ___  ____  ____  __  __  ____ ", 10
            DB "                                             / __)( ___)(_  _)(  )(  )(  _ \", 10
            DB "                                             \__ \ )__)   )(   )(__)(  )___/", 10
            DB "                                             (___/(____) (__) (______)(__)  ", 10, 10, 10, 10
			DB "                                                     Select level:", 10
            DB "                                                  Press 1 for Level 1", 10
			DB "                                                  Press 2 for Level 2", 10
	        DB "                                                  Press 3 for Level 3", 0

Paused             DB "                                   ____   __    __  __  ___  ____  ____", 10                                   
       DB "                                              (  _ \ /__\  (  )(  )/ __)( ___)(  _ \  ", 10                                 
       DB "                                               )___//(__)\  )(__)( \__ \ )__)  )(_) ) ", 10                                 
       DB "                                              (__) (__)(__)(______)(___/(____)(____/  ", 10                                
	   DB "                  ____  ____  ____  ___  ___    ____    ____  _____    ____  ____  ___  __  __  __  __  ____ ", 10 
       DB "                 (  _ \(  _ \( ___)/ __)/ __)  (  _ \  (_  _)(  _  )  (  _ \( ___)/ __)(  )(  )(  \/  )( ___)", 10 
       DB "                  )___/ )   / )__) \__ \\__ \   )   /    )(   )(_)(    )   / )__) \__ \ )(__)(  )    (  )__) ", 10 
       DB "                 (__)  (_)\_)(____)(___/(___/  (_)\_)   (__) (_____)  (_)\_)(____)(___/(______)(_/\/\_)(____)", 0
playerName DB ?                                                                                                 
startPrompt DB "Press Any Button to Begin", 0
strScore DB "Score: ",0
score DB 0
totalScore DW 0
xSize DB 121
pacMan1 DB  " __", 0
pacMan2 DB  "/ o\", 0
pacMan3 DB  "\__<", 0
pacMan4 DB  " __", 0
pacMan5 DB  "/ o\", 0
pacMan6 DB  "\__/", 0
pacMan7 DB  " __", 0
pacMan8 DB  "/o \", 0
pacMan9 DB  ">__/", 0
pacMan10 DB  " __", 0
pacMan11 DB  "/o \", 0
pacMan12 DB  "\__/", 0
ghost1 DB " __", 0
ghost2 DB "/oo\", 0
ghost3 DB "|,,|", 0
shouldMove DB 0
return DB 0
Wall DB "X", 0
ghostWall DB "_", 0
Pellet DB "C", 0
collectedPellet DB "D", 0
Berry DB "B", 0
anim DB 0
right DB 0
ghostDelay DB 0
ghostDelayTotal DB 3
regenerate DB 0
direction DB 1, 2, 3, 4
invincibility DB 0

xPos DB 58
yPos DB 25

xGhostPos DB 4 Dup(?)
yGhostPos DB 4 Dup(?)

xGhostPos2 DB ?
yGhostPos2 DB ?

berryPosX DB ?
berryPosY DB ?

bonus DB 0

ghostNum DB 1
currGhost DB 1

inputChar DB ?
string DB 255 Dup(?)

maze DB 10000 dup (?)

liveStr DB "Lives: ", 0
lives DB 3
level DB 1
levelStr DB "Level: ", 0

buffer DB BUFFER_SIZE DUP(?)
filename DB "HighScores.txt", 0
fileHandle HANDLE ?
stringLength DD ?
space DB " "
nextLine DB 10
thisScore DB 0

scoreString DB "0000", 0
divisor DB 10
sizeRead DD 0

bonusTime DB 0
teleported DB 0
drawDelay DB 0
eatTime DB 0

musicFile DB "Intro.wav",0
levelFile DB "Music.wav", 0

level1Maze DB "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", 10
		   DB "X                                                                                                                      X", 10
		   DB "X C   C  C  C  C   C   C   C  C   C  C   C  C   C   C   C   C  C   C   C   C  C   C   C  C  C   C  C  C  C  C  C C  C  X", 10
		   DB "X                                                                                                                      X", 10
		   DB "X C  XXXXX  C XXXXXXXX C  XX  C XXXXXXXX C  XXXXXXXXXXX C  XX  C XXXXXXXXXXX  C XXXXXXXX C  XX  C XXXXXXXX  C XXXXX C  X", 10
		   DB "X                                                                                                                      X", 10
		   DB "X C   C  C  C  C   C   C   C  C   C  C   C  C   C   C   C   C  C   C   C   C  C   C   C  C  C   C  C  C  C  C  C C  C  X", 10
		   DB "X                                                                                                                      X", 10
		   DB "X C  XXXXX  C XXXXXXXX C  XX  C XXXXXXXX C  XXXXXXXXXXX C  XX  C XXXXXXXXXXX  C XXXXXXXX C  XX  C XXXXXXXX  C XXXXX C  X", 10
		   DB "X                                                                                                                      X", 10
		   DB "X C   C  C  C  C   C   C   C  C   C  C   C  C   C   C   C   C  C   C   C   C  C   C   C  C  C   C  C  C  C  C  C C  C  X", 10
		   DB "X                                                                                                                      X", 10
		   DB "X C  XXXXX  C XXXXXXXX C  XX  C XXXXXXXX C  XXXXXXXXXXX C  XX  C XXXXXXXXXXX  C XXXXXXXX C  XX  C XXXXXXXX  C XXXXX C  X", 10
		   DB "X             XXXXXXXX    XX                     L                                          XX    XXXXXXXX             X", 10
		   DB "X C   C  C  C XXXXXXXX C  XX  C  C  C  C  C   C   C     C  BB  C    C   C   C  C   C  C  C  XX  C XXXXXXXX  C  C C  C  X", 10
		   DB "X             XXXXXXXX    XX                                                                XX    XXXXXXXX             X", 10
		   DB "X C  XXXXX  C XXXXXXXX C  XX  C XXXXXXXX C  XXXXXXXXXXX C  XX  C XXXXXXXXXXX  C XXXXXXXX C  XX  C XXXXXXXX  C XXXXX C  X", 10
		   DB "X                                                                                                                      X", 10
		   DB "X C   C  C  C  C   C   C   C  C   C  C   C  C   C   C   C   C  C   C   C   C  C   C   C  C  C   C  C  C  C  C  C C  C  X", 10
		   DB "X                                                                                                                      X", 10
		   DB "X C  XXXXX  C XXXXXXXX C  XX  C XXXXXXXX C  XXXXXXXXXXX C  XX  C XXXXXXXXXXX  C XXXXXXXX C  XX  C XXXXXXXX  C XXXXX C  X", 10
		   DB "X                                                                                                                      X", 10
		   DB "X C   C  C  C  C   C   C   C  C   C  C   C  C   C   C   C   C  C   C   C   C  C   C   C  C  C   C  C  C  C  C  C C  C  X", 10
		   DB "X                                                                                                                      X", 10
		   DB "X C  XXXXX  C XXXXXXXX C  XX  C XXXXXXXX C  XXXXXXXXXXX C  XX  C XXXXXXXXXXX  C XXXXXXXX C  XX  C XXXXXXXX  C XXXXX C  X", 10
		   DB "X                                                                                                                      X", 10
		   DB "X C   C  C  C  C   C   C   C  C   C  C   C  C   C   C   C   C  C   C   C   C  C   C   C  C  C   C  C  C  C  C  C C  C  X", 10
		   DB "X                                                                                                                      X", 10
		   DB "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", 0

level2Maze DB "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", 10
	 DB "X                                                          XX                                                          X", 10
	 DB "X C   C   C   C   C    C   C  C  C  C   C  C   C   C    C  XX  C   C   C   C   C   C    C   C   C   C   C   C   C   C  X", 10
	 DB "X                                                          XX                                                          X", 10
     DB "X C  XXXXXXXXXXXXXXXXX C  XXXXXXXXXXXXXXXXXXXXXXXXXXXXX C  XX  C XXXXXXXXXXXXXXXXXXXXXXXXXXXXX  C XXXXXXXXXXXXXXXXX C  X", 10
	 DB "X                                                                                                                      X", 10
	 DB "X C   C   C   C   C    C   C  C  C  C   C  C   C   C    C   C  C   C   C   C   C   C  C  C  C   C   C   C   C   C   C  X", 10
	 DB "X                                                                                                                      X", 10
     DB "X C  XXXXXXXXXXXXXXXXX C  XX  C XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX C  XX  C XXXXXXXXXXXXXXXXX C  X", 10
     DB "X                         XX                               XX                               XX                         X", 10
     DB "X C   C   C   C   C    C  XX  C  C  C  C  C   C   C  C  C  XX  C    C   C   C   C   C    C  XX  C   C   C   C   C   C  X", 10
     DB "X                         XX                               XX                               XX                         X", 10
     DB "X C  XXXXXXXXXXXXXXXXX C  XXXXXXXXXXXXXXXXXXXXXXXXXXXXX C  XX  C XXXXXXXXXXXXXXXXXXXXXXXXXXXXX  C XXXXXXXXXXXXXXXXX C  X", 10
     DB "X                   XX    XX                     L                    P                     XX    XX                   X", 10
     DB "X C   C   C   C   C XX C  XX  C  C  C  C  C   C   C  C  C  BB  C    C   C    C  C   C  C  C XX  C XX  C  C   C   C  C  X", 10
     DB "X                   XX    XX                                                                XX    XX                   X", 10
     DB "X C  XXXXXXXXXXX  C XX C  XX  C XX  C XX C  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX C  XX  C XX  C XX  C XX  C XXXXXXXXXXX C  X", 10
     DB "X                                     XX                                        XX                                     X", 10
     DB "X C   C   C   C   C C  C   C  C  C  C XX  C   C   C  C  C  C C  C   C   C    C  XX  C  C  C  C  C  C  C  C  C   C   C  X", 10
     DB "X                                     XX                                        XX                                     X", 10
     DB "XXXXXXXXXXXXXXXXXXXXXX C  XXXXXXXXXXXXXX  C XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX C  XXXXXXXXXXXXXX  C XXXXXXXXXXXXXXXXXXXXXX", 10
     DB "X                                     XX                   XX                   XX                                     X", 10
     DB "X  C   C   C   C   C   C   C   C   C  XX  C    C    C   C  XX  C   C    C    C  XX  C   C   C   C   C   C   C   C   C  X", 10
     DB "X                                     XX                   XX                   XX                                     X", 10
     DB "X  C XXXXX C  XXXXXXXXXXXXXXXXXXXX C  XXXXXXXXXXXXXXXXX C  XX  C XXXXXXXXXXXXXXXXX  C XXXXXXXXXXXXXXXXXXXX  C XXXXX C  X", 10
     DB "X                                                                                                                      X", 10
     DB "X  C   C   C   C   C   C   C   C   C   C   C   C    C   C      C   C    C   C   C   C   C   C   C   C   C   C   C   C  X", 10
     DB "X                                                                                                                      X", 10
     DB "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", 0

level3Maze DB "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", 10
	 DB "X RR                                                       XX                                                      G   X", 10
	 DB "X RR  C   C   C   C    C   C  C  C  C   C  C   C   C    C  XX  C   C   C   C   C   C    C   C   C   C   C   C   C   C  X", 10
	 DB "X RR                                                       XX                                                          X", 10
     DB "X  C XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX C  XX  C XXXXXXXXXXXXXXXXXXXXXXXXXXXXX  C XXXXXXXXXXXXXXXXX C  X", 10
	 DB "X                                                                                                                      X", 10
	 DB "X  C  C   C   C   C    C   C  C  C  C   C  C   C   C    C   C  C   C   C   C   C   C  C  C  C   C   C   C   C   C   C  X", 10
	 DB "X                                                                                                                      X", 10
     DB "X  C XXXXXXXXXXXXXXXXXXXXXXX  C XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX C  XX  C XXXXXXXXXXXXXXXXX C  X", 10
     DB "X                         XX                               XX                               XX                         X", 10
     DB "X  C  C   C   C   C    C  XX  C  C  C  C  C   C   C  C  C  XX  C    C   C   C   C   C    C  XX  C   C   C   C   C   C  X", 10
     DB "X                         XX                               XX                               XX                         X", 10
     DB "X  C XXXXXXXXXXXXXXXXX C  XXXXXXXXXXXXXXXXXXXXXXXXXXXXX C  XX  C XXXXXXXXXXXXXXXXXXXXXXXXXXXXX  C XXXXXXXXXXXXXXXXX C  X", 10
     DB "X                   XX    XX                     L         XX         P         XX          XX    XX                   X", 10
     DB "X  C   C   C   C  C XX C  XX  C  C  C  C  C   C   C  C  C  XX  C    C   C    C  XX  C  C  C XX  C XX  C  C   C   C  C  X", 10
     DB "X                   XX    XX                               XX                   XX          XX    XX                   X", 10
     DB "X  C XXXXXXXXXXX  C XX C  XX  C XX  C XX    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX    XX  C XX  C XX  C XX  C XXXXXXXXXXX C  X", 10
     DB "X                         XX          XX  C XX TT                      RR XX C  XX                                     X", 10
     DB "X  C   C   C   C  C    C  XX  C  C  C XX    XX TT  C   C   BB   C   C  RR XX    XX  C  C  C  C  C  C  C  C  C   C   C  X", 10
     DB "X                         XX          XX    XX TT                      RR XX    XX                                     X", 10
     DB "XXXXXXXXXXXXXXXXXXXXXX C  XXXXXXXXXXXXXX  C XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX C  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", 10
     DB "X                                     XX                   XX                   XX                                     X", 10
     DB "X  C   C   C   C   C   C   C   C   C  XX  C    C    C   C  XX  C   C    C    C  XX  C   C   C   C   C   C   C   C   C  X", 10
     DB "X                                     XX                   XX                   XX                                     X", 10
     DB "X  C XXXXXXXXXXXXXXXXXXXXXXXXXXXXX C  XXXXXXXXXXXXXXXXX C  XX  C XXXXXXXXXXXXXXXXX  C XXXXXXXXXXXXXXXXXXXX  C XXXXX C  X", 10
     DB "XI                                                                                                                  TT X", 10
     DB "X  C   C   C   C   C   C   C   C   C   C   C   C    C   C      C   C    C   C   C   C   C   C   C   C   C   C   C   TT X", 10
     DB "X                                                                                                                   TT X", 10
     DB "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", 0

.code
Main Proc
	Restart::
    INVOKE PlaySound, OFFSET musicFile, NULL, 20001H
	call titleScreen
	call UserName
	call mainMenu
	CMP level, 1
	JE Level1
	CMP level, 2 
	JE Level2
	CMP level, 3
	JE Level3

	startLevel::
	INVOKE PlaySound, OFFSET levelFile, NULL, 20001H
	call DrawMaze
	call DrawPlayer

	gameLoop:
		LookForKey:
			mov  eax, 50
			call Delay
			
			call eatPellets
			call completeLevel
			mov dl, 7
			mov dh, 29
			call goToXY
			mov eax, 0
			mov al, score
			call writeDec

			mov dl, 22
			mov dh, 29
			call goToXY
			mov eax, 0
			mov al, lives
			call writeDec

			CMP bonus, 1
			JNE KeepBonus
			inc bonusTime
			CMP bonusTime, 5
			JNE SkipBonus
			call createBonus
			JMP SkipBonus
			KeepBonus:
			inc bonusTime
			CMP bonusTime, 50
			JNE SkipBonus
			mov bonusTime, 0
			call createBonus
			SkipBonus:

			CMP level, 3
			JNE SkipTeleDraw
			inc drawDelay
			CMP drawDelay, 5
			JNE SKipTeleDraw
			mov drawDelay, 0
			call DrawTeleports
			SkipTeleDraw:

			mov ecx, 0
			mov cl, ghostNum
			mov esi, offset xGhostPos
			mov edi, offset yGhostPos
			GLoop2:
				mov al, [esi]
				mov xGhostPos2, al
				mov al, [edi]
				mov yGhostPos2, al
				call LoseLife
				inc esi	
				inc edi
			Loop GLoop2

			inc ghostDelay
			mov al, ghostDelayTotal
			CMP ghostDelay, al
			JNE SkipGhost
			mov ecx, 0
			mov cl, ghostNum
			mov currGhost, 1
			mov esi, offset xGhostPos
			mov edi, offset yGhostPos
			mov edx, offset direction
			GLoop:
				mov al, [esi]
				mov xGhostPos2, al
				mov al, [edi]
				mov yGhostPos2, al

				push ecx
				call moveGhost
				pop ecx

				mov al, xGhostPos2
				mov [esi], al
				mov al, yGhostPos2
				mov [edi], al
				inc esi	
				inc edi
				inc edx
				inc currGhost
			Loop GLoop
			mov ghostDelay, 0

			SkipGhost:
			call ReadKey
			JZ LookForKey

			CMP dx, "W"
			JE moveUp

			CMP dx, "A"
			JE moveLeft

			CMP dx, "D"
			JE moveRight

			CMP dx, "S"
			JE moveDown

			CMP dx, "P"
			JE pauseGame

		JMP LookForKey

		moveUp:

		mov ebx, offset maze
		movzx ecx, xPos
		add ebx, ecx
		mov eax, 0
		movzx ecx, yPos
		add eax, ecx
		dec eax
		mul xSize
		add ebx, eax
		inc ebx
		mov al, [ebx]
		CMP al, Wall
		JE LookForKey

		inc ebx
		mov al, [ebx]
		CMP al, Wall
		JE LookForKey

		call UpdatePlayer
		sub yPos, 2
		call DrawPlayer
		mov teleported, 0

		JMP TeleStart

		moveDown:

		mov ebx, offset maze
		movzx ecx, xPos
		add ebx, ecx
		mov eax, 0
		movzx ecx, yPos
		add eax, ecx
		add eax, 3
		mul xSize
		add ebx, eax
		inc ebx
		mov al, [ebx]
		CMP al, Wall
		JE LookForKey

		inc ebx
		mov al, [ebx]
		CMP al, Wall
		JE LookForKey

		CMP al, ghostWall
		JE LookForKey

		call UpdatePlayer
		add yPos, 2
		call DrawPlayer
		mov teleported, 0

		JMP TeleStart

		moveLeft:
		mov ebx, offset maze
		movzx ecx, xPos
		add ebx, ecx
		dec ebx
		mov eax, 0
		movzx ecx, yPos
		add eax, ecx
		inc eax
		mul xSize
		add ebx, eax
		mov al, [ebx]
		CMP al, Wall
		JE LookForKey

		inc ebx
		mov al, [ebx]
		CMP al, Wall
		JE LookForKey

		call UpdatePlayer
		sub xPos, 3
		mov right, 0
		call DrawPlayer
		mov teleported, 0

		JMP TeleStart

		moveRight:
		mov ebx, offset maze
		movzx ecx, xPos
		add ebx, ecx
		add ebx, 3
		mov eax, 0
		movzx ecx, yPos
		add eax, ecx
		inc eax
		mul xSize
		add ebx, eax
		mov al, [ebx]
		CMP al, Wall
		JE LookForKey

		inc ebx
		mov al, [ebx]
		CMP al, Wall
		JE LookForKey

		call UpdatePlayer
		add xPos, 3
		mov right, 1
		call DrawPlayer
		mov teleported, 0

		TeleStart:
		CMP level, 3
		JNE LookForKey

		CMP teleported, 1
		JE LookForKey

		CMP xPos, 73h
		JNE Tele1
		CMP yPos, 19h
		JNE Tele1
		call UpdatePlayer
		mov xPos, 2Eh
		mov yPos, 11h
		call DrawPlayer
		mov teleported, 1
		JMP LookForKey
		Tele1:

		CMP xPos, 2Eh
		JNE Tele2
		CMP yPos, 11h
		JNE Tele2
		call UpdatePlayer
		mov xPos, 73h
		mov yPos, 19h
		call DrawPlayer
		mov teleported, 1
		JMP LookForKey
		Tele2:

		CMP xPos, 46h
		JNE Tele3
		CMP yPos, 11h
		JNE Tele3
		call UpdatePlayer
		mov xPos, 1h
		mov yPos, 1h
		call DrawPlayer
		mov teleported, 1
		JMP LookForKey
		Tele3:

		CMP xPos, 1h
		JNE Tele4
		CMP yPos, 1h
		JNE Tele4
		call UpdatePlayer
		mov xPos, 46h
		mov yPos, 11h
		call DrawPlayer
		mov teleported, 1
		JMP LookForKey
		Tele4:

		JMP LookForKey

	jmp gameLoop

	exitGame::
	exit
Main ENDP

moveGhost PROC

	mov ebx, offset maze
	movzx ecx, xGhostPos2
	add ebx, ecx
	mov eax, 0
	movzx ecx, yGhostPos2
	add eax, ecx
	mul xSize
	add ebx, eax

	mov al, [edx]
	CMP al, 1
	JE notRight
	CMP al, 2
	JE notRight
	CMP al, 3
	JE notUp
	CMP al, 4
	JE notUp

	notRight:
	mov al, yPos
	CMP yGhostPos2, al
	JA prioUp

	mov al, "X"
	CMP [ebx + 363], al
	JNE Down2
	CMP [ebx - 121], al
	JNE Up2

    prioUp:
	mov al, "X"
	CMP [ebx - 121], al
	JNE Up2
	CMP [ebx + 363], al
	JNE Down2

	JMP keepMoving

	notUp:
	mov al, xPos
	CMP xGhostPos2, al
	JA prioLeft

	mov al, "X"
	CMP [ebx + 4], al
	JNE Right2
	CMP [ebx - 1], al
	JNE Left2

	prioLeft:
	mov al, "X"
	CMP [ebx - 1], al
	JNE Left2
	CMP [ebx + 4], al
	JNE Right2
	JMP keepMoving

	Up2:
	CMP [ebx - 120], al
	JNE Up3
	JMP keepMoving

	Up3:
	CMP [ebx - 119], al
	JNE Up4
	JMP keepMoving

	Up4:
	mov al, yPos
	CMP yGhostPos2, al
	JA changeToUp
	mov return, 1
	mov al, [edx]
	CMP al, 1
	JE checkGhostRight
	CMP al, 2
	JE checkGhostLeft
	CMP al, 4
	JE checkGhostDown

	checkGhostReturn1:
	CMP shouldMove, 1
	JE changeToUp
	JMP keepMoving

	Down2:
	CMP [ebx + 364], al
	JNE Down3
	JMP keepMoving

	Down3:
	CMP [ebx + 365], al
	JNE Down4
	JMP keepMoving

	Down4:
	mov al, yPos
	CMP yGhostPos2, al
	JB changeToDown

	mov return, 2
	mov al, [edx]
	CMP al, 1
	JE checkGhostRight
	CMP al, 2
	JE checkGhostLeft
	CMP al, 3
	JE checkGhostUp

	checkGhostReturn2:
	CMP shouldMove, 1
	JE changeToDown
	JMP keepMoving

	Left2:
	CMP [ebx + 120], al
	JNE Left3
	JMP keepMoving

	Right2:
	CMP [ebx + 125], al
	JNE Right3
	JMP keepMoving

	Left3:
	CMP [ebx + 241], al
	JNE Left4
	JMP keepMoving

	Left4:
	CMP [ebx - 2], al
	JNE Left5
	JMP keepMoving

	Right3:
	CMP [ebx + 246], al
	JNE Right4
	JMP keepMoving

	Right4:
	CMP [ebx + 5], al
	JNE Right5
	JMP keepMoving

	Right5:
	mov al, xPos
	CMP xGhostPos2, al
	JB changeToRight

	mov return, 3
	mov al, [edx]
	CMP al, 2
	JE checkGhostLeft
	CMP al, 3
	JE checkGhostUp
	CMP al, 4
	JE checkGhostDown

	checkGhostReturn3:
	CMP shouldMove, 1
	JE changeToRight
	JMP keepMoving

	Left5:
	mov al, xPos
	CMP xGhostPos2, al
	JA changeToLeft

	mov return, 4
	mov al, [edx]
	CMP al, 1
	JE checkGhostRight
	CMP al, 3
	JE checkGhostUp
	CMP al, 4
	JE checkGhostDown
	JMP keepMoving

	checkGhostReturn4:
	CMP shouldMove, 1
	JE changeToLeft
	JMP keepMoving

	changeToRight:
	mov al, 1
	mov [edx], al
	JMP KeepMoving

	changeToLeft:
	mov al, 2
	mov [edx], al
	JMP KeepMoving

	changeToUp:
	mov al, 3
	mov [edx], al
	JMP KeepMoving

	changeToDown:
	mov al, 4
	mov [edx], al
	JMP keepMoving

	checkGhostRight:
		mov ebx, offset maze
		movzx ecx, xGhostPos2
		add ebx, ecx
		add ebx, 3
		mov eax, 0
		movzx ecx, yGhostPos2
		add eax, ecx
		inc eax
		mul xSize
		add ebx, eax
		mov al, [ebx]
		CMP al, Wall
		JE noMove

		inc ebx
		mov al, [ebx]
		CMP al, Wall
		JE noMove

		mov shouldMove, 0
		JMP yesMove

		noMove:
		mov shouldMove, 1

        yesMove:
		CMP return, 1
		JE checkGhostReturn1
		CMP return, 2
		JE checkGhostReturn2
		CMP return, 3
		JE checkGhostReturn3
		CMP return, 4
		JE checkGhostReturn4

	checkGhostLeft:
		mov ebx, offset maze
		movzx ecx, xGhostPos2
		add ebx, ecx
		dec ebx
		mov eax, 0
		movzx ecx, yGhostPos2
		add eax, ecx
		inc eax
		mul xSize
		add ebx, eax
		mov al, [ebx]
		CMP al, Wall
		JE noMove2

		inc ebx
		mov al, [ebx]
		CMP al, Wall
		JE noMove2

		mov shouldMove, 0
		JMP yesMove2

		noMove2:
		mov shouldMove, 1

        yesMove2:
		CMP return, 1
		JE checkGhostReturn1
		CMP return, 2
		JE checkGhostReturn2
		CMP return, 3
		JE checkGhostReturn3
		CMP return, 4
		JE checkGhostReturn4

	checkGhostUp:
		mov ebx, offset maze
		movzx ecx, xGhostPos2
		add ebx, ecx
		mov eax, 0
		movzx ecx, yGhostPos2
		add eax, ecx
		dec eax
		mul xSize
		add ebx, eax
		inc ebx
		mov al, [ebx]
		CMP al, Wall
		JE noMove3

		inc ebx
		mov al, [ebx]
		CMP al, Wall
		JE noMove3

		mov shouldMove, 0
		JMP yesMove3

		noMove3:
		mov shouldMove, 1

        yesMove3:
		CMP return, 1
		JE checkGhostReturn1
		CMP return, 2
		JE checkGhostReturn2
		CMP return, 3
		JE checkGhostReturn3
		CMP return, 4
		JE checkGhostReturn4

	checkGhostDown:
		mov ebx, offset maze
		movzx ecx, xGhostPos2
		add ebx, ecx
		mov eax, 0
		movzx ecx, yGhostPos2
		add eax, ecx
		add eax, 3
		mul xSize
		add ebx, eax
		inc ebx
		mov al, [ebx]
		CMP al, Wall
		JE noMove4

		inc ebx
		mov al, [ebx]
		CMP al, Wall
		JE noMove4

		mov shouldMove, 0
		JMP yesMove4

		noMove4:
		mov shouldMove, 1

        yesMove4:
		CMP return, 1
		JE checkGhostReturn1
		CMP return, 2
		JE checkGhostReturn2
		CMP return, 3
		JE checkGhostReturn3
		CMP return, 4
		JE checkGhostReturn4

	keepMoving:
	mov al, [edx]
	push edx
	CMP al, 1
	JE moveGhostRight
	CMP al, 2
	JE moveGhostLeft
	CMP al, 3
	JE moveGhostUp
	CMP al, 4
	JE moveGhostDown
	
	moveGhostRight:
		mov ebx, offset maze
		movzx ecx, xGhostPos2
		add ebx, ecx
		mov eax, 0
		movzx ecx, yGhostPos2
		add eax, ecx
		mul xSize
		add ebx, eax

		push ebx
		call UpdateGhost
		pop ebx

		add xGhostPos2, 3
		mov al, " "
		mov [ebx], al

		call DrawGhost
		JMP SkipMove2

	moveGhostLeft:
		mov ebx, offset maze
		movzx ecx, xGhostPos2
		add ebx, ecx
		mov eax, 0
		movzx ecx, yGhostPos2
		add eax, ecx
		mul xSize
		add ebx, eax

		push ebx
		call UpdateGhost
		pop ebx

		sub xGhostPos2, 3
		mov al, " "
		mov [ebx], al

		call DrawGhost
		JMP SkipMove2

	SkipMove:
	
	mov al, yPos
	CMP yGhostPos2, al

	JMP SkipMove2

	moveGhostDown:
		mov ebx, offset maze
		movzx ecx, xGhostPos2
		add ebx, ecx
		mov eax, 0
		movzx ecx, yGhostPos2
		add eax, ecx
		mul xSize
		add ebx, eax

		push ebx
		call UpdateGhost
		pop ebx

		add yGhostPos2, 1
		mov al, " "
		mov [ebx], al

		call DrawGhost
		JMP SkipMove

	moveGhostUp:
		mov ebx, offset maze
		movzx ecx, xGhostPos2
		add ebx, ecx
		mov eax, 0
		movzx ecx, yGhostPos2
		add eax, ecx
		mul xSize
		add ebx, eax

		push ebx
		call UpdateGhost
		pop ebx

		sub yGhostPos2, 1
		mov al, " "
		mov [ebx], al

		call DrawGhost

	SkipMove2:
	pop edx
	ret
moveGhost ENDP

DrawGhost PROC
	CMP currGhost, 1
	JE RedCol
	CMP currGhost, 2
	JE PinkCol
	CMP currGhost, 3
	JE BlueCol
	CMP currGhost, 4
	JE OrangeCol

	RedCol:
	mov eax, red
    JMP DrawStart

	PinkCol:
	mov eax, lightmagenta
    JMP DrawStart

	BlueCol:
	mov eax, blue
    JMP DrawStart

	OrangeCol:
	mov eax, lightred
    JMP DrawStart

	DrawStart:
	call SetTextColor

	mov dl, xGhostPos2
	mov dh, yGhostPos2
	call Gotoxy

	mov edx, offset ghost1
	call WriteString

	mov dl, xGhostPos2
	mov dh, yGhostPos2
	inc dh
	call Gotoxy

	mov edx, offset ghost2
	call WriteString

	mov dl, xGhostPos2
	mov dh, yGhostPos2
	add dh, 2
	call Gotoxy

	mov edx, offset ghost3
	call WriteString

	mov eax, white (black * 16)
	call SetTextColor

	ret
DrawGhost ENDP

UpdateGhost PROC
	call ghostPellets
	mov al, " "
	mov dl, xGhostPos2
	mov dh, yGhostPos2
	call Gotoxy
	call WriteChar
	call WriteChar
	call WriteChar
	call WriteChar

	inc dh
	call Gotoxy
	call WriteChar
	call WriteChar
	call WriteChar
	call WriteChar

	inc dh
	call Gotoxy
	call WriteChar
	call WriteChar
	call WriteChar
	call WriteChar

	CMP regenerate, 1
	JNE SkipRegen
	call UpdateMaze
	mov regenerate, 0
	
	SkipRegen:
	ret
UpdateGhost ENDP

ghostPellets PROC
	mov regenerate, 1
	mov ebx, offset maze
	movzx ecx, xGhostPos2
	add ebx, ecx
	mov eax, 0
	movzx ecx, yGhostPos2
	add eax, ecx
	inc eax
	mul xSize
	add ebx, eax
	mov al, [ebx]
	CMP al, Pellet
	JNE SkipEat5
	mov al, "Q"
	mov [ebx], al
	ret

	SkipEat5:
	inc ebx
	mov al, [ebx]
	CMP al, Pellet
	JNE SkipEat6
	mov al, "Q"
	mov [ebx], al
	ret

	SkipEat6:
	inc ebx
	mov al, [ebx]
	CMP al, Pellet
	JNE SkipEat7
	mov al, "Q"
	mov [ebx], al
	ret

	SkipEat7:
	inc ebx
	mov al, [ebx]
	CMP al, Pellet
	JNE SkipEat8
	mov al, "Q"
	mov [ebx], al
	ret

	SkipEat8:
	add ebx, 121
	mov al, [ebx]
	CMP al, Pellet
	JNE SkipEat9
	mov al, "Q"
	mov [ebx], al
	ret

	SkipEat9:
	dec ebx
	mov al, [ebx]
	CMP al, Pellet
	JNE SkipEat10
	mov al, "Q"
	mov [ebx], al
	ret

	SkipEat10:
	dec ebx
	mov al, [ebx]
	CMP al, Pellet
	JNE SkipEat11
	mov al, "Q"
	mov [ebx], al

	SkipEat11:
	sub ebx, 242
	mov al, [ebx]
	CMP al, Pellet
	JNE SkipEat12
	mov al, "Q"
	mov [ebx], al
	ret

	SkipEat12:
	inc ebx
	mov al, [ebx]
	CMP al, Pellet
	JNE SkipEat13
	mov al, "Q"
	mov [ebx], al
	ret

	SkipEat13:
	inc ebx
	mov al, [ebx]
	CMP al, Pellet
	JNE SkipEat14
	mov al, "Q"
	mov [ebx], al
	ret

	SkipEat14:
	mov regenerate, 0
	ret
ghostPellets ENDP

eatPellets PROC
	mov ebx, offset maze
	movzx ecx, xPos
	add ebx, ecx
	mov eax, 0
	movzx ecx, yPos
	add eax, ecx
	inc eax
	mul xSize
	add ebx, eax
	mov al, [ebx]
	CMP al, Pellet
	JNE SkipEat
	inc score
	mov al, collectedPellet
	mov [ebx], al
	ret

	SkipEat:
	inc ebx
	mov al, [ebx]
	CMP al, Pellet
	JNE SkipEat2
	inc score
	mov al, collectedPellet
	mov [ebx], al
	ret

	SkipEat2:
	inc ebx
	mov al, [ebx]
	CMP al, Pellet
	JNE SkipEat3
	inc score
	mov al, collectedPellet
	mov [ebx], al
	ret

	SkipEat3:
	inc ebx
	mov al, [ebx]
	CMP al, Pellet
	JNE SkipEat4
	inc score
	mov al, collectedPellet
	mov [ebx], al

	SkipEat4:
	CMP bonus, 1
	JNE SkipEat18
	CMP al, berry
	JNE SkipEat15
	add score, 5
	mov bonus, 0

	SkipEat15:
	dec ebx
	mov al, [ebx]
	CMP al, berry
	JNE SkipEat16
	add score, 5
	mov bonus, 0

	SkipEat16:
	dec ebx
	mov al, [ebx]
	CMP al, berry
	JNE SkipEat17
	add score, 5
	mov bonus, 0

	SkipEat17:
	dec ebx
	mov al, [ebx]
	CMP al, berry
	JNE SkipEat18
	add score, 5
	mov bonus, 0
	
	SkipEat18:
	ret
eatPellets ENDP

UpdateMaze PROC
	mov ebx, offset maze
	movzx ecx, xGhostPos2
	add ebx, ecx
	mov eax, 0
	movzx ecx, yGhostPos2
	add eax, ecx
	mul xSize
	add ebx, eax
	mov al, [ebx]
	mov dl, xGhostPos2
	mov dh, yGhostPos2
	call goToXY

	mazeLoop2:
	mov cl, [ebx]
	CMP cl, 10
	JE SkipY2
	CMP cl, "Q"
	JNE SkipX9
	mov eax, yellow (yellow * 16)
	call SetTextColor
	mov al, Pellet
	mov [ebx], al
	call writeChar
	inc ebx
	JMP mazeLoop2

	SkipY2:
	mov dl, 0
	inc dh
	call goToXY
	inc ebx
	JMP mazeLoop2

	SkipX9:
	inc dl
	call goToXY
	inc ebx
	CMP cl, 0
	JNE mazeLoop2

	ret
UpdateMaze ENDP

DrawMaze PROC
	mov eax, blue (blue * 16)
	call SetTextColor
	mov al, Wall
	mov ebx, offset maze
	mov dl, 0
	mov dh, 0
	call GoToXY

	mazeLoop:
	mov cl, [ebx]
	CMP cl, 10
	JE SkipY
	CMP cl, "X"
	JNE SkipX
	mov eax, blue (blue * 16)
	call SetTextColor
	mov al, Wall
	call writeChar
	inc dl
	call goToXY
	inc ebx
	JMP mazeLoop

	SkipY:
	mov eax, 10
	call Delay
	mov dl, 0
	inc dh
	call goToXY
	inc ebx
	JMP mazeLoop

	SkipX:
	CMP cl, "C"
	JNE SkipX2
	mov eax, yellow (yellow * 16)
	call SetTextColor
	mov al, Pellet
	call writeChar

	SkipX2:
	CMP cl, "B"
	JNE SKipX4
	mov berryPosX, dl
	mov berryPosY, dh

	SkipX4:
	CMP cl, "I"
	JNE SKipX5
	mov eax, blue
	call SetTextColor
	mov XghostPos[2], dl
	mov YghostPos[2], dh
	mov edx, offset ghost1
	call writeString

	mov dl, XghostPos[2]
	mov dh, YghostPos[2]
	inc dh
	call GoToXY
	mov edx, offset ghost2
	call writeString

	mov dl, XghostPos[2]
	mov dh, YghostPos[2]
	add dh, 2
	call GoToXY
	mov edx, offset ghost3
	call writeString
	
	mov dl, XghostPos[2]
	mov dh, YghostPos[2]
	call GoToXY

	SkipX5:
	CMP cl, "L"
	JNE SKipX6
	mov eax, red
	call SetTextColor
	mov XghostPos[0], dl
	mov YghostPos[0], dh
	mov edx, offset ghost1
	call writeString

	mov dl, XghostPos[0]
	mov dh, YghostPos[0]
	inc dh
	call GoToXY
	mov edx, offset ghost2
	call writeString

	mov dl, XghostPos[0]
	mov dh, YghostPos[0]
	add dh, 2
	call GoToXY
	mov edx, offset ghost3
	call writeString
	
	mov dl, XghostPos[0]
	mov dh, YghostPos[0]
	call GoToXY

	SkipX6:
	CMP cl, "P"
	JNE SKipX7
	mov eax, lightmagenta
	call SetTextColor
	mov XghostPos[1], dl
	mov YghostPos[1], dh
	mov edx, offset ghost1
	call writeString

	mov dl, XghostPos[1]
	mov dh, YghostPos[1]
	inc dh
	call GoToXY
	mov edx, offset ghost2
	call writeString

	mov dl, XghostPos[1]
	mov dh, YghostPos[1]
	add dh, 2
	call GoToXY
	mov edx, offset ghost3
	call writeString
	
	mov dl, XghostPos[1]
	mov dh, YghostPos[1]
	call GoToXY

	SkipX7:
	CMP cl, "G"
	JNE SKipX8
	mov eax, lightred
	call SetTextColor
	mov XghostPos[3], dl
	mov YghostPos[3], dh
	mov edx, offset ghost1
	call writeString

	mov dl, XghostPos[3]
	mov dh, YghostPos[3]
	inc dh
	call GoToXY
	mov edx, offset ghost2
	call writeString

	mov dl, XghostPos[3]
	mov dh, YghostPos[3]
	add dh, 2
	call GoToXY
	mov edx, offset ghost3
	call writeString
	
	mov dl, XghostPos[3]
	mov dh, YghostPos[3]
	call GoToXY

	SkipX8:
	CMP cl, "T"
	JNE SKipX9
	mov eax, green (green * 16)
	call SetTextColor
	mov al, Pellet
	call writeChar

	SkipX9:
	CMP cl, "R"
	JNE SKipX10
	mov eax, lightblue (lightblue * 16)
	call SetTextColor
	mov al, Pellet
	call writeChar

	SkipX10:
	inc dl
	call goToXY
	inc ebx
	CMP cl, 0
	JNE mazeLoop

	mov eax, white
	call setTextColor
	mov dl, 0
	mov dh, 29
	call goToXY
	mov edx, offset strScore
	call writeString

	mov dl, 15
	mov dh, 29
	call goToXY
	mov edx, offset liveStr
	call writeString

	mov dl, 30
	mov dh, 29
	call goToXY
	mov edx, offset levelStr
	call writeString

	mov dl, 37
	mov dh, 29
	call goToXY
	mov al, level
	call writeDec

	ret
DrawMaze ENDP

createBonus PROC
	CMP level, 1
	JE SkipB
	mov dl, berryPosX
	dec dl
	mov dh, berryPosY
	call GoToXY
	mov eax, red (red * 16)
	call SetTextColor
	mov al, Berry
	call writeChar
	call writeChar
	mov eax, white (black * 16)
	call SetTextColor
    mov bonus, 1
	SkipB:
	ret
createBonus ENDP

DrawTeleports PROC
	mov dl, 2Fh
	mov dh, 11h
	call GoToXY
	mov eax, green (green * 16)
	call setTextColor
	mov al, Pellet
	call writeChar
	call writeChar
	
	inc dh
	call GoToXY
	call writeChar
	call writeChar

	inc dh
	call GoToXY
	call writeChar
	call writeChar

	mov dl, 74h
	mov dh, 19h
	call GoToXY
	call writeChar
	call writeChar
	
	inc dh
	call GoToXY
	call writeChar
	call writeChar

	inc dh
	call GoToXY
	call writeChar
	call writeChar

	mov dl, 47h
	mov dh, 11h
	call GoToXY
	mov eax, lightblue (lightblue * 16)
	call setTextColor
	mov al, Pellet
	call writeChar
	call writeChar
	
	inc dh
	call GoToXY
	call writeChar
	call writeChar

	inc dh
	call GoToXY
	call writeChar
	call writeChar

	mov dl, 2h
	mov dh, 1h
	call GoToXY
	call writeChar
	call writeChar
	
	inc dh
	call GoToXY
	call writeChar
	call writeChar

	inc dh
	call GoToXY
	call writeChar
	call writeChar

	mov eax, white (black * 16)
	call SetTextColor
	ret
DrawTeleports ENDP

titleScreen PROC

	mov dl, 3
	mov dh, 5
	call GotoXY

	mov eax, yellow
	call SetTextColor

	mov edx, offset Logo
	call writeString
	
	mov dl, 48
	mov dh, 17
	call GotoXY

	mov eax, blue
	call SetTextColor

	mov edx, offset startPrompt
	call writeString
	call readChar
	call clrscr

	mov eax, white
	call SetTextColor
	ret
titleScreen ENDP

MainMenu Proc
	call clrscr
	mov dl, 15
	mov dh, 4
	call GotoXY

	mov edx, offset Menu
	call writeString
	
	options:
		call readchar
		CMP al, "1"
		JE startJump
		CMP al, "2"
		JE instructions
		CMP al, "3"
		JE GameSetup
		CMP al, "4"
		JE exitGame
	JMP options

	startJump::
	call clrscr
	ret
MainMenu ENDP

Instructions PROC
	call clrscr
	mov dh, 8
	mov dl, 23
    call GoToXY
	mov edx, offset instruction
	call writeString
	call readChar
	JMP mainMenu
Instructions ENDP

GameSetup PROC
	call clrscr
	mov dh, 8
	mov dl, 45
    call GoToXY
	mov edx, offset Setup
	call writeString
	call readChar
	CMP al, "1"
	JE SetLevel1
	CMP al, "2"
	JE SetLevel2
	CMP al, "3"
	JE SetLevel3
	JMP mainMenu

	SetLevel1:
	mov level, 1
	JMP mainMenu

	SetLevel2:
	mov level, 2
	JMP mainMenu

	SetLevel3:
	mov level, 3
	JMP mainMenu
GameSetup ENDP

PauseGame PROC
	call clrscr
	mov dh, 8
	mov dl, 12
    call GoToXY
	mov edx, offset paused
	call writeString
	Input:
	call readChar
	CMP al, "r"
	JNE Input
	call clrscr
	JMP startLevel
PauseGame ENDP

DrawPlayer PROC
	mov eax, yellow
	call SetTextColor

	CMP anim, 2
	JE Closed

	CMP right, 0
	JE Left

	mov dl, xPos
	mov dh, yPos
	call Gotoxy

	mov edx, offset pacMan1
	call WriteString

	mov dl, xPos
	mov dh, yPos
	inc dh
	call Gotoxy

	mov edx, offset pacMan2
	call WriteString

	mov dl, xPos
	mov dh, yPos
	add dh, 2
	call Gotoxy

	mov edx, offset pacMan3
	call WriteString

	mov eax, white (black * 16)
	call SetTextColor

	inc anim
	ret

	Left:
	mov dl, xPos
	mov dh, yPos
	call Gotoxy

	mov edx, offset pacMan7
	call WriteString

	mov dl, xPos
	mov dh, yPos
	inc dh
	call Gotoxy

	mov edx, offset pacMan8
	call WriteString

	mov dl, xPos
	mov dh, yPos
	add dh, 2
	call Gotoxy

	mov edx, offset pacMan9
	call WriteString

	mov eax, white (black * 16)
	call SetTextColor

	inc anim
	ret

	Closed:
		CMP right, 0
		JE Left2

		mov dl, xPos
		mov dh, yPos
		call Gotoxy

		mov edx, offset pacMan4
		call WriteString

		mov dl, xPos
		mov dh, yPos
		inc dh
		call Gotoxy

		mov edx, offset pacMan5
		call WriteString

		mov dl, xPos
		mov dh, yPos
		add dh, 2
		call Gotoxy

		mov edx, offset pacMan6
		call WriteString

		mov eax, white (black * 16)
		call SetTextColor

		mov anim, 0
		ret

		Left2:
			mov dl, xPos
			mov dh, yPos
			call Gotoxy

			mov edx, offset pacMan10
			call WriteString

			mov dl, xPos
			mov dh, yPos
			inc dh
			call Gotoxy

			mov edx, offset pacMan11
			call WriteString

			mov dl, xPos
			mov dh, yPos
			add dh, 2
			call Gotoxy

			mov edx, offset pacMan12
			call WriteString

			mov eax, white (black * 16)
			call SetTextColor

			mov anim, 0
			ret
DrawPlayer ENDP

UpdatePlayer PROC
	mov al, " "

	mov dl, xPos
	mov dh, yPos
	call Gotoxy
	call WriteChar
	call WriteChar
	call WriteChar
	call WriteChar

	inc dh
	call Gotoxy
	call WriteChar
	call WriteChar
	call WriteChar
	call WriteChar

	inc dh
	call Gotoxy
	call WriteChar
	call WriteChar
	call WriteChar
	call WriteChar

	ret
UpdatePlayer ENDP

LoseLife PROC
	CMP invincibility, 0
	JNE SkipDamage

	mov al, xPos
	CMP al, xGhostPos2
	JE LoseX
	inc al
	CMP al, xGhostPos2
	JE LoseX
	inc al
	CMP al, xGhostPos2
	JE LoseX
	inc al
	CMP al, xGhostPos2
	JE LoseX
	ret

	LoseX:
	mov al, yPos
	CMP al, yGhostPos2
	JE LoseY
	inc al
	CMP al, yGhostPos2
	JE LoseY
	inc al
	CMP al, yGhostPos2
	JE LoseY
	ret

	LoseY:
	dec lives
	call UpdatePlayer
	mov xPos, 58
	mov yPos, 25
	call DrawPlayer
	mov invincibility, 10

	CMP lives, 0
	JE Res
	ret

	Res:
	call finishScreen
	ret

	SkipDamage:
	dec invincibility
	call DrawPlayer
    ret
LoseLife ENDP

completeLevel PROC
	CMP score, 250
	JE finishLevel
	ret

	finishLevel:
	inc level
	CMP level, 2
	JE Level2
	CMP level, 3
	JE Level3
	CMP level, 4
	JE FinishScreen
completeLevel ENDP

Level1 Proc
	mov score, 0
	mov ebx, offset maze
	mov esi, offset level1Maze
	L1Loop:
		mov al, [esi]
		mov [ebx], al
		inc esi
		inc ebx
	CMP al, 0
	JNE L1Loop
	mov xPos, 58
	mov yPos, 25
	call DrawPlayer
	mov ghostNum, 1
	mov ghostDelayTotal, 3
	JMP startLevel
	ret
Level1 ENDP

Level2 Proc
	call clrscr
	mov [direction], 1
	mov [direction + 1], 2
	movzx ax, score
	add totalScore, ax
	mov score, 0
	mov ebx, offset maze
	mov esi, offset level2Maze
	L3Loop:
		mov al, [esi]
		mov [ebx], al
		inc esi
		inc ebx
	CMP al, 0
	JNE L3Loop
	mov ghostNum, 2
	mov ghostDelayTotal, 2
	mov xPos, 58
	mov yPos, 25
	call DrawPlayer
	JMP startLevel
	ret
Level2 ENDP

Level3 Proc
	call clrscr
	movzx ax, score
	add totalScore, ax
	mov score, 0
	mov xPos, 58
	mov yPos, 25
	call DrawPlayer
	mov ebx, offset maze
	mov esi, offset level3Maze
	L3Loop:
		mov al, [esi]
		mov [ebx], al
		inc esi
		inc ebx
	CMP al, 0
	JNE L3Loop
	mov ghostNum, 4
	mov ghostDelayTotal, 2
	JMP startLevel
	ret
Level3 ENDP

userName PROC
	call clrscr
	mov dl, 5
	mov dh, 5
	call GoToXY
	mov edx, offset namePrompt
	call writeString
	mov dl, 55
	mov dh, 15
	call GoToXY
	mov edx, offset playerName
	mov ecx, 255
	call readString
	mov stringLength, eax
	ret
userName ENDP

finishScreen PROC
	call clrscr
	mov dl, 28
	mov dh, 7
	call GoToXY
	mov edx, offset GameOver
	call writeString
	mov dl, 65
	mov dh, 15
	call GoToXY
	mov edx, offset playerName
	call writeString
	mov dl, 66
	mov dh, 19
	call GoToXY
	movzx ax, score
    add totalScore, ax
	mov eax, 0
	mov ax, totalScore
	call writeDec
	call readChar
	mov dl, 200
	mov dh, 200
	call GoToXY
	call saveHighscore
	exit
finishScreen ENDP

saveHighScore PROC
	mov edx,OFFSET filename
	call OpenInputFile
	mov fileHandle, eax
	
	cmp eax, INVALID_HANDLE_VALUE
	jne letsOpenFile 
	
	mov edx, offset filename
	call CreateOutputFile
	mov fileHandle, eax
	jmp SaveScore
	
	
	letsOpenFile:
		mov edx, offset buffer
		mov ecx, BUFFER_SIZE
		call ReadFromFile
		mov edx, OFFSET buffer
		mov sizeRead, eax
	SaveScore:

	mov eax,fileHandle
	call CloseFile

	mov edx, offset filename
	call CreateOutputFile
	mov fileHandle, eax

	mov eax, fileHandle
    mov edx, OFFSET buffer
    mov ecx, sizeRead
    call WriteToFile

	mov eax, fileHandle
    mov edx, OFFSET playerName
    mov ecx, stringLength
    call WriteToFile

	mov eax, fileHandle
    mov edx, offset space
    mov ecx, 1
    call WriteToFile

	call scoreToString
	mov eax, fileHandle
	mov edx, offset scoreString
    mov ecx, lengthof scoreString
    call WriteToFile

	mov eax, fileHandle
	mov edx, offset nextline
    mov ecx, 1
    call WriteToFile

	close_file:
		mov eax,fileHandle
		call CloseFile

	quit:
	ret
saveHighScore ENDP

scoreToString PROC
	mov eax, 0
	mov ax, totalScore
	divLoop:
		div divisor
		mov ebx, offset scoreString
		add ah, 30h
		mov [ebx], ah
		inc ebx
		CMP al, 10
		JNA endDivLoop
		mov score, al
		movzx ax, score
	JMP divLoop

	endDivLoop:
	add al, 30h
	inc ebx
	mov [ebx], al

	mov ecx, lengthof scoreString
	mov esi, 0
	dec ecx
	reverse:
		movzx eax, scoreString[esi]
		push eax
		inc esi
	loop reverse

	mov ecx, lengthof scoreString
	mov ebx, offset scoreString
	dec ecx
	reverse2:
		pop [ebx]
		inc ebx
	loop reverse2
	ret
scoreToString ENDP
end main