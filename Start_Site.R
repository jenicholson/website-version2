## Start my new Website

library(blogdown)
# if exists, opens; if not, creates new

blogdown::config_Rprofile() 

# blogdown::install_hugo()

# blogdown::new_site(theme = 'wowchemy/starter-hugo-academic')

blogdown::serve_site()

blogdown::build_site()

blogdown::stop_server()
