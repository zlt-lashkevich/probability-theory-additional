#set document(title: "Геометрический вывод константы нормального распределения")
#set page(paper: "a4", margin: 2cm)
#set text(lang: "ru", font: "New Computer Modern", size: 11pt)
#set par(justify: true, leading: 0.65em)
#show selector(<nonumber>): set heading(numbering: none)

#import "@preview/cetz:0.4.2": canvas, draw

#align(center)[
  #text(size: 16pt, weight: "bold")[
    Нормальное распределение: продвинутые методы
  ]
  #v(0.5em)
  #text(size: 12pt)[Метод Мамикона, Аксиома Эрмита–Максвелла, метод Кавальери, лемма Штейна]
]

#v(1em)

= Свойства экспоненты


#box(
  width: 100%,
  fill: rgb("#e8f4f8"),
  inset: 12pt,
  radius: 4pt,
)[
  *Определяющие свойства $e^x$:*
  
  1. $e^0 = 1$ (нормировка)
  2. $(e^x)' = e^x$ (производная равна самой себе)
  3. *Площадь под касательной всегда равна 1* (геометрическое свойство)
]

=== Вывод третьего свойства

Касательная к $y = e^x$ в точке $(a, e^a)$:

$ y - e^a = e^a (x - a) quad => quad y = e^a (x - a + 1) $

*Точка пересечения с осью $x$:*

$ 0 = e^a (x - a + 1) quad => quad x = a - 1 $

#box(
  width: 100%,
  fill: rgb("#fff4e6"),
  inset: 10pt,
  radius: 4pt,
)[
  *Замечательный факт:* Касательная *всегда* пересекает ось $x$ ровно на 1 левее точки касания!
  
  Проекция касательной на ось $x$: от $(a-1)$ до $a$ = длина 1.
]

== График экспоненты с касательной

#align(center)[
#canvas(length: 1cm, {
  import draw: *
  
  line((-1, 0), (5, 0), stroke: black, mark: (end: ">"))
  line((0, -0.5), (0, 5), stroke: black, mark: (end: ">"))
  content((5.3, 0), [$x$])
  content((0, 5.3), [$y$])
  
  let exp_points = ()
  for i in range(-10, 35) {
    let x = i / 10
    let y = calc.exp(x)
    if y < 5 {
      exp_points.push((x, y))
    }
  }
  line(..exp_points, stroke: blue + 2pt)
  
  let a = 1
  let ea = calc.exp(1)
  circle((a, ea), radius: 0.08, fill: red)
  content((a + 0.3, ea + 0.3), [$A = (a, e^a)$])
  
  line((a - 1, 0), (a + 0.8, ea + 0.8 * ea), stroke: red + 1.5pt)
  
  circle((a - 1, 0), radius: 0.08, fill: green)
  content((a - 1, -0.4), [$a-1$])
  
  line((a, 0), (a, ea), stroke: gray + 1pt, stroke-dasharray: (4, 4))
  content((a, -0.4), [$a$])
  
  fill(rgb("#ffcccc").transparentize(50%))
  stroke(none)
  line((a - 1, 0), (a, 0), (a, ea), close: true)
  
  content((a - 0.3, ea / 3), [$S = 1/2 dot 1 dot e^a$])
  
  line((a - 1, -0.2), (a, -0.2), stroke: green + 1pt, mark: (start: "|", end: "|"))
  content((a - 0.5, -0.5), [длина $= 1$], fill: green)
})
]

#box(
  width: 100%,
  fill: rgb("#e8f8e8"),
  inset: 10pt,
  radius: 4pt,
)[
  *Площадь треугольника под касательной:*
  
  $ S = 1/2 dot "основание" dot "высота" = 1/2 dot 1 dot e^a = e^a / 2 $
  
  Площадь *не* константа, но *проекция основания* всегда равна 1
]

#pagebreak()

= Метод Мамикона Мнацаканяна

