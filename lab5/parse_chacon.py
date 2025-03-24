import json
import pandas as pd

with open('../data/schacon.repos.json', 'r') as file:
    data = json.load(file)

extracted_data = []

for repo in data[:5]:
    name = repo.get('name', '')
    html_url = repo.get('html_url', '')
    updated_at = repo.get('updated_at', '')
    visibility = repo.get('visibility', '')
    extracted_data.append([name, html_url, updated_at, visibility])

with open('chacon.csv', 'w') as output:
    for entry in extracted_data:
        line = ",".join(entry)
        output.write(line + "\n")
