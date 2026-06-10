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
  #body
]

#let idea-block(body) = block(
  width: 100%,
  fill: rgb("#E3F2FD"),
  radius: 6pt,
  inset: 12pt,
)[
  #text(weight: "bold", fill: rgb("#1565C0"))[Ключевая идея:]
  #v(4pt)
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
  #text(weight: "bold", fill: rgb("#E65100"))[Результат:]
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

#align(center)[
  #text(size: 20pt, weight: "bold")[Вероятностный метод]
]

#v(1em)

#def-block("Что такое вероятностный метод?")[
  Утверждения из *других дисциплин* (геометрия, алгебра, комбинаторика) доказываются инструментами *теории вероятностей*.

  Общая схема:
  1. Выбрать что-то *случайно* (точку, перестановку, направление).
  2. Вычислить математическое ожидание или ковариацию.
  3. Из свойств ожидания сделать *детерминированный* вывод.
  4. Получить утверждение, в котором нет ничего случайного.
]

#idea-block[
  Если $bb(E)[Z] = c$, значит:
  - существует реализация, где $Z >= c$;
  - существует реализация, где $Z <= c$.

  Если $bb(E)[Z] = 0$ и $Z$ непрерывна, значит $Z$ где-то обращается в ноль.
]

Варианты «случайно выбрать»:
- случайная точка $X tilde "Unif"(0, 1)$;
- случайная перестановка $a_1, dots, a_n$;
- случайная точка на окружности;
- случайное направление (прямая через начало координат).


= Сумма углов треугольника через случайную проекцию


#note-block("Цель")[
  Доказать вероятностным методом:
  $
  alpha + beta + gamma = pi
  $
  где $alpha, beta, gamma$ --- углы треугольника $A B C$
]

== Конструкция: вероятность «видимости» точки

Рассмотрим точку $P$ на плоскости и маленькую окружность (эпсилон-окрестность) вокруг неё. Проведём случайную прямую через начало координат.

*Вероятность «попасть в закрашенную область»* при равномерном выборе точки на маленькой окружности:

#table(
  columns: (auto, auto, auto),
  align: (center, center, left),
  stroke: 0.5pt,
  table.header([*Точка*], [*Вероятность*], [*Пояснение*]),
  [$F$ (вне треугольника)], [$P(F) = 0$], [Окрестность полностью снаружи],
  [$D$ (на стороне)], [$P(D) = 1/2$], [Половина окрестности внутри],
  [$C$ (вершина, угол $gamma$)], [$P(C) = gamma / (2 pi)$], [Доля угла от полного оборота],
  [$E$ (внутри)], [$P(E) = 1$], [Окрестность полностью внутри],
)

== Проекция треугольника на случайную прямую

