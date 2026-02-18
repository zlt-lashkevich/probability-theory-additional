#set document(title: "Производящие функции и комплексные числа")
#set page(paper: "a4", margin: 2cm)
#set text(lang: "ru", font: "New Computer Modern", size: 11pt)
#set par(justify: true, leading: 0.65em)
#show selector(<nonumber>): set heading(numbering: none)

#align(center)[
  #text(size: 16pt, weight: "bold")[
    Производящие функции и комплексные числа
  ]
  #v(0.5em)
  #text(size: 12pt)[На примере обобщённых чисел Фибоначчи]
]

#v(1em)

#line(length: 100%, stroke: 1pt)
#align(center)[#text(size: 14pt, weight: "bold")[Часть 1: Рекуррентность $H_n = 2H_(n-1) + 3H_(n-2)$]]
#line(length: 100%, stroke: 0.5pt)

= Постановка задачи

#box(
  width: 100%,
  fill: rgb("#e8f4f8"),
  inset: 12pt,
  radius: 4pt,
)[
  *Рекуррентное соотношение:*
  
  $ H_n = 2 H_(n-1) + 3 H_(n-2), quad n >= 2 $
  
  *Начальные условия:* $H_0 = H_1 = 1$
  
  *Задача:* Найти $H_(2026)$
]

= Комбинаторная интерпретация

#box(
  width: 100%,
  fill: rgb("#fff4e6"),
  inset: 12pt,
  radius: 4pt,
)[
  == Модель: слова с весами
  
  *Алфавит:* 5 букв — $a, b$ (вес 1) и $c, d, e$ (вес 2)
  
  *Определение:* $H_n$ = количество слов суммарного веса $n$
  
  *Проверка рекуррентности:*
  - Слово веса $n$, оканчивающееся на букву веса 1: $(a "или" b)$ + слово веса $(n-1)$ → $2 H_(n-1)$
  - Слово веса $n$, оканчивающееся на букву веса 2: $(c, d "или" e)$ + слово веса $(n-2)$ → $3 H_(n-2)$
]

== Таблица переходов

#align(center)[
#box(
  width: 90%,
  fill: rgb("#f8f8f8"),
  inset: 10pt,
  radius: 4pt,
)[
#table(
  columns: 5,
  stroke: 0.5pt,
  inset: 6pt,
  align: center,
  fill: (col, row) => if row == 0 { rgb("#e8f4f8") },
  [*Из*], [*Буква*], [*Вес*], [*В состояние*], [*Вклад в $H_n$*],
  
  [$S$], [$a$], [$1$], [$S$], [$H_(n-1)$],
  [$S$], [$b$], [$1$], [$S$], [$H_(n-1)$],
  [$S$], [$c$], [$2$], [$S$], [$H_(n-2)$],
  [$S$], [$d$], [$2$], [$S$], [$H_(n-2)$],
  [$S$], [$e$], [$2$], [$S$], [$H_(n-2)$],
)
]
]

#box(
  width: 100%,
  fill: rgb("#e8f8e8"),
  inset: 10pt,
  radius: 4pt,
)[
  *Итого:* $H_n = 2 dot H_(n-1) + 3 dot H_(n-2)$ ✓
]

#pagebreak()

= Производящая функция: стандартный вывод

== Определение

$ g(t) = sum_(n=0)^infinity H_n t^n = H_0 + H_1 t + H_2 t^2 + ... $

== Вывод замкнутой формы

Из рекуррентности для $n >= 2$:
$ H_n - 2 H_(n-1) - 3 H_(n-2) = 0 $

Умножаем на $t^n$ и суммируем по $n >= 2$:

$ sum_(n=2)^infinity H_n t^n - 2 sum_(n=2)^infinity H_(n-1) t^n - 3 sum_(n=2)^infinity H_(n-2) t^n = 0 $

*Преобразуем каждую сумму:*

$ sum_(n=2)^infinity H_n t^n = g(t) - H_0 - H_1 t = g(t) - 1 - t $

$ sum_(n=2)^infinity H_(n-1) t^n = t sum_(n=2)^infinity H_(n-1) t^(n-1) = t(g(t) - H_0) = t(g(t) - 1) $

$ sum_(n=2)^infinity H_(n-2) t^n = t^2 sum_(n=2)^infinity H_(n-2) t^(n-2) = t^2 g(t) $

*Подставляем:*

$ [g(t) - 1 - t] - 2t[g(t) - 1] - 3t^2 g(t) = 0 $

$ g(t) - 1 - t - 2t g(t) + 2t - 3t^2 g(t) = 0 $

$ g(t)(1 - 2t - 3t^2) = 1 + t - 2t = 1 - t $


