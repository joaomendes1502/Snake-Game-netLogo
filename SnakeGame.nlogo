extensions [sound]

breed [snakes snake]
breed [snakes2 snake2]


snakes2-own [direction snake-score number2 ticks-since-here p o alive]

snakes-own [direction snake-score number ticks-since-here a b alive]

globals[difficulty difficulty-chosen mensagem score speed players x y snakenumber snakenumber2 double-score-time time-power life ticks-at-color-change Ghost-Time head sx sy whoWas whoWasPower score1 score2 valor-recorde]

to setup

  clear-all
  reset-ticks
  tick
  set players 1
  set speed 1
  import-drawing "teste-removebg.png"

  set difficulty-chosen false
  set score 0
  set score1 0
  set score2 0
  set snakenumber 0
  set snakenumber2 0
sound:play-note "Rain" 60 64 1.3







  menu





end



to menu
  reset-ticks
  create-buttons
  tick

  while [difficulty-chosen = false] [
    check-mouse-click
    wait 0.1
  ]
  create-map
  create-fruit
  create-powers
  create-snake


end


to create-buttons
  set mensagem "Amarelo = Jogadores | Escolha uma dificuldade. Verde = Fácil | Azul = Normal | Vermelho = Difícil"
  ask patches [
    if pxcor >= 9 and pxcor <= 17  and pycor <= -10 and pycor >= -14 [

     set pcolor red

    ]

    if pxcor >= -17 and pxcor <= -9  and pycor <= -10 and pycor >= -14 [
     set pcolor green

    ]

    if pxcor >= -4 and pxcor <= 4   and pycor <= -10 and pycor >= -14 [
     set pcolor blue

    ]


    if pxcor >= -4 and pxcor <= 4   and pycor <= -17 and pycor >= -19 [
     set pcolor yellow

    ]
  ]
end

to check-mouse-click
  if mouse-down? [
    let mouse-patch patch mouse-xcor mouse-ycor
    if [pcolor] of mouse-patch = red [
      set difficulty "Difícil"
      set mensagem "Jogo em modo Difícil"
      set difficulty-chosen true
      set speed 1.6
    ]

    if [pcolor] of mouse-patch = blue [
      set difficulty "Normal"
      set mensagem "Jogo em modo Normal"
      set difficulty-chosen true
      set speed 1.3
    ]

    if [pcolor] of mouse-patch = green [
      set difficulty "Fácil"
      set speed 1

      set difficulty-chosen true

    ]

    if [pcolor] of mouse-patch = yellow [

      ifelse players = 1 [
    set players 2
  ] [
    set players 1
  ]
    ]

  ]
end

to create-map
  clear-drawing
  ask patches [

    if difficulty = "Fácil"[
      let row-id (pycor - min-pycor) mod 2
    let col-id (pxcor - min-pxcor) mod 2

    ifelse (row-id = 0 and col-id = 0) or (row-id = 1 and col-id = 1) [
      set pcolor green ; Patches de cor verde escura
    ] [
      set pcolor 63 ; Patches de cor verde clara
    ]
    ]


    if difficulty = "Normal"[
      let row-id (pycor - min-pycor) mod 2
    let col-id (pxcor - min-pxcor) mod 2
      ifelse (row-id = 0 and col-id = 0) or (row-id = 1 and col-id = 1) [
      set pcolor green ; Patches de cor verde escura
    ] [
      set pcolor 63 ; Patches de cor verde clara
    ]



      ifelse pxcor = max-pycor and (pycor >= -8 and pycor <= 8) or pxcor = min-pycor and (pycor >= -8 and pycor <= 8) or (pycor = max-pxcor and (pxcor >= -8 and pxcor <= 8)) or (pycor = min-pxcor and (pxcor >= -8 and pxcor <= 8)) or (pycor = 8 or pycor = 7 or pycor = 6 or pycor = -8 or pycor = -7 or pycor = -6 and (pxcor >= -8 and pxcor <= 8))  [
      set pcolor white  ;
      ] []

    ]

    if difficulty = "Difícil"[
      let row-id (pycor - min-pycor) mod 2
    let col-id (pxcor - min-pxcor) mod 2
      ifelse (row-id = 0 and col-id = 0) or (row-id = 1 and col-id = 1) [
      set pcolor green ; Patches de cor verde escura
    ] [
      set pcolor 63 ; Patches de cor verde clara
    ]



     ifelse pxcor = max-pycor or pxcor = min-pycor or pycor = max-pxcor or pycor = min-pxcor or   (pxcor >= -20 and pxcor <= -11 and (pycor >= 0 and pycor <= 1)) or (pxcor >= -11 and pxcor <= -10 and pycor <= 11 and pycor >= 0 ) or (pxcor >= -1 and pxcor <= 0 and (pycor >= 0 and pycor <= 20)) or (pxcor >= -11 and pxcor <= -10 and (pycor >= -20 and pycor <= -9)) or (pxcor >= -10 and pxcor <= 11 and (pycor >= -10 and pycor <= -9)) or (pxcor >= 10 and pxcor <= 11 and (pycor >= -9 and pycor <= 12)) [
      set pcolor white  ;
      ] []

    ]


  ]
