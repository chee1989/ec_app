module ApplicationHelper
  def reset_tag(value = "Reset form", options = {})
    options = options.stringify_keys
    tag :input, { "type" => "reset", "value" => value }.update(options)
  end

  def sortTh(title, colName)
    if request.fullpath.include?('asc')
      link_to title + '▲', sort: "#{colName} desc"
    else
      link_to title + '▼', sort: "#{colName} asc"
    end
  end
end