#box(
  width: 100%,
  fill: rgb("#e8f4f8"),
  inset: 12pt,
  radius: 4pt,
)[
  *Производящая функция:*
  
  $ g(t) = (1 - t)/(1 - 2t - 3t^2) $
]

== Корни знаменателя

$ 1 - 2t - 3t^2 = 0 $

$ 3t^2 + 2t - 1 = 0 $

$ t = (-2 plus.minus sqrt(4 + 12))/6 = (-2 plus.minus 4)/6 $

$ t_1 = 1/3, quad t_2 = -1 $

== Факторизация

$ 1 - 2t - 3t^2 = (1 - 3t)(1 + t) $

== Разложение на простейшие дроби

$ g(t) = (1 - t)/((1 - 3t)(1 + t)) = A/(1 - 3t) + B/(1 + t) $

$ 1 - t = A(1 + t) + B(1 - 3t) $

*При $t = -1$:* $quad 2 = 4B quad => quad B = 1/2$

*При $t = 1/3$:* $quad 2/3 = (4/3)A quad => quad A = 1/2$

#box(
  width: 100%,
  fill: rgb("#e8f8e8"),
  inset: 12pt,
  radius: 4pt,
)[
  $ g(t) = 1/2 dot 1/(1 - 3t) + 1/2 dot 1/(1 + t) $
]

= Разложение в ряд Тейлора

== Геометрические ряды

$ 1/(1 - 3t) = sum_(n=0)^infinity 3^n t^n $

$ 1/(1 + t) = 1/(1 - (-t)) = sum_(n=0)^infinity (-1)^n t^n $

== Итоговое разложение

$ g(t) = 1/2 sum_(n=0)^infinity 3^n t^n + 1/2 sum_(n=0)^infinity (-1)^n t^n = sum_(n=0)^infinity (3^n + (-1)^n)/2 t^n $

#box(
  width: 100%,
  fill: rgb("#e8f4f8"),
  inset: 15pt,
  radius: 4pt,
)[
  *Явная формула:*
  
  $ H_n = [t^n] g(t) = (3^n + (-1)^n)/2 $
]

= Ответ: $H_(2026)$

$ H_(2026) = (3^(2026) + (-1)^(2026))/2 = (3^(2026) + 1)/2 $

#box(
  width: 100%,
  fill: rgb("#e8f8e8"),
  inset: 15pt,
  radius: 4pt,
)[
  #align(center)[
    *Ответ:*
    
    $ H_(2026) = (3^(2026) + 1)/2 $
    
    *Порядок величины:* $log_(10) H_(2026) approx 2026 dot log_(10) 3 approx 967$
    
    Это число с примерно *967 цифрами*.
  ]
]

#pagebreak()

#line(length: 100%, stroke: 1pt)
#align(center)[#text(size: 14pt, weight: "bold")[Часть 2: Комплексные числа в производящих функциях]]
#line(length: 100%, stroke: 0.5pt)

= Мотивация

#box(
  width: 100%,
  fill: rgb("#fff4e6"),
  inset: 12pt,
  radius: 4pt,
)[
  == Задача:
  
  *Дано:* Слова длины $n$ из букв $H$ и $T$.
  
  *Найти:* Количество слов, в которых число букв $H$ делится на 3:
  
  $ Q_3 = sum_(k equiv 0 (mod 3)) binom(n, k) = binom(n, 0) + binom(n, 3) + binom(n, 6) + ... $
]

== Проблема

Обычная производящая функция $(1 + x)^n = sum_(k=0)^n binom(n,k) x^k$ даёт *все* коэффициенты.

*Как выделить только те, где $k equiv 0 (mod 3)$?*

= Ключевая идея

#box(
  width: 100%,
  fill: rgb("#e8f4f8"),
  inset: 12pt,
  radius: 4pt,
)[
  *Корень 3-й степени из единицы:*
  
  $ omega = e^(2 pi i slash 3) = -1/2 + i (sqrt(3))/2 $
  
  *Свойства:*
  - $omega^3 = 1$
  - $1 + omega + omega^2 = 0$
  - $omega^2 = overline(omega) = e^(-2 pi i slash 3)$
]

== Фильтрующее свойство

#box(
  width: 100%,
  fill: rgb("#fff4e6"),
  inset: 12pt,
  radius: 4pt,
)[
  *Лемма:* Для любого целого $k$:
  
  $ 1 + omega^k + omega^(2k) = cases(
    3 & "если" k equiv 0 (mod 3),
    0 & "если" k equiv.not 0 (mod 3)
  ) $
  
  *Доказательство:*
  
  - Если $k equiv 0$: $omega^k = 1$, поэтому $1 + 1 + 1 = 3$
  - Если $k equiv 1$: $1 + omega + omega^2 = 0$ (по свойству)
  - Если $k equiv 2$: $1 + omega^2 + omega^4 = 1 + omega^2 + omega = 0$
]

