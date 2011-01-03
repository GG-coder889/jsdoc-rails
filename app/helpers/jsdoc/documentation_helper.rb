module Jsdoc::DocumentationHelper
  def symbols
    return Jsdoc::Symbol.order(:alias)
  end

  def namespaces
    return Jsdoc::Symbol.namespaces
  end

  def full_class_list
    output = '<ul>'
    Jsdoc::Symbol.where(:member_of => nil).each do |child|
      output += '<li>' + link_to(list_namespace(child), jsdoc_symbol_path(child.alias)) + '</li>'
    end
    output += '</ul>'
    return output.html_safe
  end

  def list_namespace(namespace)
    output = namespace.name
    if namespace.children.size > 0
      output += '<ul>'
      for child in namespace.children
        output += '<li>' + link_to(list_namespace(child), jsdoc_symbol_path(child.alias)) + '</li>'
      end
      output += '</ul>'
    end


    return output.html_safe
  end
end
