#!/usr/bin/env Rscript
#
# Utility to help post a blog directly from R (via knitr) to WordPress
# This utility was inspired by knitr author Yi Hui's post at the link below:
#   http://yihui.name/knitr/demo/wordpress/
#
# The utility takes two inputs:
#
#  1. The name of the R Markdown file that needs to be posted to the blog.
#  2. A title for the blog post.
#
# Notes: 
#  1. The images are automatically uploaded to imgur.com
#  2. The blog post is saved to the 'Draft' folder on the WordPress account to allow
#     review before publishing.
# 
r2wordpress <- function() {

  if (!require('RWordPress'))
    install.packages('RWordPress', repos = 'http://www.omegahat.org/R', type = 'source')

  require(knitr)

  # set up the WordPress login credentials for use by RWordPress
  # Replace the following tokens appropriately:
  #   username = WordPress.com account username
  #   passowrd = Password for WordPress.com account
  #   blogname = domain name or blogname of WordPress.com account
  #
  # Note: Keep the single quotes
  options(WordpressLogin = c(username = 'password'),
          WordpressURL = 'https://blogname.wordpress.com/xmlrpc.php')

  # set up knitr options to upload all images to imgur.com 
  opts_knit$set(upload.fun = imgur_upload, base.url = NULL)

  RmdFile <- NA
  while(is.na(RmdFile)){
    RmdFile <- readline("Name of R Markdown file (including .Rmd): ")
  }

  BlogPostTitle <- NA
  while(is.na(BlogPostTitle)){
    BlogPostTitle <- readline(prompt="Blog post title: ")
  }

  knit2wp(RmdFile, title = BlogPostTitle, shortcode = TRUE, publish = FALSE)
}
