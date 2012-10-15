desc "Testing rake task"
task :simple_test => :environment do
	a = "Rake task called to controller"
	return a
end