#align(center)[
  #canvas(length: 1cm, {
    import draw: *

    let blue = rgb("#1565C0")
    let red = rgb("#C62828")
    let green = rgb("#2E7D32")
    let dark = rgb("#263238")
    let lgray = rgb("#E0E0E0")
    let cyan = rgb("#00897B")

    let A = (-3.0, -1.5)
    let B = (3.0, -1.5)
    let C = (0.5, 2.5)

    line(A, B, C, close: true, fill: green.lighten(80%), stroke: 1.2pt + green)

    circle(A, radius: 0.08, fill: dark, stroke: none)
    circle(B, radius: 0.08, fill: dark, stroke: none)
    circle(C, radius: 0.08, fill: dark, stroke: none)

    content((-3.4, -1.8), text(size: 10pt, weight: "bold")[$A$])
    content((3.3, -1.8), text(size: 10pt, weight: "bold")[$B$])
    content((0.5, 2.9), text(size: 10pt, weight: "bold")[$C$])

    let angle = 25.0
    let dx = 5.0 * calc.cos(angle * calc.pi / 180.0)
    let dy = 5.0 * calc.sin(angle * calc.pi / 180.0)

    line((-dx, -dy), (dx, dy), stroke: 1.5pt + dark)
    content((dx + 0.4, dy + 0.2), text(size: 9pt)[$ell$])

    circle((0, 0), radius: 0.06, fill: dark, stroke: none)
    content((0.3, -0.3), text(size: 8pt)[$O$])

    
    let proj-x(px, py) = {
      let c = calc.cos(angle * calc.pi / 180.0)
      let s = calc.sin(angle * calc.pi / 180.0)
      let t = px * c + py * s
      (t * c, t * s)
    }

    let pA = proj-x(-3.0, -1.5)
    let pB = proj-x(3.0, -1.5)
    let pC = proj-x(0.5, 2.5)

    line(A, pA, stroke: 0.7pt + green)
    line(B, pB, stroke: 0.7pt + green)
    line(C, pC, stroke: 0.7pt + green)

    circle(pA, radius: 0.08, fill: red, stroke: none)
    circle(pB, radius: 0.08, fill: red, stroke: none)
    circle(pC, radius: 0.08, fill: red, stroke: none)

    content((pA.at(0) - 0.1, pA.at(1) - 0.4), text(size: 8pt, fill: red)[$A'$])
    content((pB.at(0) + 0.2, pB.at(1) - 0.4), text(size: 8pt, fill: red)[$B'$])
    content((pC.at(0) + 0.2, pC.at(1) + 0.3), text(size: 8pt, fill: red)[$C'$])
  })
]

== Индикаторы видимости вершин

Для каждой вершины определим индикатор:

$
X_A = cases(
  1\, & "если проекция" A' "является краем отрезка-проекции",
  0\, & "иначе (проекция внутри отрезка)"
)
$

=== Ключевое наблюдение

При проецировании выпуклого треугольника на прямую ровно *две* вершины оказываются крайними точками проекции (левый и правый концы отрезка), а одна --- внутри.

Поэтому почти наверное:

$
X_A + X_B + X_C = 2 quad "(п.н.)"
$

Вырожденный случай (прямая проходит точно через вершину) имеет вероятность 0.

=== Вероятности индикаторов

Вершина $A$ *не видна* (её проекция внутри отрезка) тогда, когда случайная прямая «входит» в угол при вершине $A$. Это происходит, когда направление прямой попадает в сектор угла $alpha$, причём с обеих сторон (сектор и его антиподальный):

$
P(X_A = 0) = 2 dot frac(alpha, 2 pi) = frac(alpha, pi)
$

$
P(X_A = 1) = 1 - frac(alpha, pi)
$

Аналогично для $B$ и $C$.

== Доказательство

Берём математическое ожидание тождества $X_A + X_B + X_C = 2$:

$
bb(E)(X_A) + bb(E)(X_B) + bb(E)(X_C) = 2
$

Подставляем:

$
(1 - frac(alpha, pi)) + (1 - frac(beta, pi)) + (1 - frac(gamma, pi)) = 2
$

$
3 - frac(alpha + beta + gamma, pi) = 2
$

$
frac(alpha + beta + gamma, pi) = 1
$

#answer-block[
  $
  alpha + beta + gamma = pi
  $
]

== Обобщение на $n$-угольник

Для выпуклого $n$-угольника ровно 2 вершины являются крайними при проекции:

$
X_(A_1) + X_(A_2) + dots + X_(A_n) = 2
$

Поэтому:

$
n - frac(alpha_1 + alpha_2 + dots + alpha_n, pi) = 2
$

#answer-block[
  $
  alpha_1 + alpha_2 + dots + alpha_n = (n - 2) pi
  $
]

= Обобщение на сферу: сферический треугольник


Рассмотрим единичную сферу ($R = 1$) с центром $O$. Три точки $A, B, C$ на сфере задают сферический треугольник. Из центра выходят лучи $O A$, $O B$, $O C$, образующие трёхгранный угол.


#table(
  columns: (auto, auto, auto),
  align: (center, center, left),
  stroke: 0.5pt,
  table.header([*Точка*], [*Вероятность*], [*Пояснение*]),
  [$F$ (вне)], [$P(F) = 0$], [Вне трёхгранного угла],
  [$D$ (на грани)], [$P(D) = "двугр. угол" / (2 pi)$], [Доля двугранного угла],
  [$A$ (вершина)], [$P(A) = alpha / (2 pi)$], [Двугранный угол при ребре $O A$],
  [$O$ (внутри)], [$P(O) = S_(A B C) / (4 pi)$], [Доля площади сферического треугольника],
)

