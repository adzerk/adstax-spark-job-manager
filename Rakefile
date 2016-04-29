require "bundler/gem_tasks"

task "publish" do
  gem_helper = Bundler::GemHelper.instance
  built_gem_path = gem_helper.build_gem
  Process.wait spawn("gem nexus #{built_gem_path}")
  Bundler.ui.confirm "#{gem_helper.gemspec.name} (#{gem_helper.gemspec.version}) pushed to Nexus."
end
