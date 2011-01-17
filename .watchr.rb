def all_specs
  "spec/lib"
end

trap 'INT' do
  if $interrupted
    exit! 0
  else
    puts "Interrupt a second time to quit"
    $interrupted = true
    sleep 1.5
    $interrupted = false
    run_spec(all_specs)
  end 
end

def run_spec(file)
  return unless file.include?(" ") || File.exist?(file)
  puts "Running specs..."
  system("rspec -f nested -c #{file}")
end


watch( '^lib/(.*)\.rb' )  {|md| run_spec("spec/lib/#{md[1]}_spec.rb") }

watch( '^spec/.*\.rb' )  {|md| run_spec(md[0]) }
