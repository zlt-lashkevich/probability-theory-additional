#set page(width: 420mm, height: 297mm, margin: (top: 0.8cm, bottom: 0.6cm, left: 0.8cm, right: 0.8cm))
#set text(font: "New Computer Modern", size: 7.5pt, lang: "ru")
#set par(leading: 0.35em)

#let blue-bg = rgb("#E3F2FD")
#let blue-dark = rgb("#1565C0")
#let green-bg = rgb("#E8F5E9")
#let green-dark = rgb("#2E7D32")
#let purple-bg = rgb("#F3E5F5")
#let purple-dark = rgb("#6A1B9A")
#let orange-bg = rgb("#FFF3E0")
#let orange-dark = rgb("#E65100")
#let center-bg = rgb("#FFFDE7")
#let center-dark = rgb("#F57F17")
#let red-bg = rgb("#FFEBEE")
#let red-dark = rgb("#C62828")
#let teal-bg = rgb("#E0F2F1")
#let teal-dark = rgb("#00695C")
#let gray-bg = rgb("#ECEFF1")
#let indigo-bg = rgb("#E8EAF6")
#let indigo-dark = rgb("#283593")
#let arrow-color = rgb("#37474F")

// --- Стили блоков ---
#let info-block(title, body, bg-color, border-color: rgb("#B0BEC5")) = {
  box(
    width: 100%,
    fill: bg-color,
    radius: 5pt,
    stroke: 1pt + border-color,
    inset: 5pt,
  )[
    #text(weight: "bold", size: 8pt, fill: border-color)[#title]
    #v(2pt)
    #line(length: 100%, stroke: 0.4pt + border-color)
    #v(2pt)
    #body
  ]
}

#let proof-block(title, body) = {
  box(
    width: 100%,
    fill: rgb("#FAFAFA"),
    radius: 4pt,
    stroke: (left: 2.5pt + rgb("#78909C"), rest: 0.4pt + rgb("#CFD8DC")),
    inset: 5pt,
  )[
    #text(weight: "bold", size: 7.5pt, fill: rgb("#455A64"))[#title]
    #v(2pt)
    #body
  ]
}

#let fact-block(body) = {
  box(
    width: 100%,
    fill: rgb("#FFF8E1"),
    radius: 3pt,
    stroke: 0.6pt + rgb("#FFB300"),
    inset: 5pt,
  )[
    #body
  ]
}

#align(center)[
  #box(
    width: 100%,
    fill: gradient.linear(rgb("#1B5E20"), rgb("#2E7D32"), rgb("#388E3C")),
    radius: 6pt,
    inset: (x: 15pt, y: 7pt),
  )[
    #text(size: 16pt, weight: "bold", fill: white)[
      Сэмплирование Томпсона — байесовский подход к задаче многоруких бандитов
    ]
    #h(0.8em)
    #text(size: 8.5pt, fill: rgb("#C8E6C9"))[
      | Beta-Bernoulli · Сопряжённость · Regret · Связь с Gittins & Kelly |
    ]
  ]
]
#v(0.15cm)

