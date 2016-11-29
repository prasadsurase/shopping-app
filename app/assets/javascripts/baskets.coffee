# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org
$ ->
  handle_select_boxes = ->
    selected_options = []
    # get all select fields
    select_fields = $('.fields select:visible')
    # get values of the select fields. skip unselected fields
    $.each select_fields, (index, select) ->
      if($(select).val() != '')
        selected_options.push $(select).val()
        return

    # get all options
    all_options = $('.fields select:visible option')

    #if option value is in the selected values, then disable the option
    $.each all_options, (index, option) ->
      if($(option).val() != '')
        if ($.inArray($(option).val(), selected_options) != -1)
          if $(option).parent('select').val() == $(option).val()
            $(option).prop('disabled' , false)
          else
            $(option).prop('disabled' , true)
        else
          $(option).prop('disabled' , false)
    return

  $(document).on 'change', '.fields select', (e) ->
    handle_select_boxes()
    return

  $(document).on 'nested:fieldAdded', (e) ->
    link = $(e.currentTarget.activeElement)
    handle_select_boxes()
    if !link.data('limit')
      return
    if link.siblings('.fields:visible').length >= link.data('limit')
      link.hide()
    return

  $(document).on 'nested:fieldRemoved', (e) ->
    link = $(e.target).siblings('a.add_nested_fields')
    if !link.data('limit')
      return
    if link.siblings('.fields:visible').length < link.data('limit')
      handle_select_boxes()
      link.show()
    return
  return