end




to create-fruit

  let random-number random-float 1.0

    create-turtles 1 [
      set size 2


    ifelse random-number <= 0.8 [
      set shape "apple"
      set color red
    ] [
      ifelse random-number > 0.8 [
        set shape "strawberry"
        set color red
      ] []

    ]

check-position




  ]
end

to check-position
  let valid-position? false
    let min-distance 2
    while [not valid-position?] [
      setxy round(random-xcor) round(random-ycor)
      if difficulty = "Normal" or difficulty = "Difícil"[
      ifelse [pcolor] of patch-here != white and not any? other turtles-here and min-distance <= min [distance myself] of patches with [pcolor = white] and pxcor != max-pxcor and pycor != min-pycor and pxcor != -19 and pxcor != 19 and pycor != -19  and pycor != 19  [
        set valid-position? true
      ] [
        set valid-position? false
      ]
    ]
      if difficulty = "Fácil"[
        ifelse [pcolor] of patch-here != white and not any? other turtles-here and pxcor != max-pxcor and pycor != min-pycor and pxcor != -19 and pxcor != 19 and pycor != -19  and pycor != 19 [
        set valid-position? true
      ] [
        set valid-position? false
      ]

      ]
    ]
end


to create-powers

  let random-number random-float 1.0
  create-turtles 1 [
      set size 2

   if random-number >= 0 and random-number <= 0.3 [
    set shape "star"
    set color yellow

      ask turtles with [shape = "default"] [
    die
  ]
    ]


    if random-number > 0.3 and random-number < 0.5[
        set shape "spider"
        set color black
        set life 450

      ask turtles with [shape = "default"] [
    die
    ]

    ]





    if random-number > 0.5 and random-number < 0.7 [
        set shape "ghost"
        set color white

       ask turtles with [shape = "default"] [
    die
    ]

      ]



    if random-number > 0.7 [
        set shape "x"
        set color red

      ask turtles with [shape = "default"] [
    die
    ]

      ]


    check-position
  ]



end

to create-snake
  ifelse players = 1 [
    create-snakes 1 [
      set snake-score 0
      set color black
      set score 0
      set size 2
      set alive 1
      set shape "square"
      setxy -15 15
      set direction "direita"
      set label "snake1"
      set number snakenumber + 1
      set snakenumber number
  ]
  ]

  [if players = 2 [
    create-snakes 1 [
      set snake-score 0
      set color black
      set score 0
      set size 2
      set alive 1
      set shape "square"
      setxy -15 15
      set direction "direita"
      set label "snake1"
      set number snakenumber + 1
      set snakenumber number
  ]
    create-snakes2 1 [
      set snake-score 0
      set color red
      set score 0
      set size 2
      set alive 1
      set shape "square"
      setxy 15 -15
      set direction "direita"
      set label "snake2"
      set number2 snakenumber2 + 1
      set snakenumber2 number2
  ]
  ]]


end

