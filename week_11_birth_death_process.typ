#set page(paper: "a4", margin: (top: 2cm, bottom: 2cm, left: 2cm, right: 2cm))
#set text(font: "New Computer Modern", size: 11pt, lang: "ru")
#set heading(numbering: none)
#set par(justify: true)

#show heading.where(level: 1): set text(size: 16pt, weight: "bold")
#show heading.where(level: 2): set text(size: 13pt, weight: "bold")
#show heading.where(level: 3): set text(size: 11pt, weight: "bold")
#import "@preview/cetz:0.4.2": canvas, draw

#let note-block(title, body) = block(
  width: 100%,
  fill: rgb("#E8F5E9"),
  radius: 6pt,
  inset: 12pt,
)[
  #text(weight: "bold", fill: rgb("#2E7D32"))[#title]
  #v(4pt)
  #body
]

#let idea-block(body) = block(
  width: 100%,
  fill: rgb("#E3F2FD"),
  radius: 6pt,
  inset: 12pt,
)[
  #body
]

#let warn-block(body) = block(
  width: 100%,
  fill: rgb("#FFF3E0"),
  radius: 6pt,
  inset: 12pt,
)[
  #text(weight: "bold", fill: rgb("#E65100"))[Важно:]
  #v(4pt)
  #body
]

#let answer-block(body) = block(
  width: 100%,
  fill: rgb("#FFFDE7"),
  radius: 6pt,
  inset: 12pt,
)[
  #text(weight: "bold", fill: rgb("#E65100"))[Ответ: ]
  #body
]

#let def-block(title, body) = block(
  width: 100%,
  fill: rgb("#F3E5F5"),
  radius: 6pt,
  inset: 12pt,
)[
  #text(weight: "bold", fill: rgb("#6A1B9A"))[#title]
  #v(4pt)
  #body
]

#let recall-block(body) = block(
  width: 100%,
  fill: rgb("#FCE4EC"),
  radius: 6pt,
  inset: 12pt,
)[
  #text(weight: "bold", fill: rgb("#AD1457"))[Напоминание:]
  #v(4pt)
  #body
]


#align(center)[
  #text(size: 20pt, weight: "bold")[
    Процессы рождения и гибели, производящие функции
  ]
]

#v(1em)

= Кусочек пазла 1: определение вероятности

== Четыре свойства вероятностной меры

#note-block("Аксиомы вероятности")[
  *1. Неотрицательность:*
  $
  bb(P)(A) >= 0 quad forall A in cal(F)
  $

  *2. Нормировка:*
  $
  bb(P)(Omega) = 1
  $

  *3. Счётная аддитивность:*

  Если $A_1, A_2, ...$ попарно не пересекаются ($A_i sect A_j = emptyset$ при $i eq.not j$), то:

  $
  bb(P)(union.big_(i=1)^infinity A_i) = sum_(i=1)^infinity bb(P)(A_i)
  $

  *4. Замкнутость относительно пределов:*

  Если $A_n arrow.t A$ (монотонно возрастающая последовательность), то:

  $
  bb(P)(A) = lim_(n -> infinity) bb(P)(A_n)
  $
]

=== Эквивалентная формулировка в терминах множеств

#idea-block[
  Свойства 1--3 эквивалентны следующему определению в терминах пределов множеств:

  Если $A_n$ --- последовательность событий, то:

  $
  liminf_(n -> infinity) A_n = union.big_(n=1)^infinity sect.big_(k=n)^infinity A_k
  $

  $
  limsup_(n -> infinity) A_n = sect.big_(n=1)^infinity union.big_(k=n)^infinity A_k
  $

  Если $lim A_n$ существует (верхний и нижний пределы совпадают), то:

  $
  bb(P)(lim_(n -> infinity) A_n) = lim_(n -> infinity) bb(P)(A_n)
  $

  Это свойство *непрерывности вероятностной меры* --- следствие счётной аддитивности.
]


= Кусочек пазла 2: деление амёб (Birth and Death Process)


