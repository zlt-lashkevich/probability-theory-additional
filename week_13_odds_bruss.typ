#set page(paper: "a4", margin: (top: 2cm, bottom: 2cm, left: 2cm, right: 2cm))
#set text(font: "New Computer Modern", size: 11pt, lang: "ru")
#set heading(numbering: none)
#set par(justify: true)
#import "@preview/cetz:0.4.2": canvas, draw

#show heading.where(level: 1): set text(size: 16pt, weight: "bold")
#show heading.where(level: 2): set text(size: 13pt, weight: "bold")
#show heading.where(level: 3): set text(size: 11pt, weight: "bold")

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
  #body
]

#let warn-block(body) = block(
  width: 100%,
  fill: rgb("#FFF3E0"),
  radius: 6pt,
  inset: 12pt,
)[
  #text(weight: "bold", fill: rgb("#E65100"))[Важно:]
  #body
]

#let answer-block(body) = block(
  width: 100%,
  fill: rgb("#FFFDE7"),
  radius: 6pt,
  inset: 12pt,
)[
  #text(weight: "bold", fill: rgb("#E65100"))[Ответ:]
  #body
]

#let def-block(title, body) = block(
  width: 100%,
  fill: rgb("#F3E5F5"),
  radius: 6pt,
  inset: 12pt,
)[
  #text(weight: "bold", fill: rgb("#6A1B9A"))[#title]
  #body
]

#let side-block(title, body) = block(
  width: 100%,
  fill: rgb("#FCE4EC"),
  radius: 6pt,
  inset: 12pt,
)[
  #text(weight: "bold", fill: rgb("#AD1457"))[#title]
  #body
]
#align(center)[
  #text(size: 20pt, weight: "bold")[
    Шансы, оптимальная остановка и правило Брусса
  ]
]

#v(1em)

= Шансы (odds)

#def-block("Шансы события")[
  $
  "odds"(A) = frac(P(A), 1 - P(A))
  $

  Пример: если $"odds"(A) = 2 : 3$, то $P(A) = 2/5$.

  Соответствие диапазонов:
  $
  "odds"(A) in [0, +infinity], quad P(A) in [0, 1]
  $
]

#idea-block[
  Некоторые утверждения удобнее формулировать в терминах шансов, а не вероятностей. Особенно это касается мультипликативных моделей: умножение шансов соответствует сложению логарифмов.
]

== Применение: логистическая регрессия

В логистической регрессии моделируется *логарифм шансов*:

$
ln "odds"(y_i = 1) = beta_1 + beta_2 x_i
$

Экспоненцируем:

$
"odds"(y_i = 1) = exp(beta_1 + beta_2 x_i)
$

$
frac(P(y_i = 1), 1 - P(y_i = 1)) = exp(beta_1 + beta_2 x_i)
$

Выражаем вероятность (логистическая функция):

$
P(y_i = 1) = frac(exp(beta_1 + beta_2 x_i), 1 + exp(beta_1 + beta_2 x_i))
$

= Задача о пирожках

#note-block("Условие")[
  Перед нами $n$ пирожков, которые мы пробуем по одному. Введём индикаторы:

  $
  I_k = cases(
    1\, & "если" k"-й пирожок вкусный",
    0\, & "если невкусный"
  )
  $

  Индикаторы $I_1, dots, I_n$ независимы, $P(I_k = 1) = p_k$.

  *Приоритеты:*
  - *1-й приоритет:* съесть все вкусные пирожки;
  - *2-й приоритет:* не есть невкусные пирожки.
]

#warn-block[
  Один вкусный пирожок гораздо важнее, чем количество невкусных, съеденных до него. Но лишних невкусных пирожков *после* последнего вкусного есть не хочется. Поэтому задача --- остановиться сразу после последнего вкусного пирожка.
]

== Стратегии

=== Интуитивная стратегия $"STR"_k$

#def-block("Стратегия " + $"STR"_k$)[
  1. Съесть $k$ пирожков (пропустить, разведка);
  2. Дальше есть пирожки до первого вкусного и остановиться.

  Стратегия выигрывает, если среди оставшихся $(n - k)$ пирожков *ровно один* вкусный:

  $
  P("STR"_k " выиграла") = P(I_(k+1) + I_(k+2) + dots + I_n = 1)
  $
]

=== Альтернативная стратегия $"ALT"_k$