Здесь $S_(A B C)$ --- площадь сферического треугольника на единичной сфере.

== Проецирование на случайную прямую

Проведём случайную прямую через центр сферы. Спроецируем точки $O, A, B, C$.

Два случая:
- *Случай A:* точка $O$ внутри проекции треугольника ($X_O = 0$, $X_(O A) + X_(O B) + X_(O C) = 0$)
- *Случай B:* точка $O$ вне проекции ($X_O = 1$, $X_(O A) + X_(O B) + X_(O C) = 2$)

Линейная связь:

$
X_(O A) + X_(O B) + X_(O C) = 2 X_O
$

== Вывод формулы

Берём математические ожидания:

$
bb(E)(X_(O A)) + bb(E)(X_(O B)) + bb(E)(X_(O C)) = 2 bb(E)(X_O)
$

Подставляем:

$
bb(E)(X_(O A)) = 1 - 2 dot frac(alpha, 2 pi) = 1 - frac(alpha, pi)
$

$
bb(E)(X_O) = 1 - 2 dot frac(S_(A B C), 4 pi) = 1 - frac(S_(A B C), 2 pi)
$

Собираем:

$
(1 - frac(alpha, pi)) + (1 - frac(beta, pi)) + (1 - frac(gamma, pi)) = 2 (1 - frac(S_(A B C), 2 pi))
$

$
3 - frac(alpha + beta + gamma, pi) = 2 - frac(S_(A B C), pi)
$

#answer-block[
  *Формула для сферического треугольника (теорема Жирара):*

  $
  alpha + beta + gamma = pi + S_(A B C)
  $

  Эксцесс сферического треугольника $= S_(A B C)$
]

#note-block("Частные случаи")[
  - При $S_(A B C) -> 0$ (малый треугольник): $alpha + beta + gamma -> pi$ (плоский случай).
  - При $S_(A B C) = 2 pi$ (полусфера): $alpha + beta + gamma = 3 pi$ (три прямых угла).
  - Диапазон: $alpha + beta + gamma in [pi, 3 pi]$.
]

== Обобщение на выпуклый многогранник

Для выпуклого многогранника с $n_v$ вершинами и $n_e$ рёбрами:

$
bb(E)(X_A) = 1 - 2 frac(S_A, 4 pi) = 1 - frac(S_A, 2 pi)
$

$
bb(E)(X_(A B)) = 1 - 2 frac("двугранный угол при" A B, 2 pi)
$

Здесь $S_A$ --- телесный угол при вершине $A$ (площадь соответствующего участка единичной сферы, если сферу центрировать в вершине).

Формулы для многогранника получаются аналогично через тождество Эйлера ($n_v - n_e + n_f = 2$) и суммирование по всем вершинам и рёбрам.


= Задача 1: корень многочлена (Cambridge Tripos)

#note-block("Задача")[
  Пусть $a_0, a_1, dots, a_n in bb(R)$ и

  $
  frac(a_0, 1) + frac(a_1, 2) + frac(a_2, 3) + dots + frac(a_n, n+1) = 0
  $

  Доказать, что уравнение $a_0 + a_1 x + a_2 x^2 + dots + a_n x^n = 0$ имеет хотя бы один действительный корень на отрезке $[0, 1]$.
]

== Решение

=== Шаг 1: выбираем случайную величину

Пусть $X tilde "Unif"(0, 1)$. Тогда:

$
bb(E)(X^k) = integral_0^1 x^k dif x = frac(1, k+1)
$

