from font import Font, FontLoader
from textdrawer import TextDrawer
import sys

def main():
	text = getText()
	font = FontLoader().loadFont('fancyFont/')

	drawer = TextDrawer()
	drawer.setFont(font)
	drawer.draw(text)

def getText():
	return sys.argv[0]

if __name__ == '__main__':
	main()