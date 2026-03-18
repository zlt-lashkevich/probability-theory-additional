#import "@preview/cetz:0.4.2": canvas, draw

#set page(paper: "a4", margin: 25mm)
#set text(lang: "ru", font: "New Computer Modern", size: 11pt)
#set par(justify: true, leading: 0.65em)
#set heading(numbering: none)

#align(center)[
  #text(size: 17pt, weight: "bold")[Гамма и Бета из дифференциальных форм]
]

#v(1em)

=== Одномерный случай

$
f(x) d x quad arrow.r^(x = h(y)) quad f(h(y)) d(h(y)) = f(h(y)) h'(y) d y
$

=== Многомерный случай

$
f(x, y) d x and d y quad arrow.r^(x = h_1(u,v),; y = h_2(u,v)) quad
f(h_1, h_2) d h_1 and d h_2
$

где $d h_i = (partial h_i) / (partial u) d u + (partial h_i) / (partial v) d v$,
а якобиан «выпадает» автоматически из свойств $d u and d u = 0$, $d u and d v = -d v and d u$.

== Упражнение

Пусть $y_1, dots, y_n$ — независимые, $y_i tilde "Exp"(lambda)$

Определим новые переменные:
$
S &= y_1 + y_2 + dots + y_n \
R_1 &= y_1 / (y_1 + y_2) \
R_i &= (y_1 + dots + y_i) / (y_1 + dots + y_(i+1)), quad i = 2, dots, n-1
$

*Задачи:*

а) Найти совместную плотность $(S, R_1, dots, R_(n-1))$

б) С точностью до константы найти маргинальные плотности $f_S, f_(R_i)$

== Взаимно однозначное соответствие

== Из $(y_1, dots, y_n)$ в $(S, R_1, dots, R_(n-1))$

Обозначим частичные суммы: $s_k = y_1 + dots + y_k$.

Тогда:
$
S = s_n, quad R_k = s_k / s_(k+1), quad k = 1, dots, n-1
$

== Обратно: из $(S, R_1, dots, R_(n-1))$ в $(y_1, dots, y_n)$

Частичные суммы восстанавливаются:
$
s_n &= S \
s_(n-1) &= R_(n-1) S \
s_(n-2) &= R_(n-2) R_(n-1) S \
&dots.v \
s_1 &= R_1 R_2 dots R_(n-1) S
$

Отсюда:
$
y_1 &= s_1 = R_1 R_2 dots R_(n-1) S \
y_2 &= s_2 - s_1 = R_2 dots R_(n-1) S - R_1 R_2 dots R_(n-1) S = (1 - R_1) R_2 dots R_(n-1) S \
y_3 &= s_3 - s_2 = (1 - R_2) R_3 dots R_(n-1) S \
&dots.v \
y_k &= (1 - R_(k-1)) R_k R_(k+1) dots R_(n-1) S, quad k >= 2 \
y_n &= (1 - R_(n-1)) S
$

== Вычисление якобиана через внешнее произведение

=== Упрощение $d y_1 and d y_2$

$
d y_1 = d(R_1 R_2 dots R_(n-1) S)
$

$
d y_2 = d((1-R_1) R_2 dots R_(n-1) S)
$

Обозначим $A = R_2 R_3 dots R_(n-1) S$ (общий множитель). Тогда:

$
d y_1 &= A d R_1 + R_1 d A \
d y_2 &= -A d R_1 + (1-R_1) d A
$

Внешнее произведение:
$
d y_1 and d y_2 &= (A d R_1 + R_1 d A) and (-A d R_1 + (1-R_1) d A) \
&= A(1-R_1) d R_1 and d A + R_1 (-A) d A and d R_1 \
&= A(1-R_1) d R_1 and d A + R_1 A d R_1 and d A \
&= A d R_1 and d A
$

Но $A = R_2 dots R_(n-1) S$, поэтому:

$
d y_1 and d y_2 = (R_2 dots R_(n-1) S) d R_1 and d(R_2 dots R_(n-1) S)
$

=== Теперь еще присоединим $d y_3$

$
y_3 = (1 - R_2) R_3 dots R_(n-1) S
$

По той же схеме, но теперь «буква» $R_2$ отделяется от
$B = R_3 dots R_(n-1) S$:

$
d y_1 and d y_2 and d y_3 = (R_2 dots R_(n-1) S) d R_1 and B d R_2 and d(R_3 dots R_(n-1) S)
$

