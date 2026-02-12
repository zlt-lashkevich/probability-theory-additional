#set document(title: "Кубик до первой единицы: три метода")
#set page(paper: "a4", margin: 2cm)
#set text(lang: "ru", font: "New Computer Modern", size: 11pt)
#set par(justify: true, leading: 0.65em)
#set heading(numbering: none)

#align(center)[
  #text(size: 16pt, weight: "bold")[
    Кубик до первой единицы
  ]
]

#v(1em)

= Условие задачи

Кубик подбрасывают до первого выпадения единицы. Обозначим: $N$ — количество бросков (включая финальный), $R$ — количество чётных результатов (2, 4 или 6)

*Найти:*
- а) $EE[N | R = 0]$
- б) $EE[N | R]$ (как функция от $R$)

= Граф переходов

#align(center)[
#box(
  width: 100%,
  fill: rgb("#f8f8f8"),
  inset: 12pt,
  radius: 4pt,
)[
  #text(size: 9pt)[
#table(
  columns: 5,
  stroke: 0.5pt,
  inset: 6pt,
  align: center,
  fill: (col, row) => if row == 0 { rgb("#e8f4f8") },
  [*Событие*], [*Результат*], [*Вероятность*], [*Изменение $R$*], [*Символ*],
  
  [Выпала 1], [#text(fill: green)[*Конец ✓*]], [$1/6$], [—], [$bold(1)$],
  [Выпало 3 или 5], [Продолжаем], [$2/6 = 1/3$], [$+0$], [$"odd"$],
  [Выпало 2, 4 или 6], [Продолжаем], [$3/6 = 1/2$], [$+1$], [$"even"$],
)
  ]
]
]

#line(length: 100%, stroke: 1pt)

= Метод 1: Индикаторы и первый шаг

== Пункт а): $EE[N | R = 0]$

#box(
  width: 100%,
  fill: rgb("#e8f4f8"),
  inset: 10pt,
  radius: 4pt,
)[
  *Формула через индикатор:*
  
  $ EE[N | R = 0] = (EE[N dot II(R = 0)])/(P(R = 0)) $
  
  где $II(R = 0) = cases(1 & "если все броски нечётные", 0 & "иначе")$
]

Обозначим $p = P(R = 0)$ — вероятность, что все броски нечётные.

#box(
  width: 100%,
  fill: rgb("#fff4e6"),
  inset: 10pt,
  radius: 4pt,
)[
  
  *Метод первого шага:*
  
  $ p = underbrace(1/6, "выпала 1") dot 1 + underbrace(1/3, "выпало 3,5") dot p + underbrace(1/2, "выпало чётное") dot 0 $
]

$
  p = 1/6 + 1/3 p quad ==> quad p(1 - 1/3) = 1/6 quad ==> quad p = 1/4
$

#box(
  width: 100%,
  fill: rgb("#e8f8e8"),
  inset: 10pt,
  radius: 4pt,
)[
  $ P(R = 0) = 1/4 $
]

=== Вычисление $f = EE[N dot II(R = 0)]$

#box(
  width: 100%,
  fill: rgb("#fff4e6"),
  inset: 10pt,
  radius: 4pt,
)[
  *Метод первого шага для $f$:*
  
  После первого броска:
  - С вер. $1/6$: выпала 1, $N = 1$, $II(R=0) = 1$ → вклад $= 1$
  - С вер. $1/3$: выпало 3 или 5, $N = 1 + N'$, $II(R=0) = II(R'=0)$
  - С вер. $1/2$: выпало чётное, $II(R=0) = 0$ → вклад $= 0$
]

$
  f = 1/6 dot 1 + 1/3 dot EE[(1 + N') dot II(R' = 0)] + 1/2 dot 0
$

$
  f = 1/6 + 1/3 (P(R = 0) + EE[N' dot II(R' = 0)]) = 1/6 + 1/3 (1/4 + f)
$

$
  f = 1/6 + 1/12 + 1/3 f quad ==> quad f(1 - 1/3) = 1/4 quad ==> quad f = 3/8
$

== Тогда