to move-snake
  sound:play-note "Warm" 60 64 0.3
 let steps speed


  ask snakes with [label = "snake1"] [

    ifelse direction = "cima" [
      set ycor ycor + steps ; Ajuste conforme necessário
    ] [
      ifelse direction = "baixo" [
        set ycor ycor - steps ; Ajuste conforme necessário
      ] [
        ifelse direction = "esquerda" [
          set xcor xcor - steps ; Ajuste conforme necessário
        ] [
          ifelse direction = "esquerdacima" [
            set xcor xcor - steps
           set ycor ycor + steps ; Ajuste conforme necessário
          ] [
            ifelse direction = "direitacima" [
            set xcor xcor + steps
             set ycor ycor + steps ; Ajuste conforme necessário
          ][ifelse direction = "direitabaixo" [
            set xcor xcor + steps
               set ycor ycor - steps ; Ajuste conforme necessário
          ][ifelse direction = "direita" [
            set xcor xcor + steps ; Ajuste conforme necessário
          ][ifelse direction = "esquerdabaixo" [
            set xcor xcor - steps
                    set ycor ycor - steps
          ][]
        ]
      ]
    ]
  ]
  ]
    ]
  ]
  ]

  let step speed

  ask snakes2 with [label = "snake2"] [

    ifelse direction = "cima" [
      set ycor ycor + step ; Ajuste conforme necessário
    ] [
      ifelse direction = "baixo" [
        set ycor ycor - step ; Ajuste conforme necessário
      ] [
        ifelse direction = "esquerda" [
          set xcor xcor - step ; Ajuste conforme necessário
        ] [
          ifelse direction = "esquerdacima" [
            set xcor xcor - step
           set ycor ycor + step ; Ajuste conforme necessário
          ] [
            ifelse direction = "direitacima" [
            set xcor xcor + step
             set ycor ycor + step ; Ajuste conforme necessário
          ][ifelse direction = "direitabaixo" [
            set xcor xcor + step
               set ycor ycor - step ; Ajuste conforme necessário
          ][ifelse direction = "direita" [
            set xcor xcor + step; Ajuste conforme necessário
          ][ifelse direction = "esquerdabaixo" [
            set xcor xcor - step
                    set ycor ycor - step
          ][]
        ]
      ]
    ]
  ]
  ]
    ]
  ]
  ]


  ask snakes [
    let previous-xcor xcor
    let previous-ycor ycor



    ask snakes with [number >= 2 and alive = 1] [
      foreach sort-on [number] snakes  [
        let nu number - 1
        let previous-snake max-one-of (snakes with [number <= nu and alive = 1]) [number]

        ;let previous-snake one-of snakes with [number = nu]

        if [xcor] of previous-snake != previous-xcor or [ycor] of previous-snake != previous-ycor [
          ;let n number - 1
          let n [number] of previous-snake
          let d [xcor] of snakes with [number = n]
          let f [ycor] of snakes with [number = n]

          let wait-ticks 1  ; Adjust as needed

          set a item 0 d
          set b item 0 f

  ]]]]


   ask snakes2 [
    let previous-xcor xcor
    let previous-ycor ycor



    ask snakes2 with [number2 >= 2 and alive = 1] [
      foreach sort-on [number2] snakes2  [
        let nu number2 - 1
        let previous-snake max-one-of (snakes2 with [number2 <= nu and alive = 1]) [number2]

        ;let previous-snake one-of snakes with [number = nu]

        if [xcor] of previous-snake != previous-xcor or [ycor] of previous-snake != previous-ycor [
          ;let n number - 1
          let n [number2] of previous-snake
          let d [xcor] of snakes2 with [number2 = n]
          let f [ycor] of snakes2 with [number2 = n]

          let wait-ticks 1  ; Adjust as needed

          set p item 0 d
          set o item 0 f

  ]]]]


  move






end

to move

  if (ticks-at-color-change != 0)[

   set Ghost-Time (- (ticks - ticks-at-color-change - 450))
  ]

    if life > 0 [

      set life life - 3

]

  if ticks - ticks-at-color-change >= 450 [
  ask snakes with [color = grey] [
    set color black
  ]

    ask snakes2 with [color = grey] [
    set color red
  ]
]

    print(life)

    if life = 0 [
      ask turtles with [shape = "spider"] [
      die
      ]

    ]

  tick

  tick

  ask snakes with [number >= 2] [

  if any? snakes-on patch a b [
            set xcor a
              set ycor b

          ]

             if not any? snakes-on patch a b [
            set xcor a
              set ycor b]

  ]

  ask snakes2 with [number2 >= 2] [

  if any? snakes2-on patch p o [
            set xcor p
              set ycor o

          ]

             if not any? snakes2-on patch p o [
            set xcor p
              set ycor o]

  ]



end



to go

  let TotalSnakes count snakes
  let TotalSnakes2 count snakes2
  let TotalCountSnakes TotalSnakes + TotalSnakes2
  check-collision
  eat

  ask snakes with [label = "snake1"][
  if heading = 0 and direction != "baixo"  [ ask snakes [ set direction "cima" ] ]
  if heading = 45 and direction != "esquerdabaixo"  [ ask snakes [ set direction "direitacima" ] ]
  if heading = 135 and direction != "esquerdacima"  [ ask snakes [ set direction "direitabaixo" ] ]
  if heading = 225 and direction != "direitacima"  [ ask snakes [ set direction "esquerdabaixo" ] ]
  if heading = 315 and direction != "direitabaixo"  [ ask snakes [ set direction "esquerdacima" ] ]
  if heading = 180 and direction != "cima"  [ ask snakes [ set direction "baixo" ] ]
  if heading = 270 and direction != "direita" [ ask snakes [ set direction "esquerda" ] ]
  if heading = 90 and direction != "esquerda" [ ask snakes [ set direction "direita" ] ]
  ]


  ask snakes2 with [label = "snake2"][
  if head = 0 and direction != "baixo"  [ ask snakes2 [ set direction "cima" ] ]
  if head = 45 and direction != "esquerdabaixo"  [ ask snakes2 [ set direction "direitacima" ] ]
  if head = 135 and direction != "esquerdacima"  [ ask snakes2 [ set direction "direitabaixo" ] ]
  if head = 225 and direction != "direitacima"  [ ask snakes2 [ set direction "esquerdabaixo" ] ]
  if head = 315 and direction != "direitabaixo"  [ ask snakes2 [ set direction "esquerdacima" ] ]
  if head = 180 and direction != "cima"  [ ask snakes2 [ set direction "baixo" ] ]
  if head = 270 and direction != "direita" [ ask snakes2 [ set direction "esquerda" ] ]
  if head = 90 and direction != "esquerda" [ ask snakes2 [ set direction "direita" ] ]
  ]


  move-snake