#grid(
  columns: (1fr, 1.2fr, 1fr),
  column-gutter: 0.3cm,

  [
    #info-block("1. Задача многоруких бандитов (MAB)", [
      Имеется $K$ «рычагов» (slot machines). На шаге $t$:

      *1.* Выбираем рычаг $A_t in {1, dots, K}$

      *2.* Получаем награду $R_t tilde P_(A_t)$ (неизвестное распределение)

      *Цель:* минимизировать *кумулятивный regret*:
      $ "Regret"(T) = T dot mu^* - sum_(t=1)^T mu_(A_t), quad mu^* = max_k mu_k $

      *Дилемма:* exploration (изучать новые рычаги) vs. exploitation (использовать лучший известный).
    ], blue-bg, border-color: blue-dark)

    #v(0.15cm)

    #info-block("2. Алгоритм Томпсона (1933)", [
      *Вход:* априорные $pi(theta_k)$ для каждого рычага $k$.

      *На каждом шаге $t$:*

      #box(fill: rgb("#F1F8E9"), inset: 5pt, radius: 3pt, width: 100%)[
        #text(size: 7.5pt)[
          1. Сэмплируем $hat(theta)_k tilde pi(theta_k | cal(D)_(t-1))$ для всех $k$ \
          2. Выбираем $A_t = arg max_k hat(theta)_k$ \
          3. Наблюдаем $R_t$, обновляем апостериорное
        ]
      ]

      *Интуиция:* действуем оптимально относительно случайно выбранных «убеждений» из апостериорного.

      #text(size: 7pt, fill: green-dark, style: "italic")[
        «Probability matching»: рычаг выбирается с вероятностью, что он лучший.
      ]
    ], green-bg, border-color: green-dark)

    #v(0.15cm)

    #info-block("3. Beta-Bernoulli: сопряжённая пара", [
      *Модель:* $R_t | A_t = k tilde "Bern"(theta_k)$, #h(0.3em) $theta_k in [0,1]$

      *Априорное:* $theta_k tilde "Beta"(alpha_k, beta_k)$

      *Апостериорное* (после $s$ успехов, $f$ неудач):
      $ theta_k | cal(D) tilde "Beta"(alpha_k + s, beta_k + f) $

      *Почему это работает:*
      $ underbrace(theta^(alpha-1)(1-theta)^(beta-1), "prior") times underbrace(theta^s (1-theta)^f, "likelihood") = theta^(alpha+s-1)(1-theta)^(beta+f-1) $

      Апостериорное $in$ то же семейство! Обновление = сложение.
    ], purple-bg, border-color: purple-dark)

    #v(0.15cm)

    #fact-block[
      #text(size: 7pt)[
        *Факт (Diaconis & Ylvisaker, 1979):* Для любого экспоненциального семейства $p(x|theta) = h(x) exp(eta(theta)^top T(x) - A(theta))$ существует сопряжённое априорное $pi(theta) prop exp(n_0 t_0^top eta(theta) - n_0 A(theta))$, где $n_0$ — «псевдо-наблюдения», $t_0$ — «псевдо-статистика».
      ]
    ]
  ],

  [
    #box(
      width: 100%,
      fill: center-bg,
      radius: 6pt,
      stroke: 1.2pt + center-dark,
      inset: 8pt,
    )[
      #align(center)[
        #text(weight: "bold", size: 9.5pt, fill: center-dark)[Центральная блок-схема: байесовский цикл]
      ]
      #v(3pt)

      #align(center)[
        #box(fill: purple-bg, radius: 5pt, inset: 5pt, stroke: 0.8pt + purple-dark)[
          #text(weight: "bold", size: 8.5pt)[Априорное: $theta_k tilde "Beta"(alpha_k, beta_k)$]
        ]
      ]
      #v(1pt)
      #align(center)[#text(size: 14pt, fill: arrow-color)[⇓] #h(0.5em) #text(size: 7pt)[Сэмплируем $hat(theta)_k$ из каждого]]
      #v(1pt)
      #align(center)[
        #box(fill: green-bg, radius: 5pt, inset: 5pt, stroke: 0.8pt + green-dark)[
          #text(weight: "bold", size: 8.5pt)[Выбор: $A_t = arg max_k hat(theta)_k$]
        ]
      ]
      #v(1pt)
      #align(center)[#text(size: 14pt, fill: arrow-color)[⇓] #h(0.5em) #text(size: 7pt)[Наблюдаем $R_t in {0, 1}$]]
      #v(1pt)
      #align(center)[
        #box(fill: orange-bg, radius: 5pt, inset: 5pt, stroke: 0.8pt + orange-dark)[
          #text(weight: "bold", size: 8.5pt)[Обновление: $alpha_k +#sym.eq.delta R_t$, #h(0.3em) $beta_k +#sym.eq.delta (1-R_t)$]
        ]
      ]
      #v(1pt)
      #align(center)[#text(size: 14pt, fill: arrow-color)[⇓] #h(0.5em) #text(size: 7pt)[Апостериорное = новое априорное]]
      #v(1pt)
      #align(center)[
        #box(fill: blue-bg, radius: 5pt, inset: 5pt, stroke: 0.8pt + blue-dark)[
          #text(weight: "bold", size: 8.5pt)[Апостериорное: $theta_k | cal(D)_t tilde "Beta"(alpha_k + s_k, beta_k + f_k)$]
        ]
      ]
      #v(2pt)
      #align(center)[
        #text(size: 7pt, fill: rgb("#5D4037"))[
          ↺ Цикл повторяется. По мере $t arrow infinity$: апостериорное концентрируется вокруг $theta_k^*$
        ]
      ]
    ]

    #v(0.15cm)

    #proof-block("Теорема (Kaufmann, Korda, Munos, 2012): асимптотическая оптимальность", [
      #text(size: 7.3pt)[
        *Нижняя граница Лай–Роббинса (1985):* для любой состоятельной стратегии:
        $ liminf_(T arrow infinity) "Regret"(T) / (ln T) >= sum_(k: mu_k < mu^*) (mu^* - mu_k) / (D_("KL")(mu_k || mu^*)) $

        *Результат:* Thompson Sampling с Beta-Bernoulli *достигает* этой границы:
        $ EE["Regret"(T)] <= sum_(k != k^*) (mu^* - mu_k) / (D_("KL")(mu_k || mu^*)) dot ln T + C $

        где $D_("KL")(p || q) = p ln(p/q) + (1-p) ln((1-p)/(1-q))$ — дивергенция Кульбака–Лейблера.

        #text(style: "italic", fill: rgb("#546E7A"))[
          Связь с курсом: KL-дивергенция из лекции 8 (энтропия) определяет скорость обучения!
        ]
      ]
    ])

    #v(0.15cm)

    #box(
      width: 100%,
      fill: gray-bg,
      radius: 5pt,
      stroke: 0.6pt + rgb("#78909C"),
      inset: 5pt,
    )[
      #text(weight: "bold", size: 7.8pt, fill: rgb("#37474F"))[Сравнение подходов к MAB]
      #v(2pt)
      #set text(size: 7pt)
      #table(
        columns: (1.3fr, 1fr, 1fr, 1fr),
        align: center,
        stroke: 0.4pt + rgb("#B0BEC5"),
        inset: 3.5pt,
        fill: (x, y) => if y == 0 { rgb("#CFD8DC") } else { white },
        [*Критерий*], [*Thompson*], [*UCB*], [*Gittins*],
        [Парадигма], [Байесовская], [Частотная], [Байесовская],
        [Regret], [$O(ln T)$], [$O(ln T)$], [Оптимален (диск.)],
        [Вычисления], [$O(K)$ / шаг], [$O(K)$ / шаг], [Экспоненц.],
        [Обобщения], [Любая модель], [Ограничены], [Только MAB],
        [Априорное], [Нужно], [Не нужно], [Нужно],
        [A/B тесты], [Да (адаптивно)], [Да], [Сложно],
        [Контекст], [Легко], [Возможно], [Нет],
      )
    ]
  ],
  
  [
    #info-block("4. Связь с индексом Гиттинса (курс)", [
      *Gittins (1979):* оптимальная стратегия для дисконтированных бандитов — выбирать рычаг с максимальным *индексом*:
      $ G_k = sup_(tau >= 1) (EE[sum_(t=1)^tau gamma^(t-1) R_t | cal(F)_k]) / (EE[sum_(t=1)^tau gamma^(t-1) | cal(F)_k]) $

      *Thompson vs Gittins:*
      - Gittins оптимален при дисконтировании, но NP-hard для вычисления
      - Thompson — *приближение*: сэмплирует вместо вычисления индекса
      - При $gamma arrow 1$: оба достигают границы Лай–Роббинса

      #text(size: 7pt, fill: teal-dark, style: "italic")[
        Из курса: индекс Гиттинса решает «когда переключиться» — TS решает это стохастически.
      ]
    ], teal-bg, border-color: teal-dark)

    #v(0.15cm)

    #info-block("5. Связь с критерием Кэлли (курс)", [
      *Kelly (1956):* оптимальная доля ставки $f^* = p - q/b$ при вероятности $p$.

      *Проблема:* $p$ неизвестно! Байесовское решение:

      $ f^*_("Bayes") = EE[theta | cal(D)] - (1 - EE[theta | cal(D)]) / b $

      Thompson Sampling *автоматически* учитывает неопределённость в $p$: широкое апостериорное $arrow.r$ больше exploration $arrow.r$ осторожные ставки.

      #text(size: 7pt, fill: orange-dark)[
        Связь: Kelly = exploitation; TS добавляет exploration через сэмплирование.
      ]
    ], orange-bg, border-color: orange-dark)

    #v(0.15cm)

    #info-block("6. Связь с методом первого шага", [
      *Метод первого шага* (курс): $EE[X] = sum_i EE[X | A_1 = i] PP(A_1 = i)$

      В Thompson Sampling — *аналогичная декомпозиция*:
      $ EE["Regret"(T)] = sum_(k=1)^K Delta_k dot EE[N_k(T)] $
      где $N_k(T)$ = число выборов рычага $k$, $Delta_k = mu^* - mu_k$.

      Анализ $EE[N_k(T)]$ — через «первый шаг» в цепи Маркова апостериорных!
    ], blue-bg, border-color: blue-dark)

    #v(0.15cm)

    #info-block("7. Max энтропии → выбор априорного", [
      *Вопрос:* какое априорное выбрать для $theta_k in [0,1]$?

      *Принцип max энтропии (Jaynes):*
      $ max H(theta) = -integral_0^1 pi(theta) ln pi(theta) d theta $
      при $integral pi = 1$ $arrow.r$ $pi(theta) = "Uniform"(0,1) = "Beta"(1,1)$

      *Неинформативное* априорное Джеффриса: $pi(theta) prop sqrt(cal(I)(theta)) = "Beta"(1/2, 1/2)$

      #text(size: 7pt, fill: purple-dark, style: "italic")[
        Из курса (лекция 9): max энтропии при ограничениях → экспоненциальное семейство.
      ]
    ], purple-bg, border-color: purple-dark)

