module Jsdoc::DocumentationHelper
  def symbols
    return Jsdoc::Symbol.order(:alias)
  end

  def namespaces
    return Jsdoc::Symbol.namespaces
  end

  def full_class_list
    output = '<ul>'
    Jsdoc::Symbol.where(:member_of => nil).each do |n|
      output += '<li>' + list_namespace(n) + '</li>'
    end
    output += '</ul>'
    return output.html_safe
  end

  def list_namespace(namespace)
    output = namespace.name
    if namespace.children.size > 0
      output += '<ul>'
      for child in namespace.children
        output += '<li>' + list_namespace(child) + '</li>'
      end
      output += '</ul>'
    end


    return output
  end
end
