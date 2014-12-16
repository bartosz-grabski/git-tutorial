from font import Font, FontLoader

def getText():
	return 'Git'

class TextDrawer:
	def setFont(self, font):
		pass

	def draw(self, text):
		pass

text = getText()
font = FontLoader().loadFont('fancyFont/')

drawer = TextDrawer()
drawer.setFont(font)
drawer.draw(text)
