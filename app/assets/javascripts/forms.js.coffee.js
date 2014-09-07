$ ->
  $('.form-post').click ->
    attrs = {}
    $('[data-form]').each (idx, attr) ->
      attrs[$(attr).data('form')] = $(attr).html()

    data = {}
    data[$(@).data('name')] = attrs

    $.ajax
      type: "POST",
      url: $(@).data('url'),
      data: data
      dataType: "json"
      success:(data) ->
        alert data.id
        return false
      error:(data, res, s) ->
        console.log s
        return false