tick

end

to eat
  ask snakes [
    let eating one-of turtles in-radius 1 with [breed != snakes and breed != snakes2]

    if eating != nobody [
      set whoWas "s1"
      set x xcor
      set y ycor

      ifelse [shape] of eating = "apple" [
         sound:play-note "Kalimba" 60 64 1
        ifelse double-score-time > ticks [
          set snake-score snake-score + 2 * 50
          set score score + 2 * 50
          set speed speed + 0.01
          set score1 score1 + 2 * 50

        ] [
          set snake-score snake-score + 50
          set score1 score1 + 50
          set score score + 50

        ]
        ask turtles with [shape = "apple"] [die]
      ] [
        ifelse [shape] of eating = "strawberry" [
           sound:play-note "Kalimba" 60 64 1
          ifelse double-score-time > ticks [
            set snake-score snake-score + 2 * 100
            set score score + 2 * 100
            set speed speed + 0.01
            set score1 score1 + 2 * 100

          ] [
            set snake-score snake-score + 100
            set score1 score1 + 100
            set score score + 100

          ]
          ask turtles with [shape = "strawberry"] [die]
        ] [
          ifelse [shape] of eating = "star" [
            sound:play-note "Music Box" 60 64 1
            set double-score-time ticks + 900
            ask turtles with [shape = "star"] [die]
          ] [
          ifelse [shape] of eating = "spider" [
              sound:play-note "Clavi" 30 34 0.7
              set score score - 200
              set score1 score1 - 200
              set snake-score snake-score - 200

            ask turtles with [shape = "spider"] [die]
            if score1 < 0 [
                ask snakes with [color = black] [die]
            ]
            ][
            ifelse [shape] of eating = "ghost" [
                sound:play-note "Soundtrack" 60 64 1.3
            ask turtles with [shape = "ghost"] [die]
            ask snakes [
                  set color grey
                  set ticks-at-color-change ticks
                ]

              ][ifelse [shape] of eating = "x" [
                  sound:play-note "Chiff" 32 32 1.5
            ask turtles with [shape = "x"] [die]
                  let max-number-snake [number] of max-one-of snakes [number]

                  ask snakes with [number = max-number-snake]
                  [set alive 0

                    die]

              ][]]
            ]


          ]
        ]
      ]
    ]
  ]

  ask snakes2 [
    let eating one-of turtles in-radius 1 with [breed != snakes and breed != snakes2]

    if eating != nobody [
      set whoWas "s2"
      set sx xcor
      set sy ycor

      ifelse [shape] of eating = "apple" [
         sound:play-note "Kalimba" 60 64 1
        ifelse double-score-time > ticks [
          set snake-score snake-score + 2 * 50
          set score score + 2 * 50
          set score2 score2 + 2 * 50
          set speed speed + 0.01

        ] [
          set snake-score snake-score + 50
          set score2 score2 + 50
          set score score + 50

        ]
        ask turtles with [shape = "apple"] [die]
      ] [
        ifelse [shape] of eating = "strawberry" [
           sound:play-note "Kalimba" 60 64 1
          ifelse double-score-time > ticks [
            set snake-score snake-score + 2 * 100
            set score score + 2 * 100
            set score2 score2 + 2 * 100
            set speed speed + 0.01

          ] [
            set snake-score snake-score + 100
            set score2 score2 + 100
            set score score + 100

          ]
          ask turtles with [shape = "strawberry"] [die]
        ] [
          ifelse [shape] of eating = "star" [
            sound:play-note "Music Box" 60 64 1
            set double-score-time ticks + 900
            ask turtles with [shape = "star"] [die]
          ] [
          ifelse [shape] of eating = "spider" [
              sound:play-note "Clavi" 30 34 0.7
              set score score - 200
              set score2 score2 - 200
              set snake-score snake-score - 200

            ask turtles with [shape = "spider"] [die]
            if score2 < 0 [
              ask snakes2 with [color = red] [die]
            ]
            ][
            ifelse [shape] of eating = "ghost" [
                sound:play-note "Soundtrack" 60 64 1.3
            ask turtles with [shape = "ghost"] [die]
            ask snakes2 [
                  set color grey
                  set ticks-at-color-change ticks
                ]

              ][ifelse [shape] of eating = "x" [
                  sound:play-note "Chiff" 32 32 1.5
            ask turtles with [shape = "x"] [die]
                  let max-number-snake [number2] of max-one-of snakes2 [number2]

                  ask snakes2 with [number2 = max-number-snake]
                  [set alive 0

                    die]

              ][]]
            ]


          ]
        ]
      ]
    ]
  ]




  if double-score-time <= ticks [
    set double-score-time 0
  ]

