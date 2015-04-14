require 'yard'

YARD::Rake::YardocTask.new do |t|
  t.files  = ['features/*.feature']
end

namespace :yard do
  task deploy: :environment do
    Rake::Task["yard"].invoke

    Dir.chdir("#{Rails.root}/doc") do
      system('git add .')
      system('git add -u')
      system("git commit -m 'Generating docs - #{Time.now}'")
      system('git push origin gh-pages')
    end
  end
end
