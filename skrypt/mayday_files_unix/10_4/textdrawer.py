class TextDrawer:
	def setFont(self, font):
		self.font = font

	def draw(self, text):
		for character in text:
			print self.font.letters[character.upper()]


def appendLetter(text, letter):
	for i in xrange(len(text)):
		text[i] += letter[i]

	return text

