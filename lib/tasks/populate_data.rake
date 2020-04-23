namespace :db do

  drawer_data = {
    title: "🗄 Drawer Example",
    description: "This is a drawer 🗄. It contains the codetools 📄🛠.\r\nYou can select friends 👥 to share the drawer and make them collaborators of all containing codetools."
  }

  codetool_data = {
    title: "🛠 Codetool Example",
    content: "This is a Codetool.\r\nThere are a lot of things that you can do:\r\n-[x] Save neatly your code snippets, notes and everything you want.\r\n-[x] Write codetool content with `Markdown`.\r\n-[x] Sort codetools with drag and drop.\r\n-[x] Make codetools public to share with other users.\r\n-[x] Search code-friends, and follow them.\r\n-[x] Save your friends public codetools as favorites.\r\n-[x] Pin the most useful codetools to the Work Board.\r\n\r\n![codedrawer screen capture](/assets/codedrawer_screen.jpg#wide   \"Codedrawer Screen\")"
  }


  desc 'Populate initial data when user creation is validated'
  task populate_data: :environment do |t, arg|

    drawer = Drawer.new(
      title: drawer_data[:title],
      description: drawer_data[:description],
      user_id: arg.id
    )
    drawer.save

    codetool = Codetool.new(
      title: codetool_data[:title],
      content: codetool_data[:content],
      drawer_id: drawer.id,
      user_id: arg.id
    )
    codetool.save
  end

  desc 'Populate initial data to a specific user (rake db:populate_user_data "email=user@mail.com")'
  task populate_user_data: :environment do |t, arg|
    email = ENV['email']
    user = User.find_by_email(email)

    drawer = Drawer.new(
      title: drawer_data[:title],
      description: drawer_data[:description],
      user_id: user.id
    )
    drawer.save

    codetool = Codetool.new(
      title: codetool_data[:title],
      content: codetool_data[:content],
      drawer_id: drawer.id,
      user_id: user.id
    )
    codetool.save
  end
end