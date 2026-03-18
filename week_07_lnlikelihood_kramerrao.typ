#import "@preview/cetz:0.4.2": canvas, draw

#set page(paper: "a4", margin: 25mm)
#set text(lang: "ru", font: "New Computer Modern", size: 11pt)
#set par(justify: true, leading: 0.65em)
#set heading(numbering: none)

#show heading.where(level: 1): it => {
  v(0.6em)
  text(size: 13pt, weight: "bold")[#it.body]
  v(0.3em)
}
#show heading.where(level: 2): it => {
  v(0.4em)
  text(size: 11pt, weight: "bold")[#it.body]
  v(0.2em)
}

#align(center)[
  #text(size: 15pt, weight: "bold")[Логарифм правдоподобия и трюк Крамера]
]

#v(0.6em)

= Логарифм функции правдоподобия

Пусть $Y$ — случайная величина с плотностью (или функцией масс) $f(y; theta)$,
зависящей от параметра $theta$.

Определим *лог-правдоподобие*:
$
ell(y, theta) = ln f(y; theta)
$

Нас интересует *score-функция* — производная по параметру:
$
(partial ell)/(partial theta) = (partial ln f)/(partial theta) = (f'_theta)/(f)
$

= Ключевой факт: $E[(partial ell)/(partial theta)] = 0$

== Вывод

$
E[(partial ell)/(partial theta)] = integral_RR (partial ell)/(partial theta) f(y) d y = integral_RR (f'_theta)/(f) dot f d y = integral_RR (partial f)/(partial theta) d y
$

Теперь *переставим* дифференцирование и интегрирование:
$
integral_RR (partial f)/(partial theta) d y = (partial)/(partial theta) integral_RR f(y; theta) d y = (partial)/(partial theta)(1) = 0
$

#box(width: 100%, fill: rgb("#e8f8e8"), inset: 10pt, radius: 4pt)[
  *Трюк Крамера:*
  $
  E[(partial ell)/(partial theta)] = E[(f'_theta (Y; theta))/(f(Y; theta))] = 0
  $
  
  Условие применимости: пределы интегрирования (суммирования)
  *не зависят* от $theta$.
]

= Пример 1: $Y tilde "Exp"(lambda)$

Плотность: $f(y) = lambda e^(-lambda y)$, $y > 0$.

Лог-правдоподобие:
$
ell = ln f = ln lambda - lambda y
$

Score-функция:
$
(partial ell)/(partial lambda) = 1/lambda - y
$

По трюку Крамера:
$
E[1/lambda - Y] = 0 quad arrow.r.double quad 1/lambda = E[Y]
$

#box(width: 100%, fill: rgb("#e8f4f8"), inset: 10pt, radius: 4pt)[
  $E[Y] = 1/lambda$ $checkmark$
  
  Пределы интегрирования $(0, +infinity)$ не зависят от $lambda$ — трюк работает.
]

= Пример 2: $Y tilde "Pois"(lambda)$

Функция масс: $P(Y = k) = lambda^k e^(-lambda) / k!$, $k = 0, 1, 2, dots$

Лог-правдоподобие:
$
ell = ln P(Y = k) = k ln lambda - lambda - ln(k!)
$

Score-функция:
$
(partial ell)/(partial lambda) = k/lambda - 1
$

По трюку Крамера:
$
E[Y/lambda - 1] = 0 quad arrow.r.double quad E[Y]/lambda = 1
$

#box(width: 100%, fill: rgb("#e8f4f8"), inset: 10pt, radius: 4pt)[
  $E[Y] = lambda$ $checkmark$
  
  Пределы суммирования $k in {0, 1, 2, dots}$ не зависят от $lambda$ — трюк работает.
]

= Когда трюк НЕ работает: $Y tilde U[0, a)$

Плотность: $f(y) = 1/a$ при $y in [0, a)$, $0$ иначе.

Лог-правдоподобие: $ell = -ln a$.

Score-функция: $(partial ell)/(partial a) = -1/a$.

Формально: $E[-1/a] = -1/a eq.not 0$.

*Почему?* Верхний предел интегрирования $a$ *зависит* от параметра $a$!

$
(partial)/(partial a) integral_0^a 1/a d y eq.not integral_0^a (partial)/(partial a) 1/a d y
$

Левая часть: $(partial)/(partial a)(1) = 0$.
Правая часть: $integral_0^a (-1/a^2) d y = -1/a eq.not 0$.

Расхождение: при дифференцировании нужно учесть *подвижный предел*
(формула Лейбница), и добавочный член $f(a; a) dot 1 = 1/a$ восстанавливает равенство.

#box(width: 100%, fill: rgb("#fff4e6"), inset: 10pt, radius: 4pt)[
  *Важно:* трюк Крамера ($E[(partial ell)/(partial theta)] = 0$) работает
  *только если* носитель распределения не зависит от $theta$.
]