$
  EE[N | R = 0] = f / p = (3/8) / (1/4) = 3/2
$

== Пункт б): $EE[N | R = r]$

=== Анализ структуры
#box(
  width: 100%,
  fill: rgb("#fff4e6"),
  inset: 10pt,
  radius: 4pt,
)[
  
$
  N = underbrace(N_"odd", "кол-во 3,5") + underbrace(R, "кол-во чётных") + underbrace(1, "финальная 1")
$
]
$
  EE[N | R = r] = EE[N_"odd" | R = r] + r + 1
$

=== Совместное распределение $(N_"odd", R)$

#box(
  width: 100%,
  fill: rgb("#fff4e6"),
  inset: 10pt,
  radius: 4pt,
)[
  $ P(N_"odd" = m, R = r) = C(m+r, r) dot (1/3)^m dot (1/2)^r dot (1/6) $
  
  *Интерпретация:* $m + r$ бросков до финала, из них $r$ чётных (порядок выбирается $C(m+r, r)$ способами), затем выпадает 1.
]

=== Маргинальное распределение $R$

$
  P(R = r) &= sum_(m=0)^infinity C(m+r, r) dot (1/3)^m dot (1/2)^r dot (1/6) \
  &= (1/6) dot (1/2)^r dot underbrace(sum_(m=0)^infinity C(m+r, r) (1/3)^m, = (3/2)^(r+1)) = (1/6) dot (1/2)^r dot (3/2)^(r+1) = 1/4 dot (3/4)^r
$

#box(
  width: 100%,
  fill: rgb("#e8f8e8"),
  inset: 10pt,
  radius: 4pt,
)[
  *Распределение $R$ - геометрическое*
  
  $ R tilde "Geom"(1/4): quad P(R = r) = 1/4 dot (3/4)^r, quad r = 0, 1, 2, ... $
]

=== Условное распределение $N_"odd" | R = r$

$
  P(N_"odd" = m | R = r) = (P(N_"odd" = m, R = r))/(P(R = r)) = (2/3)^(r+1) dot C(m+r, r) dot (1/3)^m
$

Это *отрицательное биномиальное* распределение

=== Условное ожидание $EE[N_"odd" | R = r]$

$
  EE[N_"odd" | R = r] &= (2/3)^(r+1) sum_(m=0)^infinity m dot C(m+r, r) dot (1/3)^m
$

Используем формулу: $sum_(m=0)^infinity m dot C(m+r, r) x^m = ((r+1) x)/((1-x)^(r+2))$

$
  &= (2/3)^(r+1) dot ((r+1) dot 1/3)/((2/3)^(r+2)) = (r+1)/3 dot (3/2) = (r+1)/2
$

=== Итоговая формула

$
  EE[N | R = r] = (r+1)/2 + r + 1 = (r + 1 + 2r + 2)/2 = (3r + 3)/2
$

#box(
  width: 100%,
  fill: rgb("#e8f8e8"),
  inset: 15pt,
  radius: 4pt,
)[
  #align(center)[
    Ответ а): $quad EE[N | R = 0] = 3/2 $
    
    Ответ б):
    $quad EE[N | R = r] = 3/2 (r + 1) $
  
    В общем виде:
    $EE[N | R] = 3/2 (R + 1) $
  ]
]


#line(length: 100%, stroke: 1pt)

= Метод 2: Производящие функции (Traj)


#box(
  width: 100%,
  fill: rgb("#e8f4f8"),
  inset: 10pt,
  radius: 4pt,
)[
  *Множество всех траекторий:*
  
  $ "Traj" = sum_(k=0)^infinity ("odd" + "even")^k dot bold(1) = bold(1)/(1 - "odd" - "even") $
  
  где $"odd" = 1/3$, $"even" = 1/2$, $bold(1) = 1/6$
  Для удобства обозначим $"Traj" = omega$
]

== Производящая функция для $(N, R)$

Введём переменные: $z$ для подсчёта шагов, $w$ для подсчёта чётных. Траектория: $(n-1)$ бросков с результатами $in {2,3,4,5,6}$, затем выпадает 1.