if not any? turtles with [shape = "star" or shape = "spider" or shape = "ghost" or shape = "x"] [

  ifelse time-power = 0 [

    set time-power ticks
  ][

    if ticks - time-power >= 450 [

      set time-power 0
      create-powers
    ]
  ]
]


if not any? turtles with [shape = "apple" or shape = "strawberry" ][



    if whoWas = "s1" [

    if [direction] of one-of snakes with [label = "snake1"] = "cima" [
        create-snakes 1 [
        set shape "square"
        set alive 1
        set color black
        if any? snakes with [color = grey and alive = 1] [
          set color grey
        ]

        set size 2
        set xcor x
        set ycor y - 2
        set heading 0
        set number snakenumber + 1
        set snakenumber number

      ]
    ]

    if [direction] of one-of snakes with [label = "snake1"] = "baixo" [
        create-snakes 1 [
        set shape "square"
        set alive 1
        set color black
        if any? snakes with [color = grey and alive = 1] [
          set color grey
        ]

        set size 2
        set xcor x
        set ycor y + 2
        set heading 0
        set number snakenumber + 1
        set snakenumber number

      ]
    ]

    if [direction] of one-of snakes with [label = "snake1"] = "esquerda" [
        create-snakes 1 [
        set shape "square"
        set alive 1
        set color black
        if any? snakes with [color = grey and alive = 1] [
          set color grey
        ]

        set size 2
        set xcor x + 2
        set ycor y
        set heading 0
        set number snakenumber + 1
        set snakenumber number

      ]
    ]

    if [direction] of one-of snakes with [label = "snake1"] = "direitacima" [
        create-snakes 1 [
        set shape "square"
        set alive 1
        set color black
        if any? snakes with [color = grey and alive = 1] [
          set color grey
        ]

        set size 2
        set xcor x - 2
        set ycor y - 2
        set heading 0
        set number snakenumber + 1
        set snakenumber number

      ]
    ]

    if [direction] of one-of snakes with [label = "snake1"] = "direitabaixo" [
        create-snakes 1 [
        set shape "square"
        set alive 1
        set color black
        if any? snakes with [color = grey and alive = 1] [
          set color grey
        ]

        set size 2
        set xcor x - 2
        set ycor y + 2
        set heading 0
        set number snakenumber + 1
        set snakenumber number

      ]
    ]

    if [direction] of one-of snakes with [label = "snake1"] = "esquerdacima" [
        create-snakes 1 [
        set shape "square"
        set alive 1
        set color black
        if any? snakes with [color = grey and alive = 1] [
          set color grey
        ]

        set size 2
        set xcor x + 2
        set ycor y - 2
        set heading 0
        set number snakenumber + 1
        set snakenumber number

      ]
    ]

    if [direction] of one-of snakes with [label = "snake1"] = "esquerdabaixo" [
        create-snakes 1 [
        set shape "square"
        set alive 1
        set color black
        if any? snakes with [color = grey and alive = 1] [
          set color grey
        ]

        set size 2
        set xcor x + 2
        set ycor y + 2
        set heading 0
        set number snakenumber + 1
        set snakenumber number

      ]
    ]

    if [direction] of one-of snakes with [label = "snake1"] = "direita" [
        create-snakes 1 [
        set shape "square"
        set alive 1
        set color black
        if any? snakes with [color = grey and alive = 1] [
          set color grey
        ]

        set size 2
        set xcor x - 2
        set ycor y
        set heading 0
        set number snakenumber + 1
        set snakenumber number

      ]
    ]
      create-fruit
    ]






    if whoWas = "s2" [
    if [direction] of one-of snakes2 with [label = "snake2"] = "cima" [
        create-snakes2 1 [
        set shape "square"
        set alive 1
        set color red
        if any? snakes2 with [color = grey and alive = 1] [
          set color grey
        ]

        set size 2
        set xcor sx
        set ycor sy - 2
        set heading 0
        set number2 snakenumber2 + 1
        set snakenumber2 number2

      ]
    ]

    if [direction] of one-of snakes2 with [label = "snake2"] = "baixo" [
        create-snakes2 1 [
        set shape "square"
        set alive 1
        set color red
        if any? snakes2 with [color = grey and alive = 1] [
          set color grey
        ]

        set size 2
        set xcor sx
        set ycor sy + 2
        set heading 0
        set number2 snakenumber2 + 1
        set snakenumber2 number2

      ]
    ]

    if [direction] of one-of snakes2 with [label = "snake2"] = "esquerda" [
        create-snakes2 1 [
        set shape "square"
        set alive 1
        set color red
        if any? snakes2 with [color = grey and alive = 1] [
          set color grey
        ]

        set size 2
        set xcor sx + 2
        set ycor sy
        set heading 0
        set number2 snakenumber2 + 1
        set snakenumber2 number2

      ]
    ]

    if [direction] of one-of snakes2 with [label = "snake2"] = "direitacima" [
        create-snakes2 1 [
        set shape "square"
        set alive 1
        set color red
        if any? snakes2 with [color = grey and alive = 1] [
          set color grey
        ]

        set size 2
        set xcor sx - 2
        set ycor sy - 2
        set heading 0
        set number2 snakenumber2 + 1
        set snakenumber2 number2

      ]
    ]

    if [direction] of one-of snakes2 with [label = "snake2"] = "direitabaixo" [
        create-snakes2 1 [
        set shape "square"
        set alive 1
        set color red
        if any? snakes2 with [color = grey and alive = 1] [
          set color grey
        ]

        set size 2
        set xcor sx - 2
        set ycor sy + 2
        set heading 0
        set number2 snakenumber2 + 1
        set snakenumber2 number2

      ]
    ]

    if [direction] of one-of snakes2 with [label = "snake2"] = "esquerdacima" [
        create-snakes2 1 [
        set shape "square"
        set alive 1
        set color red
        if any? snakes2 with [color = grey and alive = 1] [
          set color grey
        ]

        set size 2
        set xcor sx + 2
        set ycor sy - 2
        set heading 0
        set number2 snakenumber2 + 1
        set snakenumber2 number2

      ]
    ]

    if [direction] of one-of snakes2 with [label = "snake2"] = "esquerdabaixo" [
        create-snakes2 1 [
        set shape "square"
        set alive 1
        set color red
        if any? snakes2 with [color = grey and alive = 1] [
          set color grey
        ]

        set size 2
        set xcor sx + 2
        set ycor sy + 2
        set heading 0
        set number2 snakenumber2 + 1
        set snakenumber2 number2

      ]
    ]

    if [direction] of one-of snakes2 with [label = "snake2"] = "direita" [
        create-snakes2 1 [
        set shape "square"
        set alive 1
        set color red
        if any? snakes2 with [color = grey and alive = 1] [
          set color grey
        ]

        set size 2
        set xcor sx - 2
        set ycor sy
        set heading 0
        set number2 snakenumber2 + 1
        set snakenumber2 number2

      ]
    ]


     create-fruit
  ]
  ]





