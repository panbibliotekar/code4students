import csv

from datetime import datetime
from matplotlib import pyplot as plt

filename = 'weather.csv'
with open(filename) as f:
    reader = csv.reader(f)
    header_row = next(reader)

    # Отримати дати та високі температури з цього файлу.
    dates, highs = [], []
    for row in reader:
        current_date = datetime.strptime(row[2], '%Y-%m-%d')
        dates.append(current_date)
        high = int(row[5])
        highs.append(high)

# Позначити високі температури.
plt.style.use('seaborn')
fig, ax = plt.subplots()
ax.plot(dates, highs, c='red')

# Форматування графіка.
plt.title("Рекордні температури повітря", fontsize=24)
plt.xlabel('', fontsize=14)
fig.autofmt_xdate()
plt.ylabel("Temperature (F)", fontsize=12)
plt.tick_params(axis='both', which='major', labelsize=12)

plt.show()