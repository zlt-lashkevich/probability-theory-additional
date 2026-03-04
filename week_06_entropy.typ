#import "@preview/cetz:0.4.2": canvas, draw

#set page(paper: "a4", margin: 25mm)
#set text(lang: "ru", font: "New Computer Modern", size: 11pt)
#set par(justify: true, leading: 0.65em)
#set heading(numbering: none)

#align(center)[
  #text(size: 17pt, weight: "bold")[Энтропия и условное нормальное распределение]
  #v(0.3em)
]

#v(0.5em)


= Метод Иоганна Худде: экстремум без производных
#v(0.5em)
*Идея:*
Если $f(x)$ имеет экстремум в точке $x = lambda$, то
$f(x) - f(lambda) = (x - lambda)^2 g(x)$
для некоторого $g$. Значит $lambda$ — *кратный корень* уравнения $f(x) = "const"$. То есть экстремум — это кратный корень

== Какое преобразование сохраняет кратный корень?


Рассмотрим $(x - lambda)^2 = 0$:
$
x^2 - 2 x lambda + lambda^2 = 0
$

Домножим коэффициенты на числа $alpha, beta, gamma$:
$
alpha x^2 - 2 beta x lambda + gamma lambda^2 = 0
$

При $x = lambda$ должно сохраняться равенство:
$
alpha lambda^2 - 2 beta lambda^2 + gamma lambda^2 = 0 quad arrow.r.double quad alpha - 2 beta + gamma = 0
arrow.r.double quad 2 beta = alpha + gamma
$

Значит $alpha, beta, gamma$ образуют *арифметическую прогрессию*!

#box(
  width: 100%,
  fill: rgb("#e8f8e8"),
  inset: 10pt,
  radius: 4pt,
)[
  *Правило Худде:* домножая коэффициенты многочлена на
  члены арифметической прогрессии, мы сохраняем кратный корень (экстремум).
]

== Пример:

Ищем $min$ функции  
$
y = (t+3)^3 / t^2 arrow.r min
$ 

Записываем $(t+3)^3 = m t^2$:
$
t^3 + 9 t^2 + 27 t + 27 = m t^2 arrow.r.double
t^3 + (9-m) t^2 + 27 t + 27 = 0
$

*Применяем Худде* (прогрессия $1, 0, -1, -2$):
$
1 dot t^3 + 0 dot (9-m) t^2 + (-1) dot 27 t + (-2) dot 27 = 0 arrow.r.double
t^3 - 27 t - 54 = 0 quad arrow.r.double quad t = 6
$

*Проверка другой прогрессией* ($0, 1, 2, 3$):
$
0 + (9-m) t^2 + 54 t + 81 = 0
$
При $t = 6$: $(9-m) dot 36 + 324 + 81 = 0 arrow.r m = 9 + 405/36 = 81/4$

== Связь с касательной $y = k x + b$

Для $f(x) = x^3$: уравнение $x^3 = k x + b$ имеет кратный корень в точке касания.
$
x^3 + 0 x^2 - k x - b = 0
$

Прогрессия $(3, 2, 1, 0)$: $3 x^3 + 0 - k x = 0 arrow.r k = 3 x^2$

Прогрессия $(0, 1, 2, 3)$: $0 + 0 - 2 k x - 3 b = 0 arrow.r b = -2 x^3$

$arrow.r.double$ *Касательная:* $y = 3 x_0^2 (x - x_0) + x_0^3$ 

#pagebreak()

= Энтропия и «удивление» (surprise)

== Ключевые свойства нормали

#box(
  width: 100%,
  fill: rgb("#e8f4f8"),
  inset: 12pt,
  radius: 4pt,
)[
  + Распределение $(X, Y)^top$ инвариантно к поворотам вокруг $(0,0)^top$
  + Проекции на ортогональные подпространства независимы
  
  *Следствия:*
  $
  cases(
    f'(x) sigma^2 = -x f(x) quad & "(центрированный)" quad (1),
    f'(x) sigma^2 = -(x - mu) f(x) quad & "(общий)" quad (2)
  )
  $
]

== Определение: surprise (удивление)

Пусть событие $A$ произошло с вероятностью $P(A)$. Определим:

$
"surprise"(A) := -ln P(A) quad ["нат" = "natural bit"]
$

*Свойства:*
- Редкое событие ($P approx 0$) $arrow.r$ большое удивление
- Достоверное событие ($P = 1$) $arrow.r$ удивление $= 0$
- Для *независимых* событий: $"surprise"(A sect B) = "surprise"(A) + "surprise"(B)$

  (так как $P(A sect B) = P(A) P(B) arrow.r -ln P(A B) = -ln P(A) - ln P(B)$)

== Энтропия = среднее удивление

$
H(X) = E["surprise"(X)] = -sum_k P(X=k) ln P(X=k)
$

Для непрерывного случая (дифференциальная энтропия):
$
h(X) = -integral f(x) ln f(x) d x
$

// ═══════════════════════════════════════════════════════════

= Упражнение: геометрическое распределение (кубик до первой 6)

Пусть $X$ — число бросков правильного кубика до первой шестёрки:

$
P(X = t) = cases(
  (5/6)^(t-1) dot 1/6 comma & t in NN,
  0 comma & t in.not NN
)
$

== Система для логарифма

$
ln P(X = t) = (t-1) ln(5/6) + ln(1/6) quad "(линейная функция по " t "!)"
$

$
"surprise"(X = t) = -(t-1) ln(5/6) - ln(1/6) = (t-1) dot 0.1823 + 1.7918
$

== Графики $P(X=t)$ и $ln P(X=t)$

#align(center)[
#canvas(length: 0.9cm, {
  import draw: *

  let xmax = 16

  grid((0, 0), (xmax, 4), step: 1, stroke: gray + 0.15pt)
  line((0, 0), (xmax, 0), mark: (end: "stealth"))
  line((0, 0), (0, 4.5), mark: (end: "stealth"))
  content((xmax, 0), $t$, anchor: "west")
  content((0, 4.5), $P(X=t)$, anchor: "south")

  for t in range(1, 16) {
    let p = calc.pow(5.0/6.0, t - 1) * (1.0/6.0)
    let h = p * 20
    line((t, 0), (t, h), stroke: (paint: blue, thickness: 2pt))
    circle((t, h), radius: 0.06, fill: blue, stroke: none)
  }

  content((8, 4), text(size: 9pt, fill: blue)[экспоненциальный спад])
})]

#v(0.5em)

#align(center)[
#canvas(length: 0.9cm, {
  import draw: *

  let xmax = 16

  grid((0, -5), (xmax, 1), step: 1, stroke: gray + 0.15pt)
  line((0, 0), (xmax, 0), mark: (end: "stealth"))
  line((0, -5), (0, 1), mark: (end: "stealth"))
  content((xmax, 0), $t$, anchor: "west")
  content((0, 1), $ln P$, anchor: "south")

  for t in range(1, 16) {
    let lnp = (t - 1) * calc.ln(5.0/6.0) + calc.ln(1.0/6.0)
    if lnp >= -5 {
      circle((t, lnp), radius: 0.08, fill: red, stroke: none)
    }
  }

  let t1 = 1
  let t2 = 15
  let lnp1 = 0 * calc.ln(5.0/6.0) + calc.ln(1.0/6.0)
  let lnp2 = 14 * calc.ln(5.0/6.0) + calc.ln(1.0/6.0)
  line((t1, lnp1), (t2, lnp2), stroke: (paint: red, dash: "dashed"))

  content((10, -1), text(size: 8pt, fill: red)[наклон $= ln(5\/6) approx -0.182$])
})]

== Энтропия

$
H(X) &= E["surprise"(X)] = -(E[X] - 1) ln(5/6) - ln(1/6) \
&= -5 ln(5/6) + ln 6 approx 2.70 "нат"
$

#pagebreak()

= Условное нормальное распределение: $Y | X$
#v(0.5em)

Пусть двумерный нормальный вектор:
$
vec(X, Y) tilde cal(N)(vec(mu_x, mu_y), bold(C)), quad
bold(C) = mat(
  sigma_x^2, C_(12);
  C_(12), sigma_y^2
)
$

*Найти:* распределение $(Y | X)$, $E[Y|X]$, $"Var"(Y|X)$.

== Трюк: работаем с $ln f$ вместо $f$

