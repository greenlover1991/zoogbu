# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

# seed for posts
posts = Post.create(:title =>'Welcome to Zoogbu!', :body=>'This site was created by:

Go, Steven
Patalinghug, Patrick
Taveros, Mark
Yu, Alvin

As a final requirement for the subjects IT 130 & 136, spearheaded by professor Ms. Mary Jane Sabellano.

Date: March 19, 2011

University of San Carlos - TC
Cebu City
Cebu, Philippines', :author=>'Management', :status=>'Active')
