---
author: 'Owen Shepherd <owen@owen.cafe>'
title: 'Purely Functional Web Frontends with Reflex'
patat:
  incrementalLists: true
...

# Housekeeping

* Slides at <https://owen.cafe/slides/reflex-2022.html>
* Asking questions
  * Interrupt me
  * Use the #talk-questions discord channel
  * Discord link: https://discord.gg/GGQEdghfzR

## Structure of talk

(So you can remind me)

1. Learn a topic
2. See real code
3. Look at running example
4. Goto 1

# The Web DSL

## Slap some elements down

We're in a monad that supports building DOM trees

```haskell
do
  pure () -- Empty element
  el "div" $ pure ()
  el "span" $ pure ()
  text "Hello, world!"
```

## Give them some attributes

```haskell
    -- semigroup join  ↓↓
attrs :: Map Text Text
attrs = "class" =: "a" <> "id" =: "b"
      -- create singleton map  ↑↑

elAttr "div" attrs $ pure ()
```

## Nesting

```haskell
do
  el "div" $ do
    el "span" $ text "hello"
    text "world"
  el "span" $ text "hi"
```

## What we're using and abusing

* Custom operators, with precendence and associativity
* Algebraic abstractions (Monads)
* Do notation

Pretty standard Haskell so far

## [Demo time](localhost:8000)

(rendering a clock frame)

# FRP

## Behaviours


```{.gnuplot im_fmt="svg" width=80%}
set terminal svg size 600,400 dynamic enhanced background rgb 'black' font 'arial,10' mousing name "behaviours" butt dashlength 1.0 
# set terminal pngcairo transparent enhanced \
#     font "arial,10" fontscale 1.0 size 500, 350
set style line 1 linecolor rgb '#ff0000' linetype 1 linewidth 4
set style line 2 linecolor rgb '#ffffff' linetype 1 linewidth 2
set border linestyle 2
set samples 400, 400
set ylabel "value" tc "white"
set xlabel "time" tc "white"
set nokey
unset xtics
unset ytics
set yrange [-4:4]
plot [-10:10] real(sin(x)) with lines linestyle 1
```

## Events

```{.gnuplot im_fmt="svg" width=80%}
set terminal svg size 600,400 dynamic enhanced background rgb 'black' font 'arial,10' mousing name "behaviours" butt dashlength 1.0 
# set terminal pngcairo transparent enhanced \
#     font "arial,10" fontscale 1.0 size 500, 350
set style line 1 linecolor rgb '#ff0000' linetype 1 linewidth 4
set style line 2 linecolor rgb '#ffffff' linetype 1 linewidth 2
set border linestyle 2
set samples 400, 400
set nokey
unset xtics
unset ytics
set ylabel "value" tc "white"
set xlabel "time" tc "white"
set yrange [0:10]
set xrange [0:10]
set style line 2 lc rgb '#ff0000' pt 7   # circle
plot "<echo '1 1'"   with points ls 2, \
     "<echo '2 2'"   with points ls 2, \
     "<echo '3 5'" with points ls 2, \
     "<echo '5 2'" with points ls 2, \
     "<echo '6 1'" with points ls 2, \
     "<echo '7 2'" with points ls 2, \
     "<echo '9 8'" with points ls 2
```

## Dynamic

```{.gnuplot im_fmt="svg" width=80%}
set terminal svg size 600,400 dynamic enhanced background rgb 'black' font 'arial,10' mousing name "behaviours" butt dashlength 1.0 
# set terminal pngcairo transparent enhanced \
#     font "arial,10" fontscale 1.0 size 500, 350
set style line 1 linecolor rgb '#ff0000' linetype 1 linewidth 4
set style line 2 linecolor rgb '#ffffff' linetype 1 linewidth 2
set border linestyle 2
set samples 400, 400
set nokey
unset xtics
unset ytics
set ylabel "value" tc "white"
set xlabel "time" tc "white"
set yrange [0:10]
set xrange [0:10]
set style line 2 lc rgb '#ff0000' pt 7   # circle

set style arrow 7 nohead ls 1

set arrow from 2,5 to 5,5 arrowstyle 7
set arrow from 5,6 to 8,6 arrowstyle 7
set arrow from 0,4 to 2,4 arrowstyle 7
set arrow from 8,4 to 10,4 arrowstyle 7

plot "<echo '2 5'" with points ls 2, \
     "<echo '5 6'" with points ls 2, \
     "<echo '8 4'" with points ls 2
```

## [Demo time](localhost:8000)

(rendering clock hands)

# More features than you can:

* Shake a stick at
* Cover on a Wednesday afternoon

---

**Disclaimer**: These are mostly `obelisk` features

## Production mode

* Frontend compiled to JS

## Development mode

* Frontend code runs as Haskell
  * Not in the browser
  * Result sent over websockets
* **Fast** cycle time
  * As fast as `:r` in `GHCI`

## Misc

* Server-side rendering
* Multi-platform
  * (desktop/mobile/web/terminal)
* No virtual DOM, just data dependency encoding
* Automatic (un)marshalling between frontend and backend
* `ob deploy`

## [Demo time](localhost:8000)

(state management)

# That's all

Thanks for coming!
<br>
**Get in touch**: <owen@owen.cafe>