#box(
  width: 100%,
  fill: rgb("#e8f4f8"),
  inset: 12pt,
  radius: 4pt,
)[
  *Основная идея:*
  
  Если взять все касательные к кривой и *перенести их параллельно*, так чтобы они выходили из одной точки, то *площадь сохраняется*.
  
  Ключевое наблюдение: при таком переносе важен только *угол* наклона и *длина* касательной, а не её положение.
]

== Пример с окружностью

#align(center)[
#canvas(length: 0.8cm, {
  import draw: *
  
  group({
    circle((0, 0), radius: 2, stroke: blue + 1.5pt)
    content((0, -3), [*Оригинальная кривая*])
    
    let n = 8
    for i in range(n) {
      let angle = i * 360 / n
      let x1 = 2 * calc.cos(angle * calc.pi / 180)
      let y1 = 2 * calc.sin(angle * calc.pi / 180)
      let tx = -calc.sin(angle * calc.pi / 180)
      let ty = calc.cos(angle * calc.pi / 180)
      line((x1, y1), (x1 + tx, y1 + ty), stroke: red + 1pt)
    }
  })
  
  content((4, 0), [$arrow.r.double$], size: 20pt)
  
  group({
    translate((8, 0))
    
    circle((0, 0), radius: 0.1, fill: black)
    
    let n = 8
    for i in range(n) {
      let angle = i * 360 / n
      let tx = calc.cos(angle * calc.pi / 180)
      let ty = calc.sin(angle * calc.pi / 180)
      line((0, 0), (tx, ty), stroke: red + 1pt)
    }
    
    circle((0, 0), radius: 1, stroke: green + 2pt, stroke-dasharray: (4, 4))
    content((0, -3), [*Собранные касательные*])
    content((0, -3.7), [(образуют окружность)])
  })
})
]

#box(
  width: 100%,
  fill: rgb("#fff4e6"),
  inset: 10pt,
  radius: 4pt,
)[
  *Ключевой принцип:* Если касательные к кривой имеют постоянную длину $R$, то при сборе в одну точку они образуют *окружность радиуса $R$*.
  
  Площадь, "заметаемая" касательными = $pi R^2$
]

== Дискретизация: ломаная вместо кривой

#align(center)[
#canvas(length: 0.7cm, {
  import draw: *
  
  let points = ((0, 0), (1, 1), (2.5, 1.5), (4, 1.2), (5, 0.5), (6, 0))
  
  line(..points, stroke: blue + 2pt)
  
  for i in range(points.len() - 1) {
    let (x1, y1) = points.at(i)
    let (x2, y2) = points.at(i + 1)
    let dx = x2 - x1
    let dy = y2 - y1
    let len = calc.sqrt(dx*dx + dy*dy)
    
    let px = -dy / len
    let py = dx / len
    line((x1, y1), (x1 + px, y1 + py), stroke: red + 1.5pt)
  }
  
  content((3, -1), [Каждая "палка" параллельна следующему сегменту])
})
]

#box(
  width: 100%,
  fill: rgb("#e8f8e8"),
  inset: 10pt,
  radius: 4pt,
)[
  *Нюанс метода Мамикона:* 
  
  "Палка" (касательный отрезок) в каждой точке должна быть *параллельна кривой* в этой точке.
  
  При переносе палок в одну точку мы *не двигаем*, а только *поворачиваем* — это сохраняет площадь!
]

#pagebreak()

= Применение к экспоненте


#box(
  width: 100%,
  fill: rgb("#e8f4f8"),
  inset: 12pt,
  radius: 4pt,
)[
  == Геометрия касательных к $e^x$
  
  Если площадь под касательной к экспоненте в точке $(a, e^a)$ равна $S$, то при сборе *всех касательных левее* в точку $(a-1, 0)$ (точку пересечения с осью $x$), площадь *сохраняется*.
]

