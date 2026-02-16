#set document(title: "Вывод нормального распределения по Гауссу")
#set page(paper: "a4", margin: 2cm)
#set text(lang: "ru", font: "New Computer Modern", size: 11pt)
#set par(justify: true, leading: 0.65em)
#set heading(numbering: none)

#align(center)[
  #text(size: 16pt, weight: "bold")[
    Вывод нормального распределения
  ]
]

#v(1em)

== Исторический контекст астрономические наблюдения

*Ситуация:* Астроном измеряет угловое положение звезды $n$ раз, получая наблюдения:
$ y_1, y_2, ..., y_n $

Каждое измерение содержит случайную ошибку. 

*Практический вопрос:* Как наилучшим образом оценить истинное положение звезды $mu$?

*Традиционный ответ:* Взять среднее арифметическое:
$ hat(mu) = overline(y) = 1/n sum_(i=1)^n y_i $


#box(
  width: 100%,
  fill: rgb("#fff4e6"),
  inset: 12pt,
  radius: 4pt,
)[
  *Фундаментальный вопрос:*
  
  При каком законе распределения ошибок измерений среднее арифметическое является *наилучшей* оценкой?
]

= Аксиоматика Гаусса

== Два ключевых допущения

#box(
  width: 100%,
  fill: rgb("#e8f4f8"),
  inset: 12pt,
  radius: 4pt,
)[
  *Допущение $A_1$:* Среднее арифметическое — оптимальный способ оценки истинного значения.
  
  $ hat(mu)_"opt" = overline(y) = 1/n sum_(i=1)^n y_i $
]

#box(
  width: 100%,
  fill: rgb("#e8f4f8"),
  inset: 12pt,
  radius: 4pt,
)[
  *Допущение $A_2$:* Наблюдения $y_i$ — независимые одинаково распределённые случайные величины с плотностью $f(y | mu)$, симметричной относительно $mu$:
  
  $ f(mu + t | mu) = f(mu - t | mu) quad forall t $
]

= Метод максимального правдоподобия


== Формализация

#box(
  width: 100%,
  fill: rgb("#fff4e6"),
  inset: 12pt,
  radius: 4pt,
)[
  
  Оптимальная оценка $hat(mu)$ — это значение, максимизирующее совместную плотность:
  
  $ hat(mu) = arg max_mu f(y_1, y_2, ..., y_n | mu) $
]

== Применение допущения $A_2$

Из независимости наблюдений:
$ f(y_1, ..., y_n | mu) = product_(i=1)^n f(y_i | mu) $

Из допущения $A_1$: оптимум достигается при $mu = overline(y)$.

#box(
  width: 100%,
  fill: rgb("#e8f8e8"),
  inset: 12pt,
  radius: 4pt,
)[
  *Связь $A_1$ и $A_2$:*
  
  $ overline(y) = arg max_mu product_(i=1)^n f(y_i | mu) $
  
  Это функциональное уравнение на неизвестную плотность $f$!
]

= Специальная выборка


Рассмотрим специальную выборку из $n + 1$ наблюдения:

#box(
  width: 100%,
  fill: rgb("#fff4e6"),
  inset: 12pt,
  radius: 4pt,
)[
  - $n$ наблюдений со значением $overline(y) - 1$
  - $1$ наблюдение со значением $overline(y) + n$
  
  *Проверка:* Среднее арифметическое:
  $ (n(overline(y) - 1) + (overline(y) + n))/(n + 1) = (n overline(y) - n + overline(y) + n)/(n + 1) = ((n+1) overline(y))/(n+1) = overline(y) quad checkmark $
]

== Функция правдоподобия

Для этой выборки:
$ L(mu) = [f(overline(y) - 1 | mu)]^n dot f(overline(y) + n | mu) $

По $A_1$: максимум достигается при $mu = overline(y)$.

= Переход к логарифму


