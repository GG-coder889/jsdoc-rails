namespace :jsdoc do
  desc "Generate a db/seeds.rb file containing all the JSDoc definitions. Specify with SRC=/path/to/javascript/, JSDOC_HOME=/path/to/jsdoc-toolkit, OUTPUT=db/"
  task :seed do
    output = ENV['OUTPUT'] || 'db/'
    output = File.join(Dir.pwd, output) unless output[0..0] == '/'

    template_path = File.join(File.dirname(__FILE__), '../../../jsdoc_template')

    puts "Reading from: #{ENV['SRC']}"
    puts "Outputing to: #{output}"
    system("cd \"#{ENV['SRC']}\"; java -jar \"#{ENV['JSDOC_HOME']}/jsrun.jar\" \"#{ENV['JSDOC_HOME']}/app/run.js\" -r=10 -a -d=\"#{output}\" -t=#{template_path} -- *")
  end
end
