# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app
- [x] Use ActiveRecord for storing information in a database
- [x] Include more than one model class (e.g. User, Post, Category)
			3 models, user, card, deck

- [x] Include at least one has_many relationship on your User model (e.g. User has_many Posts)
			user has many decks, deck has many cards

- [x] Include at least one belongs_to relationship on another model (e.g. Post belongs_to User)
			card belongs to deck, deck belongs to user

- [x] Include user accounts with unique login attribute (username or email)
			username with uniqueness

- [x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying
			CRUD for cards and decks, only CRU for users

- [x] Ensure that users can't modify content created by other users
			helper methods in /app/controllers/application_controller.rb, especially #access_forbiden? verify permission

- [x] Include user input validations
			validated with uniquness, length, scope on back end and front end validation via html

- [x] BONUS - not required - Display validation failures to user with error message (example form URL e.g. /posts/new)
			done using flash

- [ ] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code

Confirm
- [x] You have a large number of small Git commits
			I need to get better at this.  Some are fairly large (i think).
- [x] Your commit messages are meaningful
			I tried to be clear about what I'm doing.  I do tend to wander from a specific task and fix whatever bug I come across which makes meaningful messages difficult
- [x] You made the changes in a commit that relate to the commit message
			See above, symptom of the same problem
- [ ] You don't include changes in a commit that aren't related to the commit message
			again, see above.  I need to work on this.