#box(
  width: 100%,
  fill: rgb("#e8f4f8"),
  inset: 10pt,
  radius: 4pt,
)[
  *Важное замечание:* Нас интересует *где* достигается максимум, а не *чему равно* максимальное значение.
  
  Поскольку $ln$ — монотонная функция, $arg max L(mu) = arg max ln L(mu)$.
]

$ ell(mu) = ln L(mu) = n ln f(overline(y) - 1 | mu) + ln f(overline(y) + n | mu) $

== Условие первого порядка

Дифференцируем по $mu$ и приравниваем к нулю:

$ (d ell)/(d mu) = n dot (f'_mu (overline(y) - 1 | mu))/(f(overline(y) - 1 | mu)) + (f'_mu (overline(y) + n | mu))/(f(overline(y) + n | mu)) = 0 $

При $mu = overline(y)$ (точка максимума):

#box(
  width: 100%,
  fill: rgb("#e8f8e8"),
  inset: 10pt,
  radius: 4pt,
)[
  $ n dot (f'_mu (overline(y) - 1 | overline(y)))/(f(overline(y) - 1 | overline(y))) + (f'_mu (overline(y) + n | overline(y)))/(f(overline(y) + n | overline(y))) = 0 $
]

= Введение функции $h$

#box(
  width: 100%,
  fill: rgb("#fff4e6"),
  inset: 12pt,
  radius: 4pt,
)[
  *Определение:* Введём функцию $h$, описывающую плотность отклонения от центра:
  
  $ h(t) = f(mu + t | mu) $
  
  *Интерпретация:* $h(t)$ — плотность ошибки $t = y - mu$.
  
  *Из симметрии ($A_2$):* $h(t) = h(-t)$ — чётная функция.
]

== Свойства $h$ и $h'$

- $h(t)$ — *чётная*: $h(-t) = h(t)$
- $h'(t)$ — *нечётная*: $h'(-t) = -h'(t)$

*Доказательство нечётности $h'$:*

Дифференцируем $h(-t) = h(t)$ по $t$:
$ -h'(-t) = h'(t) quad => quad h'(-t) = -h'(t) $

== Переписывание уравнения

Подставляем в условие первого порядка:
- $f(overline(y) - 1 | overline(y)) = h(-1)$
- $f(overline(y) + n | overline(y)) = h(n)$
- $f'_mu (overline(y) - 1 | overline(y)) = h'(-1) = -h'(1)$ (нечётность!)
- $f'_mu (overline(y) + n | overline(y)) = h'(n)$

#box(
  width: 100%,
  fill: rgb("#e8f8e8"),
  inset: 12pt,
  radius: 4pt,
)[
  *Уравнение:*
  
  $ n dot (-h'(1))/(h(-1)) + (h'(n))/(h(n)) = 0 $
  
  Используя чётность $h(-1) = h(1)$:
  
  $ -n dot (h'(1))/(h(1)) + (h'(n))/(h(n)) = 0 $
]

= Функциональное уравнение


Перепишем:
$ (h'(n))/(h(n)) = n dot (h'(1))/(h(1)) $

== Знак константы

#box(
  width: 100%,
  fill: rgb("#fff4e6"),
  inset: 10pt,
  radius: 4pt,
)[
  *Условие максимума:* В точке $mu = overline(y)$ должен быть именно *максимум*, а не минимум.
  
  Это требует $c < 0$.
  
  *Обозначение:* $c = -1/sigma^2$, где $sigma > 0$.
]

Из вывода Гаусса получено:

#box(
  width: 100%,
  fill: rgb("#e8f4f8"),
  inset: 12pt,
  radius: 4pt,
)[
  *Дифференциальное соотношение:*
  
  $ (h'(x))/(h(x)) = -x/sigma^2 $
  
  *Эквивалентные формы:*
  
  $ h'(x) = -x/sigma^2 dot h(x) $
  
  $ x dot h(x) = -sigma^2 dot h'(x) $
]

#box(
  width: 100%,
  fill: rgb("#fff4e6"),
  inset: 10pt,
  radius: 4pt,
)[
  *Ключевая идея:* Мы *не решаем* это уравнение, а используем его для вычисления интегралов!
]
== Граничные условия

