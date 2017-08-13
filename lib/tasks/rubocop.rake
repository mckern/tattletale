require "rubocop/rake_task"

desc "Run RuboCop"
RuboCop::RakeTask.new(:rubocop) do |task|
  task.options << "--display-cop-names"
end
