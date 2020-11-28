for f in *.png; do
  convert ./"$f" -gravity center -crop 400x400+0+0 ./"crop_${f%.png}.png"
done

