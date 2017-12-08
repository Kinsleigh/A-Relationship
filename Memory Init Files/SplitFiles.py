infile = open("Sad_data.txt", "r")
outfile1 = open("Core0.txt", "w")
outfile2 = open("Core1.txt", "w")
outfile3 = open("Core2.txt", "w")
outfile4 = open("Core3.txt", "w")
outfile5 = open("Core4.txt", "w")
outfile6 = open("Core5.txt", "w")
outfile7 = open("Core6.txt", "w")
outfile8 = open("Core7.txt", "w")
lines = infile.readlines()
start = []
end = []
for i in range(0, 8):
	start.append(512*i + 4)
	print(str(i) + " " + str(start[i]))
	end.append(start[i] + (11 * 64))
	print(str(i) + " " + str(end[i]))

outfile1.write("11\n64\n4\n4\n")
for i in range(start[7] + (8*64), start[7] + (8*64) + 16):
	outfile1.write(lines[i])
for i in range (start[0], end[0]):
	outfile1.write(lines[i])


outfile2.write("11\n64\n4\n4\n")
for i in range(start[7] + (8*64), start[7] + (8*64) + 16):
	outfile2.write(lines[i])

for i in range (start[1], end[1]):
	outfile2.write(lines[i] )

outfile3.write("11\n64\n4\n4\n")
for i in range(start[7] + (8*64), start[7] + (8*64) + 16):
	outfile3.write(lines[i])
for i in range (start[2], end[2]):
	outfile3.write(lines[i] )


outfile4.write("11\n64\n4\n4\n")
for i in range(start[7] + (8*64), start[7] + (8*64) + 16):
	outfile4.write(lines[i])
for i in range (start[3], end[3]):
	outfile4.write(lines[i] )


outfile5.write("11\n64\n4\n4\n")
for i in range(start[7] + (8*64), start[7] + (8*64) + 16):
	outfile5.write(lines[i])
for i in range (start[4], end[4]):
	outfile5.write(lines[i] )


outfile6.write("11\n64\n4\n4\n")
for i in range(start[7] + (8*64), start[7] + (8*64) + 16):
	outfile6.write(lines[i])
for i in range (start[5], end[5]):
	outfile6.write(lines[i] )


outfile7.write("11\n64\n4\n4\n")
for i in range(start[7] + (8*64), start[7] + (8*64) + 16):
	outfile7.write(lines[i])
for i in range (start[6], end[6]):
	outfile7.write(lines[i] )

outfile8.write("8\n64\n4\n4\n")
for i in range(start[7] + (8*64), start[7] + (8*64) + 16):
	outfile8.write(lines[i])
for i in range (start[7], start[7] + (8*64)):
	outfile8.write(lines[i])


infile.close()
outfile8.close()
outfile7.close()
outfile6.close()
outfile5.close()
outfile4.close()
outfile3.close()
outfile2.close()
outfile1.close()
