Dir["#{File.dirname(__FILE__)}/config/initializers/**/*.rb"].sort.each do |initializer|
  Kernel.load(initializer)
end

require 'redmine'
require 'scoreboard_menu_helper_patch'
require 'issue_patch'
require 'timelog_controller_patch'
require 'users_controller_patch'
require 'user_patch'
require 'users_helper_patch'
require 'project_patch'

Redmine::Plugin.register :redmine_cmiplugin do
  name 'Cuadro de Mando Integral'
  author 'Emergya Consultoría'
  description ' Vistas resumenes globales y por proyectos'
  version '1.1'

  settings :default => { }

  requires_redmine :version_or_higher => '1.0.0'
  project_module :cmiplugin do
  #     permission :view_cmi, {:cmi => [:projects, :groups, :show]}
        permission :view_metrics, {:metrics => [:show]}
  end

  menu :project_menu, :metrics, {:controller => 'metrics', :action => 'show' }, :caption => 'Métricas', :after => :settings, :param => :project_id
  menu :top_menu, :cmi, {:controller => 'management', :action => 'projects'}, :caption => 'CMI', :if => Proc.new { User.current.admin? }
  menu :scoreboard_menu, :projects, {:controller => 'management', :action => 'projects' }, :caption => 'Proyectos'
  menu :scoreboard_menu, :status, {:controller => 'management', :action => 'status' }, :caption => 'Estado'
  menu :scoreboard_menu, :groups, {:controller => 'management', :action => 'groups' }, :caption => 'Grupos'
end