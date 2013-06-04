desc 'Generates a properties file for each job based on properties.X.Y used in templates'
task :job_properties do
  require 'fileutils'
  Dir['jobs/*'].each do |path|
    puts "Searching job #{File.basename(path)}..."
    FileUtils.chdir(path) do
      properties = []
      Dir['templates/*.erb'].each do |template_path|
        properties |= File.read(template_path).scan(/\bproperties\.[\w\.]*\b/)
        puts properties.join("\n")
        File.open('properties', 'w') { |file| file << properties.join("\n") }
      end
    end
  end
end

desc 'run tests'
task :spec do
  unless File.exists?('config/dev.yml')
    File.open('config/dev.yml', 'w') do |f|
      f.puts("---\ndev_name: redis\n")
    end
  end
  sh 'bosh create release --force'
end
