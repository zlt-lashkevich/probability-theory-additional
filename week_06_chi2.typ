#import "@preview/cetz:0.4.2": canvas, draw

#set page(paper: "a4", margin: 25mm)
#set text(lang: "ru", font: "New Computer Modern", size: 11pt)
#set par(justify: true, leading: 0.65em)
#set heading(numbering: none)

#align(center)[
  #text(size: 17pt, weight: "bold")[Хи-квадрат и F-распределение из проекций]
  #v(0.3em)
  #text(size: 11pt)[Ортогональные проекции гауссовского вектора, $chi^2_d$ и $F(d_1, d_2)$]
]

#v(1em)

= Напоминание: два ключевых свойства нормали

#box(
  width: 100%,
  fill: rgb("#e8f4f8"),
  inset: 12pt,
  radius: 4pt,
)[
  Пусть $bold(Y) tilde cal(N)(bold(0), sigma^2 bold(I)_n)$ — изотропный гауссов вектор.
  
  + Распределение $bold(Y)$ инвариантно к поворотам (ортогональным преобразованиям)
  + Проекции на ортогональные подпространства *независимы*
]

= Линейная алгебра: проекция на подпространство

== Оператор проекции

Пусть $V subset.eq RR^n$ — линейное подпространство размерности $d$,
а $bold(A)$ — матрица $n times d$, столбцы которой образуют *базис* $V$.

Оператор ортогональной проекции на $V$:
$
bold(P)_V = bold(A)(bold(A)^top bold(A))^(-1) bold(A)^top
$

*Свойства:*
- $bold(P)_V^2 = bold(P)_V$ (идемпотентность)
- $bold(P)_V^top = bold(P)_V$ (симметричность)
- $"tr"(bold(P)_V) = d = dim V$
- $bold(P)_(V^perp) = bold(I) - bold(P)_V$

== Разложение вектора

Любой вектор $bold(y) in RR^n$ разлагается:
$
bold(y) = underbrace(bold(P)_V bold(y), "Proj"(bold(y), V)) + underbrace((bold(I) - bold(P)_V) bold(y), "Proj"(bold(y), V^perp))
$

По свойству (2): если $bold(Y) tilde cal(N)(bold(0), sigma^2 bold(I))$, то
$bold(P)_V bold(Y)$ и $(bold(I) - bold(P)_V) bold(Y)$ *независимы*.

= Упражнение:

== Пункт а): $V = "Span"(bold(1))$, где $bold(1) = (1, 1, dots, 1)^top$

Базис: $bold(A) = bold(1)$ (один столбец). Тогда:

$
bold(P)_V = frac(bold(1) bold(1)^top, bold(1)^top bold(1)) = frac(1, n) bold(1) bold(1)^top
$

Проекция:
$
"Proj"(bold(Y), V) = bold(P)_V bold(Y) = frac(1, n) bold(1) bold(1)^top bold(Y) = frac(1, n) (sum_(i=1)^n Y_i) bold(1) = overline(Y) dot bold(1)
$

то есть вектор $(overline(Y), overline(Y), dots, overline(Y))^top$.

Ортогональная составляющая:
$
"Proj"(bold(Y), V^perp) = bold(Y) - overline(Y) dot bold(1) = (Y_1 - overline(Y), dots, Y_n - overline(Y))^top
$

#box(
  width: 100%,
  fill: rgb("#e8f8e8"),
  inset: 10pt,
  radius: 4pt,
)[
  *Вывод:* по аксиоме (2) выборочное среднее $overline(Y)$ и
  вектор отклонений $(Y_i - overline(Y))$ *независимы*.
]

== Пункт б): $W = "Span"((1, 2, 3, dots, n)^top)$

Базис: $bold(A) = (1, 2, dots, n)^top$. Тогда:

$
bold(P)_W = frac(bold(A) bold(A)^top, bold(A)^top bold(A)), quad
bold(A)^top bold(A) = sum_(i=1)^n i^2 = frac(n(n+1)(2n+1), 6)
$

Проекция:
$
"Proj"(bold(Y), W) = frac(sum_(i=1)^n i Y_i, sum_(i=1)^n i^2) dot bold(A)
$

Аналогично, $"Proj"(bold(Y), W)$ и $"Proj"(bold(Y), W^perp)$ *независимы*.

= Хи-квадрат распределение из проекции


