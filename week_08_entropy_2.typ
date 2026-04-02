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
  #text(size: 15pt, weight: "bold")[Трюк Фейнмана, кумулянты score и энтропия]
  #v(0.2em)
  #text(size: 10pt)[Дифференцирование тождеств, cross-entropy, дискретное → непрерывное]
]

#v(0.6em)

= Трюк Фейнмана: дифференцируем известное тождество

Идея: если известно $sum_(k=1)^infinity a_k(theta) = C$ или $integral_0^1 f(x, theta) d x = C$,
то, дифференцируя по $theta$, получаем *новые* тождества бесплатно.

== Пример: $X tilde "Geom"(p)$

$P(X=k) = (1-p)^(k-1) p$, $k = 1, 2, dots$

Исходное тождество (нормировка):
$
sum_(k=1)^infinity (1-p)^(k-1) p = 1
$

Делим на $p$:
$
sum_(k=1)^infinity (1-p)^(k-1) = 1/p
$

Дифференцируем по $p$:
$
sum_(k=1)^infinity (k-1)(1-p)^(k-2)(-1) = -1/p^2
$

$
sum_(k=1)^infinity (k-1)(1-p)^(k-2) = 1/p^2
$

Умножая на $p(1-p)$, получаем $E[X(X-1)]$ и далее $"Var"(X)$ — всё из одного тождества.

== Пример: интеграл $integral x^3 e^x d x$ без интегрирования по частям

Вместо трёхкратного IBP, заметим:
$
integral e^(lambda x) d x = e^(lambda x)/lambda + C
$

Дифференцируем по $lambda$ три раза:
$
(d^3)/(d lambda^3) integral e^(lambda x) d x = integral x^3 e^(lambda x) d x
$

Справа:
$
(d^3)/(d lambda^3) (e^(lambda x)/lambda) = dots
$

При $lambda = 1$ получаем ответ, не интегрируя по частям ни разу.

= Цепочка тождеств из $integral f d x = 1$

== Без дополнительной информации

Стартовое тождество:
$
integral_RR f(x; theta) d x = 1
$

$d/(d theta)$:
$
integral_RR f'/f dot f d x = 0 quad arrow.r.double quad E[ell'] = 0
$

$d/(d theta)$ ещё раз:
$
integral_RR (ell'' + ell' dot ell') f d x = 0 quad arrow.r.double quad E[ell'' + (ell')^2] = 0
$

$d/(d theta)$ в третий раз:
$
E[ell''' + 3 ell' ell'' + (ell')^3] = 0
$

#box(width: 100%, fill: rgb("#e8f4f8"), inset: 10pt, radius: 4pt)[
  *Пояснение:* каждое следующее дифференцирование порождает
  «колокольные полиномы» от производных $ell$:
  
  - Порядок 1: $E[ell'] = 0$
  - Порядок 2: $E[ell''] + E[(ell')^2] = 0$  (связь Гессиана и дисперсии score)
  - Порядок 3: $E[ell'''] + 3 E[ell' ell''] + E[(ell')^3] = 0$  (третий кумулянт score)
  
  Это *кумулянтные соотношения* Бартлетта.
]

== С дополнительной информацией $E[x^3] = theta$

$
integral_RR x^3 f d x = theta
$

$d/(d theta)$:
$
integral_RR x^3 ell' f d x = 1 quad arrow.r.double quad E[X^3 ell'] = 1
$

Это частный случай общего факта про ковариацию оценки и score (см. ниже).

== Несмещённая оценка и score

Пусть $g(y_1, dots, y_n)$ — несмещённая оценка $theta$:
$E[g] = theta$.

Дифференцируем по $theta$:
$
integral_(RR^n) g f' d y = 1 quad arrow.r.double quad integral_(RR^n) g ell' f d y = 1
$

