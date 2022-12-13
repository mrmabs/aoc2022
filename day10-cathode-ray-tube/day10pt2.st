input := ''.
inarray := OrderedCollection new.
line := ''.

cycle := 0.
x := 1.

checkpoints := #(40 80 120 160 200 240).
value := 0.
accumulator := 0.

[ input ~= nil ] whileTrue: [ " this isn't quite working, crashing loop to exit"
	input := stdin nextLine.
	inarray := (input tokenize: ' ') asOrderedCollection.
	command := inarray at: 1.
	"input printNl."
	cycle := cycle + 1. "moved out of if statements below"
	col := (cycle - 1) \\ 40.
	(col >= (x - 1)) & (col <= (x + 1)) ifTrue: [
		line := line, '#'.
	] ifFalse: [
		line := line, '.'.
	].
	(checkpoints includes: cycle) ifTrue: [
		line printNl.
		line := ''.
	].
	(command = 'noop') ifTrue: [
		x := x. "noop"
	] ifFalse: [
		param := inarray at: 2.
		value := param asNumber. 
		cycle := cycle + 1.
		col := (cycle - 1) \\ 40.
		(col >= (x - 1)) & (col <= (x + 1)) ifTrue: [
			line := line, '#'.
		] ifFalse: [
			line := line, '.'.
		].
		(checkpoints includes: cycle) ifTrue: [
			line printNl.
			line := ''.
		].
		x := x + value.
	].
].
