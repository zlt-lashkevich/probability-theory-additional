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

= Упражнение: конкретные подпространства

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


#box(
  width: 100%,
  fill: rgb("#f0f0ff"),
  inset: 10pt,
  radius: 4pt,
)[
  *Главный вывод:*
  
  Всё строится на двух свойствах стандартного гауссовского вектора:
  
  + *Изотропия* $arrow.r$ $chi^2_d$ не зависит от выбора подпространства $V$
  + *Независимость ортогональных проекций* $arrow.r$ $chi^2$ в числителе и знаменателе $F$ независимы
  
  Из этого *автоматически* вытекают распределения
  $chi^2$, $F$, а также независимость $overline(Y)$ и $sum(Y_i - overline(Y))^2$.
]