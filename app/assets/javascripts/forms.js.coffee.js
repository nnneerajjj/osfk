$ ->
  $('.form-post').click ->
    attrs = {}
    $('[data-form]').each (idx, attr) ->
      attrs[$(attr).data('form')] = $(attr).html()

    data = {}
    name = $(@).data('name')
    data[name] = attrs

    $.ajax
      type: "POST",
      url: $(@).data('url'),
      data: data
      dataType: "json"
      success:(data) ->
        if data[name].errors
          alert(data[name].errors)
        else
          window.location.href = data[name].path
        return false
      error:(data, res, s) ->
        console.log s
        return false
