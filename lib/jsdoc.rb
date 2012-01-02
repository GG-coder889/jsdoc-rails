require 'jsdoc/engine'
require 'jsdoc/version'

module Jsdoc
  def self.build_docs(root, srcs, dst, project_name, version_number, extra_args='')
    output_dir = File.dirname(dst)
    output_file = File.basename(dst)
    jsdoc_path = File.join(File.dirname(__FILE__), '../jsdoc-toolkit')
    template_path = File.join(jsdoc_path, 'templates', 'jsdoc-rails')

    srcs = srcs.map {|s| '"' + s.gsub('"', '\\"') + '"' }

    project_slug = project_name.gsub(/[^0-9a-zA-Z\-_]+/, '-').gsub(/-+/, '-').gsub(/^-|-$/, '').downcase

    ::Rails.logger.info "Generating docs from: #{srcs.join(', ')}"
    ::Rails.logger.info "Outputing docs to: #{File.join(output_dir, output_file)}"

    system(%Q(cd "#{root.gsub('"', '\\"')}"; java -jar "#{jsdoc_path}/jsrun.jar" "#{jsdoc_path}/app/run.js" -r=100 -a -d="#{output_dir}" -D="outputFile:#{output_file}" -D="projectName:#{project_name}" -D="projectSlug:#{project_slug}" -D="versionNumber:#{version_number}" -t=#{template_path} #{extra_args} -- #{srcs.join(' ')}))
    ::Rails.logger.info "Docs generated"
  end

  def self.reload_docs(root, srcs, project_name, version_number, extra_args='')
    tmpfile = Tempfile.new('jsdoc-rails')
    build_docs(root, srcs, tmpfile, project_name, version_number, extra_args)
    wipe_data(project_name, version_number)
    load(tmpfile.path)
    tmpfile.close
  end

  def self.wipe_data(project_name, version_number)
    project = Jsdoc::Project.where(['name = :name OR slug = :name', {:name => project_name}]).first
    unless project.present?
      ::Rails.logger.warn "No project found named '#{project_name}', so nothing to delete"
      return false
    end

    version = project.versions.where(:version_number => version_number).first
    unless version.present?
      ::Rails.logger.warn "No version found named '#{version_number}', so nothing to delete"
      return false
    end

    puts "Deleting everything for: #{project.name} (#{version.version_number})"
    version.symbols.destroy_all
  end
end
