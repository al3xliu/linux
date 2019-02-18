#!/usr/bin/env python
import os

path = '/Users/alexliu/projects/linux'

def pre_tree(root_path):
    print root_path
    if os.path.isdir(root_path):
        files = os.listdir(root_path)
        for file in files:
            file = root_path + '/' + file
            pre_tree(file)

pre_tree(path)