- Выпало чётное (2, 4, 6): вероятность $1/2$, вклад $z w$
- Выпало нечётное ≠ 1 (3, 5): вероятность $1/3$, вклад $z$
- Выпала 1: вероятность $1/6$, вклад $z$

$
  G(z, w) = sum_(n, r) z^n w^r P(N = n, R = r) = z dot 1/6 dot sum_(k=0)^infinity (z dot "odd" + z w dot "even")^k
$

$
  G(z, w) = z dot 1/6 dot sum_(k=0)^infinity (z dot 1/3 + z w dot 1/2)^k = (z slash 6)/(1 - z/3 - z w/2)
$

#box(
  width: 100%,
  fill: rgb("#e8f8e8"),
  inset: 10pt,
  radius: 4pt,
)[
  $ G(z, w) = z/(6(1 - z/3 - z w/2)) $
]

== Формула для условного ожидания

#box(
  width: 100%,
  fill: rgb("#fff4e6"),
  inset: 12pt,
  radius: 4pt,
)[
  *Формула через коэффициенты:*
  
  $ EE[N | R = r] = ([w^r] z (partial G)/(partial z) |_(z=1))/([w^r] G(1, w)) $
  
  *Почему $z (partial G)/(partial z)$?*
  
  Оператор $z (partial)/(partial z)$ умножает коэффициент при $z^n$ на $n$:
  
  $ z (partial)/(partial z) sum a_n z^n = sum n dot a_n z^n $
]

== Вычисление производной

Обозначим $D(z, w) = 1 - z/3 - z w/2 = 1 - z(1/3 + w/2)$.

$
  G = z/(6 D)
$

По правилу частного:

$
  (partial G)/(partial z) = (1 dot 6 D - z dot 6 dot (-(1/3 + w/2)))/(36 D^2) = (D + z(1/3 + w/2))/(6 D^2)
$

Упростим числитель

$
  D + z(1/3 + w/2) = 1 - z/3 - z w/2 + z/3 + z w/2 = 1
$

#box(
  width: 100%,
  fill: rgb("#e8f8e8"),
  inset: 10pt,
  radius: 4pt,
)[
  *Получаем:*
  
  $ (partial G)/(partial z) = 1/(6 D^2) = 1/(6(1 - z/3 - z w/2)^2) $
]

Тогда
$
  z (partial G)/(partial z) = z/(6 D^2) = z/(6(1 - z/3 - z w/2)^2)
$

== Подстановка $z = 1$, тогда вычисляем $D(1, w)$

$
  D(1, w) = 1 - 1/3 - w/2 = 2/3 - w/2
$

== Числитель: $[w^r]$ от $z (partial G)/(partial z)|_(z=1)$

$
  z (partial G)/(partial z) |_(z=1) = 1/(6(2/3 - w/2)^2)
$

Преобразуем:

$
  = 1/(6 dot (2/3)^2 dot (1 - (3w)/4)^2) = 1/(6 dot 4/9 dot (1 - (3w)/4)^2) = 9/(24(1 - (3w)/4)^2) = 3/(8(1 - (3w)/4)^2)
$

Используем разложение в ряд:

#box(
  width: 100%,
  fill: rgb("#fff4e6"),
  inset: 10pt,
  radius: 4pt,
)[
  *Известный ряд:*
  
  $ 1/((1-x)^2) = sum_(r=0)^infinity (r+1) x^r $
]

$
  3/(8(1 - (3w)/4)^2) = 3/8 sum_(r=0)^infinity (r+1) ((3w)/4)^r = 3/8 sum_(r=0)^infinity (r+1) dot (3^r)/(4^r) w^r
$

#box(
  width: 100%,
  fill: rgb("#e8f8e8"),
  inset: 10pt,
  radius: 4pt,
)[
  $ [w^r] z (partial G)/(partial z) |_(z=1) = (3(r+1))/(8) dot (3/4)^r = ((r+1) dot 3^(r+1))/(8 dot 4^r) $
]

== Знаменатель: $[w^r]$ от $G(1, w)$