Пусть $bold(Y) tilde cal(N)(bold(0), bold(I)_n)$ (стандартный, $sigma^2 = 1$).

Пусть $V$ — *неслучайное* подпространство размерности $d$.

Определим:
$
Q = ||"Proj"(bold(Y), V)||^2
$

#box(
  width: 100%,
  fill: rgb("#e8f4f8"),
  inset: 12pt,
  radius: 4pt,
)[
  *Утверждение:* $Q tilde chi^2_d$ (хи-квадрат с $d$ степенями свободы).
]

== Доказательство: $Q$ не зависит от выбора $V$

*Шаг 1: не зависит от конкретного $V$ (только от $d = dim V$).*

По свойству (1) распределение $bold(Y)$ инвариантно к поворотам.

Пусть $bold(U)$ — ортогональная матрица, переводящая $V$ в
$"Span"(bold(e)_1, dots, bold(e)_d)$.

Тогда $bold(U) bold(Y) tilde cal(N)(bold(0), bold(I))$ (то же распределение!), и
$
||"Proj"(bold(Y), V)||^2 = ||"Proj"(bold(U) bold(Y), bold(U) V)||^2 = sum_(i=1)^d (bold(U) bold(Y))_i^2 tilde sum_(i=1)^d Z_i^2
$
где $Z_i tilde cal(N)(0, 1)$ независимые.

*Шаг 2: не зависит от $n$ (размерности пространства).*

Сравним:

$V_1 = "Span"(bold(e)_1, bold(e)_2) subset.eq RR^4$:
$
||"Proj"(bold(Y), V_1)||^2 = Y_1^2 + Y_2^2
$

$V_2 = "Span"(bold(e)_1, bold(e)_2) subset.eq RR^5$:
$
||"Proj"(bold(Y), V_2)||^2 = Y_1^2 + Y_2^2
$

Добавление «лишних» координат не влияет.

== Применение к задаче

Для $V = "Span"(bold(1))$, $dim V = 1$:
$
||"Proj"(bold(Y), V)||^2 = n overline(Y)^2 tilde chi^2_1
$

Для $V^perp$, $dim V^perp = n-1$:
$
||"Proj"(bold(Y), V^perp)||^2 = sum_(i=1)^n (Y_i - overline(Y))^2 tilde chi^2_(n-1)
$

И они *независимы* (по свойству 2).

= Математическое ожидание $chi^2_d$

Выберем ОНБ $(bold(e)_1, dots, bold(e)_n)$ и разложим:
$
E[chi^2_d] = E[||"Proj"(bold(Y), V)||^2] = sum_(i=1)^d E["Proj"^2 (Y_i, bold(e)_i)]
$

Каждое слагаемое — это $E[Z_i^2] = 1$ для $Z_i tilde cal(N)(0, 1)$.

#box(
  width: 100%,
  fill: rgb("#e8f8e8"),
  inset: 12pt,
  radius: 4pt,
)[
  $
  E[chi^2_d] = d
  $
]

= F-распределение из двух проекций

== Геометрическая картина

#align(center)[
#canvas(length: 1cm, {
  import draw: *

  // Оси (V и W)
  line((0, 0), (7, 0), mark: (end: "stealth"), stroke: (paint: red, thickness: 1pt))
  content((7.3, 0), text(fill: red)[$V$], anchor: "west")

  line((0, 0), (0, 5), mark: (end: "stealth"), stroke: (paint: blue, thickness: 1pt))
  content((0, 5.3), text(fill: blue)[$W$], anchor: "south")

  // Вектор Y
  line((0, 0), (5, 3.5), mark: (end: "stealth"), stroke: (thickness: 1.2pt))
  content((5.2, 3.7), $bold(Y)$, anchor: "west")

  // Проекции
  line((5, 3.5), (5, 0), stroke: (paint: red, dash: "dashed"))
  line((5, 3.5), (0, 3.5), stroke: (paint: blue, dash: "dashed"))

  circle((5, 0), radius: 0.06, fill: red)
  content((5, -0.3), text(size: 8pt, fill: red)[$"Proj"(bold(Y), V)$], anchor: "north")

  circle((0, 3.5), radius: 0.06, fill: blue)
  content((-0.3, 3.5), text(size: 8pt, fill: blue)[$"Proj"(bold(Y), W)$], anchor: "east")

  // Угол gamma
  let r = 1.2
  for i in range(0, 8) {
    let a1 = calc.atan2(5.0, 3.5) * i / 7
    let a2 = calc.atan2(5.0, 3.5) * (i + 1) / 7
    line(
      (r * calc.cos(a1 * 3.14159 / 180), r * calc.sin(a1 * 3.14159 / 180)),
      (r * calc.cos(a2 * 3.14159 / 180), r * calc.sin(a2 * 3.14159 / 180)),
      stroke: green + 0.6pt
    )
  }
  content((1.5, 0.7), text(size: 8pt, fill: green.darken(20%))[$gamma$])
})]

