# проводимо t-тест в R
library(readxl)
mos <- read_excel(path = '/BeerAndMosquitoes.xlsx', sheet = 'mosquitoes')
str(mos)
colSums(is.na(mos)) # перевіряємо, чи є пропущені значення в наших даних
table(mos$drink) # перевіряємо обсяг вибірки
library(car)
f_beer <- mos$drink == 'beer' # логічний вектор-фільтр 
qqPlot(mos$change[f_beer])
qqPlot(mos$change[ ! f_beer])
tt <- t.test(change ~ drink, data = mos) 
tt
library(ggplot2)
theme_set(theme_bw())
ggplot(data = mos, aes(x = drink, y = change)) + 
  stat_summary(fun.data = mean_cl_normal)
ggplot(data = mos, aes(x = drink, y = change)) + 
  stat_summary (fun.data = mean_cl_normal, colour = 'forestgreen') + 
  scale_x_discrete(labels = c('Пиво', 'Вода')) +
  labs(x = 'Напій', y = 'Зміна активності комарів')
