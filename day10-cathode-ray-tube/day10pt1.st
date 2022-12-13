input := ''.
inarray := OrderedCollection new.

cycle := 0.
x := 1.

checkpoints := #(20 60 100 140 180 220).
value := 0.
accumulator := 0.

[ input ~= nil ] whileTrue: [ " this isn't quite working, crashing loop to exit"
	input := stdin nextLine.
	inarray := (input tokenize: ' ') asOrderedCollection.
	command := inarray at: 1.
	input printNl.
	cycle := cycle + 1. "moved out of if statements below"
	(checkpoints includes: cycle) ifTrue: [
		cycle printNl.
		(x * cycle) printNl.
		accumulator := accumulator + (x * cycle).
	].
	(command = 'noop') ifTrue: [
		x := x. "nop"
	] ifFalse: [
		param := inarray at: 2.
		value := param asNumber. 
		cycle := cycle + 1.
		(checkpoints includes: cycle) ifTrue: [
			cycle printNl.
			(x * cycle) printNl.
			accumulator := accumulator + (x * cycle).
		].
		x := x + value.
		x printNl.
	].
].

accumulator printNl.