== Определение F-статистики

Пусть $V, W subset.eq RR^n$ — *ортогональные* неслучайные подпространства:
$V perp W$, $dim V = d_1$, $dim W = d_2$.

Определим:
$
F = frac(||"Proj"(bold(Y), V)||^2 \/ d_1, ||"Proj"(bold(Y), W)||^2 \/ d_2)
$

#box(
  width: 100%,
  fill: rgb("#e8f4f8"),
  inset: 12pt,
  radius: 4pt,
)[
  *Утверждение:*
  $
  F tilde F(d_1, d_2)
  $
  
  F-распределение Фишера с $d_1$ и $d_2$ степенями свободы.
]

== Обоснование

+ $||"Proj"(bold(Y), V)||^2 tilde chi^2_(d_1)$
+ $||"Proj"(bold(Y), W)||^2 tilde chi^2_(d_2)$
+ $V perp W$ $arrow.r.double$ по свойству (2) проекции *независимы*
+ По определению: $F(d_1, d_2) = frac(chi^2_(d_1)\/d_1, chi^2_(d_2)\/d_2)$ при независимых $chi^2$

== Геометрический смысл: угол $gamma$

Угол $gamma$ между $bold(Y)$ и подпространством $W$:

$
tan^2 gamma = frac(||"Proj"(bold(Y), V)||^2, ||"Proj"(bold(Y), W)||^2)
$

Тогда:
$
F = tan^2 gamma dot frac(d_2, d_1) = frac(||"Proj"(bold(Y), V)||^2 \/ d_1, ||"Proj"(bold(Y), W)||^2 \/ d_2)
$

#box(
  width: 100%,
  fill: rgb("#fff4e6"),
  inset: 10pt,
  radius: 4pt,
)[
  *Интерпретация:*
  
  $F$-статистика — это *нормированный тангенс* угла между
  случайным вектором и подпространством $W$,
  скорректированный на размерности подпространств.
  
  - $F approx 1$: проекции «пропорциональны» размерностям (нет эффекта)
  - $F >> 1$: $bold(Y)$ «слишком сильно» отклонился в сторону $V$ (значимый эффект)
]

#pagebreak()

#align(center)[
  #text(size: 17pt, weight: "bold")[Плотность $chi^2_d$]
  #v(0.3em)
  #text(size: 11pt)[Геометрия, вероятности с $o(h)$, дифференциальные формы]
]

#v(1em)

= Три языка описания плотности

#box(
  width: 100%,
  fill: rgb("#e8f4f8"),
  inset: 12pt,
  radius: 4pt,
)[
  + *Язык геометрических плотностей:* $f(t)$ — высота графика, строгие равенства
  + *Язык вероятностей с $o(h)$:* $P(X in [t, t+h]) approx.eq f(t) h$ (ultimately equal)
  + *Дифференциальные формы:* $d P(X <= t) = f(t) d t$ — строгие равенства
]

= Разминка: пример $f(t) = 2t$

Пусть $X$ имеет плотность:
$
f(t) = cases(2t comma & t in [0, 1], 0 comma & "иначе")
$

== График плотности

#align(center)[
#canvas(length: 1cm, {
  import draw: *

  grid((0, 0), (5, 3), step: 1, stroke: gray + 0.15pt)
  line((-0.3, 0), (5, 0), mark: (end: "stealth"))
  line((0, -0.3), (0, 3), mark: (end: "stealth"))
  content((5, 0), $t$, anchor: "west")
  content((0, 3), $f(t)$, anchor: "south")

  // f(t) = 2t на [0,1], масштаб: 1 ед = 3 см
  line((0, 0), (3, 2), stroke: (paint: blue, thickness: 1.2pt))
  line((3, 2), (3, 0), stroke: (paint: blue, dash: "dashed"))
  line((3, 0), (5, 0), stroke: (paint: blue, thickness: 1.2pt))

  content((1.5, 1.3), text(size: 9pt, fill: blue)[$f(t) = 2t$])
  content((3, -0.3), $1$, anchor: "north")
  content((-0.3, 2), $2$, anchor: "east")
})]