#note-block("Условие: деление амёбы")[
  Одна амёба может:
  - *умереть* с вероятностью $p_0 = 1/4$
  - *разделиться на 2* с вероятностью $p_1 = 1/2$
  - *разделиться на 3* с вероятностью $p_2 = 1/4$

  Каждая дочерняя амёба ведёт себя точно так же, независимо от остальных.

  Обозначим $X_n$ --- количество амёб в поколении $n$. Начальное условие: $X_0 = 1$
]

// Это классический *процесс Гальтона--Ватсона* (branching process), частный случай процесса рождения и гибели (birth and death process).

Обозначим $Y$ --- число потомков одной амёбы:

$
bb(P)(Y = 0) = 1/4, quad bb(P)(Y = 2) = 1/2, quad bb(P)(Y = 3) = 1/4
$

== Рекурсивная структура

Если $X_n = k$, то в следующем поколении:

$
X_(n+1) = Y_1^((n)) + Y_2^((n)) + ... + Y_k^((n))
$

где $Y_i^((n))$ --- независимые копии $Y$ (число потомков $i$-й амёбы)

= Упражнение
== а) $bb(E)(X_n)$ 

=== Среднее число потомков одной амёбы

$
mu = bb(E)(Y) = 0 dot 1/4 + 2 dot 1/2 + 3 dot 1/4 = 0 + 1 + 3/4 = 7/4
$

=== Среднее в поколении $n$

Так как $X_(n+1) = sum_(i=1)^(X_n) Y_i$, по формуле полного математического ожидания:

$
bb(E)(X_(n+1)) = bb(E)[bb(E)(X_(n+1) | X_n)] = bb(E)[X_n dot mu] = mu dot bb(E)(X_n)
$

Это геометрическая прогрессия:

$
bb(E)(X_n) = mu^n dot bb(E)(X_0) = mu^n = (7/4)^n
$

#answer-block[
  $
  bb(E)(X_n) = (7/4)^n
  $
  Так как $mu = 7/4 > 1$, среднее число амёб экспоненциально растёт.
]
= б) Var($X_n$)

Прежде чем считать дисперсию и вероятность вымирания, сравним три основные производящие функции


#def-block("PGF - probability generating function")[
  Для целочисленной неотрицательной с.в. $Y$:

  $
  g_Y (t) = bb(E)(t^Y) = sum_(k=0)^infinity bb(P)(Y = k) t^k
  $

  Область сходимости: $|t| <= 1$
]

Свойства:

$
g_Y (1) = 1 quad "(нормировка)"  quad quad 
g'_Y (1) = bb(E)(Y)
$

$
g''_Y (1) = bb(E)[Y(Y-1)]
$

$
"Var"(Y) = g''_Y (1) + g'_Y (1) - (g'_Y (1))^2
$

#idea-block[
  PGF идеальна для целочисленных неотрицательных величин: дискретных подсчётов, ветвящихся процессов, числа потомков.
]

#def-block("MGF - moment generating function")[
  $
  m_Y (t) = bb(E)(e^(t Y))
  $

  Если существует в окрестности $t = 0$.
]

Свойства:

$
m_Y (0) = 1
$

$
m'_Y (0) = bb(E)(Y)
$

$
m''_Y (0) = bb(E)(Y^2)
$

Вообще:

$
m_Y^((n))(0) = bb(E)(Y^n)
$

#idea-block[
  MGF удобна для непрерывных величин и сумм независимых: $m_(X+Y)(t) = m_X(t) m_Y(t)$.

  Но может не существовать (например, для распределения Коши)
]

#def-block("characteristic function")[
  $
  c_Y (t) = bb(E)(e^(i t Y))
  $

  Всегда существует, $|c_Y(t)| <= 1$
]

Свойства:

$
c_Y (0) = 1
$

$
c'_Y (0) = i dot bb(E)(Y)
$

$
c''_Y (0) = i^2 dot bb(E)(Y^2) = -bb(E)(Y^2)
$

Вообще:

$
bb(E)(Y^n) = frac(1, i^n) c_Y^((n))(0)
$

#idea-block[
  ХФ всегда существует (в отличие от MGF) и однозначно определяет распределение. Это самый мощный инструмент, но вычисления используют комплексные числа.
]