#box(
  width: 100%,
  fill: rgb("#f0f8ff"),
  inset: 10pt,
  radius: 4pt,
)[
  *На бесконечности* для любой плотности вероятности:
  
  $ lim_(x -> plus.minus infinity) h(x) = 0 $
  
  $ lim_(x -> plus.minus infinity) x^k h(x) = 0 quad "для любого" k $
  
  (экспоненциальное убывание $h$ доминирует над полиномиальным ростом $x^k$)
]

= Вычисление математического ожидания $EE[X]$


$ EE[X] = integral_(-infinity)^(+infinity) x dot h(x) d x $


Используем $x dot h(x) = -sigma^2 dot h'(x)$:

$ EE[X] = integral_(-infinity)^(+infinity) (-sigma^2) dot h'(x) d x = -sigma^2 integral_(-infinity)^(+infinity) h'(x) d x $

=== Вычисление

$ integral_(-infinity)^(+infinity) h'(x) d x = [h(x)]_(-infinity)^(+infinity) = h(+infinity) - h(-infinity) = 0 - 0 = 0 $

#box(
  width: 100%,
  fill: rgb("#e8f8e8"),
  inset: 12pt,
  radius: 4pt,
)[
  $ EE[X] = -sigma^2 dot 0 = 0 $
]

= Вычисление дисперсии $EE[X^2]$


$ EE[X^2] = integral_(-infinity)^(+infinity) x^2 dot h(x) d x $


Перепишем $x^2 dot h(x) = x dot (x dot h(x))$ и используем $x dot h(x) = -sigma^2 h'(x)$:

$ EE[X^2] = integral_(-infinity)^(+infinity) x dot (-sigma^2 h'(x)) d x = -sigma^2 integral_(-infinity)^(+infinity) x dot h'(x) d x $

=== Интегрирование по частям

$ integral x dot h'(x) d x = underbrace(x dot h(x), u dot v) - integral underbrace(h(x), v) underbrace(d x, d u) $

*Вычисляем:*

$ integral_(-infinity)^(+infinity) x dot h'(x) d x = [x dot h(x)]_(-infinity)^(+infinity) - integral_(-infinity)^(+infinity) h(x) d x $

- Первое слагаемое: $[x dot h(x)]_(-infinity)^(+infinity) = 0 - 0 = 0$ (граничные условия)
- Второе слагаемое: $integral_(-infinity)^(+infinity) h(x) d x = 1$ (нормировка)

$ integral_(-infinity)^(+infinity) x dot h'(x) d x = 0 - 1 = -1 $


$ EE[X^2] = -sigma^2 dot (-1) = sigma^2 $

#box(
  width: 100%,
  fill: rgb("#e8f8e8"),
  inset: 12pt,
  radius: 4pt,
)[
  $ "Var"(X) = EE[X^2] - (EE[X])^2 = sigma^2 - 0 = sigma^2 $
  
  Параметр $sigma^2$ — это в точности дисперсия!
]

// #pagebreak()


= Анализ размерностей

== Размерность плотности вероятности

#box(
  width: 100%,
  fill: rgb("#e8f4f8"),
  inset: 12pt,
  radius: 4pt,
)[
  *Физический смысл плотности:*
  
  $ P(x < X < x + d x) = h(x) d x $
  
  *Размерности:*
  - $P$ — безразмерная величина (вероятность)
  - $d x$ — имеет размерность $[x]$ (например, градусы)
  - Следовательно: $[h(x)] = 1/[x]$ (обратная размерность!)
]

== Анализ экспоненты

Аргумент экспоненты должен быть безразмерным:
$ [x^2/sigma^2] = [x]^2/[sigma]^2 = 1 quad => quad [sigma] = [x] $

Размерность $sigma$ совпадает с размерностью $x$ (это стандартное отклонение).

== Размерность константы $A$

