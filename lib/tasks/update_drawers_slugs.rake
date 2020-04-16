namespace :slugs do
  desc "Updates drawers slugs"
  task update: :environment do

     drawers = Drawer.all
     drawers.each do |drawer|
       drawer.update(slug: drawer.title.parameterize)
     end

     codetools = Codetool.all
     codetools.each do |codetool|
       codetool.update(slug: codetool.title.parameterize)
     end

  end
end