#v(0.1cm)

    #fact-block[
      #text(size: 7pt)[
        *Применения:* A/B тесты (Google, Netflix); клинические испытания (Thompson, 1933); рекомендации; онлайн-реклама (CTR); RL/MDP (Strens, 2000). *Факт (Chapelle & Li, NeurIPS 2011):* TS превосходит UCB и $epsilon$-greedy эмпирически.
      ]
    ]
  ]
)

#v(0.1cm)
#box(
  width: 100%,
  fill: indigo-bg,
  radius: 4pt,
  stroke: 0.7pt + indigo-dark,
  inset: 5pt,
)[
  #set text(size: 7pt)
  #grid(
    columns: (1.1fr, 1fr, 1fr, 1fr),
    column-gutter: 0.2cm,
    [
      #text(weight: "bold", fill: indigo-dark)[Экспоненциальное семейство и сопряжённость]
      #v(1pt)
      $p(x|theta) = h(x) exp(eta^top T(x) - A(eta))$. Сопряжённое: $pi(eta) prop exp(n_0 t_0^top eta - n_0 A(eta))$. Обновление: $n_0 arrow n_0 + n$, $t_0 arrow (n_0 t_0 + sum T(x_i))/(n_0+n)$. Замкнутая форма!
    ],
    [
      #text(weight: "bold", fill: indigo-dark)[Смешанные распределения (курс)]
      #v(1pt)
      Predictive distribution: $p(x|cal(D)) = integral p(x|theta) pi(theta|cal(D)) d theta$ — *смесь* по апостериорному. Для Beta-Bernoulli: $PP(R=1|cal(D)) = (alpha+s)/(alpha+beta+n)$ — среднее апостериорного.
    ],
    [
      #text(weight: "bold", fill: indigo-dark)[Критерий Брусса (курс) vs TS]
      #v(1pt)
      Брусс: оптимальная остановка, «когда остановиться». TS: «что выбрать на каждом шаге». Оба используют обратную индукцию. TS — онлайн-версия: не останавливаемся, а *адаптируемся*.
    ],
    [
      #text(weight: "bold", fill: indigo-dark)[Псевдокод (3 строки!)]
      #v(1pt)
      #text(size: 6.5pt)[
        for t = 1, 2, ..., T: \
        #h(0.5em) sample theta from Beta \
        #h(0.5em) play k = argmax theta \
        #h(0.5em) update alpha, beta
      ]
    ],
  )
]

#v(0.08cm)
#align(center)[
  #text(size: 6.5pt, fill: rgb("#78909C"))[
    Источники: Thompson (1933, Biometrika 25:285); Gittins (1979, JRSS-B 41:148); Lai & Robbins (1985, Adv. Appl. Math. 6:4); Kaufmann et al. (2012, ALT); Russo et al. (2018, Found. & Trends ML 11:1); Chapelle & Li (2011, NeurIPS) | Подготовила Лашкевич Злата БЭАД245
  ]
]
