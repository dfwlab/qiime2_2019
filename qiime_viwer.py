#!/usr/bin/python
# -*- coding: UTF-8 -*-
# ddhmed 20191116
#!pip install PyGithub
# https://raw.githubusercontent.com/gz16s/qiime_viwer/master/7230538196.qzv
import sys
import random
from github import Github
from IPython.core.display import HTML
g = Github("gz16s", "2019gz123456")
repo = g.get_repo("gz16s/qiime_viwer")
file_path = sys.argv[1]
file_type = file_path.split('.')[-1]
newfile = str(int(random.random()*10**10))+"."+file_type
contents = open(file_path, 'rb').read()
repo.create_file(newfile, "upload", contents, branch="master")
view_data = "<a href='https://view.qiime2.org/visualization/?type=html&src=https%3A%2F%2Fraw.githubusercontent.com%2Fgz16s%2Fqiime_viwer%2Fmaster%2F"+newfile+"' target='_blank'>在新窗口查看结果</a>"
view_data += "<iframe width='100%', height='300px', src='https://view.qiime2.org/visualization/?type=html&src=https%3A%2F%2Fraw.githubusercontent.com%2Fgz16s%2Fqiime_viwer%2Fmaster%2F"+newfile+"' />"
display(HTML(view_data))