// #table(
//   columns: (auto, auto, auto, auto),
//   align: (left, center, center, center),
//   stroke: 0.5pt,
//   table.header(
//     [*Свойство*],
//     [*PGF: $g(t)=bb(E)(t^Y)$*],
//     [*MGF: $m(t)=bb(E)(e^(t Y))$*],
//     [*ХФ: $c(t)=bb(E)(e^(i t Y))$*],
//   ),
//   [Существование], [всегда ($|t|<=1$)], [не всегда], [всегда],
//   [Нормировка], [$g(1)=1$], [$m(0)=1$], [$c(0)=1$],
//   [$bb(E)(Y)$], [$g'(1)$], [$m'(0)$], [$c'(0)/i$],
//   [$bb(E)(Y^2)$], [$g''(1)+g'(1)$], [$m''(0)$], [$-c''(0)$],
//   [Для сумм], [умножение PGF], [умножение MGF], [умножение ХФ],
//   [Лучше всего для], [дискретных, подсчётов], [непрерывных, моментов], [предельных теорем],
// )

= PGF для задачи об амёбах

== PGF числа потомков одной амёбы

$
g_Y (t) = bb(E)(t^Y)
= 1/4 t^0 + 1/2 t^2 + 1/4 t^3
= 1/4 + 1/2 t^2 + 1/4 t^3
$

== Производные

$
g'_Y (t) = t + 3/4 t^2, quad quad
g'_Y (1) = 1 + 3/4 = 7/4 = bb(E)(Y)
$

$
g''_Y (t) = 1 + 3/2 t, quad quad 
g''_Y (1) = 1 + 3/2 = 5/2 = bb(E)[Y(Y-1)]
$

$
bb(E)(Y^2) = g''_Y (1) + g'_Y (1) = 5/2 + 7/4 = 17/4
$

$
"Var"(Y) = bb(E)(Y^2) - (bb(E) Y)^2 = 17/4 - 49/16 = 68/16 - 49/16 = 19/16
$

= PGF для $X_n$

#idea-block[
  Ключевое наблюдение: PGF величины $X_n$ получается *вложением* PGF $n$ раз
]

Если $X_0 = 1$, то $X_1 = Y$ и:

$
g_(X_1)(t) = g_Y (t)
$

Для $X_2 = Y_1 + Y_2 + ... + Y_(X_1)$, где $Y_i$ независимы:

$
g_(X_2)(t)
= bb(E)(t^(X_2))
= bb(E)[bb(E)(t^(Y_1 + ... + Y_(X_1)) | X_1)]
$

При фиксированном $X_1 = k$:

$
bb(E)(t^(Y_1 + ... + Y_k)) = (g_Y (t))^k
$

Поэтому:

$
g_(X_2)(t)
= bb(E)[(g_Y (t))^(X_1)]
= g_(X_1)(g_Y (t))
= g_Y (g_Y (t))
$

Обозначим вложение:

$
g_Y^(circle.small n)(t) = underbrace(g_Y (g_Y (...g_Y (t)...)), n " раз")
$

Тогда:

$
g_(X_n)(t) = g_Y^(circle.small n)(t)
$

#answer-block[
  PGF числа амёб в поколении $n$:

  $
  g_(X_n)(t) = underbrace(g_Y (g_Y (...g_Y (t)...)), n " вложений")
  $
]

== Дисперсия через PGF

Из рекурсии $X_(n+1) = sum_(i=1)^(X_n) Y_i$ получаем формулу полной дисперсии:

$
"Var"(X_(n+1))
= bb(E)[X_n] dot "Var"(Y) + "Var"(X_n) dot (bb(E) Y)^2
$

Обозначим $v_n = "Var"(X_n)$:

$
v_(n+1) = mu^n dot sigma^2 + mu^2 dot v_n
$

где $mu = 7/4$, $sigma^2 = "Var"(Y) = 19/16$.

Это линейная рекуррентность с $v_0 = 0$ (начинаем с одной амёбы).

Решаем:

$
v_n = sigma^2 mu^(n-1) dot frac(mu^n - 1, mu^2 - 1) dot 1/mu
$

Упростим. Из стандартной формулы для ветвящихся процессов:

