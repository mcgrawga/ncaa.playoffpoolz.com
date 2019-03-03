#
#  Run this to reset teams and create one super user garthmcgraw@statgolf.com
#  When you have got the teams set, run brackets to set the master bracket
#  so users can pick their bracket.
#

heroku run rake db:fixtures:load FIXTURES=users
heroku run rake db:fixtures:load FIXTURES=teams  # You will need to adjust this every year
heroku run rake db:fixtures:load FIXTURES=brackets
heroku run rake db:fixtures:load FIXTURES=cutoff_dates  # You will need to adjust this every year