class TextDrawer:
	def setFont(self, font):
		self.font = font

	def draw(self, text):
		for character in text:
			print self.font.letters[character.upper()]


