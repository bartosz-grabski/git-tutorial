class TextDrawer:
	def setFont(self, font):
		self.font = font

	def draw(self, text):
		firstLetter = self.font.letters[text[0].upper()]
		drawing = splitLetter(firstLetter)

		for character in text[1:]:
			 letter = splitLetter(self.font.letters[character.upper()])
			 drawing = appendLetter(drawing, letter)

		for line in drawing:
			print line


def splitLetter(letter):
	return letter.split('\n')

def appendLetter(text, letter):
	for i in xrange(len(text)):
		text[i] += letter[i]

	return text

