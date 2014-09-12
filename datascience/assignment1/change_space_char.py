import sys
import string

def count_spaces_by_line(sent_file):
	file = open(sent_file)
	text_value = ""
	for line in file:
		count = line.count('\t')
		if count > 1:
			text_value = text_value + string.replace(line, '\t',';')
			print count
		else:
		  	text_value = text_value + line

	write_to_file(text_value)

def count_spaces(sent_file):
	file = open(sent_file)
	text_value = ""
	for line in file:
		count = line.count(';')
		if count > 0:
			print line
			print count
			

def replace_last_char(sent_file):
	file = open(sent_file)
	text_value = ""
	for line in file:
		text_value = text_value + string.replace(line, '\t',';')
		text_value = text_value[:-2]
		print text_value
		text_value = text_value + '\n'


	write_to_file(text_value)			  	

def find_and_replace_spacechars(sent_file):
	file = open(sent_file)
	text_value = ""
	for line in file:
		text_value = text_value + string.replace(line, ' ','\t')

	write_to_file(text_value)

def write_to_file(text_value):
	file = open('new4.txt', "w")
	file.write(text_value)
	file.close()		
	

def main():
    #find_and_replace_spacechars(sys.argv[1])
    count_spaces(sys.argv[1])


if __name__ == '__main__':
    main()

    