$
= R_2 B^2 S d R_1 and d R_2 and d(R_3 dots R_(n-1) S)
$

Подставляя $B = R_3 dots R_(n-1) S$:

$
= R_2 (R_3 dots R_(n-1) S)^2 S d R_1 and d R_2 and d(R_3 dots R_(n-1) S)
$

Упростим: множитель при $d R_1 and d R_2$ содержит $R_2^1$.

=== Общий результат по индукции

Продолжая попарно, на каждом шаге $k$ отделяем $R_k$ от оставшегося «хвоста»:

$
d y_1 and d y_2 and dots and d y_n = R_1^0 dot R_2^1 dot R_3^2 dot dots dot R_(n-1)^(n-2) dot S^(n-1) dot d R_1 and d R_2 and dots and d R_(n-1) and d S
$

#box(
  width: 100%,
  fill: rgb("#e8f8e8"),
  inset: 12pt,
  radius: 4pt,
)[
  *Якобиан:*
  $
  d y_1 and dots and d y_n = product_(i=1)^(n-1) R_i^(i-1) dot S^(n-1) dot d R_1 and dots and d R_(n-1) and d S
  $
]

= Совместная плотность в новых координатах

== Исходная совместная плотность

$y_i tilde "Exp"(lambda)$ независимые:
$
f(y_1, dots, y_n) = product_(i=1)^n lambda e^(-lambda y_i) = lambda^n e^(-lambda(y_1 + dots + y_n)) = lambda^n e^(-lambda S)
$

== Подстановка

$
f(y_1, dots, y_n) d y_1 and dots and d y_n = lambda^n e^(-lambda S) dot product_(i=1)^(n-1) R_i^(i-1) dot S^(n-1) dot d R_1 and dots and d R_(n-1) and d S
$

#box(
  width: 100%,
  fill: rgb("#e8f4f8"),
  inset: 12pt,
  radius: 4pt,
)[
  *Совместная плотность:*
  $
  f_(S, R_1, dots, R_(n-1))(s, r_1, dots, r_(n-1)) = lambda^n e^(-lambda s) s^(n-1) product_(i=1)^(n-1) r_i^(i-1)
  $
  
  при $s > 0$, $r_i in [0, 1]$ для всех $i$.
]
= Независимость и маргинальные плотности

Совместная плотность *разбивается в произведение*:
$
f = underbrace(lambda^n e^(-lambda s) s^(n-1), "зависит только от" s) dot underbrace(r_1^0, "от" r_1) dot underbrace(r_2^1, "от" r_2) dot dots dot underbrace(r_(n-1)^(n-2), "от" r_(n-1))
$

$arrow.r.double$ $S, R_1, R_2, dots, R_(n-1)$ *взаимно независимы*
$
f = underbrace(c_S s^(n-1) e^(-lambda s), f_S) dot product_(i=1)^(n-1) underbrace(c_i r_i^(i-1), f_(R_i))
$

== Константы $c_i$ для $R_i$

$
integral_0^1 c_i r^(i-1) d r = c_i\/i = 1
arrow.r.double c_i = i
$

#table(
  columns: 4,
  stroke: 0.5pt,
  inset: 5pt,
  align: center,
  fill: (col, row) => if row == 0 { rgb("#e8f4f8") },
  [*Перем.*], [*Ядро*], [*Интеграл*], [*$c_i$*],
  [$R_1$], [$1$], [$1$], [$1$],
  [$R_2$], [$r$], [$1\/2$], [$2$],
  [$R_3$], [$r^2$], [$1\/3$], [$3$],
  [$R_k$], [$r^(k-1)$], [$1\/k$], [$k$],
  [$R_(n-1)$], [$r^(n-2)$], [$1\/(n-1)$], [$n-1$],
)

Итого $f_(R_i)(r) = i r^(i-1)$, $r in [0,1]$ — это $R_i tilde "Beta"(i,1)$

== Константа $c_S$ для $S$

Замена $u = lambda s$:
$
integral_0^infinity s^(n-1) e^(-lambda s) d s = Gamma(n)\/lambda^n = (n-1)!\/lambda^n
$
поэтому $c_S = lambda^n\/(n-1)!$


=== Плотность $S$ (Гамма-распределение)

$
f_S (s) prop lambda^n s^(n-1) e^(-lambda s), quad s > 0
$