$
E[g ell'] = 1
$

Но $E[ell'] = 0$, значит:
$
"Cov"(g, ell') = E[g ell'] - E[g] E[ell'] = 1 - 0 = 1
$

#box(width: 100%, fill: rgb("#e8f8e8"), inset: 10pt, radius: 4pt)[
  *Факт:* для любой несмещённой оценки $g$: $"Cov"(g, ell') = 1$.
  
  Это основа неравенства Крамера–Рао.
]

= Энтропия

== Мотивация: игра «Чёрный ящик»

В ящике один из предметов. Угадываем, задавая вопросы «да/нет».
$Q$ — число вопросов до угадывания.

#table(
  columns: 6,
  stroke: 0.5pt,
  inset: 5pt,
  align: center,
  fill: (col, row) => if row == 0 { rgb("#e8f4f8") },
  [*$X$*], [попугай], [помидор], [папка], [земля], [мороженое],
  [*$P$*], [$1\/2$], [$1\/4$], [$1\/16$], [$1\/8$], [$1\/16$],
  [*код*], [`1`], [`01`], [`0001`], [`001`], [`0000`],
  [*$Q$*], [$1$], [$2$], [$4$], [$3$], [$4$],
)

== Оптимальная стратегия (дерево вопросов)

#align(center)[
#canvas(length: 0.8cm, {
  import draw: *

  // Корень
  circle((5, 8), radius: 0.3, fill: rgb("#aaddff"))
  content((5, 8), text(size: 7pt)[$?$])

  // Уровень 1
  circle((2, 6), radius: 0.3, fill: rgb("#aaffaa"))
  content((2, 6), text(size: 6pt)[поп.])
  line((4.7, 7.8), (2.3, 6.2), stroke: 0.5pt)
  content((3, 7.3), text(size: 6pt)[да])

  circle((8, 6), radius: 0.3, fill: rgb("#aaddff"))
  content((8, 6), text(size: 7pt)[$?$])
  line((5.3, 7.8), (7.7, 6.2), stroke: 0.5pt)
  content((7, 7.3), text(size: 6pt)[нет])

  // Уровень 2
  circle((6, 4), radius: 0.3, fill: rgb("#aaffaa"))
  content((6, 4), text(size: 6pt)[пом.])
  line((7.7, 5.8), (6.3, 4.2), stroke: 0.5pt)
  content((6.5, 5.3), text(size: 6pt)[да])

  circle((10, 4), radius: 0.3, fill: rgb("#aaddff"))
  content((10, 4), text(size: 7pt)[$?$])
  line((8.3, 5.8), (9.7, 4.2), stroke: 0.5pt)
  content((9.5, 5.3), text(size: 6pt)[нет])

  // Уровень 3
  circle((9, 2), radius: 0.3, fill: rgb("#aaffaa"))
  content((9, 2), text(size: 6pt)[зем.])
  line((9.7, 3.8), (9.3, 2.2), stroke: 0.5pt)

  circle((11, 2), radius: 0.3, fill: rgb("#aaddff"))
  content((11, 2), text(size: 7pt)[$?$])
  line((10.3, 3.8), (10.7, 2.2), stroke: 0.5pt)

  // Уровень 4
  circle((10, 0), radius: 0.3, fill: rgb("#aaffaa"))
  content((10, 0), text(size: 6pt)[мор.])
  line((10.7, 1.8), (10.3, 0.2), stroke: 0.5pt)

  circle((12, 0), radius: 0.3, fill: rgb("#aaffaa"))
  content((12, 0), text(size: 6pt)[пап.])
  line((11.3, 1.8), (11.7, 0.2), stroke: 0.5pt)
})]

== Среднее число вопросов

$
E[Q] = 1/2 dot 1 + 1/4 dot 2 + 1/8 dot 3 + 1/16 dot 4 + 1/16 dot 4
$

Заметим: $Q_i = log_(1\/2)(p_i) = -log_2(p_i)$.

$
E[Q] = sum_i p_i (-log_2 p_i) = -sum_i p_i log_2 p_i
$

#box(width: 100%, fill: rgb("#e8f8e8"), inset: 10pt, radius: 4pt)[
  *Энтропия Шеннона:*
  $
  H(X) = -E[log_2 f(X)] = -sum_t P(X=t) log_2 P(X=t) quad ["бит"]
  $
  
  Смысл: среднее число вопросов «да/нет» до угадывания $X$.
]

== Биты и наты

Ранее мы определяли энтропию через натуральный логарифм:
$
H_("нат")(X) = -E[ln f(X)] quad ["нат" = "natural bit"]
$

Связь:
$
1 "нат" = log_2 e = 1/ln 2 approx 1.4427 "бит"
$

$
H_("бит") = H_("нат") / ln 2
$

= Кросс-энтропия

== Определение

Пусть *истинное* распределение $p$, а мы *думаем*, что распределение $q$.
Тогда наша стратегия вопросов оптимальна для $q$, но используется при $p$.

$
"CE"(p || q) = -sum_t p(t) log_2 q(t) = -E_p [log_2 q(X)]
$

Интерпретация: среднее число вопросов при *неправильных* предположениях.

== Упражнение: $min_q "CE"(p || q) = H(p)$

