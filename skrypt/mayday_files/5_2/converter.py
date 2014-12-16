from font import Font, FontLoader
from textdrawer import TextDrawer

def getText():
	return 'Git'

text = getText()
font = FontLoader().loadFont('fancyFont/')

drawer = TextDrawer()
drawer.setFont(font)
drawer.draw(text)
