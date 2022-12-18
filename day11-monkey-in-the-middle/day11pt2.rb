class Monkey

def initialize(num)
	@num = num
	@items = Array.new
	@number = 0
	@operation = ""
	@opval = 0
	@test = 0
	@true = 0
	@false = 0
	@itemcntr = 0
end

def setMod(div)
	@@modulus = div
end

def getTest()
	return @test
end

def getID()
	#print @num, "\n"
	return @num
end

def getItms()
	#print @items
	#print "\n"
	#print @items.length(), "\n"
	return @items
end

def addItem(item)
	@items.append(item)
	#print "i: ", item, "\n"
end

def length()
	#print @items[0], "\n"
	#print @items.length(), "\n"
	return @items.length()
end

def nextItem()
	# select item
	item = @items.shift()
	# do operation
	case @operation
	when "*"
		worry = item * @opval
	when "+"
		worry = item + @opval
	when "^"
		worry = item * item
	end
	# dev by 3
	#item = (worry / 3).floor()
	item = worry % @@modulus
	# do the test
	if (item % @test) == 0 then
		toMonkey = @true
	else
		toMonkey = @false
	end
	# return item number & monkey to number
	@itemcntr = @itemcntr + 1
	return item, toMonkey
end

def getInspected()
	return @itemcntr
end

def setTestVal(value)
	@test = value
end

def setOper(operation, value)
	@operation = operation
	@opval = value
end

def setTrueMonkey(number)
	@true = number
end

def setFalseMonkey(number)
	@false = number
end

def getItems()
	return @items
end

def display()
	print "Number    : ", @num, "\n"
	print "#Items    : ", @items.length(), "\n"
	print "Operation : ", @operation, "\n"
	print "Op'n value: ", @opval, "\n"
	print "Test      : ", @test, "\n"
	print "True Mon  : ", @true, "\n"
	print "False Mon : ", @false, "\n"
end
end


line = STDIN.readline
monkeys = Array.new
#monkeys = Hash.new

while not STDIN.eof do
	#puts line
	linearray = line.split(" ")
	if linearray[0] == "Monkey" then
		index = linearray[1][0..-2].to_i
		amonkey = Monkey.new(index)
		#print "Monkey: ", linearray[1][0..-2].to_i, " ", amonkey.getID(), "\n"
		
		other = false
		while other == false do
			line = STDIN.readline
			if STDIN.eof then
				linearray = Array.new(0)
			else
				linearray = line.split(" ")
			end

			if linearray.length() > 0 then
				case linearray[0][0..3]
				when "Star"
					for item in linearray[2..-1].join("").split(",") do
						amonkey.addItem(item.to_i)
					end
				when "Oper"
					if linearray[5] == "old" then # special case
						amonkey.setOper("^", 2)
					else
						amonkey.setOper(linearray[4], linearray[5].to_i)
					end
					#print "Oper ", linearray[1..-1].join(" "), "\n"
				when "Test"
					amonkey.setTestVal(linearray[3].to_i)
				when "If" # shhh, don't tell anyone this can fail if this is the last line
					if linearray[1] == "true:" then
						amonkey.setTrueMonkey(linearray[5].to_i)
					else
						#print linearray
						amonkey.setFalseMonkey(linearray[5].to_i)
					end
				else
					print "Othe ", line, "\n"
				end
			else
				other = true
			end
		end
		#amonkey.display()
		#print amonkey.getItems()
		monkeys.append(amonkey)
	end
	if STDIN.eof then
		line = ""
	else
		line = STDIN.readline
	end

end

# get a modulus
monkeytests = Array.new

for monkey in monkeys
	#print "- ", monkey.getID(), ": ", monkey.getTest(), "\n"
	monkeytests.append(monkey.getTest())
end

#print "--", monkeytests.inject(:*), "\n"

monkeys[0].setMod(monkeytests.inject(:*))

#exit()

# Monkeys throw items
for i in 1..10000
	#print "+ ", i, "\n"
	for monkey in monkeys
		#print monkey.getItms()
		#print "\n"
		#monkey.display()
		while monkey.length() > 0 do
			#print monkey.length()
			#print monkey.getID(), "\n"
			item = monkey.nextItem()
			#print "> ", item[0], " ", item[1], "\n"
			for m in monkeys
				#print m.getID(), item[1], "\n"
				if m.getID() == item[1] then
					m.addItem(item[0])
				end
			end
		end
		#print monkey.length()
		#print monkeys.length()
	end
end

monkeybus = Array.new

for monkey in monkeys
	#print "= ", monkey.getID(), ": ", monkey.getInspected(), "\n"
	monkeybus.append(monkey.getInspected())
end

print monkeybus.max(2).inject(:*), "\n"