== Три описания одного и того же

*Язык 1 (геометрический):*
$
f(t) = 2t, quad integral_0^1 2t d t = 1
$

*Язык 2 (вероятности, ultimately equal):*

Введём обозначение: $A approx.eq B$ означает $lim_(h -> 0) A\/B = 1$.

$
P(X in [t, t+h]) = f(t) h + o(h) approx.eq f(t) h = 2t h
$

Проверка:
$
P(X in [t, t+h]) = 1/2(2t + 2(t+h)) h = 2t h + h^2 approx.eq 2t h checkmark
$

*Язык 3 (дифференциальные формы):*
$
d P(X <= t) = f(t) d t = 2t d t
$

Строгое равенство, без $o(h)$.

= Замена переменной: одномерный случай

== Задача: $Y = X^2$, найти $f_Y$

*Три способа вывести одну и ту же формулу.*

=== Способ 1 (CDF)

$
F_Y (y) = P(Y <= y) = P(X^2 <= y) = P(X <= sqrt(y)) = F_X (sqrt(y))
$

$
f_Y (y) = F_Y'(y) = f_X (sqrt(y)) dot 1/(2 sqrt(y))
$

Подставим $f_X (t) = 2t$:
$
f_Y (y) = 2 sqrt(y) dot 1/(2 sqrt(y)) = 1, quad y in [0, 1]
$

$arrow.r.double Y tilde U[0, 1]$

=== Способ 2 (ultimately equal)

$
P(Y in [y, y+h]) approx.eq P(X in [y^(1\/2), (y+h)^(1\/2)])
$

Разложим $(y+h)^(1\/2)$ по Тейлору:
$
(y+h)^(1\/2) = y^(1\/2) + 1/2 y^(-1\/2) h + O(h^2)
$

Длина интервала для $X$:
$
Delta x = 1/2 y^(-1\/2) h + O(h^2)
$

Тогда:
$
P(Y in [y, y+h]) approx.eq f_X (y^(1\/2)) dot 1/2 y^(-1\/2) dot h = 2 y^(1\/2) dot 1/2 y^(-1\/2) dot h = h
$

$arrow.r.double f_Y (y) = 1$ $checkmark$

=== Способ 3 (дифференциальные формы)

$
f_X (x) d x = 2x d x
$

Подставляем $x = sqrt(y)$, $d x = 1/(2 sqrt(y)) d y$:

$
2 sqrt(y) dot 1/(2 sqrt(y)) d y = 1 dot d y
$

$arrow.r.double f_Y (y) d y = 1 dot d y$ $checkmark$

== Общий рецепт (одномерный)

#box(
  width: 100%,
  fill: rgb("#e8f8e8"),
  inset: 12pt,
  radius: 4pt,
)[
  *Теорема.* Если $x = h(y)$ взаимно однозначно, то:
  
  + *Геометрически / CDF:* $f_Y (y) = f_X (h(y)) dot |h'(y)|$
  + *Ultimately equal:* $P(Y in [y, y+h]) approx.eq f_X (h(y)) dot |h'(y)| dot h$
  + *Дифф. формы:* $f_X (x) d x = f_X (h(y)) d(h(y)) = f_X (h(y)) h'(y) d y$
]

= Многомерный случай: внешнее произведение

== Определение и свойства

*Внешнее произведение* $d x_1 and d x_2$ — ориентированный элемент площади.

#box(
  width: 100%,
  fill: rgb("#e8f4f8"),
  inset: 12pt,
  radius: 4pt,
)[
  *Ключевые свойства:*
  
  + $d x and d y = -d y and d x$ (антикоммутативность)
  + $d x and d x = 0$ (следствие из 1)
  + $(a d x + b d y) and d z = a (d x and d z) + b (d y and d z)$ (линейность)
]

== Геометрический смысл