Минимизируем $"CE"(p || q) = -sum_t p_t ln q_t$ при условии $sum_t q_t = 1$.

Лагранжиан:
$
cal(L) = -sum_t p_t ln q_t + lambda (sum_t q_t - 1)
$

Условие первого порядка:
$
(partial cal(L))/(partial q_t) = -p_t / q_t + lambda = 0 quad arrow.r.double quad q_t = p_t / lambda
$

Из условия $sum q_t = 1$: $lambda = 1$, значит $q_t = p_t$.

$
min_q "CE"(p || q) = "CE"(p || p) = -sum_t p_t ln p_t = H(p) quad checkmark
$

#box(width: 100%, fill: rgb("#e8f4f8"), inset: 10pt, radius: 4pt)[
  *Факт:* $"CE"(p || q) >= H(p)$, равенство $arrow.l.r.double$ $q = p$.
  
  Разность $"CE"(p || q) - H(p) = D_("KL")(p || q) >= 0$ — расстояние Кульбака–Лейблера.
]

= От дискретной к непрерывной энтропии

== Дискретизация непрерывной с.в.

Пусть $X$ — непрерывная с.в. с плотностью $f_X$.
Дискретизуем с шагом $delta$: $X^delta$ принимает значения $t, t+delta, t+2delta, dots$

$
P(X^delta = t) = f_X (t) delta + o(delta)
$

Энтропия дискретизированной величины:
$
H(X^delta) = -sum_t ln(f_X (t) delta + o(delta)) dot (f_X (t) delta + o(delta))
$

== Шаг 1: отбрасываем $o(delta)$

$
H(X^delta) approx -sum_t (ln f_X (t) + ln delta) dot f_X (t) delta
$

$
= underbrace(-sum_t ln f_X (t) dot f_X (t) delta, arrow.r -integral f ln f d x) - ln delta underbrace(dot sum_t f_X (t) delta, arrow.r 1)
$

$
H(X^delta) approx underbrace(-E[ln f_X (X)], h(X)) - ln delta
$

== Шаг 2: оправдание

При $delta -> 0$: $H(X^delta) -> infinity$ (нужно бесконечно много вопросов
для бесконечной точности). Но *разность*
$
H(X^delta) - (-ln delta)
$
стабилизируется и равна $h(X)$.

Сравнивая две дискретизации $X^delta$ и $Y^delta$ одинаковой точности $delta$:
$
H(X^delta) - H(Y^delta) approx h(X) - h(Y)
$

Слагаемое $-ln delta$ *сокращается* — поэтому для сравнений достаточно
дифференциальной энтропии.

#box(width: 100%, fill: rgb("#e8f8e8"), inset: 10pt, radius: 4pt)[
  *Дифференциальная энтропия:*
  $
  h(X) = -E[ln f_X (X)] = -integral_RR f_X (x) ln f_X (x) d x quad ["нат"]
  $
  
  Это *не* число вопросов (оно бесконечно), а «информативная» часть,
  не зависящая от точности дискретизации.
]

== Кросс-энтропия в непрерывном случае

$
"CE"(p || q) = -integral p(x) ln q(x) d x = -E_p [ln q(X)]
$

Аналогично: $"CE"(p || q) >= h(p)$, равенство при $q = p$.

= Итоговая сводка

#box(width: 100%, fill: rgb("#f0f0ff"), inset: 10pt, radius: 4pt)[
  *Трюк Фейнмана:* дифференцирование $integral f = 1$ по $theta$ даёт
  цепочку кумулянтных тождеств для score $ell'$.

  *Энтропия:*
  
  #table(
    columns: 3,
    stroke: 0.5pt,
    inset: 5pt,
    align: center,
    fill: (col, row) => if row == 0 { rgb("#e8f4f8") },
    [*Величина*], [*Формула*], [*Единицы*],
    [Энтропия (дискр.)], [$-sum p_t log_2 p_t$], [бит],
    [Энтропия (непр.)], [$-integral f ln f d x$], [нат],
    [Кросс-энтропия], [$-E_p [ln q]$], [нат],
    [KL-дивергенция], [$E_p [ln(p\/q)] >= 0$], [нат],
  )

  $1 "нат" = 1\/ln 2 approx 1.4427 "бит"$.

  *Кумулянтные тождества:*
  - $E[ell'] = 0$
  - $E[ell'' + (ell')^2] = 0$
  - $E[ell''' + 3 ell' ell'' + (ell')^3] = 0$
  - Для несмещённой оценки $g$: $"Cov"(g, ell') = 1$
]