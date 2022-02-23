frp.html: frp.md
	pandoc --standalone --highlight-style=zenburn --filter pandoc-imagine --slide-level=2 -t revealjs -o frp.html frp.md
	sed -i '/^<rect/d' pd-images/*.svg

clean:
	rm frp.html