$
  G(1, w) = (1/6)/(2/3 - w/2) = 1/(6(2/3 - w/2)) = 1/(4 - 3w) = 1/(4(1 - (3w)/4))
$

$
  = 1/4 sum_(r=0)^infinity ((3w)/4)^r = 1/4 sum_(r=0)^infinity (3/4)^r w^r
$

#box(
  width: 100%,
  fill: rgb("#e8f8e8"),
  inset: 10pt,
  radius: 4pt,
)[
  $ [w^r] G(1, w) = 1/4 dot (3/4)^r = (3^r)/(4^(r+1)) $
]

== Собираем все вместе

$
  EE[N | R = r] = (((r+1) dot 3^(r+1))/(8 dot 4^r))/((3^r)/(4^(r+1))) = ((r+1) dot 3^(r+1))/(8 dot 4^r) dot (4^(r+1))/(3^r)
$


$
  = ((r+1) dot 3 dot 4)/8 = (12(r+1))/8 = (3(r+1))/2
$

#box(
  width: 100%,
  fill: rgb("#e8f8e8"),
  inset: 15pt,
  radius: 4pt,
)[
  #align(center)[
    *Ответ (Метод 2):*
    $EE[N | R = r] = 3/2 (r + 1) $
    
    В частности $EE[N | R = 0] = 3/2$
    
    *Совпадает с Методом 1!* 
  ]
]

= Альтернативная форма через MGF

#box(
  width: 100%,
  fill: rgb("#fff4e6"),
  inset: 12pt,
  radius: 4pt,
)[
  *Производящая функция моментов:*
  
  $ M(t, w) = G(e^t, w) = EE[e^(t N) w^R] = (e^t slash 6)/(1 - e^t/3 - e^t w/2) $
  
  *Формула:*
  
  $ EE[N | R = r] = ([w^r] (partial M)/(partial t)|_(t=0))/([w^r] M(0, w)) $
  
  Вычисление даёт тот же результат, поскольку $e^t|_(t=0) = 1$ и $(partial e^t)/(partial t)|_(t=0) = 1$
]


#line(length: 100%, stroke: 1pt)

= Метод 3: Разложение $N$ и башенное свойство
 Этого не было на лекции, но было предложено найти альтернативное решение задачи, кроме метода первого шага и слов

#box(
  width: 100%,
  fill: rgb("#e8f4f8"),
  inset: 10pt,
  radius: 4pt,
)[
  == Ключевая идея
  
  Количество бросков до финала: $K = N - 1 tilde "Geom"(1/6)$
  
  При условии $K = k$: количество чётных $R | K tilde "Binomial"(k, 3/5)$
  
  (Среди продолжений: $P("чётное") = (1/2)/(5/6) = 3/5$)
]

== Условное ожидание через $K$

$
  EE[N | R = r] = EE[K + 1 | R = r] = EE[K | R = r] + 1
$

=== Распределение $K | R = r$

$
  P(K = k | R = r) = (P(R = r | K = k) dot P(K = k))/(P(R = r))
$

$
  = (C(k, r) (3/5)^r (2/5)^(k-r) dot (5/6)^k dot 1/6)/(1/4 dot (3/4)^r)
$

После упрощений:

$
  P(K = k | R = r) = C(k, r) dot (2/3)^(k-r) dot (1/3)^r dot (4/3)^r dot 4/6 dot ...
$

Это *отрицательное биномиальное* распределение

$
  K - r | (R = r) tilde "NegBin"(r + 1, 2/3)
$

=== Среднее

$
  EE[K - r | R = r] = (r + 1) dot (1/3)/(2/3) = (r+1)/2
$

$
  EE[K | R = r] = r + (r+1)/2 = (3r + 1)/2
$


#box(
  width: 100%,
  fill: rgb("#e8f8e8"),
  inset: 10pt,
  radius: 4pt,
)[
  *Итог:*
  $
    EE[N | R = r] = (3r + 1)/2 + 1 = (3r + 3)/2 = 3/2 (r + 1) quad checkmark
  $
  *Совпадает с Методом 1!* 
]