$ [h(x)] = [A] dot [exp(...)] = [A] dot 1 = [A] $

Следовательно:
$ [A] = 1/[x] = 1/[sigma] $

#box(
  width: 100%,
  fill: rgb("#e8f8e8"),
  inset: 12pt,
  radius: 4pt,
)[
  *Вывод из размерностей:*
  
  $ A = "const"/sigma $
  
  где const — безразмерная численная константа.
]

= Условие нормировки

$ integral_(-infinity)^(+infinity) h(x) d x = 1 $

$ A integral_(-infinity)^(+infinity) exp(-x^2/(2 sigma^2)) d x = 1 $

== Вычисление интеграла Гаусса

Замена $u = x/(sigma sqrt(2))$, $d x = sigma sqrt(2) d u$:

$ integral_(-infinity)^(+infinity) exp(-x^2/(2 sigma^2)) d x = sigma sqrt(2) integral_(-infinity)^(+infinity) e^(-u^2) d u = sigma sqrt(2) dot sqrt(pi) = sigma sqrt(2 pi) $

== Константа нормировки

$ A dot sigma sqrt(2 pi) = 1 quad => quad A = 1/(sigma sqrt(2 pi)) $

#box(
  width: 100%,
  fill: rgb("#e8f8e8"),
  inset: 15pt,
  radius: 4pt,
)[
  #align(center)[
    *Плотность нормального распределения:*
    
    $ h(x) = 1/(sigma sqrt(2 pi)) exp(-x^2/(2 sigma^2)) $
    
    *Или в терминах исходной плотности:*
    
    $ f(y | mu) = h(y - mu) = 1/(sigma sqrt(2 pi)) exp(-(y - mu)^2/(2 sigma^2)) $
  ]
]

#box(
  width: 100%,
  fill: rgb("#e8f8e8"),
  inset: 12pt,
  radius: 4pt,
)[
  *Красота метода:*
  
  Мы получили все моменты нормального распределения, *не зная явного вида* плотности $h(x)$!
  
  Достаточно только соотношения $h'/h = -x/sigma^2$ и граничных условий.
  
  Это пример того, как *дифференциальное уравнение* содержит больше информации, чем кажется на первый взгляд.
]

#pagebreak()
= Рекуррентная формула для моментов

== Вычисление $EE[X^(2k)]$

$ EE[X^(2k)] = integral_(-infinity)^(+infinity) x^(2k) dot h(x) d x $

Перепишем:
$ x^(2k) dot h(x) = x^(2k-1) dot (x dot h(x)) = x^(2k-1) dot (-sigma^2 h'(x)) $

$ EE[X^(2k)] = -sigma^2 integral_(-infinity)^(+infinity) x^(2k-1) dot h'(x) d x $

=== Интегрируем по частям

#box(
  width: 100%,
  fill: rgb("#fff4e6"),
  inset: 10pt,
  radius: 4pt,
)[
  $ integral x^(2k-1) h'(x) d x = [x^(2k-1) h(x)] - integral (2k-1) x^(2k-2) h(x) d x $
]

*Вычисляем:*
- $[x^(2k-1) h(x)]_(-infinity)^(+infinity) = 0$ (граничные условия)
- $integral x^(2k-2) h(x) d x = EE[X^(2k-2)]$

$ integral_(-infinity)^(+infinity) x^(2k-1) h'(x) d x = 0 - (2k-1) EE[X^(2k-2)] = -(2k-1) EE[X^(2k-2)] $

== Рекуррентное соотношение

$ EE[X^(2k)] = -sigma^2 dot (-(2k-1) EE[X^(2k-2)]) = sigma^2 (2k-1) EE[X^(2k-2)] $

#box(
  width: 100%,
  fill: rgb("#e8f4f8"),
  inset: 15pt,
  radius: 4pt,
)[
  *Рекуррентная формула:*
  
  $ EE[X^(2k)] = (2k - 1) dot sigma^2 dot EE[X^(2k-2)] $
  
  *Начальное условие:* $EE[X^0] = 1$
]