#align(center)[
#canvas(length: 0.9cm, {
  import draw: *
  
  line((-2, 0), (4, 0), stroke: black, mark: (end: ">"))
  line((0, -0.3), (0, 4), stroke: black, mark: (end: ">"))
  
  let exp_points = ()
  for i in range(-20, 20) {
    let x = i / 10
    let y = calc.exp(x)
    if y < 4 {
      exp_points.push((x, y))
    }
  }
  line(..exp_points, stroke: blue + 2pt)
  
  for a in (-1, -0.3, 0.4, 1) {
    let ea = calc.exp(a)
    if ea < 3.5 {
      line((a - 1, 0), (a + 0.3, ea + 0.3 * ea), stroke: red.transparentize(30%) + 1pt)
    }
  }
  
  let a0 = 1
  circle((a0 - 1, 0), radius: 0.1, fill: green)
  content((a0 - 1, -0.5), [Точка сбора])
  
  content((2.5, 3), [Касательные], fill: red)
})
]

== Принцип сохранения площади

#box(
  width: 100%,
  fill: rgb("#fff4e6"),
  inset: 12pt,
  radius: 4pt,
)[
  *Утверждение:*
  
  Если площадь под касательной равна $S$, то площадь, образованная при сборе всех предыдущих касательных в одну точку, равна $S/2$.
  
  *Причина:* При "сворачивании" касательных в веер из одной точки, площадь перераспределяется, и из-за свойств экспоненты получается коэффициент $1/2$.
]

#pagebreak()

= Задача: площадь под параболой


Найти площадь под параболой $y = x^2$ от $0$ до $x_0$ методом Мамикона.

=== Касательная к параболе

Касательная в точке $A = (x_0, x_0^2)$:

$ y = x_0^2 + 2x_0(x - x_0) = 2x_0 x - x_0^2 $

*Точка пересечения с осью $x$:*

$ 0 = 2x_0 x - x_0^2 quad => quad x = x_0 / 2 $

#box(
  width: 100%,
  fill: rgb("#e8f8e8"),
  inset: 10pt,
  radius: 4pt,
)[
  *Важное свойство:* Касательная делит отрезок $[0, x_0]$ *пополам* в точке $x_0/2$.
]


#align(center)[
#canvas(length: 1.2cm, {
  import draw: *
  
  line((-0.5, 0), (3.5, 0), stroke: black, mark: (end: ">"))
  line((0, -0.5), (0, 4.5), stroke: black, mark: (end: ">"))
  content((3.7, 0), [$x$])
  content((0, 4.7), [$y$])
  
  let x0 = 2
  let parab_points = ()
  for i in range(0, 25) {
    let x = i / 10
    let y = x * x
    parab_points.push((x, y))
  }
  line(..parab_points, stroke: blue + 2pt)
  content((2.3, 3.5), [$y = x^2$], fill: blue)
  
  circle((x0, x0*x0), radius: 0.07, fill: red)
  content((x0 + 0.3, x0*x0 + 0.2), [$A$])
  
  line((x0/2, 0), (x0 + 0.5, x0*x0 + (x0 + 0.5 - x0) * 2 * x0), stroke: red + 1.5pt)
  
  circle((x0/2, 0), radius: 0.07, fill: green)
  content((x0/2, -0.3), [$x_0/2$])
  
  circle((x0, 0), radius: 0.07, fill: black)
  content((x0, -0.3), [$x_0$])
  
  line((x0, 0), (x0, x0*x0), stroke: gray + 1pt, stroke-dasharray: (3, 3))
  
  fill(rgb("#ffcccc").transparentize(50%))
  stroke(none)
  line((x0/2, 0), (x0, 0), (x0, x0*x0), close: true)
  content((x0 - 0.3, 1.5), [$S_r$], fill: red)
  
  fill(rgb("#ccffcc").transparentize(50%))
  line((0, 0), ..parab_points.slice(0, 21), (x0, 0), close: true)
  content((0.8, 0.8), [$S_l$], fill: green)
})
]

== Вычисление площадей

*Площадь правого треугольника $S_r$:*

$ S_r = 1/2 dot "основание" dot "высота" = 1/2 dot x_0/2 dot x_0^2 = x_0^3/4 $

*Метод Мамикона: соотношение площадей*

