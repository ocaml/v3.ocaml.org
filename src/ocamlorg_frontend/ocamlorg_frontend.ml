module Package_breadcrumbs = Package_breadcrumbs
module Package_overview = Package_overview
module Navmap = Navmap
module Toc = Toc
include Package_intf

let about = About.render
let academic_users = Academic_users.render
let best_practices = Best_practices.render
let books = Books.render
let community = Community.render
let workshop = Workshop.render
let home = Home.render
let industrial_users = Industrial_users.render
let learn = Learn.render
let platform  = Platform.render
let blog = Blog.render
let news = News.render
let news_post = News_post.render
let jobs = Jobs.render
let package_overview = Package_overview.render
let package_documentation = Package_documentation.render
let package_documentation_not_found = Package_documentation_not_found.render
let packages  = Packages.render
let packages_search = Packages_search.render
let packages_autocomplete_fragment = Packages_autocomplete_fragment.render
let papers = Papers.render
let problems = Problems.render
let release = Release.render
let releases = Releases.render
let success_story = Success_story.render
let tutorial = Tutorial.render
let page = Page.render
let playground = Playground.render
let not_found = Not_found.render
