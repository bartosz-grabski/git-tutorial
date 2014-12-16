from font import Font, FontLoader

def main():
	text = getText()
	font = FontLoader().loadFont('fancyFont/')

	drawer = TextDrawer()
	drawer.setFont(font)
	drawer.draw(text)

def getText():
	return 'Git'

class TextDrawer:
	def setFont(self, font):
		pass

	def draw(self, text):
		pass

if __name__ == '__main__':
	main()