#box(
  width: 100%,
  fill: rgb("#fff4e6"),
  inset: 12pt,
  radius: 4pt,
)[
  При сборе касательных к параболе в одну точку, получается подобная фигура.
  
  Касательная делит $[0, x_0]$ в отношении $1:1$.
  
  Коэффициент подобия для площадей: $(1/1)^2 = 1$... но с учётом "направления" получаем:
  
  $ 4 S_l = S_l + S_r $
  
  *Откуда:* $3 S_l = S_r$, то есть $S_l = S_r / 3$
]

*Система уравнений:*

$ S_r &= x_0^3 / 4 $
$ S_l &= S_r / 3 = x_0^3 / 12 $

*Полная площадь под параболой:*

$ S_l + S_r = x_0^3/12 + x_0^3/4 = x_0^3/12 + 3x_0^3/12 = 4x_0^3/12 = x_0^3/3 $

#box(
  width: 100%,
  fill: rgb("#e8f8e8"),
  inset: 12pt,
  radius: 4pt,
)[
  *Результат:*
  
  $ integral_0^(x_0) x^2 d x = x_0^3 / 3 quad checkmark $
]

// #pagebreak()

= Обобщение: площадь под $y = x^n$

== Касательная к $y = x^n$

В точке $(x_0, x_0^n)$:

$ y = x_0^n + n x_0^(n-1) (x - x_0) = n x_0^(n-1) x - (n-1) x_0^n $

*Пересечение с осью $x$:*

$ x = ((n-1) x_0^n) / (n x_0^(n-1)) = ((n-1)/n) x_0 $

#box(
  width: 100%,
  fill: rgb("#e8f4f8"),
  inset: 10pt,
  radius: 4pt,
)[
  *Точка пересечения делит отрезок $[0, x_0]$ в отношении $(n-1) : 1$*
]

== Пример: $y = x^5$

$ x_"пересеч" = 4/5 x_0 $

Отношение: $4x_0/5 : x_0/5 = 4 : 1$

*Отношение площадей (квадрат отношения длин):* $4^2 = 16$

#box(
  width: 100%,
  fill: rgb("#fff4e6"),
  inset: 10pt,
  radius: 4pt,
)[
  Если увеличить "радиус палки" в методе Мамикона в $a$ раз, площадь увеличится в $a^2$ раз.
]

== Общая формула

Для $y = x^n$ касательная делит отрезок в отношении $(n-1):1$.

$ 16 S_l = S_l + S_r quad ("для" n = 5) $

Отсюда: $S_l = S_r / 15$

В общем случае:

$ integral_0^(x_0) x^n d x = x_0^(n+1) / (n+1) $

= Аксиома Эрмита–Максвелла

#box(
  width: 100%,
  fill: rgb("#e8f4f8"),
  inset: 12pt,
  radius: 4pt,
)[
  *Аксиома Эрмита–Максвелла:*
  
  Пусть $(X, Y)$ — случайный вектор с совместной плотностью $f(x, y)$. Если выполнены два условия:
  
  1. $f(x, y)$ *инвариантна относительно поворотов* вокруг начала координат
  2. Проекции $(X, Y)^T$ на *любые ортогональные оси* независимы
  
  То $X$ и $Y$ имеют *нормальное распределение*.
]

== Условие 1: Инвариантность к поворотам

#box(
  width: 100%,
  fill: rgb("#fff4e6"),
  inset: 10pt,
  radius: 4pt,
)[
  *Геометрический смысл:*
  
  Плотность $f(x, y)$ зависит только от расстояния до начала координат:
  
  $ f(x, y) = g(sqrt(x^2 + y^2)) = g(r) $
  
  Линии уровня плотности — *концентрические окружности*.
]