Для нормали:
$
ln f(x) = -frac((x - mu)^2, 2 sigma^2) + "const"
$

Два ключевых свойства:

$
(ln f(x))' |_(x = mu) = 0 quad arrow.r.double quad "argmax" f = mu = E[X] quad dots.c (star)
$

$
(ln f(x))'' = -1/sigma^2 quad arrow.r.double quad "Var"(X) = -1/(ln f)'' quad dots.c (star star)
$

== Логарифм условной плотности

$
ln f(y|x) = ln f(x, y) - ln f(x)
$

Совместная плотность:
$
ln f(x, y) = -1/2 (x - mu_x, y - mu_y) bold(C)^(-1) vec(x - mu_x, y - mu_y) + "const"
$

Маргинальная:
$
ln f(x) = -1/2 (x - mu_x) (sigma_x^2)^(-1) (x - mu_x) + "const"
$

== Precision-матрица

Обозначим $bold(Theta) = bold(C)^(-1)$ — *precision matrix*:

$
bold(Theta) = bold(C)^(-1) = frac(1, det bold(C)) mat(
  sigma_y^2, -C_(12);
  -C_(12), sigma_x^2
)
$

где $det bold(C) = sigma_x^2 sigma_y^2 - C_(12)^2$.

Элементы:
$
Theta_(11) = sigma_y^2 / (det bold(C)), quad
Theta_(22) = sigma_x^2 / (det bold(C)), quad
Theta_(12) = -C_(12) / (det bold(C))
$

== Нахождение $E[Y|X]$ через $(star)$

Берём производную $ln f(y|x)$ по $y$:

$
frac(partial, partial y) ln f(y|x) = frac(partial, partial y) ln f(x, y) - underbrace(frac(partial, partial y) ln f(x), = 0)
$

$
= -Theta_(22)(y - mu_y) - Theta_(12)(x - mu_x)
$

Приравниваем к нулю (условие $(star)$):

$
-Theta_(22)(y - mu_y) - Theta_(12)(x - mu_x) = 0
$

$
y - mu_y = -frac(Theta_(12), Theta_(22))(x - mu_x)
$

#box(
  width: 100%,
  fill: rgb("#e8f8e8"),
  inset: 12pt,
  radius: 4pt,
)[
  *Условное математическое ожидание:*
  $
  E[Y|X] = mu_y - frac(Theta_(12), Theta_(22))(X - mu_x)
  $
]

== Нахождение $"Var"(Y|X)$ через $(star star)$

Берём вторую производную $ln f(y|x)$ по $y$:

$
frac(partial^2, partial y^2) ln f(y|x) = -Theta_(22)
$

По свойству $(star star)$:

#box(
  width: 100%,
  fill: rgb("#e8f8e8"),
  inset: 12pt,
  radius: 4pt,
)[
  *Условная дисперсия:*
  $
  "Var"(Y|X) = frac(1, Theta_(22))
  $
  
  Замечание: *не зависит от $X$!*
]

== Переход к исходным обозначениям

Подставляем выражения для элементов precision-матрицы:

$
-frac(Theta_(12), Theta_(22)) = -frac(-C_(12) \/ det bold(C), sigma_x^2 \/ det bold(C)) = frac(C_(12), sigma_x^2) = frac("Cov"(X, Y), "Var"(X))
$

$
frac(1, Theta_(22)) = frac(det bold(C), sigma_x^2) = frac(sigma_x^2 sigma_y^2 - C_(12)^2, sigma_x^2)
$

Введём корреляцию $rho = C_(12) / (sigma_x sigma_y)$:

#box(
  width: 100%,
  fill: rgb("#e8f4f8"),
  inset: 12pt,
  radius: 4pt,
)[
  *Итоговые формулы:*
  
  $
  (Y | X) tilde cal(N)(E[Y|X], "Var"(Y|X))
  $
  
  $
  E[Y|X] = mu_y + frac("Cov"(X,Y), "Var"(X))(X - mu_x) = mu_y + rho frac(sigma_y, sigma_x)(X - mu_x)
  $
  
  $
  "Var"(Y|X) = frac(det bold(C), sigma_x^2) = sigma_y^2(1 - rho^2)
  $
]

