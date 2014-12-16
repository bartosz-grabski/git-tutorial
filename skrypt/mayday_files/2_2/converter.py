def getText():
	return 'Git'

class Font:
	pass

class FontLoader:
	def loadFont(self, directory):
		pass

t = getText()
f = FontLoader().loadFont('fancyFont/')

d = TextDrawer()
d.setFont(f)
d.draw(t)