#align(center)[
#canvas(length: 0.7cm, {
  import draw: *
  
  line((-4, 0), (4, 0), stroke: black, mark: (end: ">"))
  line((0, -4), (0, 4), stroke: black, mark: (end: ">"))
  content((4.3, 0), [$x$])
  content((0, 4.3), [$y$])
  
  for r in (0.7, 1.4, 2.1, 2.8) {
    circle((0, 0), radius: r, stroke: blue.transparentize(30%) + 1pt)
  }
  
  fill(rgb("#ccccff").transparentize(80%))
  circle((0, 0), radius: 0.7)
  
  line((0, 0), (2.1 * 0.707, 2.1 * 0.707), stroke: red + 1.5pt, mark: (end: ">"))
  content((1.8, 1.2), [$r$], fill: red)
  
  content((3, 3), [Линии уровня], fill: blue)
  content((3, 2.3), [$f(x,y) = g(r)$], fill: blue)
})
]

== Условие 2: Независимость проекций

#box(
  width: 100%,
  fill: rgb("#fff4e6"),
  inset: 10pt,
  radius: 4pt,
)[
  *Математически:*
  
  Для любого угла поворота $theta$, если
  
  $ X' = X cos theta + Y sin theta, quad Y' = -X sin theta + Y cos theta $
  
  то $X'$ и $Y'$ *независимы*.
  
  Это возможно только если $f(x,y) = h(x) dot h(y)$ — разделяется на множители.
]

== Вывод: почему именно нормальное распределение?

#box(
  width: 100%,
  fill: rgb("#f0f8ff"),
  inset: 12pt,
  radius: 4pt,
)[
  *Объединение условий:*
  
  Из условия 1: $f(x,y) = g(x^2 + y^2)$
  
  Из условия 2: $f(x,y) = h(x) dot h(y)$
  
  *Функциональное уравнение:*
  
  $ g(x^2 + y^2) = h(x) dot h(y) $
  
  *Единственное решение* (с точностью до констант):
  
  $ h(x) = C e^(-alpha x^2), quad g(r^2) = C^2 e^(-alpha r^2) $
]

Из рассказа о нормальном распределении (метод Гаусса) мы получили:

$ f(x, y) = c^2/sigma^2 exp(-(x^2 + y^2)/(2 sigma^2)) $



#box(
  width: 100%,
  fill: rgb("#e8f4f8"),
  inset: 12pt,
  radius: 4pt,
)[
  *Альтернативная формулировка*
  
  Для независимых одинаково распределённых случайных величин $X$ и $Y$, если их совместное распределение зависит *только от расстояния* $sqrt(X^2 + Y^2)$ до начала координат, то $X$ и $Y$ имеют *нормальное распределение*.
]


#pagebreak()

= Метод Кавальери

#box(
  width: 100%,
  fill: rgb("#e8f4f8"),
  inset: 10pt,
  radius: 4pt,
)[
  *Цель:* Вычислить интеграл Гаусса $integral_(-infinity)^(+infinity) e^(-x^2/2) d x$ геометрически
  
  *Для простоты:* Положим $sigma^2 = 1$
]


#box(
  width: 100%,
  fill: rgb("#fff4e6"),
  inset: 12pt,
  radius: 4pt,
)[
  == Принцип Кавальери
  Объём тела можно вычислить, интегрируя площади горизонтальных сечений
  
  $ V = integral_0^H S(h) d h $
  
  где $S(h)$ — площадь сечения на высоте $h$.
]

== Применение к гауссовой поверхности

Рассмотрим поверхность:

$ H(x, y) = exp(-(x^2 + y^2)/2) $

*Высота* $h$ изменяется от $0$ (на бесконечности) до $1$ (в центре)

*Сечение на высоте* $h$:

$ h = exp(-(x^2 + y^2)/2) $

$ ln h = -(x^2 + y^2)/2 $

$ x^2 + y^2 = -2 ln h = R^2 $

#box(
  width: 100%,
  fill: rgb("#e8f8e8"),
  inset: 10pt,
  radius: 4pt,
)[
  *Сечение на высоте $h$* — это *окружность* радиуса:
  
  $ R(h) = sqrt(-2 ln h) $
  
  *Площадь сечения:*
  
  $ S(h) = pi R^2 = pi (-2 ln h) = -2 pi ln h $
]

