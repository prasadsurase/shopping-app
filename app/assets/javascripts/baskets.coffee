# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org
$ ->
  ###
  $(document).on 'change' , '.fields select', (e) ->
    # if this select box has a selected value
    that = this
    if($(that).val() != '')
      # if there are other select boxes expect
      if($('.fields select').not(that).length >= 1)
        $('.fields select').not(that).each () ->
          $(this).children('option[value="' + $(that).val() + '"]').prop('disabled', true)
  ###

  $(document).on 'nested:fieldAdded', (e) ->
    link = $(e.currentTarget.activeElement)
    $('.fields select').each (e) ->
      return
    if !link.data('limit')
      return
    if link.siblings('.fields:visible').length >= link.data('limit')
      link.hide()
    return

  $(document).on 'nested:fieldRemoved', (e) ->
    link = $(e.target).siblings('a.add_nested_fields')
    $('.fields select').each (e) ->
      return
    if !link.data('limit')
      return
    if link.siblings('.fields:visible').length < link.data('limit')
      link.show()
    return
  return