end


to check-collision
  ask turtles with [label = "snake1" and color = black] [
    let collision-patch patch-here

    if collision-patch != nobody and [pcolor] of collision-patch = white [
     ask snakes [
        die]

      stop
    ]

     let other-snakes other snakes with [number > 4] in-radius 0.9
  if any? other-snakes [
      ask snakes[
        die]
  ]


  ]

  ask turtles with [label = "snake2" and color = red] [
    let collision-patch patch-here

    if collision-patch != nobody and [pcolor] of collision-patch = white [
 ask snakes2 [
        die]

      stop
    ]



     let other-snakes2 other snakes2 with [number2 > 4] in-radius 0.9
  if any? other-snakes2 [
      ask snakes2
      [die]
  ]
  ]



  if not any? turtles with [label = "snake1"] and not any? turtles with [label = "snake2"] [
    Game-over
  ]

end




to Game-over
sound:play-note "Gunshot" 60 64 1.3
  if players = 1 [

 file-open "Recorde.txt"

    let conteudo file-read-line
  carefully [
    set valor-recorde read-from-string conteudo
    ] []


  ; Fechar o arquivo
 file-close

  if score > valor-recorde [

    file-delete "Recorde.txt"
    file-open "Recorde.txt"
    set valor-recorde score

    file-write score
    file-close
  ]

    if (score < 0)[
    set score 0
  ]
  user-message (word "Game Over! Pontuação: " score " | Recorde: " valor-recorde)

  ]


  if players = 2 [

 file-open "RecordeMultiplayer.txt"

let conteudo file-read-line
  carefully [
    set valor-recorde read-from-string conteudo
    ] []

  ; Fechar o arquivo
 file-close

  if score > valor-recorde [

    file-delete "RecordeMultiplayer.txt"
    file-open "RecordeMultiplayer.txt"
    set valor-recorde score

    file-write score
    file-close
  ]

    if (score < 0)[
    set score 0
  ]
  user-message (word "Game Over! Pontuação: " score " | Recorde Multiplayer: " valor-recorde)

  ]








end
@#$#@#$#@
GRAPHICS-WINDOW
370
64
904
599
-1
-1
12.83
1
10
1
1
1
0
1
1
1
-20
20
-20
20
1
1
1
ticks
30.0