Нормировочная константа: $integral_0^infinity s^(n-1) e^(-lambda s) d s = Gamma(n) / lambda^n$

#box(
  width: 100%,
  fill: rgb("#e8f8e8"),
  inset: 12pt,
  radius: 4pt,
)[
  *Определение Гамма-распределения:*
  $
  S tilde "Gamma"(n, lambda) quad arrow.l.r.double quad tilde (s) = lambda^n / Gamma(n) s^(n-1) e^(-lambda s), quad s > 0
  $
  
  Смысл: $S$ — время обслуживания $n$ клиентов, если кофейня обслуживает
  $lambda$ клиентов в минуту.
]

=== Плотность $R_i$ (Бета-распределение)

$
f_(R_i)(r) prop r^(i-1), quad r in [0, 1]
$

Нормировка: $integral_0^1 r^(i-1) d r = 1/i$, значит $f_(R_i)(r) = i dot r^(i-1)$.

Это $"Beta"(i, 1)$.

В общем случае:

#box(
  width: 100%,
  fill: rgb("#e8f8e8"),
  inset: 12pt,
  radius: 4pt,
)[
  *Определение Бета-распределения:*
  
  Пусть всего $a + b$ клиентов, $a$ заказали капучино, $b$ — раф.
  Время на обслуживание $y_i tilde "Exp"(lambda)$ независимы.
  
  $
  R = (y_1 + dots + y_a) / (y_1 + dots + y_(a+b)) = ("Gamma"(a, lambda)) / ("Gamma"(a, lambda) + "Gamma"(b, lambda)) tilde "Beta"(a, b)
  $
  
  $
  f_R (r) = 1 / (B(a, b)) r^(a-1) (1-r)^(b-1), quad r in [0, 1]
  $
  
  Важно: $lambda$ *сокращается*! Распределение $R$ не зависит от $lambda$.
]

=== Почему $lambda$ есть только в $f_S$

Параметр $lambda$ определяет *масштаб* времени обслуживания.

$R_i$ — это *доля*, безразмерная величина $arrow.r$ не может зависеть от $lambda$.

Если бы при раскрытии скобок коэффициенты с $lambda$ сократились,
мы восстановили бы константы из условия нормировки:
$
integral_0^1 f_(R_i)(r) d r = 1
$

== Упражнение 2: полярные координаты

В заключение — классический пример той же техники.

Переход $(x, y) arrow.r (rho, phi)$:
$
x = rho cos phi, quad y = rho sin phi
$

$
d x = cos phi d rho - rho sin phi d phi
$
$
d y = sin phi d rho + rho cos phi d phi
$

Внешнее произведение:
$
d x and d y &= (cos phi d rho - rho sin phi d phi) and (sin phi d rho + rho cos phi d phi) \
&= cos phi dot rho cos phi (d rho and d phi) + (-rho sin phi) dot sin phi (d phi and d rho) \
&= rho cos^2 phi (d rho and d phi) + rho sin^2 phi (d rho and d phi) \
&= rho (d rho and d phi)
$

(использовали $d rho and d rho = 0$, $d phi and d rho = -d rho and d phi$)



#box(
  width: 100%,
  fill: rgb("#f0f0ff"),
  inset: 10pt,
  radius: 4pt,
)[
  *Техника:* подставляем $x_i = h_i(u, v, dots)$ прямо в дифференциальную форму,
  якобиан «выпадает» из алгебры $d x and d y = -d y and d x$, $d x and d x = 0$.
  
  
  #table(
    columns: 3,
    stroke: 0.5pt,
    inset: 6pt,
    align: center,
    fill: (col, row) => if row == 0 { rgb("#e8f4f8") },
    [*Переменная*], [*Распределение*], [*Плотность (с точн. до const)*],
    [$S = sum y_i$], [$"Gamma"(n, lambda)$], [$s^(n-1) e^(-lambda s)$],
    [$R_i = s_i \/ s_(i+1)$], [$"Beta"(i, 1)$], [$r^(i-1)$],
    [$R = "Gamma"(a) \/ ("Gamma"(a) + "Gamma"(b))$], [$"Beta"(a, b)$], [$r^(a-1)(1-r)^(b-1)$],
  )
  
  Все переменные $S, R_1, dots, R_(n-1)$ *взаимно независимы*.
  
  *Источники:* Michael Denn, _Differential Forms_;
  аналогичная техника у Пойя (картинопись) и Уэдерберна.
]