== Первые моменты

#table(
  columns: 4,
  stroke: 0.5pt,
  inset: 8pt,
  align: center,
  fill: (col, row) => if row == 0 { rgb("#e8f4f8") } else if calc.odd(row) { rgb("#f9f9f9") },
  
  [*$k$*], [*Рекуррентность*], [*$EE[X^(2k)]$*], [*Коэффициент*],
  
  [0], [—], [$1$], [$1$],
  [1], [$1 dot sigma^2 dot 1$], [$sigma^2$], [$1$],
  [2], [$3 dot sigma^2 dot sigma^2$], [$3 sigma^4$], [$3 = 1 dot 3$],
  [3], [$5 dot sigma^2 dot 3 sigma^4$], [$15 sigma^6$], [$15 = 1 dot 3 dot 5$],
  [4], [$7 dot sigma^2 dot 15 sigma^6$], [$105 sigma^8$], [$105 = 1 dot 3 dot 5 dot 7$],
  [5], [$9 dot sigma^2 dot 105 sigma^8$], [$945 sigma^(10)$], [$945 = 1 dot 3 dot 5 dot 7 dot 9$],
)

== Общая формула

#box(
  width: 100%,
  fill: rgb("#e8f8e8"),
  inset: 15pt,
  radius: 4pt,
)[
  $ EE[X^(2k)] = (2k - 1)!! dot sigma^(2k) $
  
  где $(2k-1)!! = 1 dot 3 dot 5 dot ... dot (2k-1)$ — двойной факториал.
  
  *Альтернативная форма:*
  
  $ EE[X^(2k)] = ((2k)!)/(2^k dot k!) dot sigma^(2k) $
]

== Нечётные моменты

#box(
  width: 100%,
  fill: rgb("#fff4e6"),
  inset: 10pt,
  radius: 4pt,
)[
  $ EE[X^(2k+1)] = 0 $
  
  *Причина:* $x^(2k+1) dot h(x)$ — нечётная функция (произведение нечётной $x^(2k+1)$ и чётной $h(x)$).
  
  Интеграл нечётной функции по симметричному промежутку равен нулю.
]

= Вычисление $EE[X^(2026)]$

== Определение $k$

$ 2026 = 2 dot 1013 quad => quad k = 1013 $

== Применение формулы

$ EE[X^(2026)] = (2 dot 1013 - 1)!! dot sigma^(2026) = 2025!! dot sigma^(2026) $

#box(
  width: 100%,
  fill: rgb("#e8f8e8"),
  inset: 15pt,
  radius: 4pt,
)[
  #align(center)[
    *Ответ:*
    
    $ EE[X^(2026)] = 2025!! dot sigma^(2026) = (1 dot 3 dot 5 dot ... dot 2025) dot sigma^(2026) $
    
    $ = product_(j=1)^(1013) (2j - 1) dot sigma^(2026) $
  ]
]

== Численная оценка (при $sigma = 1$)

$ 2025!! = product_(j=1)^(1013) (2j - 1) $

Используем формулу Стирлинга для двойного факториала:

$ ln(2k-1)!! approx k ln(2k) - k + 1/2 ln(pi k) $

При $k = 1013$:

$ ln(2025!!) approx 1013 ln(2026) - 1013 + 1/2 ln(1013 pi) approx 5906 $

$ 2025!! approx e^(5906) approx 10^(2565) $



#box(
  width: 100%,
  fill: rgb("#fff4e6"),
  inset: 12pt,
  radius: 4pt,
)[
  *Историческое значение:*
  
  Гаусс показал: если мы *постулируем* оптимальность среднего арифметического как оценки, то закон распределения ошибок *однозначно определяется* — это нормальное (гауссово) распределение.
  
  Это замечательный пример "обратной задачи" в статистике: не "какая оценка оптимальна для данного распределения?", а "какое распределение делает данную оценку оптимальной?"
]