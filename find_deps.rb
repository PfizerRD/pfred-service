
require 'awesome_print'

dir = ARGV[0].sub(/\/+$/, '')

$stderr.puts dir

def format name
  name = name.gsub(/_/, "_\n").split('.', 2)
  "#{name[0]}\n(#{name[1]})"
end

puts 'digraph deps {'
Dir[dir + '/*'].select{|f| File.file?(f) }.each do |file|
  script = File.basename file
  refs = `rg -F -l '#{script}'`
  refs.split(/\n/).each do |ref|
    ref = ref.strip
    ref = File.basename ref
    puts '  "%s" -> "%s";' % [format(ref), format(script)]
  end
end
puts '}'