== Вычисление объёма

#align(center)[
#canvas(length: 0.8cm, {
  import draw: *
  
  // 3D вид гауссова колокола (схематично)
  line((0, 0), (0, 4), stroke: black, mark: (end: ">"))
  content((0.3, 4), [$h$])
  
  line((-3, 0), (3, 0), stroke: black)
  content((3.3, 0), [$x$])
  
  let bell_left = ()
  let bell_right = ()
  for i in range(0, 40) {
    let h = i / 40
    let r = if h > 0.01 { calc.sqrt(-2 * calc.ln(h)) } else { 3 }
    if r < 3 {
      bell_left.push((-r, h * 3))
      bell_right.push((r, h * 3))
    }
  }
  bell_left.push((0, 3))
  bell_right.push((0, 3))
  
  line(..bell_left, stroke: blue + 2pt)
  line(..bell_right, stroke: blue + 2pt)
  
  let h_sect = 0.5
  let r_sect = calc.sqrt(-2 * calc.ln(h_sect))
  line((-r_sect, h_sect * 3), (r_sect, h_sect * 3), stroke: red + 1.5pt)
  content((r_sect + 0.5, h_sect * 3), [$R(h)$], fill: red)
  
  content((-2.5, 1), [Сечение], fill: red)
  content((2, 2.5), [$H(x,y)$], fill: blue)
})
]

$ V = integral_0^1 S(h) d h = integral_0^1 (-2 pi ln h) d h = -2 pi integral_0^1 ln h space d h $

*Вычисление интеграла:*

$ integral_0^1 ln h space d h = [h ln h - h]_0^1 = (1 dot 0 - 1) - lim_(h -> 0^+) (h ln h - h) $

Используем $lim_(h -> 0^+) h ln h = 0$ (правило Лопиталя):

$ = (0 - 1) - (0 - 0) = -1 $

*Объём:*

$ V = -2 pi dot (-1) = 2 pi $

== Связь с интегралом Гаусса

#box(
  width: 100%,
  fill: rgb("#e8f4f8"),
  inset: 12pt,
  radius: 4pt,
)[
  *Объём под гауссовой поверхностью:*
  
  $ V = integral_(-infinity)^(+infinity) integral_(-infinity)^(+infinity) exp(-(x^2 + y^2)/2) d x d y $
  
  $ = (integral_(-infinity)^(+infinity) e^(-x^2/2) d x)^2 = I^2 = 2 pi $
  
  *Следовательно:*
  
  $ I = integral_(-infinity)^(+infinity) e^(-x^2/2) d x = sqrt(2 pi) $
]

== Нормировочная константа

#box(
  width: 100%,
  fill: rgb("#e8f8e8"),
  inset: 15pt,
  radius: 4pt,
)[
  #align(center)[
    *Константа нормального распределения:*
    
    $ c = 1/sqrt(2 pi) $
    
    *Плотность стандартного нормального распределения:*
    
    $ phi(x) = 1/sqrt(2 pi) e^(-x^2/2) $
  ]
]

#pagebreak()

= Лемма Штейна