= Пример 3: $S tilde "Gamma"(n, lambda)$

Плотность: $f(s) = lambda^n / Gamma(n) s^(n-1) e^(-lambda s)$, $s > 0$.

Лог-правдоподобие:
$
ell = n ln lambda - ln Gamma(n) + (n-1) ln s - lambda s
$

== Дифференцирование по $lambda$

$
(partial ell)/(partial lambda) = n/lambda - s
$

По трюку Крамера: $E[n/lambda - S] = 0$

#box(width: 100%, fill: rgb("#e8f4f8"), inset: 10pt, radius: 4pt)[
  $E[S] = n/lambda$ $checkmark$
]

== Дифференцирование по $n$ (формально)

$
(partial ell)/(partial n) = ln lambda - psi(n) + ln s
$

где $psi(n) = Gamma'(n)/Gamma(n)$ — дигамма-функция.

По трюку Крамера: $E[ln lambda - psi(n) + ln S] = 0$

$
E[ln S] = psi(n) - ln lambda
$

Это тоже полезная формула, которую «бесплатно» получили дифференцированием.

= Пример 4: $Y tilde "Binom"(n, p)$

Функция масс: $P(Y = k) = binom(n, k) p^k (1-p)^(n-k)$, $k = 0, 1, dots, n$.

Лог-правдоподобие:
$
ell = ln binom(n, k) + k ln p + (n-k) ln(1-p)
$

Score-функция по $p$:
$
(partial ell)/(partial p) = k/p - (n-k)/(1-p)
$

По трюку Крамера: $E[Y/p - (n - Y)/(1-p)] = 0$

$
E[Y]/p = (n - E[Y])/(1-p)
$

$
E[Y](1-p) = p(n - E[Y])
$

$
E[Y] - E[Y] p = n p - E[Y] p
$

#box(width: 100%, fill: rgb("#e8f4f8"), inset: 10pt, radius: 4pt)[
  $E[Y] = n p$ $checkmark$
  
  Пределы суммирования $k in {0, dots, n}$ не зависят от $p$ — трюк работает.
  
  (Но $n$ здесь фиксировано; если бы мы дифференцировали по $n$,
  верхний предел суммирования изменился бы — и трюк был бы неприменим напрямую.)
]


#import "@preview/cetz:0.4.2": canvas, draw

#set page(paper: "a4", margin: 25mm)
#set text(lang: "ru", font: "New Computer Modern", size: 11pt)
#set par(justify: true, leading: 0.65em)
#set heading(numbering: none)

#show heading.where(level: 1): it => {
  v(0.6em)
  text(size: 13pt, weight: "bold")[#it.body]
  v(0.3em)
}
#show heading.where(level: 2): it => {
  v(0.4em)
  text(size: 11pt, weight: "bold")[#it.body]
  v(0.2em)
}

#align(center)[
  #text(size: 15pt, weight: "bold")[Неравенство Крамера–Рао]
]

#v(0.6em)

= Два главных тождества

Пусть $ell(y, theta) = ln f(y; theta)$ — лог-правдоподобие.

#box(width: 100%, fill: rgb("#e8f4f8"), inset: 10pt, radius: 4pt)[
  *Тождество 1 (score):*
  $
  E[(partial ell)/(partial theta)] = 0
  $

  *Тождество 2 (Гессиан + дисперсия score):*
  $
  E[(partial^2 ell)/(partial theta partial theta^top)] + E[(partial ell)/(partial theta) dot (partial ell)/(partial theta^top)] = 0
  $

  Второе слагаемое — это $"Var"((partial ell)/(partial theta))$, поскольку $E[(partial ell)/(partial theta)] = 0$

  Кратко: $E["He"(ell)] + "Var"("grad" ell) = 0$
]

= Пример 1: $Y tilde "Exp"(lambda)$

$f = lambda e^(-lambda y)$, $ell = ln lambda - lambda y$.