$
v_n = sigma^2 mu^(n-1) dot frac(mu^n - 1, mu - 1) quad "(при" mu eq.not 1")"
$

Подставим:

$
v_n = frac(19, 16) dot (7/4)^(n-1) dot frac((7/4)^n - 1, 7/4 - 1)
$

$
= frac(19, 16) dot (7/4)^(n-1) dot frac((7/4)^n - 1, 3/4)
$

$
= frac(19, 12) dot (7/4)^(n-1) dot ((7/4)^n - 1)
$

#answer-block[
  $
  "Var"(X_n) = frac(19, 12) dot (7/4)^(n-1) dot ((7/4)^n - 1)
  $

  При больших $n$: $"Var"(X_n) approx frac(19, 12) (7/4)^(2n-1)$, то есть дисперсия растёт как $mu^(2n)$
]

= Вероятность вымирания династии


Пусть $q$ --- вероятность того, что династия вымрет (рано или поздно все амёбы умрут).

$
q = bb(P)(X_n = 0 " для некоторого " n)
$

== Уравнение на $q$

#idea-block[
  Вероятность вымирания $q$ --- это наименьший неотрицательный корень уравнения

  $
  g_Y (q) = q
  $

  то есть неподвижная точка PGF.
]

=== Вывод уравнения

Рассмотрим первое поколение:
- с вероятностью $1/4$ амёба умирает: вымирание гарантировано (вклад $1/4$);
- с вероятностью $1/2$ амёба делится на 2: обе линии должны вымереть независимо (вклад $1/2 dot q^2$);
- с вероятностью $1/4$ амёба делится на 3: все три линии должны вымереть (вклад $1/4 dot q^3$).

Итого:

$
q = 1/4 + 1/2 q^2 + 1/4 q^3
$

Но это ровно:

$
q = g_Y (q)
$

== Решение уравнения

$
q = 1/4 + 1/2 q^2 + 1/4 q^3
$

Умножаем на 4:

$
4 q = 1 + 2 q^2 + q^3
$

$
q^3 + 2 q^2 - 4 q + 1 = 0
$

Заметим, что $q = 1$ --- всегда корень уравнения $g(q) = q$ (так как $g(1) = 1$).

Делим на $(q - 1)$:

$
q^3 + 2 q^2 - 4 q + 1 = (q - 1)(q^2 + 3 q - 1)
$

Проверка:

$
(q-1)(q^2+3q-1) = q^3+3q^2-q-q^2-3q+1 = q^3+2q^2-4q+1
$

Решаем $q^2 + 3q - 1 = 0$:

$
q = frac(-3 plus.minus sqrt(9+4), 2) = frac(-3 plus.minus sqrt(13), 2)
quad quad 
sqrt(13) approx 3.606
$

$
q_1 = frac(-3 + 3.606, 2) approx 0.303 quad quad 
q_2 = frac(-3 - 3.606, 2) approx -3.303
$

Второй корень отрицателен и не является вероятностью.

Итого три корня: $q approx 0.303$, $q = 1$, $q approx -3.303$


#idea-block[
  == Какой корень выбрать?
  
  Выбираем *наименьший неотрицательный корень* уравнения $g(q) = q$
]

