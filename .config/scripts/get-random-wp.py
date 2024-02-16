import os
import random

user = os.getenv('USER')
path = f'/home/{user}/Pictures/Wallpapers/'

list = os.listdir(path)
randomValue = random.randint(0, len(list) - 1)
print(path + list[randomValue])
