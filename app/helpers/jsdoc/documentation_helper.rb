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

  def link_to_symbol(symbol_type)
    return nil if symbol_type.blank?

    # split symbols on | or /
    symbols = symbol_type.split(/\||\//)

    html = ''
    symbols.each do |s|
      symbol = Jsdoc::Symbol.where(:alias => s.gsub(/\[\]$/, '')).first

      html += '/' unless html.blank?
      if symbol.nil?
        html += s
      else
        html += link_to(s, symbol_path(symbol.alias), :class => 'symbol')
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
