# README

# Rails Project Manager
  A simple web app for managing projects, designed with an outdoor facility, such as a ski area, in mind.  Users can create, edit, and view projects and other users, with limits based on their roles (see Authorization).  

# Authentication
  Users have two options for authentication - sign in with Facebook via OmniAuth or create a password that gets salted and hashed via bcrypt.

# Authorization
  All authorization logic is custom and built-in.  Users can log in or sign up, and fall into one of four 'role' enum categories - 'worker', 'supervisor', 'admin', and 'big_boss'.  Users default to 'worker' and can be promoted (or demoted) only by those who outrank them.  Projects have an owner and many workers.  Users have many pet projects (those they own) and projects (those they are assigned to).  Anyone can create a project.  Users may edit projects they own or projects whose owners they outrank.  Tools are added by editing projects.  Anyone can add a new tool to the master list.  Anyone who owns or is assigned to a project can leave notes about that project.  A 'big_boss' can do pretty much anything.  Users should not see options they don't have access to, but errors are displayed any time they are encountered.

# AJAX/JQuery Implementation
  Some views are now available without page refresh from a user's profile page.  Users can check out a users index, projects index, and project quick view implemented with `$.get` requests.  Also, all note creation and deletion is now done with `$.post` and `$.ajax` delete methods, making them nice and snappy.

# Usage
To use, copy repo and run `bundle intstall` from main file directory in command line.
Run `rails s` and copy address listed, open in browser.

# API
  New to the app is a JSON API backend.  API endpoints render JSON objects and can be viewed by anyone who is logged in.  Projects, Users, and Tools are all available on the API, indexed or individual show. They can be accessed via an AJAX request that's looking for JSON, or via regular routing with a `.json` extension.  For example, to view the projects index in JSON format, head to:
    `/projects.json`
    or, to check out a JSON version of a user with an id of 4:
    `/users/4.json`
    Simple stuff.

# Contributing
Contributions are welcome - suggestions, bug reports, additions, and edits! https://github.com/howardbdev/rails-project-manager or email me at howarddevennish@gmail.com

# License

MIT License

Copyright (c) <2017> howardbdev

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
