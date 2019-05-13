

mem = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
register = [0,0,0,0,0,0]

if __name__ == '__main__':
	file = open("assembleur", "r")
	lines = file.readlines()
	#print(lines)
	print(len(lines))
	pc = 0

	while pc < len(lines):
		code = lines[pc].strip().split()
		print("PC : "+str(pc)+" / "+str(code))
		if code[0]=="LOAD":
			register[int(code[1])] = mem[int(code[2])]
		elif code[0]=="STORE":
			mem[int(code[1])] = register[int(code[2])]
		elif code[0]=="AFC":
			register[int(code[1])] = int(code[2])
		elif code[0]=="MUL":
			register[int(code[1])] = register[int(code[2])] * register[int(code[3])]
		elif code[0]=="ADD":
			register[int(code[1])] = register[int(code[2])] + register[int(code[3])]
		elif code[0]=="JMPC":
			print("Addr " +str(code[1])+ " / R"+str(code[2])+" = "+str(register[int(code[2])]))
			if register[int(code[2])]==0:
				pc = int(code[1])
				continue
		elif code[0]=="INF":
			if register[int(code[2])] < register[int(code[3])]:
				register[int(code[1])]=1
			else:
				register[int(code[1])] = 0
		elif code[0]=="SUP":
			if register[int(code[2])] > register[int(code[3])]:
				register[int(code[1])] = 1
			else:
				register[int(code[1])] = 0
		elif code[0]=="EQU":
			if register[int(code[2])] == register[int(code[3])]:
				register[int(code[1])] = 1
			else:
				register[int(code[1])] = 0
		elif code[0]=="INFE":
			if register[int(code[2])] <= register[int(code[3])]:
				register[int(code[1])] = 1
			else:
				register[int(code[1])] = 0
		elif code[0]=="SUPE":
			if register[int(code[2])] >= register[int(code[3])]:
				register[int(code[1])] = 1
			else:
				register[int(code[1])] = 0
		elif code[0]=="JMP":
			pc = int(code[1])
			continue
		elif code[0]=="SOU":
			register[int(code[1])] = register[int(code[2])] - register[int(code[3])]
		elif code[0]=="DIV":
			register[int(code[1])] = int(register[int(code[2])] / register[int(code[3])])
		elif code[0]=="COP":
			pass
		else:
			pass
		pc += 1


	print(mem)