#box(
  width: 100%,
  fill: rgb("#e8f4f8"),
  inset: 12pt,
  radius: 4pt,
)[
  == Формулировка
  
  Если $X tilde cal(N)(0, sigma^2)$ и $g$ — дифференцируемая функция с $EE[|g'(X)|] < infinity$, то:
  
  $ EE[X dot g(X)] = sigma^2 EE[g'(X)] $
]

== Доказательство через интегрирование

*Левая часть:*

$ EE[X dot g(X)] = integral_(-infinity)^(+infinity) x dot g(x) dot f(x) d x $

где $f(x) = 1/(sigma sqrt(2 pi)) exp(-x^2/(2 sigma^2))$

*Ключевое соотношение* (из вывода Гаусса):

$ x f(x) = -sigma^2 f'(x) $

*Подстановка:*

$ EE[X dot g(X)] = integral_(-infinity)^(+infinity) g(x) dot (-sigma^2 f'(x)) d x = -sigma^2 integral_(-infinity)^(+infinity) g(x) f'(x) d x $

*Интегрирование по частям:*

$ = -sigma^2 ([g(x) f(x)]_(-infinity)^(+infinity) - integral_(-infinity)^(+infinity) g'(x) f(x) d x) $

Граничный член: $[g(x) f(x)]_(-infinity)^(+infinity) = 0$ (экспоненциальное убывание $f$)

$ = -sigma^2 (0 - EE[g'(X)]) = sigma^2 EE[g'(X)] $

#box(
  width: 100%,
  fill: rgb("#e8f8e8"),
  inset: 12pt,
  radius: 4pt,
)[
  *Лемма Штейна доказана:*
  
  $ EE[X dot g(X)] = sigma^2 EE[g'(X)] $
]

== Частные случаи

*При $g(x) = 1$:*

$ EE[X dot 1] = sigma^2 EE[0] = 0 quad => quad EE[X] = 0 quad checkmark $

*При $g(x) = x$:*

$ EE[X^2] = sigma^2 EE[1] = sigma^2 quad checkmark $

*При $g(x) = x^(2k-1)$:*

$ EE[X^(2k)] = sigma^2 (2k-1) EE[X^(2k-2)] $

Это *рекуррентная формула для моментов*!

#pagebreak()

= Упражнения


#box(
  width: 100%,
  fill: rgb("#e8f4f8"),
  inset: 12pt,
  radius: 4pt,
)[
  == Исходные соотношения
  
  Для $X tilde cal(N)(0, sigma^2)$ с плотностью $f(x)$:
  
  1. $f(0) = 1/(sigma sqrt(2 pi))$
  
  2. $x f(x) = -sigma^2 f'(x)$ (ключевое соотношение)
  
  3. $f(x) = 1/(sigma sqrt(2 pi)) exp(-x^2/(2 sigma^2))$
]

== Упражнение 1:

*Задача:* Найти $EE[Y]$, где $Y = |X|$ для $X tilde cal(N)(0, sigma^2)$

*Решение:*

$ EE[|X|] = integral_(-infinity)^(+infinity) |x| f(x) d x $

По симметрии $f(-x) = f(x)$:

$ = 2 integral_0^(+infinity) x f(x) d x $

Используем $x f(x) = -sigma^2 f'(x)$:

$ = 2 integral_0^(+infinity) (-sigma^2 f'(x)) d x = -2 sigma^2 integral_0^(+infinity) f'(x) d x $

$ = -2 sigma^2 [f(x)]_0^(+infinity) = -2 sigma^2 (0 - f(0)) = 2 sigma^2 f(0) $

Подставляем $f(0) = 1/(sigma sqrt(2 pi))$:

$ EE[|X|] = 2 sigma^2 dot 1/(sigma sqrt(2 pi)) = (2 sigma)/sqrt(2 pi) = sigma sqrt(2/pi) $

#box(
  width: 100%,
  fill: rgb("#e8f8e8"),
  inset: 15pt,
  radius: 4pt,
)[
  #align(center)[
    *Ответ:*
    
    $ EE[|X|] = sigma sqrt(2/pi) approx 0.798 sigma $
  ]
]

*Проверка размерности:* $[EE[|X|]] = [sigma]$ ✓

*При $sigma = 1$:* $EE[|X|] = sqrt(2/pi) approx 0.798$

#pagebreak()

== Упражнение 2:

*Задача:* Найти точки перегиба функции плотности $f(x)$ для $X tilde cal(N)(0, sigma^2)$

*Решение:*

Точки перегиба — это точки, где $f''(x) = 0$.

*Найдём $f'(x)$*

Из $x f(x) = -sigma^2 f'(x)$:

$ f'(x) = -x/(sigma^2) f(x) $

*Найдём $f''(x)$*

$ f''(x) = d/ \dx (-x/(sigma^2) f(x)) = -1/(sigma^2) f(x) - x/(sigma^2) f'(x) $

$ = -1/(sigma^2) f(x) - x/(sigma^2) dot (-x/(sigma^2) f(x)) $

$ = -1/(sigma^2) f(x) + x^2/(sigma^4) f(x) $

$ = f(x) (x^2/(sigma^4) - 1/(sigma^2)) = f(x)/(sigma^4) (x^2 - sigma^2) $

*Решаем $f''(x) = 0$*

Поскольку $f(x) > 0$ всюду:

$ x^2 - sigma^2 = 0 quad => quad x = plus.minus sigma $

#box(
  width: 100%,
  fill: rgb("#e8f8e8"),
  inset: 15pt,
  radius: 4pt,
)[
  #align(center)[
    *Ответ:*
    
    Точки перегиба плотности нормального распределения:
    
    $ x = plus.minus sigma $
    
    То есть на расстоянии *одного стандартного отклонения* от среднего!
  ]
]


#align(center)[
#canvas(length: 1cm, {
  import draw: *
  
  line((-4, 0), (4, 0), stroke: black, mark: (end: ">"))
  line((0, -0.3), (0, 2.5), stroke: black, mark: (end: ">"))
  content((4.3, 0), [$x$])
  content((0, 2.7), [$f(x)$])
  
  let gauss_points = ()
  for i in range(-35, 36) {
    let x = i / 10
    let y = 2 * calc.exp(-x*x/2)
    gauss_points.push((x, y))
  }
  line(..gauss_points, stroke: blue + 2pt)
  
  let sigma = 1
  let y_infl = 2 * calc.exp(-0.5)
  
  circle((sigma, y_infl), radius: 0.1, fill: red)
  circle((-sigma, y_infl), radius: 0.1, fill: red)
  
  line((sigma, 0), (sigma, y_infl), stroke: red + 1pt, stroke-dasharray: (3, 3))
  line((-sigma, 0), (-sigma, y_infl), stroke: red + 1pt, stroke-dasharray: (3, 3))
  
  content((sigma, -0.3), [$sigma$])
  content((-sigma, -0.3), [$-sigma$])
  content((0, -0.3), [$0$])
  
  content((2.5, 1.5), [Точки перегиба], fill: red)
  line((2.3, 1.3), (sigma + 0.2, y_infl + 0.1), stroke: red + 0.5pt, mark: (end: ">"))
})
]

