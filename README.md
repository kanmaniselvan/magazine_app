# Magazine app

A simple Rails application composed of Users,​ Articles​, Tags​ & SubTags.​
Users can register to the app, and once they are registered they can create their own
articles. Articles are composed by title and description. An article can also be linked to many tags and subtags.

# Functionality
- Create a new User
- Create a new Article
- See a list of whole magazine (all articles) ordered by creation date
- Filter articles by Tag / SubTag / text in Title or Content
- See a single article, show: title, content, owner name, and related tags.

# Setup
`> bundle install`<br>
`> rake db:create`<br>
`> rake db:migrate`<br>
`> rake db:seed`

Start the server. Hit `localhost:3000`

email: `user@user.com` <br>
password: `password`

That's it.