В частности:

$
bb(E)(X^0) = 1, quad bb(E)(X) = frac(1, 2), quad bb(E)(X^2) = frac(1, 3), quad bb(E)(X^3) = frac(1, 4)
$

=== Шаг 2: вычисляем ожидание многочлена

Обозначим $f(x) = a_0 + a_1 x + dots + a_n x^n$.

$
bb(E)[f(X)] = a_0 bb(E)(1) + a_1 bb(E)(X) + a_2 bb(E)(X^2) + dots + a_n bb(E)(X^n)
$

$
= a_0 dot 1 + a_1 dot frac(1, 2) + a_2 dot frac(1, 3) + dots + a_n dot frac(1, n+1)
$

$
= frac(a_0, 1) + frac(a_1, 2) + dots + frac(a_n, n+1) = 0
$

=== Шаг 3: делаем вывод

$
bb(E)[f(X)] = 0
$

Если $f(x)$ всюду положительна на $[0, 1]$, то $bb(E)[f(X)] > 0$. Если всюду отрицательна, то $bb(E)[f(X)] < 0$. Раз ожидание равно нулю и $f$ --- непрерывная функция, значит $f$ принимает и положительные, и отрицательные значения (или тождественно равна нулю).

По теореме о промежуточном значении:

#answer-block[
  Существует $x_0 in [0, 1]$ такой, что $f(x_0) = 0$ #h(2em) $square$
]

=== График-иллюстрация

#align(center)[
  #canvas(length: 1cm, {
    import draw: *

    let blue = rgb("#1565C0")
    let red = rgb("#C62828")
    let green = rgb("#2E7D32")
    let dark = rgb("#263238")
    let lgray = rgb("#E0E0E0")

    let W = 8.0
    let H = 4.0

    line((-0.5, 0), (W + 0.5, 0), stroke: 1pt + dark, mark: (end: "stealth"))
    line((0, -H / 2 - 0.3), (0, H / 2 + 0.5), stroke: 1pt + dark, mark: (end: "stealth"))

    content((W + 0.7, -0.2), text(size: 9pt)[$x$])
    content((-0.3, H / 2 + 0.7), text(size: 9pt)[$f(x)$])

    content((-0.3, -0.3), text(size: 8pt)[$0$])
    content((W, -0.4), text(size: 8pt)[$1$])

    line((W, -H / 2), (W, H / 2), stroke: 0.3pt + lgray)

    let n-pts = 200
    let curve = range(0, n-pts + 1).map(i => {
      let t = i / n-pts
      let x = t * W
      let y = H / 2 * (0.8 * calc.sin(t * 2.0 * calc.pi + 0.5) - 0.2 * calc.sin(t * 4.0 * calc.pi))
      (x, y)
    })
    line(..curve, stroke: 2pt + blue)

    content((W / 2, H / 2 + 0.3), text(size: 9pt, fill: blue)[$f(x) = a_0 + a_1 x + dots + a_n x^n$])

    let t0 = 0.44
    let x0 = t0 * W
    circle((x0, 0), radius: 0.12, fill: red, stroke: none)
    content((x0, -0.5), text(size: 8pt, fill: red)[$x_0$])

    let t1 = 0.88
    let x1 = t1 * W
    circle((x1, 0), radius: 0.12, fill: red, stroke: none)
    content((x1, -0.5), text(size: 8pt, fill: red)[$x_1$])

    content((W / 2 + 1.5, -H / 2 + 0), text(size: 8.5pt, fill: green)[$bb(E)[f(X)] = 0$ $=>$ корень существует])
  })
]

= Задача 2: циклическая перестановка (Cambridge Tripos, 2004)

#note-block("Задача")[
  Даны $n$ действительных чисел $a_1, a_2, dots, a_n$ таких, что:

  $
  a_1 + a_2 + dots + a_n = 0, quad "существует" a_i eq.not 0
  $

  Доказать, что можно расположить их в цикл так, что:

  $
  a_1 a_2 + a_2 a_3 + dots + a_n a_1 < 0
  $
]

