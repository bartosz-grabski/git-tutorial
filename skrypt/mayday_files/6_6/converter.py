from font import Font, FontLoader
from textdrawer import TextDrawer

def main():
	text = getText()
	font = FontLoader().loadFont('fancyFont/')

	drawer = TextDrawer()
	drawer.setFont(font)
	drawer.draw(text)

def getText():
	return 'Git'

if __name__ == '__main__':
	main()