BUTTON
206
194
269
227
NIL
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

MONITOR
372
10
903
55
NIL
mensagem
17
1
11

MONITOR
1042
65
1146
110
Dificuldade
difficulty
17
1
11

MONITOR
918
65
1019
110
Pontuação
score
17
1
11

MONITOR
1171
64
1269
109
Nº Jogadores
players
17
1
11

BUTTON
288
194
351
227
NIL
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
207
254
270
287
W
set heading 0
NIL
1
T
TURTLE
NIL
W
NIL
NIL
1

BUTTON
131
303
192
336
A
set heading 270
NIL
1
T
TURTLE
NIL
A
NIL
NIL
1

BUTTON
288
303
347
336
D
set heading 90
NIL
1
T
TURTLE
NIL
D
NIL
NIL
1

BUTTON
206
353
269
386
S
set heading 180
NIL
1
T
TURTLE
NIL
S
NIL
NIL
1

MONITOR
920
139
1021
184
Tamanho Cobra 1
count snakes
17
1
11

MONITOR
1292
63
1403
108
Tempo Fantasma
Ghost-Time
17
1
11

BUTTON
289
253
348
286
E
set heading 45
NIL
1
T
TURTLE
NIL
E
NIL
NIL
1

BUTTON
286
352
348
385
X
set heading 135
NIL
1
T
TURTLE
NIL
X
NIL
NIL
1

BUTTON
131
352
191
385
Z
set heading 225
NIL
1
T
TURTLE
NIL
Z
NIL
NIL
1

BUTTON
133
253
190
286
Q
set heading 315
NIL
1
T
TURTLE
NIL
Q
NIL
NIL
1

BUTTON
285
453
349
486
O
set head 45
NIL
1
T
TURTLE
NIL
O
NIL
NIL
1

BUTTON
284
512
350
545
L
set head 90
NIL
1
T
TURTLE
NIL
L
NIL
NIL
1

BUTTON
207
453
272
486
I
set head 0
NIL
1
T
TURTLE
NIL
I
NIL
NIL
1

BUTTON
283
561
347
594
,
set head 135
NIL
1
T
TURTLE
NIL
,
NIL
NIL
1

BUTTON
203
560
271
593
K
set head 180
NIL
1
T
TURTLE
NIL
K
NIL
NIL
1

BUTTON
130
560
187
593
M
set head 225
NIL
1
T
TURTLE
NIL
M
NIL
NIL
1

BUTTON
131
512
189
545
J
set head 270
NIL
1
T
TURTLE
NIL
J
NIL
NIL
1

BUTTON
130
453
190
486
U
set head 315
NIL
1
T
TURTLE
NIL
U
NIL
NIL
1

MONITOR
1169
141
1271
186
Tamanho Cobra 2
count snakes2
17
1
11

PLOT
925
248
1399
501
Pontuação
Tempo
Pontos
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 0 -16777216 true "" "plot score1"
"pen-1" 1.0 0 -2674135 true "" "plot score2"

MONITOR
1043
140
1151
185
Pontuação Cobra 1
score1
17
1
11

MONITOR
1294
141
1402
186
Pontuação Cobra 2
score2
17
1
11

@#$#@#$#@
## WHAT IS IT?

(a general understanding of what the model is trying to show or explain)

## HOW IT WORKS

(what rules the agents use to create the overall behavior of the model)

## HOW TO USE IT

(how to use the model, including a description of each of the items in the Interface tab)

## THINGS TO NOTICE

(suggested things for the user to notice while running the model)

## THINGS TO TRY

(suggested things for the user to try to do (move sliders, switches, etc.) with the model)

## EXTENDING THE MODEL

(suggested things to add or change in the Code tab to make the model more complicated, detailed, accurate, etc.)

## NETLOGO FEATURES

(interesting or unusual features of NetLogo that the model uses, particularly in the Code tab; or where workarounds were needed for missing features)

## RELATED MODELS

(models in the NetLogo Models Library and elsewhere which are of related interest)

## CREDITS AND REFERENCES