Первая производная: $ell'_lambda = 1/lambda - y$.
По Тождеству 1: $E[1/lambda - Y] = 0$ $arrow.r.double$ $E[Y] = 1/lambda$.

Вторая производная: $ell''_(lambda lambda) = -1/lambda^2$.

По Тождеству 2:
$
E[ell''_(lambda lambda)] + "Var"(ell'_lambda) = 0
$
$
-1/lambda^2 + "Var"(1/lambda - Y) = 0
$
$
"Var"(Y) = 1/lambda^2
$

#box(width: 100%, fill: rgb("#e8f8e8"), inset: 10pt, radius: 4pt)[
  $E[Y] = 1/lambda$, $"Var"(Y) = 1/lambda^2$ $checkmark$
]

= Пример 2: $Y tilde "Pois"(lambda)$

$P(Y=k) = lambda^k e^(-lambda)/k!$, $ell = k ln lambda - lambda - ln(k!)$.

$ell'_lambda = k/lambda - 1$, $ell''_(lambda lambda) = -k/lambda^2$.

Тождество 1: $E[Y]/lambda - 1 = 0$ $arrow.r.double$ $E[Y] = lambda$.

Тождество 2:
$
-E[Y]/lambda^2 + "Var"(Y/lambda - 1) = 0
$
$
-lambda/lambda^2 + "Var"(Y)/lambda^2 = 0
$
$
"Var"(Y) = lambda
$

#box(width: 100%, fill: rgb("#e8f8e8"), inset: 10pt, radius: 4pt)[
  $E[Y] = lambda$, $"Var"(Y) = lambda$ $checkmark$
]

= Пример 3: $Y tilde "Geom"(p)$

$P(Y=k) = (1-p)^(k-1) p$, $k = 1, 2, dots$

$ell = (k-1) ln(1-p) + ln p$.

$ell'_p = -(k-1)/(1-p) + 1/p$, $ell''_(p p) = -(k-1)/(1-p)^2 - 1/p^2$.

Тождество 1: $-(E[Y]-1)/(1-p) + 1/p = 0$ $arrow.r.double$ $E[Y] = 1/p$.

