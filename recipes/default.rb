
home = "/home/"+node["user"]

["libssl-dev", "gcc", "libreadline-dev", "zlibg-dev"].each do |pkg|
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
		sudo ./install.sh
		cd ..
		rm -rf ruby-build
	EOH

end	