#box(
  width: 100%,
  fill: rgb("#fff4e6"),
  inset: 12pt,
  radius: 4pt,
)[
  *Геометрический смысл:*
  
  - При $|x| < sigma$: кривая *выпукла вверх* (вогнутая)
  - При $|x| > sigma$: кривая *выпукла вниз* (выпуклая)
  
  Точки $x = plus.minus sigma$ — это границы "центральной части" колокола, где кривизна меняет знак.
]


#v(1em)

#box(
  width: 100%,
  fill: rgb("#f0f8ff"),
  inset: 12pt,
  radius: 4pt,
)[
  *Ключевая идея:* Соотношение $x f(x) = -sigma^2 f'(x)$ — это *фундаментальное свойство* нормального распределения, из которого выводятся все остальные результаты:
  
#table(
  columns: 2,
  stroke: 0.5pt,
  inset: 10pt,
  align: (left, center),
  fill: (col, row) => { rgb("#e8f4f8") },
  
  [Интеграл Гаусса (метод Кавальери)], [$integral e^(-x^2/2) d x = sqrt(2 pi)$],
  
  [Константа нормировки], [$c = 1/sqrt(2 pi)$],
  
  [Лемма Штейна], [$EE[X g(X)] = sigma^2 EE[g'(X)]$],
  
  [$EE[|X|]$ для $X tilde cal(N)(0, sigma^2)$], [$sigma sqrt(2/pi)$],
  
  [Точки перегиба $f(x)$], [$x = plus.minus sigma$],
)
  
  Это соотношение — прямое следствие вывода Гаусса через метод максимального правдоподобия!
]
