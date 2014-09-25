$ ->
  $('.form-post').click ->
    $submit = $(this)
    $submit.prop('disabled', true)
    attrs = {}

    $('[data-form]').each (idx, attr) ->
      console.log(idx);
      $attr = $(attr);
      key = $attr.data('form')

      value = null
      if $attr.attr('type') == 'checkbox'
        value = $attr.prop('checked')
      else
        value = $attr.data('value') || $attr.val() || $(attr).html()
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
    console.log(data)
    return

    $.ajax
      type: $submit.data('method') || "POST",
      url: url,
      data: data
      dataType: "json"
      complete: ->
        $submit.prop('disabled', false)
      success:(data) ->
        if data[name].errors
          $('.message.error span').text(data[name].errors)
          $('.message.error').removeClass('hide')
          $("html, body").animate({ scrollTop: 0 }, "fast");
        else
          window.location.href = data[name].path
        return false
