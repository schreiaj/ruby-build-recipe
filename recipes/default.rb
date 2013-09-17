
home = "/home/"+node["ruby-build"]["user"]

["libssl-dev", "gcc", "libreadline-dev", "zlib1g-dev"].each do |pkg|
	package pkg do
		action :install
	end
end


directory "/tmp/ruby-build" do
	owner node["user"]
	group node["group"]
	mode "755"
	action :create
end

git "ruby-build" do
	repository "https://github.com/sstephenson/ruby-build.git"
	action :sync
	destination "/tmp/ruby-build"
end

bash "install ruby-build" do
	user node["user"]
	cwd "/tmp/ruby-build"
	code <<-EOH
		# This is dirty, because Chef doesn't allow us a way to specify a commit I clone
		# using git provider but then checkout the specific branch I need. 
		git checkout 993b7c2b2d3e43fdb6e439ecf7f260687554f689
		sudo ./install.sh
		cd ..
		sudo rm -rf ruby-build
	EOH

end	
