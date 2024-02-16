import os
import random

home = os.getenv('HOME')
path = f'{home}/Pictures/Wallpapers/'

list = os.listdir(path)
randomValue = random.randint(0, len(list) - 1)
print(path + list[randomValue])