Тождество 2:
$
E[-(Y-1)/(1-p)^2 - 1/p^2] + "Var"(ell'_p) = 0
$

Подставим $E[Y-1] = (1-p)/p$:
$
-1/(p(1-p)) - 1/p^2 + "Var"(ell'_p) = 0
$

$"Var"(ell'_p) = "Var"(Y)/(1-p)^2$, поэтому:
$
"Var"(Y)/(1-p)^2 = 1/(p(1-p)) + 1/p^2 = 1/(p^2(1-p))
$
$
"Var"(Y) = (1-p)/p^2
$

#box(width: 100%, fill: rgb("#e8f8e8"), inset: 10pt, radius: 4pt)[
  $E[Y] = 1/p$, $"Var"(Y) = (1-p)/p^2$ $checkmark$
]

= Пример 4: $Y tilde cal(N)(mu, sigma^2)$ — два параметра

$ell = -1/2 ln(2 pi) - ln sigma - (y-mu)^2/(2 sigma^2)$.

Параметры: $theta = (mu, sigma)^top$.

== Производные по $mu$

$ell'_mu = (y-mu)/sigma^2$, $ell''_(mu mu) = -1/sigma^2$.

Тождество 1: $E[Y-mu]/sigma^2 = 0$ $arrow.r.double$ $E[Y] = mu$ $checkmark$

Тождество 2: $-1/sigma^2 + "Var"(Y)/sigma^4 = 0$ $arrow.r.double$ $"Var"(Y) = sigma^2$ $checkmark$

== Производные по $sigma$

$ell'_sigma = -1/sigma + (y-mu)^2/sigma^3$, $ell''_(sigma sigma) = 1/sigma^2 - 3(y-mu)^2/sigma^4$.

Тождество 1: $-1/sigma + E[(Y-mu)^2]/sigma^3 = 0$ $arrow.r.double$ $E[(Y-mu)^2] = sigma^2$ $checkmark$

Тождество 2 даёт $E[(Y-mu)^4]$ через уже известные моменты.

== Смешанная производная

$ell''_(mu sigma) = -2(y-mu)/sigma^3$.

$E[ell''_(mu sigma)] = 0$, что означает *ортогональность* score-функций по $mu$ и $sigma$ — оценки $hat(mu)$ и $hat(sigma)$ асимптотически независимы.

= Доказательство Тождества 2

Так как $E[ell'_theta] = 0$, имеем $"Var"(ell'_theta) = E[(ell'_theta)^2]$.

Нужно показать: $E[ell''_(theta theta) + (ell'_theta)^2] = 0$.

Раскрываем через интеграл:
$
E[ell''_(theta theta) + (ell'_theta)^2] = integral (ell''_(theta theta) + (ell'_theta)^2) f d y
$

Подставляем $ell'_theta = f'_theta / f$:
$
ell''_(theta theta) = (f''_(theta theta) dot f - (f'_theta)^2) / f^2
$

Тогда:
$
ell''_(theta theta) + (ell'_theta)^2 = (f''_(theta theta)) / f - (f'_theta)^2 / f^2 + (f'_theta)^2 / f^2 = (f''_(theta theta)) / f
$

Интегрируем:
$
integral (f''_(theta theta)) / f dot f d y = integral f''_(theta theta) d y = (partial^2) / (partial theta^2) integral f d y = (partial^2) / (partial theta^2)(1) = 0 quad checkmark
$

= Информация Фишера

#box(width: 100%, fill: rgb("#e8f4f8"), inset: 10pt, radius: 4pt)[
  *Определение:*
  $
  I_F (theta) = "Var"(ell'_theta) = E[(ell'_theta)^2] = -E[ell''_(theta theta)]
  $

  Три эквивалентные формулы (по Тождеству 2).
]

Для выборки $(y_1, dots, y_n)$ из одного распределения:
$I_F^((n))(theta) = n dot I_F (theta)$ (информация аддитивна).

= Неравенство Крамера–Рао

== Формулировка

Пусть $hat(theta) = hat(theta)(Y)$ — произвольная оценка параметра $theta$.

#box(width: 100%, fill: rgb("#e8f8e8"), inset: 10pt, radius: 4pt)[
  *Неравенство Крамера–Рао:*
  $
  "Var"(hat(theta)) >= ((partial E[hat(theta)])/(partial theta))^2 / I_F (theta)
  $

  Для *несмещённой* оценки ($E[hat(theta)] = theta$):
  $
  "Var"(hat(theta)) >= 1 / I_F (theta)
  $
]

== Доказательство

Рассмотрим $"corr"(hat(theta), ell'_theta)$. По определению:
$
"corr"^2(hat(theta), ell'_theta) <= 1
$

$
("Cov"(hat(theta), ell'_theta))^2 / ("Var"(hat(theta)) dot "Var"(ell'_theta)) <= 1
$

$
"Var"(hat(theta)) >= ("Cov"(hat(theta), ell'_theta))^2 / I_F (theta)
$

Осталось вычислить ковариацию.

== Вычисление $"Cov"(hat(theta), ell'_theta)$

$
"Cov"(hat(theta), ell'_theta) = E[hat(theta) ell'_theta] - E[hat(theta)] dot underbrace(E[ell'_theta], = 0) = E[hat(theta) ell'_theta]
$

Раскрываем через интеграл:
$
E[hat(theta) ell'_theta] = integral hat(theta)(y) dot (f'_theta(y)) / (f(y)) dot f(y) d y = integral hat(theta)(y) f'_theta(y) d y
$

Переставляем дифференцирование и интегрирование:
$
= (partial) / (partial theta) integral hat(theta)(y) f(y; theta) d y = (partial E[hat(theta)]) / (partial theta)
$

Итого:
$
"Cov"(hat(theta), ell'_theta) = (partial E[hat(theta)]) / (partial theta)
$

Подставляя в неравенство:
$
"Var"(hat(theta)) >= ((partial E[hat(theta)])/(partial theta))^2 / I_F
$

Для несмещённой оценки $(partial E[hat(theta)])/(partial theta) = 1$:
$
"Var"(hat(theta)) >= 1 / I_F quad checkmark
$

== Когда достигается равенство?

$"corr"^2(hat(theta), ell'_theta) = 1$ тогда и только тогда, когда
$hat(theta)$ *линейно* зависит от $ell'_theta$:

$
hat(theta) = a(theta) + b(theta) dot ell'_theta
$

#box(width: 100%, fill: rgb("#fff4e6"), inset: 10pt, radius: 4pt)[
  *Равенство в Крамера–Рао достигается $arrow.l.r.double$ $hat(theta)$ — линейная функция score.*

  Если зависимость нелинейная — строгое неравенство, и нижняя граница *недостижима*.
]
