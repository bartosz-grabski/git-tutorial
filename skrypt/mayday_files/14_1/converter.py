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
	if len(sys.argv) != 1:
		print "Bad arguments"
		sys.exit(1)

	return sys.argv[0]

if __name__ == '__main__':
	main()