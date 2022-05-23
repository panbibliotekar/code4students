# Вага новонарождених. Дані: Hosmer, Lemeshow, 1989

# Читаємо дані
library(MASS)
baby <- birthwt
head(baby) #переглянемо кілька перших рядків
tail(baby) #переглянемо кілька останніх рядків
nrow(baby)  #кількість рядків
ncol(baby)  #кількість стовпців
colnames(baby) #назви змінних

# Побудуємо простий точковий графік, де вісь x = вага матері, а вісь y = вага дитини
library(ggplot2) 
ggplot(baby, aes(x = lwt, y = bwt)) + geom_point(colour = 'red', size = 2, shape = 15)

# Наш датасет містить також дані про тютюнопаління матерів, расу, кількість відвідин лікаря ітд. Візуалізуймо ці дані!
baby$smoke <- factor(baby$smoke,
                     levels = c(1, 0),
                     labels = c('Smoker', 'Non-smoker'))
baby$race <- factor(baby$race,
                    levels = c(1, 2, 3),
                    labels = c('White', 'Black', 'Other'))

# Естетика `colour` допоможе показати матерів, які палять і тих, які не палять
ggplot(baby, aes(x = lwt, y = bwt, colour = smoke)) +
  geom_point(size = 2, shape = 17)

# Введемо `size`, щоб за допомогою розміру точок показати скільки разів жінка відвідувала лікаря (`baby$ftv`)
ggplot(baby, aes(x = lwt, y = bwt, colour = smoke, size = ftv)) +
  geom_point() + guides(size = guide_legend(ncol = 4))

# Проведемо фасетування, щоб було легше зрозуміти наші дані
ggplot(baby, aes(x = lwt, y = bwt, colour = smoke, shape = race)) +
  geom_point(size = 2) +
  scale_colour_brewer(palette = 'Set1') +
  facet_grid(smoke~race)

# Побудуймо гістограму і за допомогою `fill` покажемо матерів, які палять і тих, які не палять
ggplot(baby, aes(x = bwt)) +
  geom_histogram(binwidth = 500, aes(fill = smoke)) +
  theme_bw()

# Проведемо фасетизацію, щоб було легше читати нашу гістограму
ggplot(baby, aes(x = bwt)) + geom_histogram(binwidth = 500, aes(fill = smoke)) +
  theme_bw() +
  facet_wrap(~smoke, nrow = 2)

# Провемо також ядрову оцінку густини розподілу (Kernel Density)
ggplot(baby, aes(x = bwt)) +
  geom_density(aes(fill = smoke), alpha = 0.5) +
  theme_bw()

# Простежмо тенденцію залежності ваги новонародженого від віку матері (з лініями регресії)
ggplot(baby, aes(x = age, y = bwt, colour = smoke)) + geom_point() +
  stat_smooth(method = 'lm') +
  theme_bw()

# Висновок - Інформаційні аналітики не курять :)