= Вывод формулы

== Три подстановки

Запишем $(1 + x)^n$ для трёх значений $x$:

$ (1 + 1)^n &= sum_(k=0)^n binom(n,k) 1^k = sum_(k=0)^n binom(n,k) $

$ (1 + omega)^n &= sum_(k=0)^n binom(n,k) omega^k  quad quad  (1 + omega^2)^n &= sum_(k=0)^n binom(n,k) omega^(2k) $

== Суммирование

$ 2^n + (1+omega)^n + (1+omega^2)^n = sum_(k=0)^n binom(n,k) (1 + omega^k + omega^(2k)) $

По фильтрующему свойству, ненулевой вклад дают только $k equiv 0 (mod 3)$:

$ = sum_(k equiv 0 (mod 3)) binom(n,k) dot 3 = 3 Q_3 $

#box(
  width: 100%,
  fill: rgb("#e8f8e8"),
  inset: 12pt,
  radius: 4pt,
)[
  *Формула:*
  
  $ Q_3 = (2^n + (1+omega)^n + (1+omega^2)^n)/3 $
]

= Упрощение комплексных слагаемых

== Вычисление $1 + omega$

$ 1 + omega = 1 + (-1/2 + i (sqrt(3))/2) = 1/2 + i (sqrt(3))/2 $

В полярной форме:
$ |1 + omega| = sqrt((1/2)^2 + (sqrt(3)/2)^2) = sqrt(1/4 + 3/4) = 1 $

$ arg(1 + omega) = arctan((sqrt(3)/2)/(1/2)) = arctan(sqrt(3)) = pi/3 $

$ 1 + omega = e^(i pi slash 3) $

== Аналогично для $1 + omega^2$

$ 1 + omega^2 = overline(1 + omega) = e^(-i pi slash 3) $

== Степени

$ (1 + omega)^n = e^(i n pi slash 3) quad quad (1 + omega^2)^n = e^(-i n pi slash 3) $

$ (1 + omega)^n + (1 + omega^2)^n = e^(i n pi slash 3) + e^(-i n pi slash 3) = 2 cos(n pi slash 3) $

#box(
  width: 100%,
  fill: rgb("#e8f4f8"),
  inset: 15pt,
  radius: 4pt,
)[
  *Итоговая формула:*
  
  $ Q_3 = (2^n + 2 cos(n pi slash 3))/3 $
]

= Проверка

== Для $n = 3$

$ Q_3 = (2^3 + 2 cos(pi))/3 = (8 + 2 dot (-1))/3 = (8 - 2)/3 = 2 $

*Проверка перебором:* Слова длины 3 с числом $H$ кратным 3:
- 0 букв $H$: $T T T$ (1 слово)
- 3 буквы $H$: $H H H$ (1 слово)


== Для $n = 6$

$ cos(2 pi) = 1 $

$ Q_3 = (64 + 2)/3 = 22 $

*Проверка:* $binom(6,0) + binom(6,3) + binom(6,6) = 1 + 20 + 1 = 22$

= Как выделить $k equiv r (mod m)$

#box(
  width: 100%,
  fill: rgb("#fff4e6"),
  inset: 12pt,
  radius: 4pt,
)[
  *Общая формула:*
  
  Пусть $omega_m = e^(2 pi i slash m)$ — примитивный корень $m$-й степени.
  
  $ sum_(k equiv r (mod m)) binom(n,k) = 1/m sum_(j=0)^(m-1) omega_m^(-r j) (1 + omega_m^j)^n $
]

= Визуализация на комплексной плоскости

#align(center)[
#box(
  width: 85%,
  fill: rgb("#f8f8f8"),
  inset: 15pt,
  radius: 8pt,
)[
#text(size: 9pt, font: "Courier New")[
```
                    Im
                     │
              ω      │      
               ●     │       
                 ╲   │   1+ω = e^(iπ/3)
                  ╲  │   ●
                   ╲ │  ╱
                    ╲│ ╱ π/3
        ─────────────┼──────────●──────── Re
                    ╱│          1
                   ╱ │
                  ╱  │
                 ╱   │
               ●     │
              ω²     │
                     │

    Корни третьей степени из 1: {1, ω, ω²}
    
    Точки 1+ω и 1+ω² лежат на единичной окружности
    под углами π/3 и -π/3 соответственно.
```
]
]
]

#box(
  width: 100%,
  fill: rgb("#e8f8e8"),
  inset: 12pt,
  radius: 4pt,
)[
  *Красота метода:*
  
  Комплексные числа — не просто формальный трюк, а *естественный инструмент* для работы с периодическими структурами. Корни из единицы образуют "фильтр", пропускающий только нужные частоты (индексы), — это та же идея, что и в преобразовании Фурье!
]