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

  File.write('.env', "XXX=1\n")
  code = <<-EOS
    $LOAD_PATH.unshift("#{lib}")
    require 'denv'
    Denv.load
    raise('Previous env vars are not removed') if ENV.has_key?('YYY')
    raise('Necessary keys are removed') unless ENV.has_key?('XXX')
    puts 'Success'
  EOS
  exec('ruby', '-e', code)
end
