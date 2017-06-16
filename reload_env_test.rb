lib = File.expand_path('../lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'denv'

require 'fileutils'

FileUtils.rm_rf('tmp')
FileUtils.mkdir_p('tmp')
Dir.chdir('tmp') do
  ENV['INIT'] = '1'
  File.write('.env', "XXX=1\nYYY=2\n")
  Denv.load
  raise('Necessary keys are removed') unless ENV.has_key?('INIT')
  raise('Can not set env') unless ENV['YYY'] == '2'

  File.write('.env', "XXX=\nYYY=3\nZZZ=4")
  code = <<-EOS
    $LOAD_PATH.unshift("#{lib}")
    require 'denv'
    Denv.load

    if ENV['XXX'] != ''
      p ENV
      raise('Previous env vars are not removed') 
    end

    if ENV['YYY'] != '3'
      p ENV
      raise('can not overwrite env var')
    end

    if ENV['ZZZ'] != '4'
      p ENV
      raise('can not add new env var')
    end

    puts 'Success'
  EOS
  exec('ruby', '-e', code)
end
