namespace :deploy do
  desc "Deploy credentials file into EC2"
  task :credentials do
    system("scp ~/Documents/projects/CodeDrawerApp/config/application.yml ssh web@161.35.87.109:apps/codedrawer/current/config/")
  end
end