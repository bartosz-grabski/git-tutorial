import os

class Font:
	def __init__(self, name):
		self.name = name
		self.letters = {}

class FontLoader:
	def loadFont(self, directory):
		font = Font("fancy")

		for filename in os.listdir(directory):
			font.letters[filename] = readFile(directory+filename)

 		return font


def readFile(filename):
	return open(filename).read()