#align(center)[
#canvas(length: 1cm, {
  import draw: *

  // Параллелограмм
  line((0, 0), (3, 0.5), stroke: red + 1pt)
  line((0, 0), (1, 2.5), stroke: blue + 1pt)
  line((3, 0.5), (4, 3), stroke: blue + 0.5pt)
  line((1, 2.5), (4, 3), stroke: red + 0.5pt)

  content((1.5, -0.1), text(size: 8pt, fill: red)[$d x_1$], anchor: "north")
  content((-0.3, 1.2), text(size: 8pt, fill: blue)[$d x_2$], anchor: "east")
  content((2, 1.5), text(size: 9pt)[$d x_1 and d x_2$])
  content((2, 1), text(size: 8pt)[= площадь])
})]

$d x_1 and d x_2$ = ориентированная площадь параллелограмма,
натянутого на $d x_1$ и $d x_2$.

== Замена переменных в многомерном случае

Если $(x_1, x_2) arrow.r (y_1, y_2)$, то:

$
d x_1 and d x_2 = det mat(
  (partial x_1)/(partial y_1), (partial x_1)/(partial y_2);
  (partial x_2)/(partial y_1), (partial x_2)/(partial y_2)
) d y_1 and d y_2
$

или короче:
$
d x_1 and d x_2 = |J| d y_1 and d y_2
$

где $J$ — якобиан перехода.

*Три языка (многомерный аналог):*

+ $f_Y (y_1, y_2) = f_X (x_1(y), x_2(y)) dot |J|$
+ $P(bold(Y) in [y, y + h]) approx.eq f_X dot |J| dot h_1 h_2$
+ $f_X d x_1 and d x_2 = f_X |J| d y_1 and d y_2$

= Упражнение: две экспоненты

== Постановка

$X_1, X_2 tilde "Exp"(lambda = 1)$ независимые.

Совместная плотность:
$
f_(X_1, X_2)(x_1, x_2) d x_1 and d x_2 = e^(-x_1) e^(-x_2) d x_1 and d x_2
$

== Замена переменных

$
y_1 = x_1 / (x_1 + x_2), quad y_2 = x_1 + x_2
$

Обратная замена:
$
x_1 = y_1 y_2, quad x_2 = y_2(1 - y_1)
$

== Якобиан (через дифференциальные формы)

$
d x_1 = y_2 d y_1 + y_1 d y_2
$
$
d x_2 = -y_2 d y_1 + (1 - y_1) d y_2
$

Внешнее произведение:
$
d x_1 and d x_2 &= (y_2 d y_1 + y_1 d y_2) and (-y_2 d y_1 + (1-y_1) d y_2) \
&= y_2(1-y_1) d y_1 and d y_2 + y_1 (-y_2) d y_2 and d y_1 \
&= y_2(1-y_1) d y_1 and d y_2 + y_1 y_2 d y_1 and d y_2 \
&= y_2 d y_1 and d y_2
$

(использовали $d y_2 and d y_1 = -d y_1 and d y_2$ и $d y_1 and d y_1 = 0$)

== Плотность в новых координатах

$
f_Y d y_1 and d y_2 &= e^(-x_1) e^(-x_2) d x_1 and d x_2 \
&= e^(-y_1 y_2) e^(-y_2(1-y_1)) dot y_2 d y_1 and d y_2 \
&= y_2 e^(-y_2) d y_1 and d y_2
$

#box(
  width: 100%,
  fill: rgb("#e8f8e8"),
  inset: 12pt,
  radius: 4pt,
)[
  *Результат:*
  $
  f_Y (y_1, y_2) = y_2 e^(-y_2), quad y_1 in [0, 1], quad y_2 > 0
  $
  
  Это *произведение*:
  - $f_(Y_1)(y_1) = 1$ на $[0, 1]$ $arrow.r$ $Y_1 tilde U[0, 1]$
  - $f_(Y_2)(y_2) = y_2 e^(-y_2)$ $arrow.r$ $Y_2 tilde "Gamma"(2, 1)$
  
  И $Y_1$, $Y_2$ *независимы*!
]

== Проверка (ultimately equal)

$
P(Y_1 in [y_1, y_1 + h_1], Y_2 in [y_2, y_2 + h_2])
$
$
approx.eq f_X (y_1 y_2, y_2(1-y_1)) dot y_2 dot h_1 h_2 = y_2 e^(-y_2) h_1 h_2 checkmark
$
  
Дифференциальные формы — самый компактный язык: якобиан «выпадает» автоматически из правил $d x and d x = 0$, $d x and d y = -d y and d x$