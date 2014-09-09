$ ->
  $('.form-post').click ->
    attrs = {}
    $('[data-form]').each (idx, attr) ->
      $attr = $(attr);
      key = $attr.data('form')
      value = $attr.data('value') || $(attr).html()
      if attrs[key]
        if(!$.isArray(attrs[key]))
          attrs[key] = [value].concat(attrs[key])
        else
          attrs[key] = attrs[key].concat(value)
      else
        attrs[key] = value

    data = {}
    name = $(this).data('name')
    url = $(this).data('url')
    data[name] = attrs

    $.ajax
      type: "POST",
      url: url,
      data: data
      dataType: "json"
      success:(data) ->
        if data[name].errors
          alert(data[name].errors)
        else
          window.location.href = data[name].path
        return false