#align(center)[
  #canvas(length: 1cm, {
    import draw: *

    let blue   = rgb("#1565C0")
    let red    = rgb("#C62828")
    let green  = rgb("#2E7D32")
    let orange = rgb("#E65100")
    let lgray  = rgb("#E0E0E0")
    let dark   = rgb("#263238")

    let W = 10.0
    let H = 10.0

    let tx(x) = x * W
    let ty(y) = y * H

    let gv(t) = 0.25 + 0.5 * t * t + 0.25 * t * t * t

    let qstar = (calc.sqrt(13.0) - 3.0) / 2.0

    for i in range(0, 6) {
      let v = i / 5.0
      line(
        (tx(v), ty(0.0)),
        (tx(v), ty(1.0)),
        stroke: 0.4pt + lgray
      )
      line(
        (tx(0.0), ty(v)),
        (tx(1.0), ty(v)),
        stroke: 0.4pt + lgray
      )
    }

    line((tx(0.0), ty(0.0)), (tx(1.12), ty(0.0)), stroke: 1.2pt + dark, mark: (end: "stealth"))
    line((tx(0.0), ty(0.0)), (tx(0.0), ty(1.12)), stroke: 1.2pt + dark, mark: (end: "stealth"))

    content((tx(1.14), ty(0.0)), text(size: 10pt)[$t$])
    content((tx(0.0), ty(1.16)), text(size: 10pt)[$y$])

    for i in range(0, 6) {
      let v = i / 5.0
      let label = if i == 0 { "0" }
        else if i == 1 { "0.2" }
        else if i == 2 { "0.4" }
        else if i == 3 { "0.6" }
        else if i == 4 { "0.8" }
        else { "1" }
      content(
        (tx(v), ty(-0.08)),
        text(size: 7pt)[#label]
      )
      if i > 0 {
        content(
          (tx(-0.1), ty(v)),
          text(size: 7pt)[#label]
        )
      }
    }

    line(
      (tx(0.0), ty(0.0)),
      (tx(1.0), ty(1.0)),
      stroke: 1.5pt + dark
    )
    content((tx(0.82), ty(0.76)), text(size: 9pt, fill: dark)[$y=t$])

    let n-pts = 200
    let g-pts = range(0, n-pts + 1).map(i => {
      let t = i / n-pts
      (tx(t), ty(gv(t)))
    })
    line(..g-pts, stroke: 2pt + blue)

    content((tx(0.30), ty(0.90)), text(size: 9pt, fill: blue)[$g(t)=frac(1,4)+frac(1,2)t^2+frac(1,4)t^3$])

    circle(
      (tx(qstar), ty(qstar)),
      radius: 0.12,
      fill: red,
      stroke: none
    )
    content(
      (tx(qstar + 0.06), ty(qstar - 0.10)),
      text(size: 8pt, fill: red)[$q^* approx 0.303$]
    )

    circle(
      (tx(1.0), ty(1.0)),
      radius: 0.12,
      fill: red,
      stroke: none
    )
    content(
      (tx(0.88), ty(1.07)),
      text(size: 8.5pt, fill: red)[$q=1$]
    )

    line(
      (tx(qstar), ty(0.0)),
      (tx(qstar), ty(qstar)),
      stroke: 0.8pt + red
    )
    line(
      (tx(0.0), ty(qstar)),
      (tx(qstar), ty(qstar)),
      stroke: 0.8pt + red
    )
    content((tx(qstar), ty(-0.08)), text(size: 7pt, fill: red)[$q^*$])
    content((tx(-0.08), ty(qstar)), text(size: 7pt, fill: red)[$q^*$])

    let q0v = 0.0
    let q1v = gv(q0v)
    let q2v = gv(q1v)
    let q3v = gv(q2v)
    let q4v = gv(q3v)
    let q5v = gv(q4v)

    let cw-stroke = 1.4pt + orange

    line((tx(q0v), ty(q0v)), (tx(q0v), ty(q1v)), stroke: cw-stroke)
    line((tx(q0v), ty(q1v)), (tx(q1v), ty(q1v)), stroke: cw-stroke)

    line((tx(q1v), ty(q1v)), (tx(q1v), ty(q2v)), stroke: cw-stroke)
    line((tx(q1v), ty(q2v)), (tx(q2v), ty(q2v)), stroke: cw-stroke)

    line((tx(q2v), ty(q2v)), (tx(q2v), ty(q3v)), stroke: cw-stroke)
    line((tx(q2v), ty(q3v)), (tx(q3v), ty(q3v)), stroke: cw-stroke)

    line((tx(q3v), ty(q3v)), (tx(q3v), ty(q4v)), stroke: cw-stroke)
    line((tx(q3v), ty(q4v)), (tx(q4v), ty(q4v)), stroke: cw-stroke)

    line((tx(q4v), ty(q4v)), (tx(q4v), ty(q5v)), stroke: cw-stroke)
    line((tx(q4v), ty(q5v)), (tx(q5v), ty(q5v)), stroke: cw-stroke)

    content(
      (tx(0.13), ty(0.52)),
      text(size: 8pt, fill: orange)[итерации $q_(n+1)=g(q_n)$]
    )

    circle(
      (tx(0.0), ty(0.0)),
      radius: 0.10,
      fill: green,
      stroke: none
    )
    content(
      (tx(0.08), ty(0.07)),
      text(size: 7.5pt, fill: green)[$q_0=0$]
    )

    content(
      (tx(-0.11), ty(q1v)),
      text(size: 7pt, fill: orange)[$q_1$]
    )
    content(
      (tx(-0.11), ty(q2v)),
      text(size: 7pt, fill: orange)[$q_2$]
    )
    content(
      (tx(-0.11), ty(q3v)),
      text(size: 7pt, fill: orange)[$q_3$]
    )
  })
]

