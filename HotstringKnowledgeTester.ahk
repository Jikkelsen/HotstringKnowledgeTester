#SingleInstance force       ; Cannot have multiple instances of program
#NoEnv                      ; Avoids checking empty variables to see if they are environment variables
#Persistent                 ; Script will stay running after auto-execute section completes 




if FileExist("G:\Shared drives\1. TMG - Internt\4. Processer\Custom Macros\Minerva\include_hotstrings.txt")
	global FileLocation := "G:\Shared drives\1. TMG - Internt\4. Processer\Custom Macros\Minerva\include_hotstrings.txt"
if FileExist("G:\Fællesdrev\1. TMG - Internt\4. Processer\Custom Macros\Minerva\include_hotstrings.txt")
	global FileLocation := "G:\Fællesdrev\1. TMG - Internt\4. Processer\Custom Macros\Minerva\include_hotstrings.txt"

global HotstringsArray := []
global CommentsArray := []
;FileRead, hotstringsFile, %FileLocation%

MakeHotstringArray()

Loop, 5 {
	Random, rand,1, HotstringsArray.Length()
	arrayNumber	:= CommentsArray[rand]
	stringToCheck	:= HotstringsArray[rand]

	InputBox, theInput, Brug hotstrings til følgende besked:, %arrayNumber%

	if !(theInput = stringToCheck)
	{
		MsgBox, 16, FØJ, Det var ikke den rigtige hotstring. Start forfra.
		ExitApp
	}
}

MsgBox, Tillykke! Du er bare så god til hotstrings


; -------------------------------------------------------------------- Functions  --------------------------------------------------------------------

MakeHotstringArray() {
	TempArray := []

	Loop
	{
		FileReadLine, line,%FileLocation%, %A_Index%
		if ErrorLevel
			break

		FirstLetter         := SubStr(line, 1, 1) 
		CommentIdentifier   := "#"
		
		; Continue if comment
		if (FirstLetter = CommentIdentifier)
		{
			continue
		}
		
		; ifstatement for comment goes here
		
		TextArray 		:= StrSplit(line, ";")       ; Split string into substrings
		callsign 			:= Trim(TextArray[1])
		replacement	:= Trim(TextArray[2])
		comment 		:= Trim(TextArray[3])	
		
		; Check hvis det er en af mine strings
		if replacement in Autohotkey,/top/?sort=top&t=month,/top/?sort=top&t=all
			continue
		
		; Check hvis emoju
		IfInString, replacement, U+
			continue
		
		; Check hvis comment er tom
		if !comment 
			continue

		HotstringsArray.Push(replacement)		
		CommentsArray.Push(comment)
	}
}


;~ InputBox, theInput, Brug hotstrings til følgende besked, %theMessage%

;~ MsgBox, %beskeden%