== Решение

=== Шаг 1: случайная перестановка

Выберем случайную перестановку $(X_1, X_2, dots, X_n)$ чисел $a_1, dots, a_n$ равномерно из всех $n!$ перестановок.

Тогда каждое $X_i$ равномерно распределено по значениям $a_1, dots, a_n$:

$
bb(E)(X_i) = frac(1, n)(a_1 + a_2 + dots + a_n) = 0
$

=== Шаг 2: ковариация соседних элементов

Рассмотрим $X_1$ и $X_2$ --- два последовательных элемента случайной перестановки. Это выборка *без возвращения* из $a_1, dots, a_n$.

Они зависимы, но одинаково распределены.

Используем свойство: $X_1 + X_2 + dots + X_n = a_1 + dots + a_n = 0$ (как случайная величина это тождественный ноль).

$
"Cov"(X_1, underbrace(X_1 + X_2 + dots + X_n, equiv 0)) = 0
$

Раскрываем:

$
"Var"(X_1) + "Cov"(X_1, X_2) + dots + "Cov"(X_1, X_n) = 0
$

По симметрии все $"Cov"(X_1, X_j)$ для $j eq.not 1$ одинаковы:

$
"Var"(X_1) + (n - 1) "Cov"(X_1, X_2) = 0
$

#answer-block[
  $
  "Cov"(X_1, X_2) = -frac("Var"(X_1), n - 1)
  $
]

=== Шаг 3: ожидание циклической суммы

Обозначим:

$
S = X_1 X_2 + X_2 X_3 + dots + X_n X_1
$

$
bb(E)(S) = n dot bb(E)(X_1 X_2)
$

Так как $bb(E)(X_1) = bb(E)(X_2) = 0$:

$
bb(E)(X_1 X_2) = "Cov"(X_1, X_2) = -frac("Var"(X_1), n - 1)
$

$
bb(E)(S) = n dot (-frac("Var"(X_1), n - 1)) = -frac(n, n - 1) "Var"(X_1)
$

Так как существует $a_i eq.not 0$, имеем $"Var"(X_1) > 0$, и поэтому:

$
bb(E)(S) = -frac(n, n - 1) "Var"(X_1) < 0
$

=== Шаг 4: вывод

Раз $bb(E)(S) < 0$, значит существует хотя бы одна перестановка, для которой $S < 0$.

#answer-block[
  Существует циклическая перестановка чисел $a_1, dots, a_n$ такая, что:

  $
  a_1 a_2 + a_2 a_3 + dots + a_n a_1 < 0 quad square
  $
]

= Задача 3: подмножество комплексных чисел (1986)

#note-block("Задача")[
  Даны комплексные числа $z_1, dots, z_n in bb(C)$.

  Доказать, что можно выбрать подмножество $S subset.eq {1, dots, n}$ так, что:

  $
  abs(sum_(j in S) z_j) >= frac(1, pi) sum_(j=1)^n abs(z_j)
  $
]

== Решение

=== Шаг 1: случайное направление

Проведём случайную прямую $O W$ через начало координат на комплексной плоскости. Угол $theta$ между $O W$ и вещественной осью равномерен: $theta tilde "Unif"(0, 2 pi)$.

=== Граф-иллюстрация: проекции комплексных чисел