#v(1em)

#note-block("Почему выбираем наименьший положительный корень")[
  Пусть $q_n = bb(P)(X_n = 0)$ --- вероятность вымирания к поколению $n$

  Рекурсия:
  $
  q_(n+1) = g(q_n), quad q_0 = 0
  $
  Красная «лесенка» на графике --- это визуализация итераций

  Последовательность $q_n$ монотонно возрастает (так как $g(t) >= t$ при $t in [0, q^*]$) и ограничена сверху значением $q^*$. По теореме о монотонных ограниченных последовательностях она сходится, и предел удовлетворяет $q^* = g(q^*)$.

  Поскольку мы стартуем из $q_0 = 0$, итерации приходят именно к *наименьшей* неподвижной точке. Корень $q = 1$ недостижим из $0$ при $mu > 1$

]

#answer-block[
  #text(weight: "bold", fill: rgb("#E65100"))[]

  Вероятность вымирания = наименьший неотрицательный корень $g(q) = q$:

  $
  q^3 + 2q^2 - 4q + 1 = 0
  quad arrow.r.double quad
  q^* = frac(sqrt(13) - 3, 2) approx 0.303
  $

  С вероятностью $approx 69.7%$ династия амёб выживает вечно.
]

== Итерации: приближаемся к корню

#table(
  columns: (auto, auto, auto),
  align: center,
  stroke: 0.5pt,
  table.header([*$n$*], [*$q_n = bb(P)(X_n = 0)$*], [*Комментарий*]),
  [$0$], [$0$], [Начало: амёба жива],
  [$1$], [$g(0) = 1/4 = 0.250$], [Вероятность смерти в 1-м поколении],
  [$2$], [$g(1/4) approx 0.285$], [Вымирание за 2 поколения],
  [$3$], [$g(0.285) approx 0.296$], [Приближаемся к $q^*$],
  [$...$], [$...$], [Монотонно возрастает],
  [$infinity$], [$q^* approx 0.303$], [Наименьший корень],
)
= Ветвящиеся процессы


#def-block("Теорема (Гальтон--Ватсон)")[
  Пусть $mu = bb(E)(Y)$ --- среднее число потомков одной особи.

  Вероятность вымирания $q$ --- наименьший неотрицательный корень $g(q) = q$.

  - Если $mu <= 1$, то $q = 1$: вымирание почти верное.
  - Если $mu > 1$, то $q < 1$: положительная вероятность выживания.
]

В нашем случае:
$mu = 7/4 > 1$

Поэтому $q < 1$, и действительно $q approx 0.303 < 1$

== Связь PGF с итерацией

$
g_(X_n)(t) = g^(circle.small n)(t) = underbrace(g(g(...g(t)...)), n)
$

Вероятность вымирания к поколению $n$:

$
q_n = bb(P)(X_n = 0) = g_(X_n)(0) = g^(circle.small n)(0)
$

При $n -> infinity$:

$
q = lim_(n -> infinity) g^(circle.small n)(0)
$

== Среднее: геометрическая прогрессия

$
bb(E)(X_n) = mu^n
$

Это следует из:

$
g'_(X_n)(1) = (g^(circle.small n))'(1) = product_(k=0)^(n-1) g'(g^(circle.small k)(1)) = (g'(1))^n = mu^n
$

так как $g^(circle.small k)(1) = 1$ для всех $k$

