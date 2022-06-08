# Приклад роботи з GitHub API за допомогою requests та plotly.
import requests

from plotly.graph_objs import Bar
from plotly import offline

# Робимо виклик через API.
url = 'https://api.github.com/search/repositories?q=language:python&sort=stars'
r = requests.get(url)

# Зберігаємо відповідь API у змінну.
response_dict = r.json()

# Обробляємо результати.
repo_dicts = response_dict['items']

# Створюємо порожні списки, щоб зберігати дані для діаграми та підказок. 
repo_links, stars, labels = [], [], []

# У циклі додаємо назву та рейтинг проєкту до відповідних списків.
for repo_dict in repo_dicts:
    repo_name = repo_dict['name']
    repo_url = repo_dict['html_url']
    repo_link = f"<a href='{repo_url}'>{repo_name}</a>"
    repo_links.append(repo_link)
    stars.append(repo_dict['stargazers_count'])
    owner = repo_dict['owner']['login']
    description = repo_dict['description']
    label = f"{owner}<br />{description}"
    labels.append(label)

# Створюємо візуалізацію.
data = [{
    'type': 'bar',
    'x': repo_links,
    'y': stars,
    'hovertext': labels,
    'marker': {
        'color': 'rgb(238, 240, 108)',
        'line': {'width': 1, 'color': 'rgb(38, 55, 85)'}
    },
    'opacity': 0.5,
}]

my_layout = {
    'title': '"Найзірковіші" Python-проєкти на GitHub',
    'titlefont': {'size': 26},
    'xaxis': {
        'title': 'Репозитарії',
        'titlefont': {'size': 16},
        'tickfont': {'size': 10},
    },
    'yaxis': {
        'title': 'Зірочки',
        'titlefont': {'size': 16},
        'tickfont': {'size': 10},
    },

}

fig = {'data': data, 'layout': my_layout}
offline.plot(fig, filename='repos_python_stars.html')