#def-block("Стратегия " + $"ALT"_k$)[
  1. Съесть $k$ пирожков;
  2. Дальше есть пирожки до *второго* вкусного.

  $
  P("ALT"_k " выиграла") = P(I_(k+1) + dots + I_n = 2)
  $
]

== Выбираем наилучшую среди $"STR"_k$

Обозначим число вкусных пирожков среди оставшихся:

$
S_k = I_(k+1) + I_(k+2) + dots + I_n
$

Это число вкусных пирожков после того, как $k$ уже пропущено. Хотим:

$
P(S_k = 1) -> max_k, quad S_k in {0, 1, 2, dots, n - k}
$

== PGF суммы независимых индикаторов

Введём производящую функцию:

$
G(t) = bb(E)(t^(I_(k+1) + dots + I_n))
= bb(E)(t^(I_(k+1))) dot bb(E)(t^(I_(k+2))) dot dots dot bb(E)(t^(I_n))
$

(произведение --- так как индикаторы независимы).

Для одного индикатора:

$
bb(E)(t^(I_(k+1)))
= underbrace(P(I_(k+1) = 0), 1 - p_(k+1)) t^0
+ underbrace(P(I_(k+1) = 1), p_(k+1)) t^1
= 1 - p_(k+1) + p_(k+1) t
$

== Извлечение вероятностей

Коэффициенты PGF дают вероятности:

$
P(S_k = 2) = frac(G''(0), 2!), quad P(S_k = 3) = frac(G'''(0), 3!)
$

#side-block("Три производящие функции")[
  - $G(t) = bb(E)(t^X)$ --- удобна в дискретном случае, достаём вероятности:
    $
    G(t) = P(X=0) + P(X=1) t + P(X=2) t^2 + dots
    $
  - $m(t) = bb(E)(e^(t X))$ --- удобна для моментов $bb(E)(X^k)$:
    $
    m(t) = 1 + bb(E)(X) t + frac(bb(E)(X^2), 2!) t^2 + dots
    $
  - $"char"(t) = bb(E)(e^(i t X))$ --- характеристическая функция, всегда существует.
]

== Переход к шансам

Введём шансы для каждого пирожка:

$
r_k = frac(P(I_k = 1), P(I_k = 0)) = frac(p_k, 1 - p_k)
$

Тогда:

$
bb(E)(t^(I_(k+1))) = (1 - p_(k+1))(1 + r_(k+1) t)
$

Поэтому PGF факторизуется:

$
G(t) = underbrace((1 - p_(k+1)), "const")(1 + r_(k+1) t) dot dots dot underbrace((1 - p_n), "const")(1 + r_n t)
$

== Вычисление $G'(0)$

Производная произведения в нуле выделяет линейный член:

$
(1 + r_3 t)(1 + r_4 t)(1 + r_5 t) = 1 + t(r_3 + r_4 + r_5) + t^2 (dots) + t^3 r_3 r_4 r_5
$

Линейный коэффициент --- сумма шансов. Поэтому:

$
G'(0) = product_(i=k+1)^n (1 - p_i) dot sum_(i=k+1)^n r_i
$

Так как $P(S_k = 1) = G'(0)$, нужно максимизировать это выражение по $k$.

== Логарифмический трюк

#idea-block[
  Удобно вычислять $G'(0)$ через логарифмическую производную:

  $
  G'(0) = frac(G'(0), G(0)) dot G(0) = [ln G(t)]'_(t=0) dot G(0)
  $

  где $G(0) = product (1 - p_i) = P(S_k = 0)$ --- вероятность нуля успехов.
]

Логарифмируем:

$
ln G(t) = sum_i ln(1 - p_i) + sum_i ln(1 + r_i t)
$

Дифференцируем:

$
frac(G'(t), G(t)) = sum_i frac(r_i, 1 + r_i t) bar_(t=0) = sum_i r_i
$

= Техника максимизации для дискретных величин

#note-block("Три способа найти максимум дискретной функции")[
  - *Производная:* $frac(d f, d x) = 0$ (для непрерывного аналога);
  - *Разность:* сравниваем $f(k+1) - f(k)$ с нулём;
  - *Отношение:* сравниваем $frac(f(k+1), f(k))$ с единицей (как при поиске моды биномиального распределения).
]

== Сравнение соседних стратегий

Сравним $"STR"_(k+1)$ и $"STR"_k$ через отношение вероятностей. Обозначим $q_i = 1 - p_i$.

Условие $P(S_(k+1) = 1) > P(S_k = 1)$:

$
q_(k+2) dots q_n (r_(k+2) + dots + r_n) > q_(k+1) q_(k+2) dots q_n (r_(k+1) + dots + r_n)
$

Делим на $q_(k+2) dots q_n$:

$
(r_(k+2) + dots + r_n) > q_(k+1)(r_(k+1) + dots + r_n)
$

Раскрываем правую часть:

$
(r_(k+2) + dots + r_n) > q_(k+1) r_(k+1) + q_(k+1)(r_(k+2) + dots + r_n)
$

Так как $q_(k+1) r_(k+1) = q_(k+1) dot frac(p_(k+1), q_(k+1)) = p_(k+1)$:

$
(1 - q_(k+1))(r_(k+2) + dots + r_n) > p_(k+1)
$

$
p_(k+1)(r_(k+2) + dots + r_n) > p_(k+1)
$

Сокращаем на $p_(k+1)$:

$
sum_(i=k+2)^n r_i > 1
$

#answer-block[
  Стратегия $"STR"_(k+1)$ лучше $"STR"_k$ тогда и только тогда, когда сумма шансов оставшихся пирожков превышает 1.
]

= Правило «sum the odds» (Брусс, 2000)

#def-block("Теорема Брусса: sum the odds")[
  Оптимальная стратегия $"STR"^*$ выбирает такое $k^*$, что:

  $
  sum_(i=k^*+2)^n r_i < 1 < sum_(i=k^*+1)^n r_i
  $

  То есть начинаем выбирать с того момента, когда сумма оставшихся шансов *впервые превышает единицу*.
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

    let W = 12.0
    let H = 4.0

    let n = 10
    let rs = (0.18, 0.20, 0.22, 0.25, 0.28, 0.32, 0.38, 0.45, 0.55, 0.70)

    let cum = ()
    let s = 0.0
    for i in range(0, n) {
      s = s + rs.at(n - 1 - i)
      cum.push(s)
    }
    
    let xstep = W / (n + 1)
    let ymax = 2.5
    let ystep = H / ymax

    let tx(k) = (k + 0.5) * xstep
    let ty(y) = y * ystep

    for i in range(0, 6) {
      let v = i * 0.5
      if v <= ymax {
        line(
          (tx(0) - 0.4, ty(v)),
          (tx(n), ty(v)),
          stroke: 0.3pt + lgray
        )
        content(
          (tx(0) - 0.7, ty(v)),
          text(size: 7pt)[#v]
        )
      }
    }

    line(
      (tx(0) - 0.4, ty(0)),
      (tx(n) + 0.4, ty(0)),
      stroke: 1.2pt + dark,
      mark: (end: "stealth")
    )
    line(
      (tx(0) - 0.4, ty(0)),
      (tx(0) - 0.4, ty(ymax) + 0.3),
      stroke: 1.2pt + dark,
      mark: (end: "stealth")
    )

    content((tx(n) + 0.7, ty(0)), text(size: 9pt)[$k$ (справа налево)])
    content((tx(0) - 0.4, ty(ymax) + 0.6), text(size: 9pt)[$sum r_i$])

    line(
      (tx(0) - 0.4, ty(1.0)),
      (tx(n) + 0.4, ty(1.0)),
      stroke: 1.3pt + red
    )
    content(
      (tx(n) + 0.5, ty(1.0) + 0.25),
      text(size: 8.5pt, fill: red)[порог $= 1$]
    )

    for i in range(0, n) {
      let k = n - 1 - i
      let h = rs.at(k)
      rect(
        (tx(i) - 0.25, ty(0)),
        (tx(i) + 0.25, ty(h)),
        fill: blue.lighten(60%),
        stroke: 0.6pt + blue
      )
      content(
        (tx(i), ty(h) + 0.2),
        text(size: 6.5pt, fill: blue)[$r_(#(10 - i))$]
      )
    }

    let cum-pts = range(0, n).map(i => (tx(i), ty(cum.at(i))))
    line(..cum-pts, stroke: 2pt + orange)

    for i in range(0, n) {
      circle(
        (tx(i), ty(cum.at(i))),
        radius: 0.10,
        fill: orange,
        stroke: none
      )
    }

    let k-star = -1
    for i in range(0, n) {
      if cum.at(i) > 1.0 and k-star == -1 {
        k-star = i
      }
    }

    if k-star >= 0 {
      line(
        (tx(k-star), ty(0)),
        (tx(k-star), ty(cum.at(k-star))),
        stroke: 1pt + green
      )
      content(
        (tx(k-star), ty(0) - 0.3),
        text(size: 8pt, fill: green, weight: "bold")[$k^*$]
      )
      content(
        (tx(k-star) + 0.7, ty(cum.at(k-star)) + 0.25),
        text(size: 8pt, fill: green)[первое пересечение]
      )
    }

    content(
      (tx(2), ty(1.8)),
      text(size: 8.5pt, fill: orange)[накопленная сумма $sum_(i=k+1)^n r_i$]
    )
  })
]

Сравнение соседних стратегий:

$
"STR"_k " лучше " "STR"_(k+1) : quad r_n + dots + r_(k+1) > 1
$

$
"STR"_k " хуже " "STR"_(k+1) : quad r_n + dots + r_(k+2) < 1
$

= Упражнение: кубик 100 раз

#note-block("Условие")[
  Подбрасываем кубик 100 раз. Как максимизировать вероятность остановиться на *последней* шестёрке?
]

== Шансы для шестёрки

$
r_i = frac(p_i, 1 - p_i) = frac(1\/6, 5\/6) = frac(1, 5) = 1 : 5
$

Все $r_i$ одинаковы.

== Применяем sum the odds

Накапливаем шансы с конца. Каждый бросок добавляет $1/5$:

$
r_100 + r_99 + dots + r_96 = 5 dot frac(1, 5) = 1
$

То есть сумма ровно пяти последних шансов равна 1.

#warn-block[
  Когда сумма попадает в 1 *точно*, имеем две одинаково оптимальные стратегии.

  $
  r_100 + dots + r_96 = 1 quad => quad "STR"_95 tilde "STR"_94
  $

  $
  r_100 + dots + r_95 > 1 quad => quad "STR"_94 succ.eq "STR"_95
  $

  $
  r_100 + dots + r_97 < 1 quad => quad "STR"_96 prec "STR"_95
  $
]

#answer-block[
  Оптимально пропустить первые 94--95 бросков, затем останавливаться на первой шестёрке. Две стратегии ($"STR"_94$ и $"STR"_95$) эквивалентны.
]

= Задача о разборчивой невесте (secretary problem)

#note-block("Условие")[
  Невеста последовательно знакомится с $n = 1000$ женихами и хочет выбрать *самого лучшего*. Отвергнутого жениха вернуть нельзя.

  $
  max P("выбран самый лучший")
  $
]

#idea-block[
  Мы умеем только *сравнивать* кандидатов друг с другом (ранжировать относительно), но не знаем абсолютной шкалы. Поэтому выбираем кандидата, который лучше всех предыдущих.
]

== Связь с шансами

Введём индикаторы рекордов:

$
I_k = cases(
  1\, & "если " k"-й лучше всех предыдущих",
  0\, & "иначе"
)
$

Вероятность того, что $k$-й кандидат --- рекорд (лучший из первых $k$):

$
P(I_k = 1) = frac(1, k)
$

(по симметрии: любой из первых $k$ равновероятно оказывается лучшим).

Шансы рекорда:

$
r_k = frac(p_k, q_k) = frac(1\/k, (k-1)\/k) = frac(1, k - 1)
$

Например:

$
r_n = frac(1, n - 1), quad r_(n-1) = frac(1, n - 2)
$

== Применяем sum the odds

Останавливаемся на первом рекорде после порога $k$. Условие оптимальности:

$
frac(1, n-1) + frac(1, n-2) + dots + frac(1, k+1) > 1 quad -> max_k
$

Это *гармонический ряд*, который аппроксимируется логарифмом:

$
sum_(i=k+1)^(n-1) frac(1, i) approx ln(n-1) - ln k = ln frac(n-1, k)
$

Условие:

$
ln(n-1) - ln k > 1 quad => quad ln k < ln(n-1) - 1
$

$
k < frac(n-1, e) approx frac(1000, e) approx 367
$

#answer-block[
  Оптимальный порог: пропустить примерно $n\/e approx 367$ кандидатов (около трети), затем выбрать первого, кто лучше всех предыдущих.

  Вероятность выбрать лучшего кандидата стремится к $1\/e approx 0.368$.
]

#side-block("Вариация: невеста с подругой")[
  Существует вариант задачи, где у невесты есть подруга, которой подходит *второй из лучших* кандидатов. Тогда оптимальная стратегия меняется: нужно учитывать не только абсолютного лидера, но и второе место. Это приводит к двухпороговой стратегии.
]

= Задача о последнем тузе

#note-block("Условие")[
  Колода из 36 карт хорошо перемешана. На каком месте в среднем находится *последний* туз?
]

== Решение через симметрию промежутков

#idea-block[
  Четыре туза разбивают колоду на 5 промежутков (включая участки до первого туза и после последнего). По симметрии все промежутки одинаково распределены.
]

#align(center)[
  #raw(
"□ □ □ A □ □ □ □ A □ A □ □ □ □ A □ □
└─L_1─┘  └──L_2──┘ └L_3┘ └──L_4──┘ └L_5┘
     ↑туз     ↑туз  ↑туз    ↑туз"
  )
]

#v(8pt)

Обозначим $L_1, dots, L_5$ --- длины 5 промежутков (число «не-тузов» в каждом, плюс распределение позиций). Всего карт 36, тузов 4, поэтому при учёте границ:

$
L_1 + L_2 + L_3 + L_4 + L_5 = 36 + 1 = 37
$

(прибавляем 1 из-за способа подсчёта позиций-разделителей).

По симметрии:

$
bb(E)(L_i) = frac(37, 5)
$

Позиция последнего туза --- это сумма первых четырёх промежутков:

$
bb(E)("позиция последнего туза") = bb(E)(L_1 + L_2 + L_3 + L_4) = 4 dot frac(37, 5) = frac(148, 5) = 29.6
$

#answer-block[
  В среднем последний туз находится на позиции $frac(148, 5) = 29.6$.
]

= Задача о подарке (байесовский ёж)

#note-block("Условие")[
  Нам дарят подарок --- ежа. Хотим оценить:
  $
  P("мне понравится подарок")
  $

  Из прошлого опыта: из 25 похожих ситуаций 20 раз понравилось, 5 раз нет.
]

== Быстрый ответ (правило Лапласа)

Наивная оценка $20\/25$ корректируется правилом сглаживания (добавляем один «плюс» и один «минус»):

$
frac(20, 25) quad -> quad frac(20 + 1, 25 + 2) = frac(21, 27)
$

#idea-block[
  Добавление по единице к успехам и неудачам соответствует *равномерному априорному распределению* (правило преемственности Лапласа). Это гарантирует, что при нуле наблюдений вероятность равна $1\/2$.
]

#align(center)[
  #canvas(length: 1cm, {
    import draw: *

    let blue   = rgb("#1565C0")
    let red    = rgb("#C62828")
    let lgray  = rgb("#E0E0E0")
    let dark   = rgb("#263238")
    let purple = rgb("#6A1B9A")

    let W = 10.0
    let H = 5.5
    let beta-pdf-unnorm(h) = calc.pow(h, 20.0) * calc.pow(1.0 - h, 5.0)
    let h-mode = 20.0 / 25.0
    let pdf-max = beta-pdf-unnorm(h-mode)

    let pdf(h) = beta-pdf-unnorm(h) / pdf-max

    let tx(h) = h * W
    let ty(y) = y * H

    for i in range(0, 6) {
      let v = i / 5.0
      line(
        (tx(v), ty(0)),
        (tx(v), ty(1.05)),
        stroke: 0.3pt + lgray
      )
      content(
        (tx(v), ty(-0.07)),
        text(size: 7pt)[#v]
      )
    }
    line(
      (tx(0), ty(0)),
      (tx(1.08), ty(0)),
      stroke: 1.2pt + dark,
      mark: (end: "stealth")
    )
    line(
      (tx(0), ty(0)),
      (tx(0), ty(1.15)),
      stroke: 1.2pt + dark,
      mark: (end: "stealth")
    )

    content((tx(1.10), ty(-0.05)), text(size: 9pt)[$h$])
    content((tx(-0.05), ty(1.18)), text(size: 9pt)[$f(h)$])

    let n-pts = 200
    let curve-pts = range(0, n-pts + 1).map(i => {
      let h = i / n-pts
      (tx(h), ty(pdf(h)))
    })
    line(..curve-pts, stroke: 2pt + blue)

    content(
      (tx(0.5), ty(0.75)),
      text(size: 9pt, fill: blue)[$f(h) prop h^(20)(1-h)^5$]
    )
    content(
      (tx(0.5), ty(0.65)),
      text(size: 9pt, fill: blue)[$"Beta"(21, 6)$]
    )

    line(
      (tx(0.8), ty(0)),
      (tx(0.8), ty(pdf(0.8))),
      stroke: 1pt + red
    )
    circle(
      (tx(0.8), ty(pdf(0.8))),
      radius: 0.10,
      fill: red,
      stroke: none
    )
    content(
      (tx(0.8) + 0.5, ty(pdf(0.8)) + 0.3),
      text(size: 8pt, fill: red)[мода $= 0.8$]
    )
    let h-mean = 21.0 / 27.0
    line(
      (tx(h-mean), ty(0)),
      (tx(h-mean), ty(pdf(h-mean))),
      stroke: 1pt + purple
    )
    circle(
      (tx(h-mean), ty(pdf(h-mean))),
      radius: 0.10,
      fill: purple,
      stroke: none
    )
    content(
      (tx(h-mean) - 1.0, ty(pdf(h-mean)) - 0.6),
      text(size: 8pt, fill: purple)[$bb(E)(h) = 21/27$]
    )

    content(
      (tx(0.18), ty(0.25)),
      text(size: 7.5pt, fill: dark)[наблюдения:]
    )
    content(
      (tx(0.18), ty(0.15)),
      text(size: 7.5pt, fill: dark)[20 успехов, 5 неудач]
    )
  })
]

== Вероятностная модель

Введём скрытый параметр привлекательности подарка:

$
h tilde "Unif"[0, 1]
$

При фиксированном $h$ исходы независимы:

$
P(X_i = 1 | h) = h, quad P(X_i = 0 | h) = 1 - h
$

== Способ 1: классический (через апостериорную плотность)

По формуле Байеса апостериорная плотность $h$ при данных «20 успехов, 5 неудач»:

$
f(h | x_1 dots x_(20) = 1, x_(21) dots x_(25) = 0)
= frac(P("данные" | h) dot f(h), P("данные"))
$

Так как $f(h) = 1$ (равномерное):

$
f(h | "данные") = c dot h^(20) (1 - h)^5, quad h in [0, 1]
$

Это *бета-распределение* $"Beta"(21, 6)$.

=== Прогноз для 26-го наблюдения

$
bb(E)(X_(26) | x_1 dots x_(25)) = bb(E)(h | x_1 dots x_(25)) = integral_0^1 h dot f(h | "данные") d h
$

$
= integral_0^1 c dot h^(21) (1 - h)^5 d h
$

Используя свойства бета-распределения, среднее $"Beta"(alpha, beta)$ равно $alpha\/(alpha + beta)$:

$
bb(E)(h | "данные") = frac(21, 21 + 6) = frac(21, 27)
$

#answer-block[
  $P("понравится 26-й подарок") = frac(21, 27) approx 0.778
  $
]

== Способ 2: геометрическая интерпретация (разрезание окружности)

#idea-block[
  Представим скрытый параметр $h$ и наблюдения как точки на окружности единичной длины. Каждое наблюдение $X_i$ и сам параметр $h$ задают разрез окружности.
]
#align(center)[
  #canvas(length: 1cm, {
    import draw: *

    let blue   = rgb("#1565C0")
    let red    = rgb("#C62828")
    let green  = rgb("#2E7D32")
    let orange = rgb("#E65100")
    let lgray  = rgb("#BDBDBD")
    let dark   = rgb("#263238")

    let cx = 0.0
    let cy = 0.0
    let R = 3.0
    let n-arcs = 27
    let n-success = 21

    circle((cx, cy), radius: R, stroke: 1.5pt + dark, fill: none)

    for i in range(0, n-arcs) {
      let angle = 360deg * i / n-arcs - 90deg
      let x = cx + R * calc.cos(angle)
      let y = cy + R * calc.sin(angle)

      // Цвет точки
      let pt-color = if i < n-success {
        green
      } else {
        red
      }

      circle((x, y), radius: 0.10, fill: pt-color, stroke: none)
    }

    for i in range(0, n-success) {
      let a1 = 360deg * i / n-arcs - 90deg
      let a2 = 360deg * (i + 1) / n-arcs - 90deg

      let x1 = cx + R * calc.cos(a1)
      let y1 = cy + R * calc.sin(a1)
      let x2 = cx + R * calc.cos(a2)
      let y2 = cy + R * calc.sin(a2)

      let mid-angle = (a1 + a2) / 2
      let r-out = R + 0.18
      let x-out = cx + r-out * calc.cos(mid-angle)
      let y-out = cy + r-out * calc.sin(mid-angle)
      circle((x-out, y-out), radius: 0.07, fill: green, stroke: none)
    }

    for i in range(n-success, n-arcs) {
      let a1 = 360deg * i / n-arcs - 90deg
      let a2 = 360deg * (i + 1) / n-arcs - 90deg

      let mid-angle = (a1 + a2) / 2
      let r-out = R + 0.18
      let x-out = cx + r-out * calc.cos(mid-angle)
      let y-out = cy + r-out * calc.sin(mid-angle)
      circle((x-out, y-out), radius: 0.07, fill: red, stroke: none)
    }

    circle((cx, cy), radius: 0.05, fill: dark, stroke: none)

    content(
      (cx, cy - R - 0.7),
      text(size: 9.5pt, weight: "bold")[
        Окружность длины $1$, разрезанная $27$ точками на $27$ дуг
      ]
    )

    let lx = R + 1.5
    let ly = R - 0.5

    circle((lx, ly), radius: 0.10, fill: green, stroke: none)
    content(
      (lx + 0.3, ly),
      text(size: 8.5pt)[$21$ успешных дуг ($X = 1$)],
      anchor: "west"
    )

    circle((lx, ly - 0.6), radius: 0.10, fill: red, stroke: none)
    content(
      (lx + 0.3, ly - 0.6),
      text(size: 8.5pt)[$6$ неудачных дуг ($X = 0$)],
      anchor: "west"
    )

    content(
      (lx, ly - 1.4),
      text(size: 8.5pt, fill: blue)[
        $P = frac(21, 27) approx 0.778$
      ],
      anchor: "west"
    )

    // Стрелка указатель к точке h
    let h-angle = 360deg * 20 / n-arcs - 90deg
    let hx = cx + R * calc.cos(h-angle)
    let hy = cy + R * calc.sin(h-angle)
    content(
      (hx + 0.8, hy + 0.3),
      text(size: 8pt, fill: orange)[точка $h$ (граница)]
    )
  })
]


По симметрии: новое наблюдение «понравится» тогда, когда его точка попадёт в одну из «успешных» дуг. Из 27 равноправных дуг успешными оказываются $21$ (= 20 прошлых успехов + 1 граничная):

$
p = frac(21, 27)
$

#answer-block[
  Оба способа дают одинаковый результат:

  $
  P("понравится") = frac(21, 27) approx 0.778
  $

  Способ 1 --- через интеграл и бета-распределение.

  Способ 2 --- через симметрию дуг на окружности (быстрее, без интегрирования)
]

#pagebreak()

= Дополнительная задача на склейку

#note-block("Задача для самостоятельного разбора")[
  *Условие:* В урне $n$ шаров, из них $m$ белых. Шары достают по одному без возвращения. На каком в среднем месте окажется *последний* белый шар?

  *Подсказка (метод склейки):* Используйте ту же технику, что и в задаче о тузах. Белые шары разбивают последовательность на $m + 1$ промежутков. По симметрии все промежутки одинаково распределены.
]

== Решение

Аналогично задаче о тузах: $m$ белых шаров создают $m + 1$ промежуток, в сумме покрывающих $n + 1$ «позицию-разделитель»:

$
sum_(i=1)^(m+1) L_i = n + 1
$

По симметрии:

$
bb(E)(L_i) = frac(n + 1, m + 1)
$

Позиция последнего белого шара --- сумма первых $m$ промежутков:

$
bb(E)("позиция последнего белого") = m dot frac(n + 1, m + 1) = frac(m(n + 1), m + 1)
$

#answer-block[
  $
  bb(E)("позиция последнего белого шара") = frac(m(n + 1), m + 1)
  $

  *Проверка:* для тузов $n = 36$, $m = 4$: получаем $frac(4 dot 37, 5) = 29.6$
]