(a reference to the model's URL on the web if it has one, as well as any other necessary credits, citations, and links)
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

acorn
false
0
Polygon -7500403 true true 146 297 120 285 105 270 75 225 60 180 60 150 75 105 225 105 240 150 240 180 225 225 195 270 180 285 155 297
Polygon -6459832 true false 121 15 136 58 94 53 68 65 46 90 46 105 75 115 234 117 256 105 256 90 239 68 209 57 157 59 136 8
Circle -16777216 false false 223 95 18
Circle -16777216 false false 219 77 18
Circle -16777216 false false 205 88 18
Line -16777216 false 214 68 223 71
Line -16777216 false 223 72 225 78
Line -16777216 false 212 88 207 82
Line -16777216 false 206 82 195 82
Line -16777216 false 197 114 201 107
Line -16777216 false 201 106 193 97
Line -16777216 false 198 66 189 60
Line -16777216 false 176 87 180 80
Line -16777216 false 157 105 161 98
Line -16777216 false 158 65 150 56
Line -16777216 false 180 79 172 70
Line -16777216 false 193 73 197 66
Line -16777216 false 237 82 252 84
Line -16777216 false 249 86 253 97
Line -16777216 false 240 104 252 96

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

apple
false
0
Polygon -7500403 true true 33 58 0 150 30 240 105 285 135 285 150 270 165 285 195 285 255 255 300 150 268 62 226 43 194 36 148 32 105 35
Line -16777216 false 106 55 151 62
Line -16777216 false 157 62 209 57
Polygon -6459832 true false 152 62 158 62 160 46 156 30 147 18 132 26 142 35 148 46
Polygon -16777216 false false 132 25 144 38 147 48 151 62 158 63 159 47 155 30 147 18

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

ghost
false
0
Polygon -7500403 true true 30 165 13 164 -2 149 0 135 -2 119 0 105 15 75 30 75 58 104 43 119 43 134 58 134 73 134 88 104 73 44 78 14 103 -1 193 -1 223 29 208 89 208 119 238 134 253 119 240 105 238 89 240 75 255 60 270 60 283 74 300 90 298 104 298 119 300 135 285 135 285 150 268 164 238 179 208 164 208 194 238 209 253 224 268 239 268 269 238 299 178 299 148 284 103 269 58 284 43 299 58 269 103 254 148 254 193 254 163 239 118 209 88 179 73 179 58 164
Line -16777216 false 189 253 215 253
Circle -16777216 true false 102 30 30
Polygon -16777216 true false 165 105 135 105 120 120 105 105 135 75 165 75 195 105 180 120
Circle -16777216 true false 160 30 30

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

spider
true
0
Polygon -7500403 true true 134 255 104 240 96 210 98 196 114 171 134 150 119 135 119 120 134 105 164 105 179 120 179 135 164 150 185 173 199 195 203 210 194 240 164 255
Line -7500403 true 167 109 170 90
Line -7500403 true 170 91 156 88
Line -7500403 true 130 91 144 88
Line -7500403 true 133 109 130 90
Polygon -7500403 true true 167 117 207 102 216 71 227 27 227 72 212 117 167 132
Polygon -7500403 true true 164 210 158 194 195 195 225 210 195 285 240 210 210 180 164 180
Polygon -7500403 true true 136 210 142 194 105 195 75 210 105 285 60 210 90 180 136 180
Polygon -7500403 true true 133 117 93 102 84 71 73 27 73 72 88 117 133 132
Polygon -7500403 true true 163 140 214 129 234 114 255 74 242 126 216 143 164 152
Polygon -7500403 true true 161 183 203 167 239 180 268 239 249 171 202 153 163 162
Polygon -7500403 true true 137 140 86 129 66 114 45 74 58 126 84 143 136 152
Polygon -7500403 true true 139 183 97 167 61 180 32 239 51 171 98 153 137 162

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

strawberry
false
0
Polygon -7500403 false true 149 47 103 36 72 45 58 62 37 88 35 114 34 141 84 243 122 290 151 280 162 288 194 287 239 227 284 122 267 64 224 45 194 38
Polygon -7500403 true true 72 47 38 88 34 139 85 245 122 289 150 281 164 288 194 288 239 228 284 123 267 65 225 46 193 39 149 48 104 38
Polygon -10899396 true false 136 62 91 62 136 77 136 92 151 122 166 107 166 77 196 92 241 92 226 77 196 62 226 62 241 47 166 57 136 32
Polygon -16777216 false false 135 62 90 62 135 75 135 90 150 120 166 107 165 75 196 92 240 92 225 75 195 61 226 62 239 47 165 56 135 30
Line -16777216 false 105 120 90 135
Line -16777216 false 75 120 90 135
Line -16777216 false 75 150 60 165
Line -16777216 false 45 150 60 165
Line -16777216 false 90 180 105 195
Line -16777216 false 120 180 105 195
Line -16777216 false 120 225 105 240
Line -16777216 false 90 225 105 240
Line -16777216 false 120 255 135 270
Line -16777216 false 120 135 135 150
Line -16777216 false 135 210 150 225
Line -16777216 false 165 180 180 195

suit heart
false
0
Circle -7500403 true true 135 43 122
Circle -7500403 true true 43 43 122
Polygon -7500403 true true 255 120 240 150 210 180 180 210 150 240 146 135
Line -7500403 true 150 209 151 80
Polygon -7500403 true true 45 120 60 150 90 180 120 210 150 240 154 135

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.3.0
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