#align(center)[
  #canvas(length: 1cm, {
    import draw: *

    let blue = rgb("#1565C0")
    let red = rgb("#C62828")
    let green = rgb("#2E7D32")
    let dark = rgb("#263238")
    let lgray = rgb("#E0E0E0")
    let cyan = rgb("#00897B")
    let orange = rgb("#E65100")

    let R = 3.5

    circle((0, 0), radius: R, stroke: 0.6pt + lgray, fill: none)

    line((-R - 0.5, 0), (R + 0.5, 0), stroke: 0.5pt + lgray)
    line((0, -R - 0.5), (0, R + 0.5), stroke: 0.5pt + lgray)

    let th = 30.0
    let cth = calc.cos(th * calc.pi / 180.0)
    let sth = calc.sin(th * calc.pi / 180.0)

    line(
      (-R * cth, -R * sth),
      (R * cth, R * sth),
      stroke: 1.5pt + dark
    )
    content((R * cth + 0.4, R * sth + 0.2), text(size: 9pt)[$O W$])

    let zs = (
      (2.5, 1.5),
      (-1.5, 2.0),
      (1.0, -2.5),
      (-2.0, -1.0),
    )
    let labels = ($z_1$, $z_2$, $z_3$, $z_4$)

    for i in range(0, 4) {
      let z = zs.at(i)
      let lbl = labels.at(i)

      line((0, 0), z, stroke: 1.5pt + blue, mark: (end: "stealth"))
      content((z.at(0) + 0.3, z.at(1) + 0.2), text(size: 9pt, fill: blue)[#lbl])

      let dot-prod = z.at(0) * cth + z.at(1) * sth
      let px = dot-prod * cth
      let py = dot-prod * sth

      line(z, (px, py), stroke: 0.6pt + red)

      circle((px, py), radius: 0.06, fill: red, stroke: none)
    }

    content((1.8, 0.4), text(size: 8pt, fill: orange)[$alpha$])

    content((0, -R - 1.0), text(size: 9pt)[Проекции $z_j$ на случайное направление $O W$])
  })
]


=== Шаг 2: ожидаемая длина проекции

Для одного вектора $z_j$ его проекция на направление $O W$ имеет длину $abs(z_j) dot abs(cos alpha_j)$, где $alpha_j$ --- угол между $z_j$ и $O W$.

$
bb(E)(abs("Proj"(z_j " на " O W)))
= abs(z_j) dot bb(E)(abs(cos alpha))
$

где $alpha tilde "Unif"(0, pi / 2)$ (с учётом симметрии).

$
bb(E)(abs(cos alpha))
= integral_0^(pi/2) frac(cos alpha, pi / 2) dif alpha
= frac(2, pi) [sin alpha]_0^(pi/2)
= frac(2, pi)
$

Поэтому:

$
sum_(j=1)^n bb(E)(abs("Proj"(z_j)))
= frac(2, pi) sum_(j=1)^n abs(z_j)
$

=== Шаг 3: выбираем подмножество

Для фиксированного направления $O W$ выберем подмножество $S$ --- те векторы, которые образуют *острый угол* с $O W$:

$
S = {j : angle(z_j, O W) < 90 degree}
$

Тогда вектор-сумма $R = sum_(j in S) z_j$ направлен «в ту же сторону», что и $O W$, и его проекция на $O W$ равна сумме проекций выбранных:

$
abs(R) >= abs("Proj"(R " на " O W)) = sum_(j in S) abs("Proj"(z_j))
$

Для каждого $z_j$ с вероятностью $1/2$ он попадает в $S$ (острый угол) и с вероятностью $1/2$ не попадает. Поэтому:

$
bb(E)(sum_(j in S) abs("Proj"(z_j)))
= frac(1, 2) sum_(j=1)^n bb(E)(abs("Proj"(z_j)))
= frac(1, 2) dot frac(2, pi) sum abs(z_j)
= frac(1, pi) sum abs(z_j)
$

=== Шаг 4: вывод

$
bb(E)[abs(R)] >= bb(E)(sum_(j in S) abs("Proj"(z_j))) = frac(1, pi) sum_(j=1)^n abs(z_j)
$

Раз ожидание не меньше $frac(1, pi) sum abs(z_j)$, значит существует реализация (конкретное направление $O W$ и соответствующее подмножество $S$), для которой неравенство выполнено.

#answer-block[
  Существует $S subset.eq {1, dots, n}$ такое, что:

  $
  abs(sum_(j in S) z_j) >= frac(1, pi) sum_(j=1)^n abs(z_j) quad square
  $
]