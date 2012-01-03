module Jsdoc::DocumentationHelper
  # Path helpers
  def welcome_path(*args)
    if ::Rails.configuration.jsdoc.single_project
      version_welcome_path(@version.version_number, *args)
    else
      project_welcome_path(@project.slug, @version.version_number, *args)
    end
  end

  def symbol_path(*args)
    if ::Rails.configuration.jsdoc.single_project
      version_symbol_path(@version.version_number, *args)
    else
      project_symbol_path(@project.slug, @version.version_number, *args)
    end
  end

  def source_path(*args)
    if ::Rails.configuration.jsdoc.single_project
      version_source_path(@version.version_number, *args)
    else
      project_source_path(@project.slug, @version.version_number, *args)
    end
  end

  def raw_source_path(*args)
    if ::Rails.configuration.jsdoc.single_project
      version_raw_source_path(@version.version_number, *args)
    else
      project_raw_source_path(@project.slug, @version.version_number, *args)
    end
  end

  def symbols
    return Jsdoc::Symbol.order(:alias)
  end

  def namespaces
    return Jsdoc::Symbol.namespaces
  end

  def anchorName(member)
    anchor = ''

    anchor += 'static_' if member.is_static
    anchor += 'method_' if member.is_a?(Jsdoc::Function) and member.symbol.present?
    anchor += 'property_' if member.is_a?(Jsdoc::Property)
    anchor += member.name
  end

  def full_class_list
    output = '<ul>'
    Jsdoc::Symbol.where(:member_of => nil).each do |child|
      output += '<li>' + link_to(list_namespace(child), symbol_path(child.alias)) + '</li>'
    end
    output += '</ul>'
    return output.html_safe
  end

  def list_namespace(namespace)
    output = namespace.name
    if namespace.children.size > 0
      output += '<ul>'
      for child in namespace.children
        output += '<li>' + link_to(list_namespace(child), symbol_path(child.alias)) + '</li>'
      end
      output += '</ul>'
    end


    return output.html_safe
  end

  def link_to_symbol(symbol_type, name=nil, html_options={})
    return nil if symbol_type.blank?

    if symbol_type.is_a? Array
      symbols = symbol_type
    elsif symbol_type.is_a? String
      # split symbols on | or /
      symbols = symbol_type.split(/\||\//)
    else
      symbols = [symbol_type]
    end

    anchor = html_options.delete(:anchor)

    html = ''
    symbols.each do |s|
      unless s.is_a? String or !s.respond_to?(:alias)
        symbol = s
        s = s.alias
      else
        symbol = Jsdoc::Symbol.where(:alias => s.gsub(/\[\]$/, '')).first
      end

      name ||= s


      html += '/' unless html.blank?
      if symbol.nil?
        html += name
      else
        opts = {:class => 'symbol', :title => symbol.alias}.merge(html_options)
        html += link_to(name, symbol_path(symbol.alias, :anchor => anchor), opts)
      end
    end

    return html.html_safe
  end

  def split_line_detail(str)
    str.strip.match(/^((?!\.\s).+?\.\s)?(.*)/m)[1..-1].map{|s| s.to_s.strip }
  end

  def first_line(str)
    line = split_line_detail(str)[0]
    line.present? ? line : str.strip
  end

  def without_first_line(str)
    detail = split_line_detail(str)
    # Empty first line means detail[1] is the first line
    detail[0].present? ? detail[1].strip : ''
  end

  def returns_detail(r)
    r_type = r.return_type || r.description
    r_desc = r.return_type.present? ? r.description : nil

    return '' if r_type.blank?

    str = '<div class="type">' + link_to_symbol(r_type) + '</div>'

    if r_desc.present?
      str += '<div class="description">' + r.description + '</div>'
    end

    str.html_safe
  end
end
